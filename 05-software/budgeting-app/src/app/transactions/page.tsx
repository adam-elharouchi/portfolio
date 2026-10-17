"use client";

import { useStore } from '@/store/useStore';
import { CreditCard, ArrowDownCircle, ArrowUpCircle } from 'lucide-react';

export default function Transactions() {
  const { transactions } = useStore();

  return (
    <div className="flex flex-col gap-8 pb-10">
      <div>
        <h1 className="text-3xl font-bold text-white mb-2">Transactions</h1>
        <p className="text-muted-foreground">View and search all your recent activity.</p>
      </div>

      <div className="glass-card rounded-2xl p-6">
        {transactions.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-20 text-muted-foreground text-center gap-4">
            <CreditCard className="w-12 h-12 opacity-20" />
            <p>No transactions yet.<br/>Connect a bank account to sync data.</p>
          </div>
        ) : (
          <div className="mt-4 overflow-hidden shadow ring-1 ring-white/5 sm:rounded-lg">
            <table className="min-w-full divide-y divide-white/10">
              <thead>
                <tr>
                  <th scope="col" className="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-white sm:pl-6">
                    Transaction
                  </th>
                  <th scope="col" className="px-3 py-3.5 text-left text-sm font-semibold text-white">
                    Category
                  </th>
                  <th scope="col" className="px-3 py-3.5 text-left text-sm font-semibold text-white">
                    Date
                  </th>
                  <th scope="col" className="px-3 py-3.5 text-right text-sm font-semibold text-white">
                    Amount
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-white/5 bg-transparent">
                {transactions.map((t) => (
                  <tr key={t.transaction_id} className="hover:bg-white/5 transition-colors">
                    <td className="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-white sm:pl-6">
                      <div className="flex items-center gap-3">
                        {t.amount > 0 ? (
                          <div className="p-2 rounded-full bg-destructive/10">
                            <ArrowDownCircle className="w-5 h-5 text-destructive" />
                          </div>
                        ) : (
                          <div className="p-2 rounded-full bg-success/10">
                            <ArrowUpCircle className="w-5 h-5 text-success" />
                          </div>
                        )}
                        {t.name}
                      </div>
                    </td>
                    <td className="whitespace-nowrap px-3 py-4 text-sm text-muted-foreground gap-2 hidden sm:flex">
                      {t.category.map((cat, i) => (
                        <span key={i} className="inline-flex items-center rounded-md bg-secondary px-2 py-1 text-xs font-medium text-muted-foreground ring-1 ring-inset ring-white/10">
                          {cat}
                        </span>
                      ))}
                    </td>
                    <td className="whitespace-nowrap px-3 py-4 text-sm text-muted-foreground">
                      {t.date}
                    </td>
                    <td className="whitespace-nowrap px-3 py-4 text-sm font-medium text-right text-white">
                      ${Math.abs(t.amount).toFixed(2)}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
