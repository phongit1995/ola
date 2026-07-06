import type { PostAuthor } from '../types';
import { useAuthStore } from './authStore';

export function selfLiker(): PostAuthor | undefined {
  const user = useAuthStore.getState().user;
  if (user == null) return undefined;
  return { id: user.id, username: user.username, fullName: user.fullName, avatar: user.avatar };
}
