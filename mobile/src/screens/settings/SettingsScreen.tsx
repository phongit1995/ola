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
import { useToastStore } from '@ola/shared/stores/toastStore';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import { VipService } from '@ola/shared/services';
import type { UserSettings } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useAppTypography } from '@components/AppFontProvider';

const PRIMARY = '#7cb342';
const ROW_BORDER = 'rgba(0,0,0,0.06)';
const VIP_PRIVACY_KEYS = ['privacyPublic', 'privacyFriends', 'privacyPrivate'] as const;
const VIP_PRIVACY_DISPLAY = ['privacyPrivate', 'privacyFriends', 'privacyPublic'] as const;

const iconPrivacy = require('@assets/icons/settings/icon-privacy.webp');
const iconNotification = require('@assets/icons/settings/icon-notification.webp');
const iconAppearance = require('@assets/icons/settings/icon-appearance.webp');

function SectionIcon({ src }: { src: ImageSourcePropType }) {
  const resolved = Image.resolveAssetSource(src);
  const ratio = resolved != null && resolved.height > 0 ? resolved.width / resolved.height : 1;
  return <Image source={src} style={{ height: 16, width: 16 * ratio }} resizeMode="contain" />;
}

function ImageIcon() {
  return (
    <View
      className="items-center justify-center"
      style={{ width: 16, height: 16, borderWidth: 1.5, borderColor: PRIMARY, borderRadius: 3 }}
    >
      <View
        className="absolute rounded-full"
        style={{ top: 2.5, left: 2.5, width: 3, height: 3, backgroundColor: PRIMARY }}
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
          borderBottomColor: PRIMARY,
        }}
      />
    </View>
  );
}

function ToggleSwitch({ on, onChange }: { on: boolean; onChange: () => void }) {
  return (
    <Pressable
      accessibilityRole="switch"
      accessibilityState={{ checked: on }}
      onPress={onChange}
      className="shrink-0 rounded-full"
      style={{ width: 48, height: 28, backgroundColor: on ? PRIMARY : 'rgba(0,0,0,0.2)' }}
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
              backgroundColor: selected ? PRIMARY : 'transparent',
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
          backgroundColor: 'rgba(124,179,66,0.05)',
        }}
      >
        {icon}
        <Text className="text-base font-bold" style={{ color: PRIMARY }}>
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
  const push = useToastStore((s) => s.push);
  const settings = useSettingsStore((s) => s.settings);
  const update = useSettingsStore((s) => s.update);
  const [draft, setDraft] = useState(settings);
  const [saving, setSaving] = useState(false);
  const [vipPrivacy, setVipPrivacy] = useState<number | null>(null);
  const [vipPrivacyDraft, setVipPrivacyDraft] = useState(0);
  const [vipTouched, setVipTouched] = useState(false);
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
  const dirty = settingsDirty || vipDirty;

  const vipPrivacyKey = VIP_PRIVACY_KEYS[vipPrivacyDraft] ?? VIP_PRIVACY_KEYS[0];

  function setField<K extends keyof UserSettings>(key: K, value: UserSettings[K]) {
    setDraft((current) => ({ ...current, [key]: value }));
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
            <Pressable
              className="shrink-0 flex-row items-center rounded-lg"
              style={{
                borderWidth: 1,
                borderColor: PRIMARY,
                paddingHorizontal: 12,
                paddingVertical: 6,
                gap: 6,
              }}
            >
              <ImageIcon />
              <Text className="text-[13px] font-semibold" style={{ color: PRIMARY }}>
                {t('settings.upload')}
              </Text>
            </Pressable>
          </SettingRow>
        </SettingsCard>

        <Text className="pt-2 text-center text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
          {t('settings.appVersion')}
        </Text>
      </ScrollView>
    </View>
  );
}
