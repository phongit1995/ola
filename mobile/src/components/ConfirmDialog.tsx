import { useTranslation } from 'react-i18next';
import { Modal, Pressable, Text, View } from 'react-native';

interface ConfirmDialogProps {
  visible: boolean;
  title: string;
  message: string;
  confirmLabel?: string;
  cancelLabel?: string;
  danger?: boolean;
  onConfirm: () => void;
  onCancel: () => void;
}

export function ConfirmDialog({
  visible,
  title,
  message,
  confirmLabel,
  cancelLabel,
  danger,
  onConfirm,
  onCancel,
}: ConfirmDialogProps) {
  const { t } = useTranslation();

  return (
    <Modal visible={visible} transparent animationType="fade" onRequestClose={onCancel}>
      <Pressable className="flex-1 items-center justify-center bg-black/40 px-8" onPress={onCancel}>
        <Pressable className="w-full max-w-md rounded-2xl bg-white p-4" onPress={() => undefined}>
          <Text className="mb-1 text-base font-semibold" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {title}
          </Text>
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {message}
          </Text>
          <View className="mt-4 flex-row justify-end gap-2">
            <Pressable onPress={onCancel} className="rounded-full px-4 py-2">
              <Text className="text-sm font-semibold" style={{ color: 'rgba(0,0,0,0.54)' }}>
                {cancelLabel ?? t('dialog.cancel')}
              </Text>
            </Pressable>
            <Pressable
              onPress={onConfirm}
              className="rounded-full px-4 py-2"
              style={{ backgroundColor: danger ? '#e53935' : '#7cb342' }}
            >
              <Text className="text-sm font-semibold text-white">
                {confirmLabel ?? t('dialog.accept')}
              </Text>
            </Pressable>
          </View>
        </Pressable>
      </Pressable>
    </Modal>
  );
}
