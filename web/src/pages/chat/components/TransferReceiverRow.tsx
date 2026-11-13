import { UserRow } from '@components';
import { cn } from '@lib';
import type { TransferReceiver } from '../types';

interface TransferReceiverRowProps {
  receiver: TransferReceiver;
  className?: string;
}

export function TransferReceiverRow({
  receiver,
  className,
}: TransferReceiverRowProps) {
  return (
    <div className={cn('rounded border border-black/12 px-3', className)}>
      <UserRow
        name={receiver.name}
        username={receiver.username}
        avatar={receiver.avatar}
        color={receiver.color}
      />
    </div>
  );
}
