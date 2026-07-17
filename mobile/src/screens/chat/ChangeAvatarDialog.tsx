import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { MeService, UserService } from '@ola/shared/services';
import type { NativeUploadFile } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { Avatar } from '@components/Avatar';
import { Dialog, DialogButton } from '@components/Dialog';
import { pickCroppedImage } from '@lib/imagePicker';

const cameraIcon = require('@assets/icons/profile/ic_action_camera.png');

const AVATAR_OUTPUT = 800;
const MIN_SOURCE_WIDTH = 100;

interface ChangeAvatarDialogProps {
  visible: boolean;
  onClose: () => void;
}

function CheckBox({ checked }: { checked: boolean }) {
  return (
    <View
      className="h-5 w-5 items-center justify-center rounded"
      style={{
        borderWidth: checked ? 0 : 1,
        borderColor: 'rgba(0,0,0,0.3)',
        backgroundColor: checked ? '#7cb342' : 'transparent',
      }}
    >
      {checked && <Text className="text-xs font-bold text-white">✓</Text>}
    </View>
  );
}

export function ChangeAvatarDialog({ visible, onClose }: ChangeAvatarDialogProps) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const push = useToastStore((s) => s.push);

  const [file, setFile] = useState<NativeUploadFile | null>(null);
  const [postToMe, setPostToMe] = useState(false);
  const [saving, setSaving] = useState(false);

  function close() {
    if (saving) return;
    setFile(null);
    setPostToMe(false);
    onClose();
  }

  async function pick() {
    if (saving) return;
    let picked;
    try {
      picked = await pickCroppedImage(AVATAR_OUTPUT, AVATAR_OUTPUT);
    } catch {
      push('error', t('avatar.error'));
      return;
    }
    if (picked == null) return;
    if (Math.min(picked.sourceWidth, picked.sourceHeight) < MIN_SOURCE_WIDTH) {
      push('error', t('avatar.tooSmall'));
      return;
    }
    setFile(picked.file);
  }

  async function save() {
    if (file == null || saving) return;
    setSaving(true);
    try {
      const uploaded = await UserService.uploadAvatar(file);
      await UserService.updateMe({ avatar: uploaded.url });
      if (postToMe) {
        await MeService.create({
          content: t('avatar.postContent'),
          images: [{ url: uploaded.url }],
        });
      }
      await refreshUser();
      push('success', t('avatar.success'));
      setSaving(false);
      setFile(null);
      setPostToMe(false);
      onClose();
    } catch {
      push('error', t('avatar.error'));
      setSaving(false);
    }
  }

  if (user == null) return null;

  const nick = user.fullName || user.username;
  const shownAvatar = file?.uri ?? user.avatar ?? '';

  return (
    <Dialog
      visible={visible}
      onClose={close}
      dismissOnBackdrop={!saving}
      title={t('avatar.title')}
      footer={
        <>
          <DialogButton variant="green" onPress={() => void save()} disabled={saving || file == null}>
            {saving ? t('avatar.saving') : t('avatar.save')}
          </DialogButton>
          <DialogButton variant="default" onPress={close} disabled={saving}>
            {t('avatar.cancel')}
          </DialogButton>
        </>
      }
    >
      <View className="items-center py-2">
        <Pressable
          accessibilityLabel={t('avatar.title')}
          onPress={() => void pick()}
          style={{ opacity: saving ? 0.6 : 1 }}
        >
          {shownAvatar !== '' ? (
            <Image
              source={{ uri: shownAvatar }}
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

        <Text className="mt-3 text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
          {t('avatar.changeHint')}
        </Text>

        <Pressable
          className="mt-6 flex-row items-center justify-center gap-3"
          onPress={() => setPostToMe((v) => !v)}
          disabled={saving}
        >
          <CheckBox checked={postToMe} />
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {t('avatar.postToMe')}
          </Text>
        </Pressable>
      </View>
    </Dialog>
  );
}
