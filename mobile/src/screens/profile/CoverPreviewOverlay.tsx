import { useTranslation } from 'react-i18next';
import { Image, Modal, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

interface CoverPreviewOverlayProps {
  visible: boolean;
  url: string;
  uploading: boolean;
  onCancel: () => void;
  onConfirm: () => void;
}

export function CoverPreviewOverlay({
  visible,
  url,
  uploading,
  onCancel,
  onConfirm,
}: CoverPreviewOverlayProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();

  return (
    <Modal visible={visible} animationType="fade" onRequestClose={onCancel}>
      <View className="flex-1 bg-black" style={{ paddingTop: insets.top }}>
        <View className="h-12 items-center justify-center">
          <Text className="text-lg font-medium text-white">{t('profileEdit.coverPreviewTitle')}</Text>
        </View>

        <View className="min-h-0 flex-1 items-center justify-center p-4">
          {url !== '' && (
            <Image source={{ uri: url }} className="h-full w-full" resizeMode="contain" />
          )}
        </View>

        <View className="flex-row gap-3 p-4" style={{ paddingBottom: Math.max(insets.bottom, 16) }}>
          <Pressable
            onPress={onCancel}
            disabled={uploading}
            className="h-11 flex-1 items-center justify-center rounded-full"
            style={{ backgroundColor: 'rgba(255,255,255,0.15)', opacity: uploading ? 0.6 : 1 }}
          >
            <Text className="text-base font-medium text-white">{t('dialog.cancel')}</Text>
          </Pressable>
          <Pressable
            onPress={onConfirm}
            disabled={uploading}
            className="h-11 flex-1 items-center justify-center rounded-full bg-ola-primary"
            style={{ opacity: uploading ? 0.6 : 1 }}
          >
            <Text className="text-base font-bold text-white">
              {uploading ? t('common.loading') : t('profileEdit.coverConfirm')}
            </Text>
          </Pressable>
        </View>
      </View>
    </Modal>
  );
}
