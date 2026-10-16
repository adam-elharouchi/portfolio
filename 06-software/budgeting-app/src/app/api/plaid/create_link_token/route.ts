import { NextResponse } from 'next/server';
import { Configuration, PlaidApi, PlaidEnvironments, Products, CountryCode } from 'plaid';

const APP_PORT = process.env.APP_PORT || 3000;
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

export async function POST() {
  try {
    if (!PLAID_CLIENT_ID || !PLAID_SECRET) {
      // Return a mock token for UI demonstration if keys are missing
      console.warn("Plaid keys missing in .env. returning mock token.");
      return NextResponse.json({
        link_token: 'mock-link-token-for-ui-testing',
        is_mock: true,
      });
    }

    const request = {
      user: {
        client_user_id: 'user-id-123', // In a real app, this comes from your auth system
      },
      client_name: 'FinSpace Budget App',
      products: [Products.Auth, Products.Transactions],
      country_codes: [CountryCode.Us, CountryCode.Ca],
      language: 'en',
    };

    const response = await client.linkTokenCreate(request);
    return NextResponse.json(response.data);
  } catch (error: any) {
    console.error('Error creating link token:', error.response?.data || error.message);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
