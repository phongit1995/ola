import { useEffect, useMemo, useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Image,
  Pressable,
  ScrollView,
  Text,
  View,
  type ImageSourcePropType,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import { useThemeStore } from '@ola/shared/stores/themeStore';
import { THEME_OPTIONS } from '@ola/shared/constants';
import { withAlpha } from '@ola/shared/lib';
import { UserService, VipService } from '@ola/shared/services';
import type { ThemeId, UserSettings } from '@ola/shared/types';
import {
  pickValidatedCroppedImage,
  WALLPAPER_OUTPUT,
} from '@lib/imagePicker';
import { openAppReview } from '@lib/appReview';
import { CachedImage } from '@components/ui/CachedImage';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useAppTypography } from '@components/AppFontProvider';
import { useThemeColors } from '@hooks/useThemeColors';

const ROW_BORDER = 'rgba(0,0,0,0.06)';
const VIP_PRIVACY_KEYS = ['privacyPublic', 'privacyFriends', 'privacyPrivate'] as const;
const VIP_PRIVACY_DISPLAY = ['privacyPrivate', 'privacyFriends', 'privacyPublic'] as const;

const iconPrivacy = require('@assets/icons/settings/icon-privacy.webp');
const iconNotification = require('@assets/icons/settings/icon-notification.webp');
const iconAppearance = require('@assets/icons/settings/icon-appearance.webp');
const iconDelete = require('@assets/icons/chat/ic_menu_delete.png');

function SectionIcon({ src }: { src: ImageSourcePropType }) {
  const resolved = Image.resolveAssetSource(src);
  const ratio = resolved != null && resolved.height > 0 ? resolved.width / resolved.height : 1;
  return <Image source={src} style={{ height: 16, width: 16 * ratio }} resizeMode="contain" />;
}

function ImageIcon() {
  const colors = useThemeColors();
  return (
    <View
      className="items-center justify-center"
      style={{ width: 16, height: 16, borderWidth: 1.5, borderColor: colors.primary, borderRadius: 3 }}
    >
      <View
        className="absolute rounded-full"
        style={{ top: 2.5, left: 2.5, width: 3, height: 3, backgroundColor: colors.primary }}
      />
      <View
        className="absolute"
        style={{
          bottom: 1,
          right: 1.5,
          width: 0,
          height: 0,
          borderLeftWidth: 4.5,
          borderRightWidth: 4.5,
          borderBottomWidth: 5.5,
          borderLeftColor: 'transparent',
          borderRightColor: 'transparent',
          borderBottomColor: colors.primary,
        }}
      />
    </View>
  );
}

function ThemeSwatches({
  value,
  onChange,
}: {
  value: ThemeId;
  onChange: (value: ThemeId) => void;
}) {
  const { t } = useTranslation();
  return (
    <View className="shrink-0 flex-row items-center" style={{ gap: 8 }}>
      {THEME_OPTIONS.map((option) => {
        const selected = value === option.id;
        return (
          <Pressable
            key={option.id}
            accessibilityRole="button"
            accessibilityLabel={t(`settings.theme_${option.id}`)}
            accessibilityState={{ selected }}
            onPress={() => onChange(option.id)}
            className="rounded-full"
            style={{
              width: 28,
              height: 28,
              backgroundColor: option.swatch,
              borderWidth: selected ? 2 : 1,
              borderColor: selected ? 'rgba(0,0,0,0.45)' : 'rgba(0,0,0,0.1)',
            }}
          />
        );
      })}
    </View>
  );
}

function ToggleSwitch({ on, onChange }: { on: boolean; onChange: () => void }) {
  const colors = useThemeColors();
  return (
    <Pressable
      accessibilityRole="switch"
      accessibilityState={{ checked: on }}
      onPress={onChange}
      className="shrink-0 rounded-full"
      style={{ width: 48, height: 28, backgroundColor: on ? colors.primary : 'rgba(0,0,0,0.2)' }}
    >
      <View
        className="absolute rounded-full bg-white"
        style={{
          top: 2,
          left: on ? 22 : 2,
          width: 24,
          height: 24,
          shadowColor: '#000',
          shadowOpacity: 0.15,
          shadowRadius: 2,
          shadowOffset: { width: 0, height: 1 },
          elevation: 2,
        }}
      />
    </Pressable>
  );
}

