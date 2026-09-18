import { useTranslation } from 'react-i18next';
import { Link } from 'react-router-dom';
import { APP_DOWNLOAD, ROUTES } from '@constants';
import { GooglePlayIcon } from './StoreIcons';

interface AppDownloadBarProps {
  className?: string;
}

export function AppDownloadBar({ className = '' }: AppDownloadBarProps) {
  const { t } = useTranslation();

  return (
    <div
      className={`flex w-full max-w-md flex-col items-center gap-2 ${className}`}
    >
      <a
        href={APP_DOWNLOAD.playStoreUrl}
        target="_blank"
        rel="noreferrer"
        className="flex h-11 items-center gap-2 rounded-full bg-white px-5 text-sm font-bold text-ola-primary-dark shadow-[0_2px_10px_rgba(0,0,0,0.18)] transition active:scale-95"
      >
        <GooglePlayIcon className="h-5 w-5" />
        {t('download.android.action')}
      </a>
      <Link
        to={ROUTES.downloadApp}
        className="text-sm text-ola-on-primary/80 underline decoration-ola-on-primary/40"
      >
        {t('download.loginLink')}
      </Link>
    </div>
  );
}
