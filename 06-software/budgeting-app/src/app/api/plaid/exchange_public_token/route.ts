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

export async function POST(request: Request) {
  try {
    const { public_token } = await request.json();

    if (!PLAID_CLIENT_ID || !PLAID_SECRET) {
      // Mock successful exchange
      return NextResponse.json({
        access_token: 'mock-access-token',
        item_id: 'mock-item-id',
        is_mock: true
      });
    }

    const response = await client.itemPublicTokenExchange({
      public_token: public_token,
    });
    
    // In a real app, save the access_token and item_id securely to your database
    return NextResponse.json(response.data);
  } catch (error: any) {
    console.error('Error exchanging public token:', error.response?.data || error.message);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
