import type { UserIdentity } from '@components/user/types';

export interface TransferReceiver extends UserIdentity {
  id: string;
}