function Segmented<T extends string>({
  value,
  options,
  onChange,
}: {
  value: T;
  options: { value: T; label: string }[];
  onChange: (value: T) => void;
}) {
  const { multiplier: fontMultiplier } = useAppTypography();
  const colors = useThemeColors();
  return (
    <View
      className="shrink-0 flex-row rounded-lg bg-white"
      style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.1)', padding: 2 }}
    >
      {options.map((option) => {
        const selected = value === option.value;
        return (
          <Pressable
            key={option.value}
            onPress={() => onChange(option.value)}
            className="rounded-md"
            style={{
              paddingHorizontal: 10,
              paddingVertical: 4,
              backgroundColor: selected ? colors.primary : 'transparent',
            }}
          >
            <Text
              style={{
                fontSize: 13 * fontMultiplier,
                lineHeight: 17 * fontMultiplier,
                color: selected ? '#ffffff' : 'rgba(0,0,0,0.7)',
                fontWeight: selected ? '600' : '400',
              }}
            >
              {option.label}
            </Text>
          </Pressable>
        );
      })}
    </View>
  );
}

function SettingRow({ label, last, children }: { label: string; last?: boolean; children: ReactNode }) {
  return (
    <View
      className="flex-row items-center justify-between gap-3 px-4 py-3"
      style={last === true ? undefined : { borderBottomWidth: 1, borderBottomColor: ROW_BORDER }}
    >
      <Text className="min-w-0 flex-1 text-sm" style={{ color: 'rgba(0,0,0,0.8)' }}>
        {label}
      </Text>
      {children}
    </View>
  );
}

function SettingsCard({
  icon,
  index,
  title,
  children,
}: {
  icon: ReactNode;
  index: number;
  title: string;
  children: ReactNode;
}) {
  const colors = useThemeColors();
  return (
    <View
      className="overflow-hidden rounded-2xl bg-white"
      style={{
        borderWidth: 1,
        borderColor: 'rgba(0,0,0,0.05)',
        shadowColor: '#000',
        shadowOpacity: 0.05,
        shadowRadius: 2,
        shadowOffset: { width: 0, height: 1 },
        elevation: 1,
      }}
    >
      <View
        className="flex-row items-center gap-2 px-4 py-3"
        style={{
          borderBottomWidth: 1,
          borderBottomColor: ROW_BORDER,
          backgroundColor: withAlpha(colors.primary, 0.05),
        }}
      >
        {icon}
        <Text className="text-base font-bold" style={{ color: colors.primary }}>
          {index}. {title}
        </Text>
      </View>
      <View>{children}</View>
    </View>
  );
}

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.Settings>;

