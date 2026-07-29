export type ToastType = 'error' | 'success' | 'info';

export interface ToastItem {
  id: number;
  type: ToastType;
  message: string;
}

export interface ToastState {
  toasts: ToastItem[];
  push: (type: ToastType, message: string) => void;
  dismiss: (id: number) => void;
}
