import { useTranslation } from 'react-i18next';
import { AndroidIcon, AppleIcon } from './platformIcons';

export type GuidePlatform = 'android' | 'ios';

interface PlatformTabsProps {
  active: GuidePlatform;
  detected: GuidePlatform | null;
  onChange: (platform: GuidePlatform) => void;
}

export function PlatformTabs({
  active,
  detected,
  onChange,
}: PlatformTabsProps) {
  const { t } = useTranslation();

  const tabs: {
    key: GuidePlatform;
    label: string;
    icon: typeof AndroidIcon;
  }[] = [
    { key: 'android', label: t('download.android.name'), icon: AndroidIcon },
    { key: 'ios', label: t('download.ios.name'), icon: AppleIcon },
  ];

  return (
    <div className="flex border-b border-black/8">
      {tabs.map(({ key, label, icon: Icon }) => {
        const selected = active === key;
        return (
          <button
            key={key}
            type="button"
            role="tab"
            aria-selected={selected}
            onClick={() => onChange(key)}
            className={`relative flex flex-1 items-center justify-center gap-2 py-3.5 text-sm font-semibold transition-colors ${
              selected
                ? 'bg-ola-primary/6 text-ola-primary-dark'
                : 'text-black/45'
            }`}
          >
            <Icon className="h-5 w-5 shrink-0" />
            <span className="truncate">{label}</span>
            {detected === key && (
              <span className="h-1.5 w-1.5 shrink-0 rounded-full bg-ola-primary" />
            )}
            {selected && (
              <span className="absolute inset-x-4 bottom-0 h-0.5 rounded-full bg-ola-primary" />
            )}
          </button>
        );
      })}
    </div>
  );
}
