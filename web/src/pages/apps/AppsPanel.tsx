import { useTranslation } from 'react-i18next';
import { HomeHeader } from '@components/HomeHeader';
import { useGameOverlayStore } from '@/store/gameOverlayStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { APP_ITEMS, type AppItem } from './constants';

export function AppsPanel() {
  const { t } = useTranslation();
  const openGame = useGameOverlayStore((s) => s.open);
  const openApp = useAppOverlayStore((s) => s.push);

  function handleOpen(item: AppItem): (() => void) | undefined {
    if (item.overlay) return () => openGame(item.overlay!);
    if (item.app) return () => openApp(item.app!);
    return undefined;
  }

  return (
    <>
      <HomeHeader>
        <span className="flex-1 text-center text-base font-medium">
          {t('home.tabApps')}
        </span>
      </HomeHeader>
      <main className="relative flex-1 overflow-y-auto">
        <ul className="min-h-full bg-[#d5d5d5]">
          {APP_ITEMS.map((item) => (
            <li key={item.titleKey} className="border-b border-black/12 last:border-b-0">
              <button
                type="button"
                onClick={handleOpen(item)}
                className="flex min-h-[72px] w-full items-center gap-4 bg-white/80 px-4 text-left active:bg-black/5"
              >
                <img
                  src={item.icon}
                  alt=""
                  className="h-10 w-10 shrink-0 object-contain"
                />
                <span className="min-w-0 flex-1">
                  <span className="block truncate text-base font-bold text-black/87">
                    {t(item.titleKey)}
                  </span>
                  {item.subtitleKey && (
                    <span className="block truncate text-sm text-black/54">
                      {t(item.subtitleKey)}
                    </span>
                  )}
                </span>
              </button>
            </li>
          ))}
        </ul>
      </main>
    </>
  );
}
