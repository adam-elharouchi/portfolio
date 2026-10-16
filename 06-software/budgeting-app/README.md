# Personal Finance Dashboard

**Next.js 15 · TypeScript · Plaid API · Zustand · ~900 lines**

A personal budgeting application that connects to real bank accounts through Plaid and tracks
transactions, budgets, and recurring subscriptions.

## Features

| Route | Purpose |
|---|---|
| `/` | Dashboard with cash-flow chart |
| `/transactions` | Transaction list from linked accounts |
| `/budgets` | Budget creation and tracking |
| `/subscriptions` | Recurring-payment detection |

## Architecture

```
src/
├── app/
│   ├── api/plaid/
│   │   ├── create_link_token/     Plaid Link initialisation
│   │   ├── exchange_public_token/  public → access token exchange
│   │   ├── accounts/               account balances
│   │   └── transactions/           transaction retrieval
│   ├── page.tsx                    dashboard
│   ├── transactions/ budgets/ subscriptions/
├── components/
│   ├── plaid/PlaidLinkButton.tsx   Plaid Link flow
│   ├── dashboard/CashFlowChart.tsx
│   └── layout/
└── store/useStore.ts               Zustand global state
```

**Bank integration via Plaid.** The OAuth-style token exchange runs entirely server-side in
Next.js route handlers: the client receives a short-lived `link_token`, Plaid Link returns a
`public_token`, and the server exchanges that for a long-lived `access_token` which never reaches
the browser. Every Plaid credential is read from environment variables and validated before use —
there are no secrets in the repository, which is the whole point of putting the exchange on the
server rather than doing it in the client.

**Zustand over Redux** for state. For four routes sharing account and transaction data, Redux's
boilerplate buys nothing.

## Stack
Next.js 15 (App Router) · TypeScript · Tailwind CSS · Zustand · Plaid API · Recharts

## Status
Working prototype. Core flows — account linking, transaction sync, budget tracking — are
functional; it is not deployed.

## Setup
```bash
npm install
# .env.local: PLAID_CLIENT_ID, PLAID_SECRET, PLAID_ENV, PLAID_ACCESS_TOKEN
npm run dev
```
