import type { RoomTab } from '@/store/roomChatStore';

export interface RoomTabItem {
  key: RoomTab;
  icon: string;
  label: string;
  indicator?: boolean;
}

interface RoomTabBarProps {
  tabs: RoomTabItem[];
  activeTab: RoomTab;
  onSelect: (tab: RoomTab) => void;
}

export function RoomTabBar({ tabs, activeTab, onSelect }: RoomTabBarProps) {
  return (
    <div className="flex h-11 shrink-0 items-stretch bg-ola-primary text-white shadow-[0_1px_0_rgba(0,0,0,.12)]">
      {tabs.map((tab) => {
        const active = activeTab === tab.key;
        return (
          <button
            key={tab.key}
            type="button"
            onClick={() => onSelect(tab.key)}
            className={`relative flex flex-1 items-center justify-center gap-1.5 text-sm font-medium transition-opacity ${
              active ? 'opacity-100' : 'opacity-60 hover:opacity-80'
            }`}
          >
            <span>{tab.label}</span>
            {(tab.indicator === undefined || tab.indicator) && (
              <img src={tab.icon} alt="" className="h-5 w-5 object-contain brightness-0 invert" />
            )}
            {active && <span className="absolute inset-x-0 bottom-0 h-0.5 bg-white" />}
          </button>
        );
      })}
    </div>
  );
}
