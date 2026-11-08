import { useTranslation } from 'react-i18next';
import { Link } from 'react-router-dom';
import { ANALYTICS_EVENT, APP_DOWNLOAD, ROUTES } from '@constants';
import { trackEvent } from '@config';
import { DESKTOP_OS_LIST, useDevicePlatform } from '@hooks';
import {
  AppleIcon,
  GooglePlayIcon,
  LinuxIcon,
  WindowsIcon,
} from './StoreIcons';

const DESKTOP_OS_ICONS = {
  windows: WindowsIcon,
  mac: AppleIcon,
  linux: LinuxIcon,
};

interface AppDownloadBarProps {
  className?: string;
}

export function AppDownloadBar({ className = '' }: AppDownloadBarProps) {
  const { t } = useTranslation();
  const { platform, isDesktopApp } = useDevicePlatform();
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
      {platform === 'desktop' && !isDesktopApp && (
        <div className="flex flex-wrap items-center justify-center gap-1.5">
          <span className="text-xs font-medium text-ola-on-primary/85">
            {t('download.desktop.barLabel')}
          </span>
          {DESKTOP_OS_LIST.map((os) => {
            const Icon = DESKTOP_OS_ICONS[os];
            return (
              <Link
                key={os}
                to={`${ROUTES.downloadApp}?os=${os}`}
                className="flex h-7 items-center gap-1.5 rounded-full bg-white/20 px-2.5 text-xs font-semibold text-ola-on-primary ring-1 ring-white/25 transition hover:bg-white/30 active:scale-95"
              >
                <Icon className="h-3.5 w-3.5" />
                {t(`download.desktop.${os}.name`)}
              </Link>
            );
          })}
        </div>
      )}
    </div>
  );
}
