import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader } from '@components';

interface SettingRow {
  id: string;
  kind: 'toggle' | 'value' | 'action';
  title: string;
  subtitle?: string;
  value?: string;
  danger?: boolean;
}

interface SettingGroup {
  id: string;
  title: string;
  rows: SettingRow[];
}

const TOGGLE_DEFAULTS: Record<string, boolean> = {
  led: true,
  newMe: true,
  quickBrowser: true,
  typing: true,
  quickReply: false,
  rssHistory: true,
};

const GROUP_IDS = ['general', 'display', 'chat', 'rss', 'about'];

function ChevronRight() {
  return (
    <svg viewBox="0 0 24 24" className="h-4 w-4 text-black/26" fill="currentColor" aria-hidden="true">
      <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6z" />
    </svg>
  );
}

function GroupChevron({ open }: { open: boolean }) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={`h-4 w-4 text-[#e79200] transition-transform ${open ? 'rotate-90' : ''}`}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6z" />
    </svg>
  );
}

function ToggleSwitch({ on }: { on: boolean }) {
  return (
    <span
      className={`relative h-6 w-10 shrink-0 rounded-full transition-colors ${on ? 'bg-ola-primary' : 'bg-black/20'}`}
    >
      <span
        className={`absolute top-0.5 h-5 w-5 rounded-full bg-white shadow transition-all ${on ? 'left-4.5' : 'left-0.5'}`}
      />
    </span>
  );
}

function RowTrailing({ row, on }: { row: SettingRow; on: boolean }) {
  if (row.kind === 'toggle') return <ToggleSwitch on={on} />;
  if (row.kind === 'value') return <span className="text-xs text-[#28a1ee]">{row.value}</span>;
  return (
    <span className="flex items-center gap-1">
      {row.value != null && <span className="text-xs text-[#28a1ee]">{row.value}</span>}
      <ChevronRight />
    </span>
  );
}