export function SettingsScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const colors = useThemeColors();
  const push = useToastStore((s) => s.push);
  const settings = useSettingsStore((s) => s.settings);
  const update = useSettingsStore((s) => s.update);
  const theme = useThemeStore((s) => s.theme);
  const setTheme = useThemeStore((s) => s.setTheme);
  const [draft, setDraft] = useState(settings);
  const [themeDraft, setThemeDraft] = useState(theme);
  const [saving, setSaving] = useState(false);
  const [vipPrivacy, setVipPrivacy] = useState<number | null>(null);
  const [vipPrivacyDraft, setVipPrivacyDraft] = useState(0);
  const [vipTouched, setVipTouched] = useState(false);
  const [uploadingWallpaper, setUploadingWallpaper] = useState(false);
  const vipTouchedRef = useRef(false);

  useEffect(() => {
    let active = true;
    VipService.store({ limit: 1 })
      .then((res) => {
        if (!active) return;
        setVipPrivacy(res.privacy);
        if (!vipTouchedRef.current) setVipPrivacyDraft(res.privacy);
      })
      .catch(() => {});
    return () => {
      active = false;
    };
  }, []);

  const settingsDirty = useMemo(
    () => (Object.keys(draft) as (keyof UserSettings)[]).some((key) => draft[key] !== settings[key]),
    [draft, settings]
  );
  const vipDirty = vipTouched && vipPrivacyDraft !== vipPrivacy;
  const themeDirty = themeDraft !== theme;
  const dirty = settingsDirty || vipDirty || themeDirty;

  const vipPrivacyKey = VIP_PRIVACY_KEYS[vipPrivacyDraft] ?? VIP_PRIVACY_KEYS[0];

  function setField<K extends keyof UserSettings>(key: K, value: UserSettings[K]) {
    setDraft((current) => ({ ...current, [key]: value }));
  }

  async function pickWallpaper() {
    if (uploadingWallpaper) return;
    const picked = await pickValidatedCroppedImage(
      WALLPAPER_OUTPUT.width,
      WALLPAPER_OUTPUT.height,
      { tooSmall: t('wallpaper.tooSmall'), error: t('wallpaper.error') }
    );
    if (picked == null) return;
    setUploadingWallpaper(true);
    push('info', t('wallpaper.uploading'));
    try {
      const uploaded = await UserService.uploadAvatar(picked);
      setField('wallpaperUrl', uploaded.url);
    } catch {
      push('error', t('wallpaper.error'));
    }
    setUploadingWallpaper(false);
  }

  async function handleRateApp() {
    if (!(await openAppReview())) push('error', t('settings.rateAppError'));
  }

  function changeVipPrivacy(value: number) {
    vipTouchedRef.current = true;
    setVipTouched(true);
    setVipPrivacyDraft(value);
  }

  async function handleSave() {
    if (!dirty || saving) return;
    setSaving(true);
    let ok = true;
    if (settingsDirty) ok = await update(draft);
    if (ok && vipDirty) {
      try {
        await VipService.setPrivacy(vipPrivacyDraft);
      } catch {
        ok = false;
      }
    }
    setSaving(false);
    if (ok) {
      if (themeDirty) setTheme(themeDraft);
      setDraft(useSettingsStore.getState().settings);
      if (vipDirty) {
        setVipPrivacy(vipPrivacyDraft);
        setVipTouched(false);
        vipTouchedRef.current = false;
      }
      push('success', t('settings.saved'));
    } else {
      push('error', t('settings.saveError'));
    }
  }

  return (
    <View className="flex-1" style={{ backgroundColor: '#eef0f2' }}>
      <ScreenHeader
        title={t('settings.title')}
        centerTitle
        onBack={() => navigation.goBack()}
        right={
          <Pressable
            onPress={handleSave}
            disabled={!dirty || saving}
            className="rounded-full px-3 py-1"
            style={{ opacity: !dirty || saving ? 0.4 : 1 }}
          >
            <Text className="text-sm font-semibold text-white">
              {saving ? t('common.loading') : t('settings.save')}
            </Text>
          </Pressable>
        }
      />

      <ScrollView
        className="flex-1"
        contentContainerClassName="gap-4 px-4 py-4"
        contentContainerStyle={{ paddingBottom: Math.max(insets.bottom, 16) }}
      >
        <SettingsCard icon={<SectionIcon src={iconPrivacy} />} index={1} title={t('settings.privacyTitle')}>
          <SettingRow label={t('settings.whoCanMessage')}>
            <Segmented
              value={draft.messagePrivacy}
              onChange={(v) => setField('messagePrivacy', v)}
              options={[
                { value: 'friends', label: t('settings.optFriends') },
                { value: 'all', label: t('settings.optAll') },
              ]}
            />
          </SettingRow>
          <SettingRow label={t('settings.whoCanViewMe')}>
            <Segmented
              value={draft.meVisibility}
              onChange={(v) => setField('meVisibility', v)}
              options={[
                { value: 'friends', label: t('settings.optFriends') },
                { value: 'all', label: t('settings.optAll') },
              ]}
            />
          </SettingRow>
          <SettingRow label={t('settings.whoCanComment')}>
            <Segmented
              value={draft.commentPrivacy}
              onChange={(v) => setField('commentPrivacy', v)}
              options={[
                { value: 'friends', label: t('settings.optFriends') },
                { value: 'all', label: t('settings.optAll') },
              ]}
            />
          </SettingRow>
          <SettingRow label={t('settings.whoCanViewVip')}>
            <Segmented
              value={vipPrivacyKey}
              onChange={(k) => changeVipPrivacy(VIP_PRIVACY_KEYS.indexOf(k))}
              options={VIP_PRIVACY_DISPLAY.map((key) => ({
                value: key,
                label:
                  key === 'privacyPrivate'
                    ? t('settings.vipPrivacyMine')
                    : key === 'privacyPublic'
                      ? t('settings.optAll')
                      : t(`vip.${key}`),
              }))}
            />
          </SettingRow>
          <SettingRow label={t('settings.showBirthday')}>
            <ToggleSwitch on={draft.showBirthday} onChange={() => setField('showBirthday', !draft.showBirthday)} />
          </SettingRow>
          <SettingRow label={t('settings.showInterested')} last>
            <ToggleSwitch on={draft.showInterested} onChange={() => setField('showInterested', !draft.showInterested)} />
          </SettingRow>
        </SettingsCard>

        <SettingsCard icon={<SectionIcon src={iconNotification} />} index={2} title={t('settings.notificationTitle')}>
          <SettingRow label={t('settings.notifMessage')}>
            <ToggleSwitch on={draft.notifMessage} onChange={() => setField('notifMessage', !draft.notifMessage)} />
          </SettingRow>
          <SettingRow label={t('settings.notifSound')}>
            <ToggleSwitch on={draft.notifSound} onChange={() => setField('notifSound', !draft.notifSound)} />
          </SettingRow>
          <SettingRow label={t('settings.soundGame')}>
            <ToggleSwitch on={draft.soundGame} onChange={() => setField('soundGame', !draft.soundGame)} />
          </SettingRow>
          <SettingRow label={t('settings.soundKen')} last>
            <ToggleSwitch on={draft.soundKen} onChange={() => setField('soundKen', !draft.soundKen)} />
          </SettingRow>
        </SettingsCard>

        <SettingsCard icon={<SectionIcon src={iconAppearance} />} index={3} title={t('settings.appearanceTitle')}>
          <SettingRow label={t('settings.theme')}>
            <ThemeSwatches value={themeDraft} onChange={setThemeDraft} />
          </SettingRow>
          <SettingRow label={t('settings.fontSize')}>
            <Segmented
              value={draft.fontSize}
              onChange={(v) => setField('fontSize', v)}
              options={[
                { value: 'small', label: t('settings.fontSmall') },
                { value: 'medium', label: t('settings.fontMedium') },
                { value: 'large', label: t('settings.fontLarge') },
              ]}
            />
          </SettingRow>
          <SettingRow label={t('settings.wallpaper')} last>
            <View className="shrink-0 flex-row items-center" style={{ gap: 8 }}>
              {draft.wallpaperUrl !== '' && (
                <>
                  <CachedImage
                    uri={draft.wallpaperUrl}
                    style={{ width: 24, height: 32, borderRadius: 4 }}
                    resizeMode="cover"
                  />
                  <Pressable
                    accessibilityLabel={t('wallpaper.remove')}
                    onPress={() => setField('wallpaperUrl', '')}
                    className="items-center justify-center rounded-lg"
                    style={{
                      width: 32,
                      height: 32,
                      borderWidth: 1,
                      borderColor: 'rgba(0,0,0,0.12)',
                    }}
                  >
                    <Image
                      source={iconDelete}
                      style={{ width: 16, height: 16, tintColor: 'rgba(0,0,0,0.45)' }}
                      resizeMode="contain"
                    />
                  </Pressable>
                </>
              )}
              <Pressable
                onPress={() => void pickWallpaper()}
                disabled={uploadingWallpaper}
                className="shrink-0 flex-row items-center rounded-lg"
                style={{
                  height: 32,
                  borderWidth: 1,
                  borderColor: colors.primary,
                  paddingHorizontal: 12,
                  gap: 6,
                  opacity: uploadingWallpaper ? 0.5 : 1,
                }}
              >
                <ImageIcon />
                <Text className="text-[13px] font-semibold" style={{ color: colors.primary }}>
                  {t('settings.upload')}
                </Text>
              </Pressable>
            </View>
          </SettingRow>
        </SettingsCard>

        <SettingsCard icon={<SectionIcon src={iconPrivacy} />} index={4} title={t('settings.aboutTitle')}>
          <Pressable
            accessibilityRole="button"
            onPress={() => navigation.navigate(ROOT_ROUTES.Terms)}
            className="flex-row items-center justify-between gap-3 px-4 py-3"
            style={{ borderBottomWidth: 1, borderBottomColor: ROW_BORDER }}
          >
            <Text className="min-w-0 flex-1 text-sm" style={{ color: 'rgba(0,0,0,0.8)' }}>
              {t('settings.termsRow')}
            </Text>
            <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.35)' }}>
              ›
            </Text>
          </Pressable>
          <Pressable
            accessibilityRole="button"
            onPress={() => navigation.navigate(ROOT_ROUTES.PrivacyPolicy)}
            className="flex-row items-center justify-between gap-3 px-4 py-3"
            style={{ borderBottomWidth: 1, borderBottomColor: ROW_BORDER }}
          >
            <Text className="min-w-0 flex-1 text-sm" style={{ color: 'rgba(0,0,0,0.8)' }}>
              {t('settings.privacyPolicyRow')}
            </Text>
            <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.35)' }}>
              ›
            </Text>
          </Pressable>
          <Pressable
            accessibilityRole="button"
            onPress={() => void handleRateApp()}
            className="flex-row items-center justify-between gap-3 px-4 py-3"
          >
            <Text className="min-w-0 flex-1 text-sm" style={{ color: 'rgba(0,0,0,0.8)' }}>
              {t('settings.rateAppRow')}
            </Text>
            <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.35)' }}>
              ›
            </Text>
          </Pressable>
        </SettingsCard>

        <Text className="pt-2 text-center text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
          {t('settings.appVersion')}
        </Text>
      </ScrollView>
    </View>
  );
}
