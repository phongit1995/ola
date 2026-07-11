import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, TextInput, View } from 'react-native';
import { UserService } from '@ola/shared/services';
import { ApiError } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { UpdateProfileRequest } from '@ola/shared/types';
import { pickSingleImage } from '../../lib/imagePicker';
import { Dialog, DialogButton } from '../../components/Dialog';

const snapPicIcon = require('../../assets/icons/chat/icon_snap_pic.png');

export function StatusEditDialog({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const push = useToastStore((s) => s.push);

  const [bio, setBio] = useState(user?.bio ?? '');
  const [imageUrl, setImageUrl] = useState(user?.bioImage ?? '');
  const [uploading, setUploading] = useState(false);
  const [saving, setSaving] = useState(false);

  if (user == null) return null;

  async function pickImage() {
    if (uploading) return;
    const picked = await pickSingleImage();
    if (picked == null) return;
    setUploading(true);
    try {
      const result = await UserService.uploadAvatar(picked.file);
      setImageUrl(result.url);
    } catch {
      push('error', t('avatar.error'));
    } finally {
      setUploading(false);
    }
  }

  async function save() {
    if (saving) return;
    setSaving(true);
    const payload: UpdateProfileRequest = { bio: bio.trim(), bioImage: imageUrl };
    try {
      await UserService.updateMe(payload);
      await refreshUser();
      push('success', t('statusDialog.saved'));
      onClose();
    } catch (err) {
      const message = err instanceof ApiError ? err.message : t('statusDialog.saveError');
      push('error', message);
      setSaving(false);
    }
  }

  return (
    <Dialog
      visible
      title={t('statusDialog.title')}
      onClose={onClose}
      footer={
        <>
          <DialogButton onPress={onClose} disabled={saving}>
            {t('common.cancel')}
          </DialogButton>
          <DialogButton variant="green" onPress={() => void save()} disabled={saving || uploading}>
            {t('statusDialog.save')}
          </DialogButton>
        </>
      }
    >
      <View className="flex-row items-center gap-3">
        <View className="relative shrink-0">
          <Pressable onPress={() => void pickImage()} disabled={uploading}>
            <Image
              source={imageUrl !== '' ? { uri: imageUrl } : snapPicIcon}
              style={{
                width: 56,
                height: 56,
                borderRadius: 2,
                borderWidth: 1,
                borderColor: 'rgba(0,0,0,0.12)',
              }}
              resizeMode={imageUrl !== '' ? 'cover' : 'contain'}
            />
          </Pressable>
          {imageUrl !== '' && (
            <Pressable
              onPress={() => setImageUrl('')}
              className="absolute -right-2 -top-2 h-6 w-6 items-center justify-center rounded-full"
              style={{ backgroundColor: 'rgba(0,0,0,0.6)', borderWidth: 1, borderColor: '#fff' }}
            >
              <Text className="text-xs font-bold text-white">×</Text>
            </Pressable>
          )}
        </View>
        <Pressable className="flex-1" onPress={() => void pickImage()} disabled={uploading}>
          <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {uploading
              ? t('common.loading')
              : imageUrl !== ''
                ? t('statusDialog.photoHint')
                : t('statusDialog.photoHintFirst')}
          </Text>
        </Pressable>
      </View>
      <TextInput
        autoFocus
        multiline
        value={bio}
        onChangeText={setBio}
        placeholder={t('chat.myStatusHint')}
        placeholderTextColor="rgba(0,0,0,0.38)"
        maxLength={500}
        className="mt-3 rounded-sm bg-white p-2 text-base"
        style={{
          minHeight: 96,
          textAlignVertical: 'top',
          borderWidth: 1,
          borderColor: 'rgba(0,0,0,0.12)',
          color: 'rgba(0,0,0,0.87)',
        }}
      />
    </Dialog>
  );
}
