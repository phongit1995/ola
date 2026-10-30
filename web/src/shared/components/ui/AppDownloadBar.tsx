import { useTranslation } from 'react-i18next';
import { Link } from 'react-router-dom';
import { ANALYTICS_EVENT, APP_DOWNLOAD, ROUTES } from '@constants';
import { trackEvent } from '@config';
import { useDevicePlatform } from '@hooks';
import { AppleIcon, GooglePlayIcon } from './StoreIcons';

interface AppDownloadBarProps {
  className?: string;
}

export function AppDownloadBar({ className = '' }: AppDownloadBarProps) {
  const { t } = useTranslation();
  const { platform } = useDevicePlatform();
  const stores = [
    {
      platform: 'android',
      href: APP_DOWNLOAD.playStoreUrl,
      label: t('download.android.action'),
      icon: <GooglePlayIcon className="h-5 w-5" />,
    },
    {
      platform: 'ios',
      href: APP_DOWNLOAD.appStoreUrl,
      label: t('download.ios.action'),
      icon: <AppleIcon className="h-5 w-5" />,
    },
  ].filter((store) => platform === 'desktop' || store.platform === platform);

  return (
    <div
      className={`flex w-full max-w-md flex-col items-center gap-2 ${className}`}
    >
      <div className="flex flex-wrap justify-center gap-2">
        {stores.map((store) => (
          <a
            key={store.platform}
            href={store.href}
            target="_blank"
            rel="noreferrer"
            onClick={() =>
              trackEvent(ANALYTICS_EVENT.storeClick, {
                store: store.platform,
                source: 'download_bar',
              })
            }
            className="flex h-11 items-center gap-2 rounded-full bg-white px-5 text-sm font-bold text-ola-primary-dark shadow-[0_2px_10px_rgba(0,0,0,0.18)] transition active:scale-95"
          >
            {store.icon}
            {store.label}
          </a>
        ))}
      </div>
      <Link
        to={ROUTES.downloadApp}
        className="text-sm text-ola-on-primary/80 underline decoration-ola-on-primary/40"
      >
        {t('download.loginLink')}
      </Link>
    </div>
  );
}
