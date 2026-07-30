import type { UserSearchResult } from '@ola/shared/types';
import type { UserIdentity } from './types';

export function userIdentityFromSearchResult(
  user: UserSearchResult,
): UserIdentity {
  return {
    name: user.fullName || user.username,
    username: user.username,
    avatar: user.avatar,
    online: user.isOnline,
  };
}
