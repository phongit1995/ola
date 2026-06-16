import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { LanguageSwitcher } from '@components/LanguageSwitcher';
import { Avatar } from '@components';
import { DEFAULT_AVATAR_COLOR } from '@lib';

interface MeAccountDialogProps {
  open: boolean;
  displayName: string;
  onClose: () => void;
  onViewProfile: () => void;
}

export function MeAccountDialog({
  open,
  displayName,
  onClose,
  onViewProfile,
}: MeAccountDialogProps) {
  const { t } = useTranslation();

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={displayName}
      footer={
        <DialogButton variant="green" onClick={onViewProfile}>
          {t('me.viewProfile')}
        </DialogButton>
      }
    >
      <div className="flex flex-col items-center gap-3 py-2">
        <Avatar name={displayName} color={DEFAULT_AVATAR_COLOR} size={64} />
        <p className="text-base font-medium text-black/87">{displayName}</p>
        <LanguageSwitcher tone="dark" />
      </div>
    </Dialog>
  );
}
