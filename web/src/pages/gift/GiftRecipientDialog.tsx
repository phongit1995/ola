import { useTranslation } from 'react-i18next';
import { Dialog, UserSearchPicker, type GiftReceiver } from '@components';
import { colorForName, toast } from '@lib';
import type { UserSearchResult } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import giftIcon from '@/assets/icons/apps/gift.webp';

interface GiftRecipientDialogProps {
  onClose: () => void;
  onPick: (receiver: GiftReceiver) => void;
}

export function GiftRecipientDialog({ onClose, onPick }: GiftRecipientDialogProps) {
  const { t } = useTranslation();
  const myId = useAuthStore((s) => s.user?.id ?? '');

  function pick(user: UserSearchResult) {
    if (user.id === myId) {
      toast.error(t('gift.errors.self'));
      return;
    }
    onPick({
      id: user.id,
      name: user.fullName || user.username,
      username: user.username,
      avatar: user.avatar,
      avatarFrameId: user.avatarFrameId,
      color: colorForName(user.username),
    });
  }

  return (
    <Dialog
      open
      onClose={onClose}
      title={t('gift.title')}
      icon={<img src={giftIcon} alt="" className="h-6 w-6 object-contain" />}
    >
      <UserSearchPicker
        label={t('gift.receiverLabel')}
        placeholder={t('gift.receiverHint')}
        onPick={pick}
      />
    </Dialog>
  );
}
