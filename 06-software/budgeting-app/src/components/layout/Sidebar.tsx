"use client";

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { Home, List, PieChart, Wallet, Settings } from 'lucide-react';
import { clsx, type ClassValue } from 'clsx';
import { twMerge } from 'tailwind-merge';

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

const navigation = [
  { name: 'Dashboard', href: '/', icon: Home },
  { name: 'Transactions', href: '/transactions', icon: List },
  { name: 'Budgets', href: '/budgets', icon: PieChart },
  { name: 'Subscriptions', href: '/subscriptions', icon: Wallet },
  { name: 'Settings', href: '/settings', icon: Settings },
];

export function Sidebar() {
  const pathname = usePathname();

  return (
    <div className="flex flex-col w-64 h-full border-r border-border bg-card/40 glass">
      <div className="flex h-16 shrink-0 items-center px-6">
        <div className="flex justify-center items-center gap-2">
          <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-primary to-accent flex items-center justify-center">
            <Wallet className="w-5 h-5 text-white" />
          </div>
          <span className="text-xl font-bold gradient-text tracking-tight">FinSpace</span>
        </div>
      </div>
      <div className="flex flex-1 flex-col py-6 px-4 gap-2">
        {navigation.map((item) => {
          const isActive = pathname === item.href;
          return (
            <Link
              key={item.name}
              href={item.href}
              className={cn(
                "group flex gap-x-3 rounded-lg p-3 text-sm leading-6 font-semibold transition-all duration-200",
                isActive
                  ? "bg-primary/10 text-primary"
                  : "text-muted-foreground hover:bg-white/5 hover:text-white"
              )}
            >
              <item.icon className="h-5 w-5 shrink-0" aria-hidden="true" />
              {item.name}
            </Link>
          );
        })}
      </div>
    </div>
  );
}
