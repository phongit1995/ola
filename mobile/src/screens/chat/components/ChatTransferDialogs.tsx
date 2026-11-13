import { GIFT_SOURCE } from '@ola/shared/constants';
import type { ChatTransferKind } from '@ola/shared/types';
import { GiftPickerDialog, type GiftReceiver } from '@components/gift/GiftPickerDialog';
import type { TransferReceiver } from '@components/transfer/types';
import { TransferKenDialog } from '@screens/ken/components/TransferKenDialog';
import { TradingVipDialog } from './TradingVipDialog';
import { TransferVipDaysDialog } from './TransferVipDaysDialog';
import { VipDayTransferDialog } from './VipDayTransferDialog';

interface ChatTransferDialogsProps {
  active: ChatTransferKind | null;
  receiver: TransferReceiver & Pick<GiftReceiver, 'avatarFrameId'>;
  vipDayTransferEnabled: boolean;
  onClose: () => void;
}

export function ChatTransferDialogs({
  active,
  receiver,
  vipDayTransferEnabled,
  onClose,
}: ChatTransferDialogsProps) {
  return (
    <>
      {active === 'ken' && <TransferKenDialog visible onClose={onClose} receiver={receiver} />}
      {active === 'vipDays' && (
        <TransferVipDaysDialog visible onClose={onClose} receiver={receiver} />
      )}
      {active === 'vipDayTransfer' && vipDayTransferEnabled && (
        <VipDayTransferDialog visible onClose={onClose} receiver={receiver} />
      )}
      {active === 'gift' && (
        <GiftPickerDialog source={GIFT_SOURCE.chat} onClose={onClose} receiver={receiver} />
      )}
      {active === 'vip' && <TradingVipDialog visible onClose={onClose} receiver={receiver} />}
    </>
  );
}
