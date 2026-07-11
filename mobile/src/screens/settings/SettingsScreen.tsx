import { useMemo, useState, type ReactNode } from 'react';
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
import type { UserSettings } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';

const PRIMARY = '#7cb342';
const ROW_BORDER = 'rgba(0,0,0,0.06)';

const iconPrivacy = require('../../assets/icons/settings/icon-privacy.webp');
const iconNotification = require('../../assets/icons/settings/icon-notification.webp');
const iconAppearance = require('../../assets/icons/settings/icon-appearance.webp');

function SectionIcon({ src }: { src: ImageSourcePropType }) {
  const resolved = Image.resolveAssetSource(src);
  const ratio = resolved != null && resolved.height > 0 ? resolved.width / resolved.height : 1;
  return <Image source={src} style={{ height: 20, aspectRatio: ratio }} resizeMode="contain" />;
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
                fontSize: 13,
                lineHeight: 17,
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

  const dirty = useMemo(
    () => (Object.keys(draft) as (keyof UserSettings)[]).some((key) => draft[key] !== settings[key]),
    [draft, settings]
  );

  function setField<K extends keyof UserSettings>(key: K, value: UserSettings[K]) {
    setDraft((current) => ({ ...current, [key]: value }));
  }

  async function handleSave() {
    if (!dirty || saving) return;
    setSaving(true);
    const ok = await update(draft);
    setSaving(false);
    if (ok) {
      setDraft(useSettingsStore.getState().settings);
      push('success', t('settings.saved'));
    } else {
      push('error', t('settings.saveError'));
    }
  }

  return (
    <View className="flex-1" style={{ backgroundColor: '#eef0f2' }}>
      <View className="bg-ola-primary" style={{ paddingTop: insets.top }}>
        <View className="h-12 flex-row items-center px-2">
          <Pressable
            className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
            onPress={() => navigation.goBack()}
          >
            <Text className="text-2xl leading-none text-white">‹</Text>
          </Pressable>
          <Text
            className="flex-1 text-center text-base font-medium text-white"
            numberOfLines={1}
          >
            {t('settings.title')}
          </Text>
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
        </View>
      </View>

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
              <Text style={{ fontSize: 13, fontWeight: '600', color: PRIMARY }}>
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
