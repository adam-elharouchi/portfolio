"use client";

import { useStore } from '@/store/useStore';
import { Activity, AlertTriangle } from 'lucide-react';

const mockSubscriptions = [
  { id: 1, name: 'Netflix', cost: 14.99, cycle: 'Monthly', nextDate: 'Apr 12', logo: 'N' },
  { id: 2, name: 'Spotify Premium', cost: 9.99, cycle: 'Monthly', nextDate: 'Apr 15', logo: 'S' },
  { id: 3, name: 'Amazon Prime', cost: 139.00, cycle: 'Yearly', nextDate: 'Nov 02', logo: 'A' },
  { id: 4, name: 'Gym Membership', cost: 45.00, cycle: 'Monthly', nextDate: 'Apr 21', logo: 'G' },
];

export default function Subscriptions() {
  const { transactions } = useStore();
  
  // In a real app, we'd detect subscriptions by grouping transactions with the exact same name and amount over recurring intervals.
  // We'll use mocked ones to show the UI for now.

  return (
    <div className="flex flex-col gap-8 pb-10">
      <div>
        <h1 className="text-3xl font-bold text-white mb-2">Subscriptions</h1>
        <p className="text-muted-foreground">Manage your recurring expenses in one place.</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mt-4">
        {mockSubscriptions.map((sub) => (
          <div key={sub.id} className="glass-card rounded-2xl p-6 flex flex-col gap-4 group hover:border-primary/50 transition-colors">
            <div className="flex justify-between items-start">
              <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-primary to-accent flex items-center justify-center shadow-lg font-bold text-xl text-white">
                {sub.logo}
              </div>
              <span className="inline-flex items-center rounded-md bg-white/5 px-2 py-1 text-xs font-medium text-muted-foreground ring-1 ring-inset ring-white/10">
                {sub.cycle}
              </span>
            </div>
            
            <div>
              <h3 className="text-xl font-bold text-white">{sub.name}</h3>
              <p className="text-2xl font-semibold text-primary mt-1">${sub.cost.toFixed(2)}</p>
            </div>
            
            <div className="flex items-center gap-2 mt-auto pt-4 border-t border-border">
              <Activity className="w-4 h-4 text-muted-foreground" />
              <span className="text-sm text-muted-foreground">Next billing: {sub.nextDate}</span>
            </div>
          </div>
        ))}
      </div>

      <div className="mt-8 rounded-xl bg-primary/10 border border-primary/20 p-6 flex items-start gap-4">
        <AlertTriangle className="w-6 h-6 text-primary shrink-0" />
        <div>
          <h4 className="text-sm font-semibold text-white">Unused Subscriptions Detected</h4>
          <p className="text-sm text-muted-foreground mt-1">
            We noticed you haven't used your Gym Membership in over 30 days. Consider canceling it to save $45/mo.
          </p>
        </div>
      </div>
    </div>
  );
}
