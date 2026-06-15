import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES, type RoutePath } from '@constants';
import { HomeHeader } from '@components/HomeHeader';
import iconNotify from '@/assets/icons/apps/notify.png';
import iconGame from '@/assets/icons/apps/game.png';
import iconPersonal from '@/assets/icons/apps/personal.png';
import iconVip from '@/assets/icons/apps/vip.png';
import iconKen from '@/assets/icons/apps/ken.png';
import iconAdme from '@/assets/icons/apps/adme.png';
import iconMedia from '@/assets/icons/apps/media.png';
import iconMall from '@/assets/icons/apps/mall.png';
import iconNearby from '@/assets/icons/apps/nearby.png';
import iconSetting from '@/assets/icons/apps/setting.png';

interface AppItem {
  icon: string;
  subtitleKey?: 'home.appGameSubtitle' | 'home.appMallSubtitle';
  route?: RoutePath;
}

const APP_ITEMS: AppItem[] = [
  { icon: iconNotify },
  { icon: iconGame, subtitleKey: 'home.appGameSubtitle' },
  { icon: iconPersonal, route: ROUTES.profileEdit },
  { icon: iconVip, route: ROUTES.vip },
  { icon: iconKen },
  { icon: iconAdme },
  { icon: iconMedia },
  { icon: iconMall, subtitleKey: 'home.appMallSubtitle' },
  { icon: iconNearby },
  { icon: iconSetting },
];

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
