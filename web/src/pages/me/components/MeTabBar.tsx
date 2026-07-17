import { useTranslation } from 'react-i18next';
import { ME_TABS } from '../constants';
import type { MeTab } from '../types';

interface MeTabBarProps {
  active: MeTab;
  onChange: (tab: MeTab) => void;
}

export function MeTabBar({ active, onChange }: MeTabBarProps) {
  const { t } = useTranslation();
  return (
    <div className="flex flex-1 items-center justify-center gap-8">
      {ME_TABS.map((tab) => {
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
              className={`h-6 w-6 object-contain ${'invert' in tab && tab.invert ? 'brightness-0 invert' : ''}`}
            />
          </button>
        );
      })}
    </div>
  );
}
