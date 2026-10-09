import { authTokens } from '@ola/shared/lib';
import { AuthService, SocketService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useSavedAccountsStore } from '@ola/shared/stores/savedAccountsStore';

export function removeSavedAccountOfCurrentUser(): void {
  const currentUsername = useAuthStore.getState().user?.username;
  if (currentUsername == null) return;
  const normalizedUsername = currentUsername.trim().toLowerCase();
  const savedAccount = useSavedAccountsStore
    .getState()
    .accounts.find((account) => account.username.trim().toLowerCase() === normalizedUsername);
  if (savedAccount != null) {
    useSavedAccountsStore.getState().removeAccount(savedAccount.username);
  }
}

export function clearSavedAccounts(): void {
  const store = useSavedAccountsStore.getState();
  for (const account of store.accounts) store.removeAccount(account.username);
}

export async function signOut(): Promise<boolean> {
  let revoked = true;
  try {
    await AuthService.logout();
  } catch {
    revoked = false;
  }
  authTokens.clear();
  SocketService.disconnect();
  useAuthStore.getState().clearUser();
  return revoked;
}
