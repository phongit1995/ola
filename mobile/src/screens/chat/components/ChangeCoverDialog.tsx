import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text } from 'react-native';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { COVER_ASPECT } from '@ola/shared/constants';
import { COVER_OUTPUT } from '@lib/imagePicker';
import { ChangeUserImageDialog } from './ChangeUserImageDialog';

interface ChangeCoverDialogProps {
  visible: boolean;
  onClose: () => void;
}

export function ChangeCoverDialog({ visible, onClose }: ChangeCoverDialogProps) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);

  if (user == null) return null;

  return (
    <ChangeUserImageDialog
      visible={visible}
      onClose={onClose}
      outputWidth={COVER_OUTPUT.width}
      outputHeight={COVER_OUTPUT.height}
      currentUrl={user.coverPhoto ?? ''}
      buildUpdate={(url) => ({ coverPhoto: url })}
      texts={{
        title: t('cover.title'),
        tooSmall: t('cover.tooSmall'),
        error: t('cover.error'),
        success: t('cover.success'),
        saving: t('cover.saving'),
        save: t('cover.save'),
        cancel: t('cover.cancel'),
        changeHint: t('cover.changeHint'),
        postToMe: t('cover.postToMe'),
        postContent: t('cover.postContent'),
      }}
      renderPicker={({ shownUri, saving, openPicker }) => (
        <Pressable
          accessibilityLabel={t('cover.title')}
          onPress={openPicker}
          className="w-full items-center justify-center overflow-hidden rounded-lg"
          style={{
            aspectRatio: COVER_ASPECT,
            backgroundColor: 'rgba(0,0,0,0.05)',
            opacity: saving ? 0.6 : 1,
          }}
        >
          {shownUri !== '' ? (
            <Image
              source={{ uri: shownUri }}
              style={{ width: '100%', height: '100%' }}
              resizeMode="cover"
            />
          ) : (
            <Text
              className="px-4 text-center text-sm"
              style={{ color: 'rgba(0,0,0,0.4)' }}
            >
              {t('cover.changeHint')}
            </Text>
          )}
        </Pressable>
      )}
    />
  );
}
