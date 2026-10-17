import { NextResponse } from 'next/server';
import { Configuration, PlaidApi, PlaidEnvironments } from 'plaid';

const PLAID_CLIENT_ID = process.env.PLAID_CLIENT_ID;
const PLAID_SECRET = process.env.PLAID_SECRET;
const PLAID_ENV = process.env.PLAID_ENV || 'sandbox';

const configuration = new Configuration({
  basePath: PlaidEnvironments[PLAID_ENV as keyof typeof PlaidEnvironments],
  baseOptions: {
    headers: {
      'PLAID-CLIENT-ID': PLAID_CLIENT_ID,
      'PLAID-SECRET': PLAID_SECRET,
    },
  },
});

const client = new PlaidApi(configuration);

export async function GET() {
  try {
    // In a real app, retrieve the access token from the database for the logged-in user
    const ACCESS_TOKEN = process.env.PLAID_ACCESS_TOKEN; // Or from a session

    if (!PLAID_CLIENT_ID || !PLAID_SECRET || !ACCESS_TOKEN) {
      // Mock data for UI demonstration
      return NextResponse.json({
        accounts: [
          {
            account_id: 'mock-1',
            name: 'Plaid Checking',
            mask: '0000',
            type: 'depository',
            subtype: 'checking',
            balances: { current: 12450.00, iso_currency_code: 'USD' }
          },
          {
            account_id: 'mock-2',
            name: 'Plaid Credit Card',
            mask: '3322',
            type: 'credit',
            subtype: 'credit card',
            balances: { current: 412.50, iso_currency_code: 'USD' }
          }
        ],
        is_mock: true
      });
    }

    const response = await client.accountsGet({
      access_token: ACCESS_TOKEN,
    });
    
    return NextResponse.json({ accounts: response.data.accounts });
  } catch (error: any) {
    console.error('Error fetching accounts:', error.response?.data || error.message);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
