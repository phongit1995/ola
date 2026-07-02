import { create } from 'zustand';

export type ToastType = 'error' | 'success' | 'info';

export interface ToastItem {
  id: number;
  type: ToastType;
  message: string;
}

interface ToastState {
  toasts: ToastItem[];
  push: (type: ToastType, message: string) => void;
  dismiss: (id: number) => void;
}

const THROTTLE_MS = 1500;

let counter = 0;
let lastMessage = '';
let lastAt = 0;

export const useToastStore = create<ToastState>((set) => ({
  toasts: [],
  push: (type, message) => {
    const now = Date.now();
    if (message === lastMessage && now - lastAt < THROTTLE_MS) return;
    lastMessage = message;
    lastAt = now;
    counter += 1;
    const id = counter;
    set((state) => ({ toasts: [...state.toasts, { id, type, message }] }));
  },
  dismiss: (id) =>
    set((state) => ({ toasts: state.toasts.filter((item) => item.id !== id) })),
}));
