"use client";

import { useState, useEffect, useCallback } from 'react';
import { usePlaidLink } from 'react-plaid-link';
import { PlusCircle, Loader2 } from 'lucide-react';
import { useStore } from '@/store/useStore';

export function PlaidLinkButton() {
  const [token, setToken] = useState<string | null>(null);
  const [isMock, setIsMock] = useState(false);
  const [isInitializing, setIsInitializing] = useState(true);
  const { setAccounts, setTransactions, setLoading, isLoading } = useStore();

  // Fetch Link Token when component mounts
  useEffect(() => {
    const createLinkToken = async () => {
      try {
        const response = await fetch('/api/plaid/create_link_token', {
          method: 'POST',
        });
        const data = await response.json();
        setToken(data.link_token);
        if (data.is_mock) setIsMock(true);
      } catch (err) {
        console.error("Failed to fetch link token", err);
      } finally {
        setIsInitializing(false);
      }
    };
    createLinkToken();
  }, []);

  const onSuccess = useCallback(
    async (public_token: string) => {
      setLoading(true);
      try {
        // Exchange public token
        await fetch('/api/plaid/exchange_public_token', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ public_token }),
        });

        // Fetch accounts
        const accountsRes = await fetch('/api/plaid/accounts');
        const accountsData = await accountsRes.json();
        if (accountsData.accounts) setAccounts(accountsData.accounts);

        // Fetch transactions
        const txRes = await fetch('/api/plaid/transactions');
        const txData = await txRes.json();
        if (txData.transactions) setTransactions(txData.transactions);

      } catch (err) {
        console.error("Error during Plaid success flow:", err);
      } finally {
        setLoading(false);
      }
    },
    [setAccounts, setTransactions, setLoading]
  );

  const config: Parameters<typeof usePlaidLink>[0] = {
    token: isMock ? null : token, // Don't pass mock token to real Plaid SDK
    onSuccess,
  };

  const { open, ready } = usePlaidLink(config);

  const handleConnect = () => {
    if (isMock) {
      // Bypass Plaid UI entirely and simulate success
      onSuccess('mock-public-token');
    } else if (ready) {
      open();
    }
  };

  return (
    <button
      onClick={handleConnect}
      disabled={isInitializing || isLoading || (!isMock && !ready)}
      className="flex items-center gap-2 bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm font-semibold transition-all shadow-lg shadow-primary/20 disabled:opacity-50 disabled:cursor-not-allowed"
    >
      {isLoading ? <Loader2 className="w-4 h-4 animate-spin" /> : <PlusCircle className="w-4 h-4" />}
      {isLoading ? "Connecting..." : "Connect Bank"}
    </button>
  );
}
