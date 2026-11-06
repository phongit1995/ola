import { useTranslation } from 'react-i18next';
import { colorForName } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { UserSearchResult } from '@ola/shared/types';
import type { GiftReceiver } from '@components/gift/GiftPickerDialog';
import { GIFT_ASSETS } from '@components/gift/giftAssets';
import { Dialog } from '@components/ui/Dialog';
import { UserSearchPicker } from '@components/user/UserSearchPicker';

interface GiftRecipientDialogProps {
  visible: boolean;
  onClose: () => void;
  onDismiss: () => void;
  onPick: (receiver: GiftReceiver) => void;
}

export function GiftRecipientDialog({ visible, onClose, onDismiss, onPick }: GiftRecipientDialogProps) {
  const { t } = useTranslation();
  const myId = useAuthStore((s) => s.user?.id ?? '');
  const push = useToastStore((s) => s.push);

  function pick(user: UserSearchResult) {
    if (user.id === myId) {
      push('error', t('gift.errors.self'));
      return;
    }
    onPick({
      id: user.id,
      name: user.fullName || user.username,
      avatar: user.avatar,
      color: colorForName(user.username),
    });
  }

  return (
    <Dialog
      visible={visible}
      onClose={onClose}
      onDismiss={onDismiss}
      title={t('gift.title')}
      icon={GIFT_ASSETS.icon}
    >
      <UserSearchPicker
        label={t('gift.receiverLabel')}
        placeholder={t('gift.receiverHint')}
        onPick={pick}
      />
    </Dialog>
  );
}
