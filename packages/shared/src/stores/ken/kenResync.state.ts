import { UserService } from '../../services/user.service';
import { useAuthStore } from '../authStore';

let realtimeRevision = 0;
let resyncQueued = false;
let resyncPromise: Promise<void> | null = null;

export function markKenRealtimeUpdate(): void {
  realtimeRevision += 1;
}

async function resyncKenBalanceOnce(): Promise<void> {
  const expectedUserId = useAuthStore.getState().user?.id;
  if (expectedUserId == null) return;

  const revisionAtStart = realtimeRevision;
  const refreshedUser = await UserService.me().catch(() => null);
  if (
    refreshedUser == null ||
    refreshedUser.id !== expectedUserId ||
    typeof refreshedUser.ken !== 'number' ||
    realtimeRevision !== revisionAtStart
  )
    return;

  const { user, setUser } = useAuthStore.getState();
  if (user?.id !== expectedUserId) return;
  setUser({ ...user, ken: refreshedUser.ken });
}

async function runResyncQueue(): Promise<void> {
  do {
    resyncQueued = false;
    await resyncKenBalanceOnce();
  } while (resyncQueued);
}

export function resyncKenBalance(): Promise<void> {
  if (resyncPromise != null) {
    resyncQueued = true;
    return resyncPromise;
  }

  const promise = runResyncQueue().finally(() => {
    if (resyncPromise === promise) resyncPromise = null;
  });
  resyncPromise = promise;
  return promise;
}
