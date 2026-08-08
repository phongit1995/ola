import iconMessage from '@/assets/icons/message.png';
import iconMessageActive from '@/assets/icons/message-active.png';
import iconRoom from '@/assets/icons/room.png';
import iconRoomActive from '@/assets/icons/room-active.png';
import iconMe from '@/assets/icons/me.png';
import iconMeActive from '@/assets/icons/me-active.png';
// import iconRss from '@/assets/icons/rss.png';
// import iconRssActive from '@/assets/icons/rss-active.png';
import iconApps from '@/assets/icons/apps.png';
import iconAppsActive from '@/assets/icons/apps-active.png';
import { useTranslation } from 'react-i18next';

export type TabKey = 'chat' | 'room' | 'me' | 'rss' | 'apps';

const TABS = [
  {
    key: 'chat',
    labelKey: 'home.tabChat',
    icon: iconMessage,
    iconActive: iconMessageActive,
  },
  {
    key: 'room',
    labelKey: 'home.tabRoom',
    icon: iconRoom,
    iconActive: iconRoomActive,
  },
  { key: 'me', labelKey: 'home.tabMe', icon: iconMe, iconActive: iconMeActive },
  // { key: 'rss', labelKey: 'home.tabRss', icon: iconRss, iconActive: iconRssActive },
  {
    key: 'apps',
    labelKey: 'home.tabApps',
    icon: iconApps,
    iconActive: iconAppsActive,
  },
] as const;

interface BottomTabBarProps {
  active: TabKey;
  onChange: (key: TabKey) => void;
  badges?: Partial<Record<TabKey, number>>;
  dots?: Partial<Record<TabKey, boolean>>;
}

export function BottomTabBar({
  active,
  onChange,
  badges,
  dots,
}: BottomTabBarProps) {
  const { t } = useTranslation();
  return (
    <nav className="flex border-t border-[#a0a0a0] bg-white bg-linear-to-t from-ola-primary/35 to-ola-primary/15">
      {TABS.map((tab) => {
        const isActive = tab.key === active;
        const badge = badges?.[tab.key];
        const dot = dots?.[tab.key];
        return (
          <button
            key={tab.key}
            type="button"
            onClick={() => onChange(tab.key)}
            className="relative flex flex-1 flex-col items-center px-1 pt-1 pb-0.5"
          >
            <span className="relative">
              <img
                src={isActive ? tab.iconActive : tab.icon}
                alt=""
                className="h-6 px-2 object-contain"
              />
              {badge ? (
                <span className="absolute -top-1 -right-0 flex h-4 min-w-4 items-center justify-center rounded-full border-2 border-white bg-ola-accent px-1 text-[10px] font-bold text-white">
                  {badge > 99 ? '99+' : badge}
                </span>
              ) : dot ? (
                <span className="absolute -top-0.5 right-0 h-3 w-3 rounded-full border-2 border-white bg-ola-warning animate-blink" />
              ) : null}
            </span>
            <span
              className={`mt-0.5 text-xs leading-none whitespace-nowrap ${
                isActive ? 'text-ola-primary-ink' : 'text-black/54'
              }`}
            >
              {t(tab.labelKey)}
            </span>
          </button>
        );
      })}
    </nav>
  );
}
