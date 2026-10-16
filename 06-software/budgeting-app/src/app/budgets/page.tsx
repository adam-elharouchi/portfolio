"use client";

import { useStore } from '@/store/useStore';
import { PieChart, Droplets, ShoppingBag, Map } from 'lucide-react';

const budgets = [
  { name: 'Food & Dining', spent: 340, limit: 500, icon: ShoppingBag, color: 'text-primary', bg: 'bg-primary' },
  { name: 'Transportation', spent: 120, limit: 200, icon: Map, color: 'text-accent', bg: 'bg-accent' },
  { name: 'Bills & Utilities', spent: 450, limit: 450, icon: Droplets, color: 'text-destructive', bg: 'bg-destructive' },
];

export default function Budgets() {
  return (
    <div className="flex flex-col gap-8 pb-10">
      <div className="flex justify-between items-end">
        <div>
          <h1 className="text-3xl font-bold text-white mb-2">Budgets</h1>
          <p className="text-muted-foreground">Keep your spending limits on track.</p>
        </div>
        <button className="bg-white/5 hover:bg-white/10 border border-white/10 text-white px-4 py-2 rounded-lg text-sm font-semibold transition-all">
          New Budget
        </button>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {budgets.map((b) => {
          const percent = Math.min((b.spent / b.limit) * 100, 100);
          const isOver = b.spent >= b.limit;

          return (
            <div key={b.name} className="glass-card rounded-2xl p-6">
              <div className="flex items-center gap-4 mb-6">
                <div className={`w-12 h-12 rounded-xl flex items-center justify-center bg-white/5 border border-white/10`}>
                  <b.icon className={`w-6 h-6 ${b.color}`} />
                </div>
                <div className="flex-1">
                   <h3 className="text-lg font-semibold text-white">{b.name}</h3>
                   <p className="text-sm text-muted-foreground">
                     ${b.spent} of ${b.limit} spent
                   </p>
                </div>
                <div className="text-right">
                   <span className={`text-sm font-bold ${isOver ? 'text-destructive' : 'text-success'}`}>
                     ${b.limit - b.spent} left
                   </span>
                </div>
              </div>

              {/* Progress Bar */}
              <div className="w-full bg-secondary rounded-full h-3 mb-2 overflow-hidden border border-white/5 relative">
                <div
                  className={`h-3 rounded-full transition-all duration-1000 ease-out ${isOver ? 'bg-destructive' : b.bg}`}
                  style={{ width: `${percent}%` }}
                ></div>
              </div>
              <div className="flex justify-between text-xs text-muted-foreground font-medium mt-2">
                <span>0%</span>
                <span>{percent.toFixed(0)}%</span>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
