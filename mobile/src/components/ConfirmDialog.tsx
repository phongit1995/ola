import { useTranslation } from 'react-i18next';
import { Image, Modal, Pressable, Text, View } from 'react-native';

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
    <Modal visible={visible} transparent animationType="fade" onRequestClose={onCancel}>
      <Pressable
        className="flex-1 items-center justify-center p-4"
        style={{ backgroundColor: 'rgba(0,0,0,0.6)' }}
        onPress={onCancel}
      >
        <Pressable
          className="w-full overflow-hidden bg-white"
          style={{
            minWidth: 280,
            maxWidth: 384,
            borderRadius: 5,
            shadowColor: '#000',
            shadowOpacity: 0.35,
            shadowRadius: 24,
            shadowOffset: { width: 0, height: 6 },
            elevation: 8,
          }}
          onPress={() => undefined}
        >
          <View
            className="flex-row items-center px-2 py-1"
            style={{
              minHeight: 38,
              gap: 5,
              backgroundColor: '#ebebeb',
              borderBottomWidth: 1,
              borderBottomColor: '#d1cece',
            }}
          >
            {showIcon && (
              <View className="items-center justify-center" style={{ width: 34, height: 34 }}>
                <Image source={infoIcon} style={{ width: 30, height: 32 }} resizeMode="contain" />
              </View>
            )}
            <Text
              numberOfLines={1}
              className="min-w-0 flex-1 text-xl font-bold"
              style={{ color: '#3a3839' }}
            >
              {title}
            </Text>
          </View>
          <View className="m-2" style={{ minHeight: 50 }}>
            <Text className="text-sm leading-relaxed" style={{ color: '#616163' }}>
              {message}
            </Text>
          </View>
          <View className="flex-row gap-2 px-1 pb-2">
            <Pressable
              onPress={onConfirm}
              className="flex-1 items-center justify-center px-1"
              style={{
                minHeight: 28,
                borderRadius: 2,
                paddingVertical: 5,
                backgroundColor: danger ? '#dd4b39' : '#9ccc65',
                borderWidth: danger ? 0 : 1,
                borderColor: '#558b2f',
              }}
            >
              <Text className="text-sm text-white">{confirmLabel ?? t('dialog.accept')}</Text>
            </Pressable>
            <Pressable
              onPress={onCancel}
              className="flex-1 items-center justify-center bg-white px-1"
              style={{
                minHeight: 28,
                borderRadius: 2,
                paddingVertical: 5,
                borderWidth: 1,
                borderColor: 'rgba(0,0,0,0.1)',
              }}
            >
              <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
                {cancelLabel ?? t('dialog.cancel')}
              </Text>
            </Pressable>
          </View>
        </Pressable>
      </Pressable>
    </Modal>
  );
}
