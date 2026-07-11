import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { MeService, UserService } from '@ola/shared/services';
import type { NativeUploadFile } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { Dialog, DialogButton } from '../../components/Dialog';
import { pickCroppedImage } from '../../lib/imagePicker';

const COVER_OUTPUT = { width: 1600, height: 900 };
const COVER_ASPECT = 16 / 9;
const MIN_SOURCE_WIDTH = 100;

interface ChangeCoverDialogProps {
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

export function ChangeCoverDialog({ visible, onClose }: ChangeCoverDialogProps) {
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
      picked = await pickCroppedImage(COVER_OUTPUT.width, COVER_OUTPUT.height);
    } catch {
      push('error', t('cover.error'));
      return;
    }
    if (picked == null) return;
    if (Math.min(picked.sourceWidth, picked.sourceHeight) < MIN_SOURCE_WIDTH) {
      push('error', t('cover.tooSmall'));
      return;
    }
    setFile(picked.file);
  }

  async function save() {
    if (file == null || saving) return;
    setSaving(true);
    try {
      const uploaded = await UserService.uploadAvatar(file);
      await UserService.updateMe({ coverPhoto: uploaded.url });
      if (postToMe) {
        await MeService.create({
          content: t('cover.postContent'),
          images: [{ url: uploaded.url }],
        });
      }
      await refreshUser();
      push('success', t('cover.success'));
      setSaving(false);
      setFile(null);
      setPostToMe(false);
      onClose();
    } catch {
      push('error', t('cover.error'));
      setSaving(false);
    }
  }

  if (user == null) return null;

  const shownCover = file?.uri ?? user.coverPhoto ?? '';

  return (
    <Dialog
      visible={visible}
      onClose={close}
      dismissOnBackdrop={!saving}
      title={t('cover.title')}
      footer={
        <>
          <DialogButton variant="green" onPress={() => void save()} disabled={saving || file == null}>
            {saving ? t('cover.saving') : t('cover.save')}
          </DialogButton>
          <DialogButton variant="default" onPress={close} disabled={saving}>
            {t('cover.cancel')}
          </DialogButton>
        </>
      }
    >
      <View className="items-center py-2">
        <Pressable
          accessibilityLabel={t('cover.title')}
          onPress={() => void pick()}
          className="w-full items-center justify-center overflow-hidden rounded-lg"
          style={{
            aspectRatio: COVER_ASPECT,
            backgroundColor: 'rgba(0,0,0,0.05)',
            opacity: saving ? 0.6 : 1,
          }}
        >
          {shownCover !== '' ? (
            <Image
              source={{ uri: shownCover }}
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

        <Text className="mt-3 text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
          {t('cover.changeHint')}
        </Text>

        <Pressable
          className="mt-6 flex-row items-center justify-center gap-3"
          onPress={() => setPostToMe((v) => !v)}
          disabled={saving}
        >
          <CheckBox checked={postToMe} />
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {t('cover.postToMe')}
          </Text>
        </Pressable>
      </View>
    </Dialog>
  );
}
