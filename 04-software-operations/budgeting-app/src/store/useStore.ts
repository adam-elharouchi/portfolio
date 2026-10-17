import { create } from 'zustand';
import { persist } from 'zustand/middleware';

export interface Account {
  id: string;
  name: string;
  mask: string;
  type: string;
  subtype: string;
  balance: {
    current: number;
    available?: number;
    iso_currency_code: string;
  };
}

export interface Transaction {
  transaction_id: string;
  account_id: string;
  amount: number;
  date: string;
  name: string;
  merchant_name?: string;
  category: string[];
  pending: boolean;
}

interface AppState {
  isSidebarOpen: boolean;
  setSidebarOpen: (isOpen: boolean) => void;
  accounts: Account[];
  setAccounts: (accounts: Account[]) => void;
  transactions: Transaction[];
  setTransactions: (transactions: Transaction[]) => void;
  isLoading: boolean;
  setLoading: (isLoading: boolean) => void;
}

export const useStore = create<AppState>()(
  persist(
    (set) => ({
      isSidebarOpen: false,
      setSidebarOpen: (isOpen) => set({ isSidebarOpen: isOpen }),
      accounts: [],
      setAccounts: (accounts) => set({ accounts }),
      transactions: [],
      setTransactions: (transactions) => set({ transactions }),
      isLoading: false,
      setLoading: (isLoading) => set({ isLoading }),
    }),
    {
      name: 'budget-app-storage',
      partialize: (state) => ({ accounts: state.accounts, transactions: state.transactions }),
    }
  )
);
