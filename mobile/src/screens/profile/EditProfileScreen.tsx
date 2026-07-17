import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  ImageBackground,
  Platform,
  Pressable,
  ScrollView,
  Text,
  TextInput,
  View,
} from 'react-native';
import { KeyboardView } from '@components/KeyboardView';
import { OlaModal } from '@components/ui/OlaModal';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import DateTimePicker from '@react-native-community/datetimepicker';
import { UserService } from '@ola/shared/services';
import { ApiError, type NativeUploadFile } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { Gender, UpdateProfileRequest } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { Avatar } from '@components/ui/Avatar';
import { AVATAR_OUTPUT, COVER_OUTPUT, pickCroppedImage, pickValidatedCroppedImage } from '@lib/imagePicker';
import { ChangePasswordDialog } from './components/ChangePasswordDialog';
import { VerifyEmailDialog } from './components/VerifyEmailDialog';
import { CoverPreviewOverlay } from './components/CoverPreviewOverlay';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { DIVIDER } from '@constants';
import { DEFAULT_BIRTHDAY, PHONE_PATTERN, PLACEHOLDER_COLOR } from './constants';

const cameraIcon = require('@assets/icons/profile/ic_action_camera.png');
const lockIcon = require('@assets/icons/profile/ic_lock.png');
const maleIcon = require('@assets/icons/profile/ic_indicate_male.png');
const femaleIcon = require('@assets/icons/profile/ic_indicate_female.png');


function formatDateOnly(date: Date): string {
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  return `${date.getFullYear()}-${month}-${day}`;
}

function parseBirthday(value: string): Date {
  if (value === '') return DEFAULT_BIRTHDAY;
  const parsed = new Date(value);
  return Number.isNaN(parsed.getTime()) ? DEFAULT_BIRTHDAY : parsed;
}

function Field({ label, first, children }: { label: string; first?: boolean; children: React.ReactNode }) {
  return (
    <View className={first ? '' : 'mt-4'}>
      <Text className="text-xs text-ola-ink-soft">{label}</Text>
      <View className="mt-1">{children}</View>
      <View className="mt-4" style={{ height: 1, backgroundColor: DIVIDER }} />
    </View>
  );
}

