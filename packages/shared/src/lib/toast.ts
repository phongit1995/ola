import { useToastStore } from '../stores/toastStore';

export const toast = {
  error: (message: string) => useToastStore.getState().push('error', message),
  success: (message: string) => useToastStore.getState().push('success', message),
  info: (message: string) => useToastStore.getState().push('info', message),
};
