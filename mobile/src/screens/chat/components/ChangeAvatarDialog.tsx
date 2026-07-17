import { useTranslation } from 'react-i18next';
import { Image, Pressable, View } from 'react-native';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { Avatar } from '@components/ui/Avatar';
import { AVATAR_OUTPUT } from '@lib/imagePicker';
import { ChangeUserImageDialog } from './ChangeUserImageDialog';

const cameraIcon = require('@assets/icons/profile/ic_action_camera.png');

interface ChangeAvatarDialogProps {
  visible: boolean;
  onClose: () => void;
}

export function ChangeAvatarDialog({ visible, onClose }: ChangeAvatarDialogProps) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);

  if (user == null) return null;

  const nick = user.fullName || user.username;

  return (
    <ChangeUserImageDialog
      visible={visible}
      onClose={onClose}
      outputWidth={AVATAR_OUTPUT}
      outputHeight={AVATAR_OUTPUT}
      currentUrl={user.avatar ?? ''}
      buildUpdate={(url) => ({ avatar: url })}
      texts={{
        title: t('avatar.title'),
        tooSmall: t('avatar.tooSmall'),
        error: t('avatar.error'),
        success: t('avatar.success'),
        saving: t('avatar.saving'),
        save: t('avatar.save'),
        cancel: t('avatar.cancel'),
        changeHint: t('avatar.changeHint'),
        postToMe: t('avatar.postToMe'),
        postContent: t('avatar.postContent'),
      }}
      renderPicker={({ shownUri, saving, openPicker }) => (
        <Pressable
          accessibilityLabel={t('avatar.title')}
          onPress={openPicker}
          style={{ opacity: saving ? 0.6 : 1 }}
        >
          {shownUri !== '' ? (
            <Image
              source={{ uri: shownUri }}
              style={{ width: 112, height: 112, borderRadius: 56 }}
              resizeMode="cover"
            />
          ) : (
            <Avatar name={nick} size={112} />
          )}
          <View
            className="absolute bottom-0 right-0 h-8 w-8 items-center justify-center rounded-full bg-ola-primary"
            style={{ borderWidth: 2, borderColor: '#fff' }}
          >
            <Image
              source={cameraIcon}
              style={{ width: 18, height: 18, tintColor: '#fff' }}
              resizeMode="contain"
            />
          </View>
        </Pressable>
      )}
    />
  );
}
