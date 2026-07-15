import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { HomeHeader } from '@components/HomeHeader';
import { useGameOverlayStore } from '@/store/gameOverlayStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { useArcadeStore } from '@/store/arcadeStore';
import iconGameDefault from '@/assets/icons/apps/game.png';
import { APP_ITEMS, type AppItem } from './constants';

interface PanelRowProps {
  icon: string;
  title: string;
  subtitle?: string;
  onClick?: () => void;
}

function PanelRow({ icon, title, subtitle, onClick }: PanelRowProps) {
  return (
    <li className="border-b border-black/12 last:border-b-0">
      <button
        type="button"
        onClick={onClick}
        className="flex min-h-[72px] w-full items-center gap-4 bg-white/80 px-4 text-left active:bg-black/5"
      >
        <img src={icon} alt="" className="h-10 w-10 shrink-0 rounded-lg object-contain" />
        <span className="min-w-0 flex-1">
          <span className="block truncate text-base font-bold text-black/87">{title}</span>
          {subtitle && <span className="block truncate text-sm text-black/54">{subtitle}</span>}
        </span>
      </button>
    </li>
  );
}

export function AppsPanel() {
  const { t } = useTranslation();
  const openGame = useGameOverlayStore((s) => s.open);
  const openApp = useAppOverlayStore((s) => s.push);
  const miniGames = useArcadeStore((s) => s.games);
  const fetchGames = useArcadeStore((s) => s.fetchGames);
  const openArcade = useArcadeStore((s) => s.open);

  useEffect(() => {
    void fetchGames();
  }, [fetchGames]);

  function handleOpen(item: AppItem): (() => void) | undefined {
    if (item.overlay) return () => openGame(item.overlay!);
    if (item.app) return () => openApp(item.app!);
    return undefined;
  }

  function renderAppItem(item: AppItem) {
    return (
      <PanelRow
        key={item.titleKey}
        icon={item.icon}
        title={t(item.titleKey)}
        subtitle={item.subtitleKey ? t(item.subtitleKey) : undefined}
        onClick={handleOpen(item)}
      />
    );
  }

  return (
    <>
      <HomeHeader>
        <span className="flex-1 text-center text-lg font-medium">
          {t('home.tabApps')}
        </span>
      </HomeHeader>
      <main className="relative flex-1 overflow-y-auto">
        <ul className="min-h-full bg-[#d5d5d5]">
          {APP_ITEMS.slice(0, 1).map(renderAppItem)}
          {miniGames.map((game) => (
            <PanelRow
              key={game.id}
              icon={game.iconUrl || iconGameDefault}
              title={game.name}
              subtitle={game.description || undefined}
              onClick={() => openArcade(game)}
            />
          ))}
          {APP_ITEMS.slice(1).map(renderAppItem)}
        </ul>
      </main>
    </>
  );
}
