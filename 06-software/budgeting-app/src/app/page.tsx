"use client";

import { useStore } from '@/store/useStore';
import { ArrowUpRight, ArrowDownRight, DollarSign, CreditCard, Activity } from 'lucide-react';
import { CashFlowChart } from '@/components/dashboard/CashFlowChart';

const stats = [
  { name: 'Total Balance', value: '$12,450.00', change: '+4.75%', changeType: 'positive', icon: DollarSign },
  { name: 'Monthly Spending', value: '$3,210.00', change: '-1.5%', changeType: 'positive', icon: CreditCard },
  { name: 'Active Subscriptions', value: '$145.99', change: '+12.5%', changeType: 'negative', icon: Activity },
];

export default function Dashboard() {
  const { transactions } = useStore();

  return (
    <div className="flex flex-col gap-8 pb-10">
      <div>
        <h1 className="text-3xl font-bold text-white mb-2">Welcome back!</h1>
        <p className="text-muted-foreground">Here is what's happening with your money today.</p>
      </div>

      {/* Stats Cards */}
      <dl className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {stats.map((stat) => (
          <div
            key={stat.name}
            className="relative overflow-hidden rounded-2xl glass-card p-6"
          >
            <dt>
              <div className="absolute rounded-lg bg-primary/10 p-3">
                <stat.icon className="h-6 w-6 text-primary" aria-hidden="true" />
              </div>
              <p className="ml-16 truncate text-sm font-medium text-muted-foreground">{stat.name}</p>
            </dt>
            <dd className="ml-16 flex items-baseline pb-1">
              <p className="text-2xl font-semibold text-white">{stat.value}</p>
              <p
                className={`ml-2 flex items-baseline text-sm font-semibold ${
                  stat.changeType === 'positive' ? 'text-success' : 'text-destructive'
                }`}
              >
                {stat.changeType === 'positive' ? (
                  <ArrowUpRight className="h-4 w-4 shrink-0" aria-hidden="true" />
                ) : (
                  <ArrowDownRight className="h-4 w-4 shrink-0" aria-hidden="true" />
                )}
                {stat.change}
              </p>
            </dd>
          </div>
        ))}
      </dl>

      {/* Main Content Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        {/* Cash Flow Chart Area */}
        <div className="lg:col-span-2 glass-card rounded-2xl p-6 min-h-[400px] flex flex-col relative">
          <h2 className="text-lg font-semibold text-white mb-4">Cash Flow</h2>
          <div className="flex-1 min-h-[300px] relative">
            <CashFlowChart />
          </div>
        </div>

        {/* Recent Transactions */}
        <div className="glass-card rounded-2xl p-6 flex flex-col">
          <h2 className="text-lg font-semibold text-white mb-4">Recent Transactions</h2>
          {transactions.length === 0 ? (
            <div className="flex-1 flex items-center justify-center text-muted-foreground text-sm text-center">
              No transactions yet. <br /> Connect a bank to see data.
            </div>
          ) : (
            <div className="space-y-4">
              {transactions.slice(0, 5).map((t) => (
                <div key={t.transaction_id} className="flex justify-between items-center bg-white/5 p-3 rounded-xl border border-white/5">
                  <div className="flex gap-3 items-center">
                    <div className="h-10 w-10 rounded-full bg-secondary flex items-center justify-center">
                      <CreditCard className="h-5 w-5 text-muted-foreground" />
                    </div>
                    <div>
                      <p className="text-sm font-medium text-white">{t.name}</p>
                      <p className="text-xs text-muted-foreground">{t.date}</p>
                    </div>
                  </div>
                  <span className="text-sm font-semibold text-white">
                    ${t.amount.toFixed(2)}
                  </span>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
