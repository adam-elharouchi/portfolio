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
    const ACCESS_TOKEN = process.env.PLAID_ACCESS_TOKEN; 

    if (!PLAID_CLIENT_ID || !PLAID_SECRET || !ACCESS_TOKEN) {
      // Mock data for UI demonstration
      return NextResponse.json({
        transactions: [
          {
            transaction_id: 't-1',
            account_id: 'mock-1',
            amount: 14.99,
            date: new Date().toISOString().split('T')[0],
            name: 'Netflix Subscription',
            category: ['Entertainment', 'Subscription'],
            pending: false,
          },
          {
            transaction_id: 't-2',
            account_id: 'mock-1',
            amount: 45.20,
            date: new Date(Date.now() - 86400000).toISOString().split('T')[0],
            name: 'Uber Eats',
            category: ['Food and Drink', 'Restaurants'],
            pending: false,
          },
          {
            transaction_id: 't-3',
            account_id: 'mock-2',
            amount: 120.00,
            date: new Date(Date.now() - 172800000).toISOString().split('T')[0],
            name: 'Target',
            category: ['Shops', 'Supermarkets'],
            pending: false,
          }
        ],
        is_mock: true
      });
    }

    // Pull transactions for the last 30 days
    const startDate = new Date();
    startDate.setDate(startDate.getDate() - 30);
    const startDateStr = startDate.toISOString().split('T')[0];
    const endDateStr = new Date().toISOString().split('T')[0];

    const response = await client.transactionsGet({
      access_token: ACCESS_TOKEN,
      start_date: startDateStr,
      end_date: endDateStr,
    });
    
    return NextResponse.json({ transactions: response.data.transactions });
  } catch (error: any) {
    console.error('Error fetching transactions:', error.response?.data || error.message);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