export function SettingsPage({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const [openGroups, setOpenGroups] = useState<Record<string, boolean>>(
    Object.fromEntries(GROUP_IDS.map((id) => [id, true]))
  );
  const [toggles, setToggles] = useState<Record<string, boolean>>(TOGGLE_DEFAULTS);

  const toggleGroup = (id: string) => setOpenGroups((prev) => ({ ...prev, [id]: !prev[id] }));
  const toggleRow = (id: string) => setToggles((prev) => ({ ...prev, [id]: !prev[id] }));

  const groups: SettingGroup[] = [
    {
      id: 'general',
      title: t('settings.groups.general'),
      rows: [
        { id: 'sound', kind: 'value', title: t('settings.rows.sound.title'), subtitle: t('settings.rows.sound.subtitle'), value: t('settings.values.on') },
        { id: 'soundType', kind: 'value', title: t('settings.rows.soundType.title'), subtitle: t('settings.rows.soundType.subtitle'), value: t('settings.values.ola') },
        { id: 'vibrate', kind: 'value', title: t('settings.rows.vibrate.title'), subtitle: t('settings.rows.vibrate.subtitle'), value: t('settings.values.on') },
        { id: 'led', kind: 'toggle', title: t('settings.rows.led.title'), subtitle: t('settings.rows.led.subtitle') },
        { id: 'language', kind: 'value', title: t('settings.rows.language.title'), subtitle: t('settings.rows.language.subtitle'), value: t('settings.values.vietnamese') },
        { id: 'passcode', kind: 'action', title: t('settings.rows.passcode.title'), subtitle: t('settings.rows.passcode.subtitle') },
      ],
    },
    {
      id: 'display',
      title: t('settings.groups.display'),
      rows: [
        { id: 'newMe', kind: 'toggle', title: t('settings.rows.newMe.title') },
        { id: 'avatar', kind: 'value', title: t('settings.rows.avatar.title'), subtitle: t('settings.rows.avatar.subtitle'), value: t('settings.values.circle') },
        { id: 'wallpaper', kind: 'value', title: t('settings.rows.wallpaper.title'), value: t('settings.values.default') },
        { id: 'quickBrowser', kind: 'toggle', title: t('settings.rows.quickBrowser.title'), subtitle: t('settings.rows.quickBrowser.subtitle') },
        { id: 'video', kind: 'value', title: t('settings.rows.video.title'), value: t('settings.values.floating') },
        { id: 'typing', kind: 'toggle', title: t('settings.rows.typing.title'), subtitle: t('settings.rows.typing.subtitle') },
      ],
    },
    {
      id: 'chat',
      title: t('settings.groups.chat'),
      rows: [
        { id: 'popup', kind: 'value', title: t('settings.rows.popup.title'), value: t('settings.values.balloon') },
        { id: 'quickReply', kind: 'toggle', title: t('settings.rows.quickReply.title'), subtitle: t('settings.rows.quickReply.subtitle') },
        { id: 'effect', kind: 'value', title: t('settings.rows.effect.title'), value: t('settings.values.flying') },
      ],
    },
    {
      id: 'rss',
      title: t('settings.groups.rss'),
      rows: [
        { id: 'rssHistory', kind: 'toggle', title: t('settings.rows.rssHistory.title') },
        { id: 'fontSize', kind: 'action', title: t('settings.rows.fontSize.title'), subtitle: t('settings.rows.fontSize.subtitle'), value: '5' },
      ],
    },
    {
      id: 'about',
      title: t('settings.groups.about'),
      rows: [
        { id: 'rating', kind: 'action', title: t('settings.rows.rating.title'), subtitle: t('settings.rows.rating.subtitle') },
        { id: 'beta', kind: 'action', title: t('settings.rows.beta.title'), subtitle: t('settings.rows.beta.subtitle') },
        { id: 'version', kind: 'action', title: t('settings.rows.version.title'), subtitle: t('settings.rows.version.subtitle') },
        { id: 'logoutAll', kind: 'action', title: t('settings.rows.logoutAll.title'), subtitle: t('settings.rows.logoutAll.subtitle'), danger: true },
      ],
    },
  ];

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('settings.title')} align="center" onBack={onClose} />

      <div className="flex-1 overflow-y-auto bg-[#eceff1] px-4 pb-6">
        {groups.map((group) => {
          const open = openGroups[group.id] ?? false;
          return (
            <div key={group.id} className="mt-4">
              <button
                type="button"
                onClick={() => toggleGroup(group.id)}
                className="flex h-12 w-full items-center justify-between bg-white px-3 text-left"
              >
                <span className="text-xs font-bold text-[#e79200]">{group.title}</span>
                <GroupChevron open={open} />
              </button>
              {open && (
                <div>
                  {group.rows.map((row) => {
                    const on = toggles[row.id] ?? false;
                    const handlePress = row.kind === 'toggle' ? () => toggleRow(row.id) : undefined;
                    return (
                      <button
                        key={row.id}
                        type="button"
                        onClick={handlePress}
                        disabled={row.kind === 'value'}
                        className="flex w-full items-center gap-2 border-b border-black/8 bg-white px-3 py-2.5 text-left disabled:opacity-100"
                      >
                        <span className="min-w-0 flex-1">
                          <span
                            className={`block truncate text-sm ${row.danger ? 'text-ola-error' : 'text-black/87'}`}
                          >
                            {row.title}
                          </span>
                          {row.subtitle != null && (
                            <span className="mt-0.5 block text-xs text-[#8f8f8f]">{row.subtitle}</span>
                          )}
                        </span>
                        <RowTrailing row={row} on={on} />
                      </button>
                    );
                  })}
                </div>
              )}
            </div>
          );
        })}
      </div>

      <div className="flex h-16 shrink-0 items-center gap-4 border-t border-black/12 bg-white px-4">
        <span className="flex-1 text-sm text-black/87">{t('settings.facebookJoin')}</span>
        <span className="rounded bg-[#1877f2] px-3 py-1 text-xs font-bold text-white">
          {t('settings.facebookLike')}
        </span>
      </div>
    </FullScreenOverlay>
  );
}
