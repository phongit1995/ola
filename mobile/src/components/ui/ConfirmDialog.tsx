import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { useThemeColors } from '@hooks/useThemeColors';
import { Dialog, DialogButton } from './Dialog';

const infoIcon = require('@assets/icons/chat/ic_dialog_indicate_info.png');

interface ConfirmDialogProps {
  visible: boolean;
  title: string;
  message: string;
  confirmLabel?: string;
  cancelLabel?: string;
  danger?: boolean;
  showIcon?: boolean;
  checkboxLabel?: string;
  checked?: boolean;
  onCheckedChange?: (value: boolean) => void;
  onConfirm: () => void;
  onCancel: () => void;
  onDismiss?: () => void;
}

export function ConfirmDialog({
  visible,
  title,
  message,
  confirmLabel,
  cancelLabel,
  danger = false,
  showIcon = true,
  checkboxLabel,
  checked = false,
  onCheckedChange,
  onConfirm,
  onCancel,
  onDismiss,
}: ConfirmDialogProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();

  return (
    <Dialog
      visible={visible}
      onClose={onCancel}
      onDismiss={onDismiss}
      title={title}
      icon={showIcon ? infoIcon : undefined}
      avoidKeyboard={false}
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
      {checkboxLabel != null && (
        <Pressable
          accessibilityRole="checkbox"
          accessibilityState={{ checked }}
          disabled={onCheckedChange == null}
          onPress={() => onCheckedChange?.(!checked)}
          className="mt-3 flex-row items-center gap-2"
        >
          <View
            className="h-5 w-5 shrink-0 items-center justify-center rounded"
            style={{
              borderWidth: 2,
              borderColor: checked ? colors.primary : 'rgba(0,0,0,0.38)',
              backgroundColor: checked ? colors.primary : 'transparent',
            }}
          >
            {checked && <Text className="text-xs font-bold text-white">✓</Text>}
          </View>
          <Text className="flex-1 text-sm" style={{ color: '#616163' }}>
            {checkboxLabel}
          </Text>
        </Pressable>
      )}
    </Dialog>
  );
}
