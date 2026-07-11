import { useTranslation } from 'react-i18next';
import { Text } from 'react-native';
import { Dialog, DialogButton } from './Dialog';

const infoIcon = require('../assets/icons/chat/ic_dialog_indicate_info.png');

interface ConfirmDialogProps {
  visible: boolean;
  title: string;
  message: string;
  confirmLabel?: string;
  cancelLabel?: string;
  danger?: boolean;
  showIcon?: boolean;
  onConfirm: () => void;
  onCancel: () => void;
}

export function ConfirmDialog({
  visible,
  title,
  message,
  confirmLabel,
  cancelLabel,
  danger = false,
  showIcon = true,
  onConfirm,
  onCancel,
}: ConfirmDialogProps) {
  const { t } = useTranslation();

  return (
    <Dialog
      visible={visible}
      onClose={onCancel}
      title={title}
      icon={showIcon ? infoIcon : undefined}
      footer={
        <>
          <DialogButton variant={danger ? 'danger' : 'green'} onPress={onConfirm}>
            {confirmLabel ?? t('dialog.accept')}
          </DialogButton>
          <DialogButton onPress={onCancel}>{cancelLabel ?? t('dialog.cancel')}</DialogButton>
        </>
      }
    >
      <Text className="text-sm leading-relaxed" style={{ color: '#616163' }}>
        {message}
      </Text>
    </Dialog>
  );
}
