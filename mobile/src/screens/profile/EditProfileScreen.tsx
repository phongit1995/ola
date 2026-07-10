import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  ImageBackground,
  KeyboardAvoidingView,
  Platform,
  Pressable,
  ScrollView,
  Text,
  TextInput,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { UserService } from '@ola/shared/services';
import { ApiError } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { Gender, UpdateProfileRequest } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { Avatar } from '../../components/Avatar';
import { pickSingleImage } from '../../lib/imagePicker';
import { ChangePasswordDialog } from './ChangePasswordDialog';

const cameraIcon = require('../../assets/icons/profile/ic_action_camera.png');
const lockIcon = require('../../assets/icons/profile/ic_lock.png');
const maleIcon = require('../../assets/icons/profile/ic_indicate_male.png');
const femaleIcon = require('../../assets/icons/profile/ic_indicate_female.png');

const DIVIDER = 'rgba(0,0,0,0.12)';
const PHONE_PATTERN = /^[0-9+\-() ]{6,20}$/;
const MIN_AVATAR_SOURCE = 100;
const PLACEHOLDER_COLOR = '#e34545';

function Field({ label, first, children }: { label: string; first?: boolean; children: React.ReactNode }) {
  return (
    <View className={first ? '' : 'mt-4'}>
      <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>{label}</Text>
      <View className="mt-1">{children}</View>
      <View className="mt-4" style={{ height: 1, backgroundColor: DIVIDER }} />
    </View>
  );
}

type Props = NativeStackScreenProps<RootStackParamList, 'EditProfile'>;

