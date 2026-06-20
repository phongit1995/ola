import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { type RoutePath } from '@constants';
import { HomeHeader } from '@components/HomeHeader';
import { APP_ITEMS } from './constants';

export function AppsPanel() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const titles = t('home.apps', { returnObjects: true });

  return (
    <>
      <HomeHeader>
        <span className="flex-1 text-center text-base font-medium">
          {t('home.tabApps')}
        </span>
      </HomeHeader>
      <main className="relative flex-1 overflow-y-auto">
        <ul className="min-h-full bg-[#d5d5d5]">
          {titles.map((title, index) => {
            const item = APP_ITEMS[index];
            if (item == null) return null;
            return (
              <li key={title} className="border-b border-black/12 last:border-b-0">
                <button
                  type="button"
                  onClick={item.route ? () => navigate(item.route as RoutePath) : undefined}
                  className="flex min-h-[72px] w-full items-center gap-4 bg-white/80 px-4 text-left active:bg-black/5"
                >
                  <img
                    src={item.icon}
                    alt=""
                    className="h-10 w-10 shrink-0 object-contain"
                  />
                  <span className="min-w-0 flex-1">
                    <span className="block truncate text-base font-bold text-black/87">
                      {title}
                    </span>
                    {item.subtitleKey && (
                      <span className="block truncate text-sm text-black/54">
                        {t(item.subtitleKey)}
                      </span>
                    )}
                  </span>
                </button>
              </li>
            );
          })}
        </ul>
      </main>
    </>
  );
}
