import iconMessage from '@/assets/icons/message.png';
import iconMessageActive from '@/assets/icons/message-active.png';
import iconRoom from '@/assets/icons/room.png';
import iconRoomActive from '@/assets/icons/room-active.png';
import iconMe from '@/assets/icons/me.png';
import iconMeActive from '@/assets/icons/me-active.png';
import iconRss from '@/assets/icons/rss.png';
import iconRssActive from '@/assets/icons/rss-active.png';
import iconApps from '@/assets/icons/apps.png';
import iconAppsActive from '@/assets/icons/apps-active.png';

export type TabKey = 'chat' | 'room' | 'me' | 'rss' | 'apps';

interface TabDef {
  key: TabKey;
  label: string;
  icon: string;
  iconActive: string;
}

const TABS: TabDef[] = [
  { key: 'chat', label: 'Chat', icon: iconMessage, iconActive: iconMessageActive },
  { key: 'room', label: 'Phòng chat', icon: iconRoom, iconActive: iconRoomActive },
  { key: 'me', label: 'Me', icon: iconMe, iconActive: iconMeActive },
  { key: 'rss', label: 'RSS', icon: iconRss, iconActive: iconRssActive },
  { key: 'apps', label: 'Ứng dụng', icon: iconApps, iconActive: iconAppsActive },
];

interface BottomTabBarProps {
  active: TabKey;
  onChange: (key: TabKey) => void;
  badges?: Partial<Record<TabKey, number>>;
}

export function BottomTabBar({ active, onChange, badges }: BottomTabBarProps) {
  return (
    <nav className="flex border-t border-[#a0a0a0] bg-white">
      {TABS.map((tab) => {
        const isActive = tab.key === active;
        const badge = badges?.[tab.key];
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
                  {badge}
                </span>
              ) : null}
            </span>
            <span
              className={`mt-0.5 text-xs leading-none whitespace-nowrap ${
                isActive ? 'text-ola-primary' : 'text-black/54'
              }`}
            >
              {tab.label}
            </span>
          </button>
        );
      })}
    </nav>
  );
}
