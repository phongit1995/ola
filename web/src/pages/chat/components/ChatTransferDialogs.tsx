import { GiftPickerDialog } from '@components';
import { GIFT_SOURCE } from '@constants';
import type { TransferReceiver } from '../types';
import { TradingVipDialog } from './TradingVipDialog';
import { TransferKenDialog } from './TransferKenDialog';
import { TransferVipDaysDialog } from './TransferVipDaysDialog';
import { VipDayTransferDialog } from './VipDayTransferDialog';
import type { ChatTransferKind } from '@app-types';

interface ChatTransferDialogsProps {
  active: ChatTransferKind | null;
  receiver: TransferReceiver;
  receiverFrameId?: string | null;
  vipDayTransferEnabled: boolean;
  onClose: () => void;
}

export function ChatTransferDialogs({
  active,
  receiver,
  receiverFrameId,
  vipDayTransferEnabled,
  onClose,
}: ChatTransferDialogsProps) {
  const hasReceiver = receiver.id !== '';
  return (
    <>
      {active === 'ken' && hasReceiver && (
        <TransferKenDialog open onClose={onClose} receiver={receiver} />
      )}
      {active === 'vip' && (
        <TradingVipDialog open onClose={onClose} receiver={receiver} />
      )}
      {active === 'vipDays' && (
        <TransferVipDaysDialog open onClose={onClose} receiver={receiver} />
      )}
      {active === 'vipDayTransfer' && vipDayTransferEnabled && (
        <VipDayTransferDialog open onClose={onClose} receiver={receiver} />
      )}
      {hasReceiver && (
        <GiftPickerDialog
          open={active === 'gift'}
          source={GIFT_SOURCE.chat}
          onClose={onClose}
          receiver={{ ...receiver, avatarFrameId: receiverFrameId }}
        />
      )}
    </>
  );
}
