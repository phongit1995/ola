import { UserIdentityRow } from '@components/user/UserIdentityRow';
import type { TransferReceiver } from './types';

interface TransferReceiverRowProps {
  receiver: TransferReceiver;
  onPress?: () => void;
}

export function TransferReceiverRow({
  receiver,
  onPress,
}: TransferReceiverRowProps) {
  return <UserIdentityRow user={receiver} onPress={onPress} />;
}
