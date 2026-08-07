import type { PostAuthor } from '../../types/api/me.type';
import { useAuthStore } from '../auth/authStore';

export function selfLiker(): PostAuthor | undefined {
  const user = useAuthStore.getState().user;
  if (user == null) return undefined;
  return { id: user.id, username: user.username, fullName: user.fullName, avatar: user.avatar };
}