function EmailStatusIcon({ verified }: { verified: boolean }) {
  return (
    <View
      className="items-center justify-center"
      style={{ width: 14, height: 14, borderRadius: 7, backgroundColor: verified ? '#16a34a' : '#f59e0b' }}
    >
      <Text style={{ color: '#fff', fontSize: 9, fontWeight: '700', lineHeight: 12 }}>
        {verified ? '✓' : '!'}
      </Text>
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
  const onClose = () => {
    if (navigation.canGoBack()) {
      navigation.goBack();
      return;
    }
    navigation.navigate(ROOT_ROUTES.MainTabs);
  };

  const [avatar, setAvatar] = useState(user?.avatar ?? '');
  const [fullName, setFullName] = useState(user?.fullName ?? '');
  const [phone, setPhone] = useState(user?.phone ?? '');
  const [gender, setGender] = useState<Gender>(user?.gender ?? 'male');
  const [dateOfBirth, setDateOfBirth] = useState(user?.dateOfBirth ?? '');
  const [saving, setSaving] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [uploadingCover, setUploadingCover] = useState(false);
  const [coverPreview, setCoverPreview] = useState<NativeUploadFile | null>(null);
  const [passwordOpen, setPasswordOpen] = useState(false);
  const [verifyOpen, setVerifyOpen] = useState(false);
  const [birthdayPickerDate, setBirthdayPickerDate] = useState<Date | null>(null);
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
    const picked = await pickValidatedCroppedImage(AVATAR_OUTPUT, AVATAR_OUTPUT, {
      tooSmall: t('avatar.tooSmall'),
      error: t('avatar.error'),
    });
    if (picked == null) return;
    setUploading(true);
    try {
      const result = await UserService.uploadAvatar(picked);
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
    try {
      const picked = await pickCroppedImage(COVER_OUTPUT.width, COVER_OUTPUT.height);
      if (picked == null) return;
      setCoverPreview(picked.file);
    } catch {
      push('error', t('profileEdit.coverError'));
    }
  }

  async function confirmCover() {
    if (coverPreview == null || uploadingCover) return;
    setUploadingCover(true);
    try {
      const { url } = await UserService.uploadAvatar(coverPreview);
      await UserService.updateMe({ coverPhoto: url });
      await refreshUser();
      push('success', t('profileEdit.coverUpdated'));
      setCoverPreview(null);
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
    <KeyboardView className="flex-1 bg-white">
      <ScreenHeader
        title={t('profileEdit.title')}
        onBack={onClose}
        style={{ borderBottomWidth: 1, borderBottomColor: DIVIDER }}
        right={
          <Pressable
            onPress={() => setPasswordOpen(true)}
            className="h-8 flex-row items-center gap-1 rounded-full bg-white/15 px-2.5 active:bg-white/25"
          >
            <Image source={lockIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
            <Text className="text-xs font-medium text-white">{t('changePassword.title')}</Text>
          </Pressable>
        }
      />

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
                <Text className="mt-2 text-xs text-ola-ink-soft">{t('common.loading')}</Text>
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
              <Pressable onPress={() => setBirthdayPickerDate(parseBirthday(dateOfBirth))}>
                <Text
                  className="text-sm"
                  style={{
                    color: dateOfBirth !== '' ? 'rgba(0,0,0,0.87)' : PLACEHOLDER_COLOR,
                  }}
                >
                  {dateOfBirth !== '' ? dateOfBirth.slice(0, 10) : t('profileEdit.birthdayHint')}
                </Text>
              </Pressable>
            </Field>

            <View className="mt-4">
              <View className="flex-row items-center gap-1">
                <Text className="text-xs text-ola-ink-soft">{t('verifyEmail.fieldLabel')}</Text>
                <EmailStatusIcon verified={!!user.emailVerified} />
              </View>
              <View className="mt-1 flex-row items-center gap-2">
                <Text className="flex-1 text-sm text-ola-ink" numberOfLines={1}>
                  {user.email !== '' ? user.email : t('verifyEmail.empty')}
                </Text>
                {!user.emailVerified && (
                  <Pressable onPress={() => setVerifyOpen(true)} className="rounded bg-ola-primary px-2.5 py-1">
                    <Text className="text-xs font-medium text-white">{t('verifyEmail.verifyAction')}</Text>
                  </Pressable>
                )}
              </View>
              <View className="mt-4" style={{ height: 1, backgroundColor: DIVIDER }} />
            </View>
          </View>
        </ScrollView>

        <View className="flex-row gap-3 p-4" style={{ borderTopWidth: 1, borderTopColor: DIVIDER, paddingBottom: Math.max(insets.bottom, 16) }}>
          <Pressable
            onPress={onClose}
            disabled={saving}
            className="flex-1 items-center rounded py-2.5"
            style={{ borderWidth: 1, borderColor: DIVIDER }}
          >
            <Text className="text-sm font-medium text-ola-ink-soft">{t('common.cancel')}</Text>
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

        <VerifyEmailDialog
          visible={verifyOpen}
          initialEmail={user.email ?? ''}
          onClose={() => setVerifyOpen(false)}
          onVerified={() => void refreshUser()}
        />

        <CoverPreviewOverlay
          visible={coverPreview != null}
          url={coverPreview?.uri ?? ''}
          uploading={uploadingCover}
          onCancel={() => setCoverPreview(null)}
          onConfirm={() => void confirmCover()}
        />

        {Platform.OS === 'ios' && birthdayPickerDate != null && (
          <OlaModal transparent animationType="fade" onRequestClose={() => setBirthdayPickerDate(null)}>
            <Pressable
              className="flex-1 justify-end"
              style={{ backgroundColor: 'rgba(0,0,0,0.4)' }}
              onPress={() => setBirthdayPickerDate(null)}
            >
              <Pressable
                className="bg-white"
                style={{ paddingBottom: insets.bottom }}
                onPress={() => undefined}
              >
                <View
                  className="h-11 flex-row items-center justify-between px-4"
                  style={{ borderBottomWidth: 1, borderBottomColor: DIVIDER }}
                >
                  <Pressable onPress={() => setBirthdayPickerDate(null)}>
                    <Text className="text-base text-ola-ink-soft">
                      {t('dialog.cancel')}
                    </Text>
                  </Pressable>
                  <Pressable
                    onPress={() => {
                      setDateOfBirth(formatDateOnly(birthdayPickerDate));
                      setBirthdayPickerDate(null);
                    }}
                  >
                    <Text className="text-base font-bold" style={{ color: '#558b2f' }}>
                      {t('dialog.accept')}
                    </Text>
                  </Pressable>
                </View>
                <DateTimePicker
                  value={birthdayPickerDate}
                  mode="date"
                  display="spinner"
                  themeVariant="light"
                  onChange={(_, date) => {
                    if (date != null) setBirthdayPickerDate(date);
                  }}
                  style={{ alignSelf: 'center' }}
                />
              </Pressable>
            </Pressable>
          </OlaModal>
        )}

        {Platform.OS === 'android' && birthdayPickerDate != null && (
          <DateTimePicker
            value={birthdayPickerDate}
            mode="date"
            onChange={(event, date) => {
              setBirthdayPickerDate(null);
              if (event.type === 'set' && date != null) {
                setDateOfBirth(formatDateOnly(date));
              }
            }}
          />
        )}
      </KeyboardView>
  );
}
