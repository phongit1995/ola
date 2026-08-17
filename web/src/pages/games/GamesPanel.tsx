import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { HomeHeader } from '@components/HomeHeader';
import { toast } from '@lib';
import { useGameOverlayStore } from '@/store/gameOverlayStore';
import { useArcadeStore } from '@/store/arcadeStore';
import { useArcadeOverlayStore } from '@/store/arcadeOverlayStore';
import iconGameDefault from '@/assets/icons/apps/game.png';
import { GAME_ITEMS, type AppItem } from '../apps/constants';

interface GameTileProps {
  icon: string;
  title: string;
  onClick?: () => void;
}

function GameTile({ icon, title, onClick }: GameTileProps) {
  return (
    <li>
      <button
        type="button"
        onClick={onClick}
        className="flex w-full flex-col items-center gap-2 rounded-xl bg-white px-1 py-3 shadow-[0_1px_2px_rgba(0,0,0,.12)] active:bg-black/5"
      >
        <img src={icon} alt="" className="h-14 w-14 object-contain" />
        <span className="line-clamp-2 min-h-8 text-center text-xs leading-4 font-bold text-black/87">
          {title}
        </span>
      </button>
    </li>
  );
}

export function GamesPanel() {
  const { t } = useTranslation();
  const openGame = useGameOverlayStore((s) => s.open);
  const miniGames = useArcadeStore((s) => s.games);
  const fetchGames = useArcadeStore((s) => s.fetchGames);
  const openArcade = useArcadeOverlayStore((s) => s.open);

  useEffect(() => {
    void fetchGames();
  }, [fetchGames]);

  function handleOpen(item: AppItem): (() => void) | undefined {
    if (item.overlay) return () => openGame(item.overlay!);
    return undefined;
  }

  function handleOpenArcade(game: (typeof miniGames)[number]) {
    if (!openArcade(game)) toast.info(t('arcade.alreadyRunning'));
  }

  return (
    <>
      <HomeHeader>
        <span className="w-full text-center text-lg font-medium">
          {t('home.tabGame')}
        </span>
      </HomeHeader>
      <main className="relative flex-1 overflow-y-auto bg-ola-surface">
        <ul className="grid grid-cols-3 gap-3 p-3">
          {miniGames.map((game) => (
            <GameTile
              key={game.id}
              icon={game.iconUrl || iconGameDefault}
              title={game.name}
              onClick={() => handleOpenArcade(game)}
            />
          ))}
          {GAME_ITEMS.map((item) => (
            <GameTile
              key={item.titleKey}
              icon={item.icon}
              title={t(item.titleKey)}
              onClick={handleOpen(item)}
            />
          ))}
        </ul>
      </main>
    </>
  );
}