export function EditProfileScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const user = useAuthStore((s) => s.user);
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const push = useToastStore((s) => s.push);
  const onClose = () => navigation.goBack();

  const [avatar, setAvatar] = useState(user?.avatar ?? '');
  const [fullName, setFullName] = useState(user?.fullName ?? '');
  const [phone, setPhone] = useState(user?.phone ?? '');
  const [gender, setGender] = useState<Gender>(user?.gender ?? 'male');
  const [dateOfBirth, setDateOfBirth] = useState(user?.dateOfBirth ?? '');
  const [saving, setSaving] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [uploadingCover, setUploadingCover] = useState(false);
  const [passwordOpen, setPasswordOpen] = useState(false);
  const [error, setError] = useState<string | null>(null);

  if (user == null) return null;

  const nick = user.fullName || user.username;
  const cover = user.coverPhoto ?? '';

  function validate(): string | null {
    if (fullName.trim() === '') return t('profileEdit.fullnameRequired');
    if (phone.trim() !== '' && !PHONE_PATTERN.test(phone.trim())) return t('profileEdit.phoneInvalid');
    return null;
  }

  async function pickAvatar() {
    if (uploading) return;
    const picked = await pickSingleImage();
    if (picked == null) return;
    if (picked.width > 0 && picked.height > 0 && Math.min(picked.width, picked.height) < MIN_AVATAR_SOURCE) {
      push('error', t('avatar.tooSmall'));
      return;
    }
    setUploading(true);
    try {
      const result = await UserService.uploadAvatar(picked.file);
      setAvatar(result.url);
      push('success', t('profileEdit.avatarUpdated'));
    } catch {
      push('error', t('profileEdit.avatarError'));
    } finally {
      setUploading(false);
    }
  }

  async function pickCover() {
    if (uploadingCover) return;
    const picked = await pickSingleImage();
    if (picked == null) return;
    setUploadingCover(true);
    try {
      const { url } = await UserService.uploadAvatar(picked.file);
      await UserService.updateMe({ coverPhoto: url });
      await refreshUser();
      push('success', t('profileEdit.coverUpdated'));
    } catch {
      push('error', t('profileEdit.coverError'));
    } finally {
      setUploadingCover(false);
    }
  }

  async function save() {
    if (saving) return;
    const validationError = validate();
    if (validationError != null) {
      setError(validationError);
      return;
    }
    setError(null);
    setSaving(true);
    const payload: UpdateProfileRequest = {
      avatar,
      fullName: fullName.trim(),
      phone: phone.trim(),
      gender,
      dateOfBirth,
    };
    try {
      await UserService.updateMe(payload);
      await refreshUser();
      push('success', t('profileEdit.saved'));
      onClose();
    } catch (err) {
      const message = err instanceof ApiError ? err.message : t('profileEdit.saveError');
      setError(message);
      push('error', message);
      setSaving(false);
    }
  }

  return (
    <KeyboardAvoidingView className="flex-1 bg-white" behavior={Platform.OS === 'ios' ? 'padding' : undefined}>
      <View
        className="flex-row items-center gap-2 bg-ola-primary px-2"
        style={{ paddingTop: insets.top, height: 48 + insets.top, borderBottomWidth: 1, borderBottomColor: DIVIDER }}
      >
        <Pressable className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15" onPress={onClose}>
          <Text className="text-2xl leading-none text-white">‹</Text>
        </Pressable>
        <Text className="flex-1 text-base font-medium text-white" numberOfLines={1}>{t('profileEdit.title')}</Text>
        <Pressable
          onPress={() => setPasswordOpen(true)}
          className="h-8 flex-row items-center gap-1 rounded-full bg-white/15 px-2.5 active:bg-white/25"
        >
          <Image source={lockIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
          <Text className="text-xs font-medium text-white">{t('changePassword.title')}</Text>
        </Pressable>
      </View>

        <ScrollView className="flex-1" keyboardShouldPersistTaps="handled">
          <ImageBackground
            source={cover !== '' ? { uri: cover } : undefined}
            style={{ width: '100%', height: 176, backgroundColor: '#f1f8e9' }}
          >
            <Pressable
              onPress={() => void pickCover()}
              disabled={uploadingCover}
              className="absolute bottom-2 right-2 h-8 w-8 items-center justify-center rounded-full"
              style={{ backgroundColor: 'rgba(0,0,0,0.4)', opacity: uploadingCover ? 0.6 : 1 }}
            >
              <Image source={cameraIcon} style={{ width: 20, height: 20, tintColor: '#fff' }} resizeMode="contain" />
            </Pressable>
            {uploadingCover && (
              <View className="absolute inset-0 items-center justify-center" style={{ backgroundColor: 'rgba(0,0,0,0.3)' }}>
                <Text className="text-sm text-white">{t('common.loading')}</Text>
              </View>
            )}
          </ImageBackground>

          <View className="p-4">
            {error != null && (
              <View className="mb-4 rounded px-3 py-2" style={{ backgroundColor: 'rgba(227,69,69,0.1)' }}>
                <Text className="text-sm" style={{ color: '#e34545' }}>{error}</Text>
              </View>
            )}

            <View className="-mt-12 mb-4 items-center">
              <Pressable onPress={() => void pickAvatar()} disabled={uploading} className="relative">
                {avatar !== '' ? (
                  <Image
                    source={{ uri: avatar }}
                    style={{ width: 96, height: 96, borderRadius: 48, borderWidth: 4, borderColor: '#fff' }}
                  />
                ) : (
                  <Avatar name={nick} size={96} />
                )}
                <View
                  className="absolute bottom-0 right-0 h-7 w-7 items-center justify-center rounded-full bg-ola-primary"
                  style={{ borderWidth: 2, borderColor: '#fff' }}
                >
                  <Image source={cameraIcon} style={{ width: 16, height: 16, tintColor: '#fff' }} resizeMode="contain" />
                </View>
              </Pressable>
              {uploading && (
                <Text className="mt-2 text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>{t('common.loading')}</Text>
              )}
            </View>

            <Field label={t('profileEdit.fullnameLabel')} first>
              <TextInput
                value={fullName}
                onChangeText={setFullName}
                placeholder={t('profileEdit.fullnameHint')}
                placeholderTextColor={PLACEHOLDER_COLOR}
                maxLength={100}
                className="text-sm"
                style={{ color: 'rgba(0,0,0,0.87)', padding: 0 }}
              />
            </Field>

            <Field label={t('profileEdit.phoneLabel')}>
              <TextInput
                value={phone}
                onChangeText={setPhone}
                keyboardType="phone-pad"
                placeholder={t('profileEdit.phoneHint')}
                placeholderTextColor={PLACEHOLDER_COLOR}
                maxLength={20}
                className="text-sm"
                style={{ color: 'rgba(0,0,0,0.87)', padding: 0 }}
              />
            </Field>

            <Field label={t('profileEdit.genderLabel')}>
              <View className="flex-row gap-2">
                {(['male', 'female'] as const).map((option) => {
                  const activeOpt = gender === option;
                  return (
                    <Pressable
                      key={option}
                      onPress={() => setGender(option)}
                      className="flex-1 flex-row items-center justify-center gap-1 rounded py-1.5"
                      style={{
                        borderWidth: 1,
                        borderColor: activeOpt ? '#7cb342' : DIVIDER,
                        backgroundColor: activeOpt ? '#f1f8e9' : 'transparent',
                      }}
                    >
                      <Text className="text-sm" style={{ color: activeOpt ? '#33691e' : 'rgba(0,0,0,0.54)' }}>
                        {option === 'male' ? t('profile.genderMale') : t('profile.genderFemale')}
                      </Text>
                      <Image source={option === 'male' ? maleIcon : femaleIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
                    </Pressable>
                  );
                })}
              </View>
            </Field>

            <Field label={t('profileEdit.birthdayLabel')}>
              <TextInput
                value={dateOfBirth}
                onChangeText={setDateOfBirth}
                placeholder={t('profileEdit.birthdayHint')}
                placeholderTextColor={PLACEHOLDER_COLOR}
                className="text-sm"
                style={{ color: 'rgba(0,0,0,0.87)', padding: 0 }}
              />
            </Field>
          </View>
        </ScrollView>

        <View className="flex-row gap-3 p-4" style={{ borderTopWidth: 1, borderTopColor: DIVIDER, paddingBottom: Math.max(insets.bottom, 16) }}>
          <Pressable
            onPress={onClose}
            disabled={saving}
            className="flex-1 items-center rounded py-2.5"
            style={{ borderWidth: 1, borderColor: DIVIDER }}
          >
            <Text className="text-sm font-medium" style={{ color: 'rgba(0,0,0,0.54)' }}>{t('common.cancel')}</Text>
          </Pressable>
          <Pressable
            onPress={() => void save()}
            disabled={saving || uploading}
            className="flex-1 flex-row items-center justify-center rounded bg-ola-primary py-2.5"
            style={{ opacity: saving || uploading ? 0.6 : 1 }}
          >
            {saving && <ActivityIndicator size="small" color="#fff" style={{ marginRight: 6 }} />}
            <Text className="text-sm font-medium text-white">{saving ? t('profileEdit.saving') : t('profileEdit.save')}</Text>
          </Pressable>
        </View>

        <ChangePasswordDialog visible={passwordOpen} onClose={() => setPasswordOpen(false)} />
      </KeyboardAvoidingView>
  );
}
