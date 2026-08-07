import { create } from 'zustand';
import { TOAST_THROTTLE_MS } from '../../constants/toast';
import type { ToastState } from '../../types/client/toast.type';
import {
  isRecentDuplicateToast,
  nextToastId,
} from './toastRuntime.state';

export type {
  ToastItem,
  ToastType,
} from '../../types/client/toast.type';

export const useToastStore = create<ToastState>((set) => ({
  toasts: [],
  push: (type, message) => {
    const now = Date.now();
    if (isRecentDuplicateToast(message, now, TOAST_THROTTLE_MS)) return;
    const id = nextToastId();
    set((state) => ({ toasts: [...state.toasts, { id, type, message }] }));
  },
  dismiss: (id) =>
    set((state) => ({ toasts: state.toasts.filter((item) => item.id !== id) })),
}));
