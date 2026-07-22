import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { OlaModal } from '@components/ui/OlaModal';
import { CachedImage } from '@components/ui/CachedImage';

interface CoverPreviewOverlayProps {
  visible: boolean;
  url: string;
  uploading: boolean;
  onCancel: () => void;
  onConfirm: () => void;
}

export function CoverPreviewOverlay(props: CoverPreviewOverlayProps) {
  return (
    <OlaModal
      visible={props.visible}
      animationType="fade"
      onRequestClose={props.onCancel}
    >
      <CoverPreviewBody {...props} />
    </OlaModal>
  );
}

function CoverPreviewBody({
  url,
  uploading,
  onCancel,
  onConfirm,
}: CoverPreviewOverlayProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();

  return (
    <View className="flex-1 bg-black" style={{ paddingTop: insets.top }}>
      <View className="h-12 items-center justify-center">
        <Text className="text-lg font-medium text-white">
          {t('profileEdit.coverPreviewTitle')}
        </Text>
      </View>

      <View className="min-h-0 flex-1 items-center justify-center p-4">
        {url !== '' && (
          <CachedImage
            uri={url}
            style={{ width: '100%', height: '100%' }}
            resizeMode="contain"
          />
        )}
      </View>

      <View
        className="flex-row gap-3 p-4"
        style={{ paddingBottom: Math.max(insets.bottom, 16) }}
      >
        <Pressable
          onPress={onCancel}
          disabled={uploading}
          className="h-11 flex-1 items-center justify-center rounded-full"
          style={{
            backgroundColor: 'rgba(255,255,255,0.15)',
            opacity: uploading ? 0.6 : 1,
          }}
        >
          <Text className="text-base font-medium text-white">
            {t('dialog.cancel')}
          </Text>
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
  );
}
