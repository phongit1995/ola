import { useTranslation } from 'react-i18next';
import tabOla from '@/assets/icons/me/ic_action_tab_ola.png';
import tabOlaActive from '@/assets/icons/me/ic_action_tab_ola_selected.png';
import tabTag from '@/assets/icons/me/ic_action_tab_tag.png';
import tabTagActive from '@/assets/icons/me/ic_action_tab_tag_selected.png';
import tabMedia from '@/assets/icons/me/ic_action_tab_media.png';
import tabMediaActive from '@/assets/icons/me/ic_action_tab_media_selected.png';
import tabFollower from '@/assets/icons/me/ic_action_tab_follower.png';
import tabFollowerActive from '@/assets/icons/me/ic_action_tab_follower_selected.png';
import type { MeTab } from '../types';

interface MeTabBarProps {
  active: MeTab;
  onChange: (tab: MeTab) => void;
}

const TABS = [
  { key: 'feed', icon: tabOla, iconActive: tabOlaActive, labelKey: 'me.tabFeed' },
  { key: 'mentions', icon: tabTag, iconActive: tabTagActive, labelKey: 'me.tabMentions' },
  { key: 'media', icon: tabMedia, iconActive: tabMediaActive, labelKey: 'me.tabMedia' },
  { key: 'follower', icon: tabFollower, iconActive: tabFollowerActive, labelKey: 'me.tabFollower' },
] as const satisfies ReadonlyArray<{
  key: MeTab;
  icon: string;
  iconActive: string;
  labelKey: string;
}>;

export function MeTabBar({ active, onChange }: MeTabBarProps) {
  const { t } = useTranslation();
  return (
    <div className="flex flex-1 items-center justify-center gap-8">
      {TABS.map((tab) => {
        const isActive = tab.key === active;
        return (
          <button
            key={tab.key}
            type="button"
            aria-label={t(tab.labelKey)}
            onClick={() => onChange(tab.key)}
            className={`flex h-12 w-12 items-center justify-center ${
              isActive ? 'opacity-100' : 'opacity-60'
            }`}
          >
            <img
              src={isActive ? tab.iconActive : tab.icon}
              alt=""
              className="h-6 w-6 object-contain"
            />
          </button>
        );
      })}
    </div>
  );
}
