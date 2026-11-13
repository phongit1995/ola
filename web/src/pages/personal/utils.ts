import { useSavedAccountsStore } from '@ola/shared/stores/savedAccountsStore';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';

export function removeSavedAccount(username: string) {
  const normalizedUsername = username.trim().toLowerCase();
  const savedAccount = useSavedAccountsStore
    .getState()
    .accounts.find(
      (account) => account.username.trim().toLowerCase() === normalizedUsername
    );
  if (savedAccount != null) {
    useSavedAccountsStore.getState().removeAccount(savedAccount.username);
  }
}

export function removeSavedAccountOfCurrentUser() {
  const currentUsername = useAuthStore.getState().user?.username;
  if (currentUsername != null) removeSavedAccount(currentUsername);
}
