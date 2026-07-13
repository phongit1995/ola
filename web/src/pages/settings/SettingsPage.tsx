import { useEffect, useMemo, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader } from '@components';
import { toast } from '@lib';
import { VipService } from '@services';
import type { UserSettings } from '@app-types';
import { useSettingsStore } from '@/store/settingsStore';
import iconPrivacy from '@/assets/icons/settings/icon-privacy.webp';
import iconNotification from '@/assets/icons/settings/icon-notification.webp';
import iconAppearance from '@/assets/icons/settings/icon-appearance.webp';

const VIP_PRIVACY_KEYS = ['privacyPublic', 'privacyFriends', 'privacyPrivate'] as const;
const VIP_PRIVACY_DISPLAY = ['privacyPrivate', 'privacyFriends', 'privacyPublic'] as const;

function SectionIcon({ src }: { src: string }) {
  return <img src={src} alt="" className="h-5 w-auto object-contain" />;
}

function ImageIcon() {
  return (
    <svg viewBox="0 0 24 24" className="h-4 w-4" fill="currentColor" aria-hidden="true">
      <path d="M21 5v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2ZM5 19h14l-4.5-6-3.5 4.5-2.5-3L5 19Zm3.5-8.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3Z" />
    </svg>
  );
}

function ToggleSwitch({ on, onChange }: { on: boolean; onChange: () => void }) {
  return (
    <button
      type="button"
      role="switch"
      aria-checked={on}
      onClick={onChange}
      className={`relative h-7 w-12 shrink-0 rounded-full transition-colors ${on ? 'bg-ola-primary' : 'bg-black/20'}`}
    >
      <span
        className={`absolute top-0.5 h-6 w-6 rounded-full bg-white shadow transition-all ${on ? 'left-5.5' : 'left-0.5'}`}
      />
    </button>
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
    <div className="inline-flex shrink-0 rounded-lg border border-black/10 bg-white p-0.5">
      {options.map((option) => (
        <button
          key={option.value}
          type="button"
          onClick={() => onChange(option.value)}
          className={`rounded-md px-2.5 py-1 text-[13px] leading-tight transition-colors ${
            value === option.value ? 'bg-ola-primary font-semibold text-white' : 'text-black/70'
          }`}
        >
          {option.label}
        </button>
      ))}
    </div>
  );
}

function SettingRow({ label, children }: { label: string; children: ReactNode }) {
  return (
    <div className="flex items-center justify-between gap-3 border-b border-black/6 px-4 py-3 last:border-b-0">
      <span className="min-w-0 flex-1 text-sm text-black/80">{label}</span>
      {children}
    </div>
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
    <section className="overflow-hidden rounded-2xl bg-white shadow-sm ring-1 ring-black/5">
      <header className="flex items-center gap-2 border-b border-black/6 bg-ola-primary/5 px-4 py-3 text-ola-primary">
        {icon}
        <h2 className="text-base font-bold">
          {index}. {title}
        </h2>
      </header>
      <div>{children}</div>
    </section>
  );
}

export function SettingsPage({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const settings = useSettingsStore((s) => s.settings);
  const update = useSettingsStore((s) => s.update);
  const [draft, setDraft] = useState(settings);
  const [saving, setSaving] = useState(false);
  const [vipPrivacy, setVipPrivacy] = useState<number | null>(null);
  const [vipPrivacyDraft, setVipPrivacyDraft] = useState(0);
  const [vipTouched, setVipTouched] = useState(false);

  useEffect(() => {
    let active = true;
    VipService.store({ limit: 1 })
      .then((res) => {
        if (!active) return;
        setVipPrivacy(res.privacy);
        setVipPrivacyDraft(res.privacy);
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
      }
      toast.success(t('settings.saved'));
    } else {
      toast.error(t('settings.saveError'));
    }
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('settings.title')} align="center" onBack={onClose}>
        <button
          type="button"
          onClick={handleSave}
          disabled={!dirty || saving}
          className="rounded-full px-3 py-1 text-sm font-semibold text-white transition-opacity disabled:opacity-40"
        >
          {saving ? t('common.loading') : t('settings.save')}
        </button>
      </ScreenHeader>

      <div className="flex-1 space-y-4 overflow-y-auto bg-[#eef0f2] px-4 py-4">
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
          <SettingRow label={t('settings.showInterested')}>
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
          <SettingRow label={t('settings.soundKen')}>
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
          <SettingRow label={t('settings.wallpaper')}>
            <button
              type="button"
              className="flex shrink-0 items-center gap-1.5 rounded-lg border border-ola-primary px-3 py-1.5 text-[13px] font-semibold text-ola-primary"
            >
              <ImageIcon />
              {t('settings.upload')}
            </button>
          </SettingRow>
        </SettingsCard>

        <p className="pt-2 pb-4 text-center text-xs text-black/40">{t('settings.appVersion')}</p>
      </div>
    </FullScreenOverlay>
  );
}
