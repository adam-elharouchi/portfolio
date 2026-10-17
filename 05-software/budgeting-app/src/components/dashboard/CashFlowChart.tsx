"use client";

import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend,
} from 'chart.js';
import { Bar } from 'react-chartjs-2';

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
);

const labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];

export const data = {
  labels,
  datasets: [
    {
      label: 'Income',
      data: [3200, 3100, 3300, 4200, 3400, 3100, 4500],
      backgroundColor: 'rgba(59, 130, 246, 0.8)', // Primary blue
      borderRadius: 6,
    },
    {
      label: 'Expenses',
      data: [2100, 2600, 2300, 2900, 2400, 2500, 3100],
      backgroundColor: 'rgba(34, 211, 238, 0.8)', // Accent cyan
      borderRadius: 6,
    },
  ],
};

const options = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      position: 'top' as const,
      labels: {
        color: '#9ca3af',
        font: {
          family: 'Inter, sans-serif',
          weight: 500,
        }
      }
    },
    tooltip: {
      backgroundColor: '#1f2229',
      titleColor: '#f3f4f6',
      bodyColor: '#f3f4f6',
      borderColor: '#2d3240',
      borderWidth: 1,
      padding: 12,
      cornerRadius: 8,
    }
  },
  scales: {
    y: {
      grid: {
        color: '#2d3240',
      },
      ticks: {
        color: '#9ca3af',
        callback: function(value: any) {
          return '$' + value;
        }
      }
    },
    x: {
      grid: {
        display: false,
      },
      ticks: {
        color: '#9ca3af',
      }
    }
  }
};

export function CashFlowChart() {
  return <Bar options={options} data={data} />;
}
