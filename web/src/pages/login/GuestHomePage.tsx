import { useTranslation } from 'react-i18next';
import { Link } from 'react-router-dom';
import { ROUTES, STATIC_PAGES } from '@constants';
import { LoginPage } from './LoginPage';

const FEATURE_KEYS = [
  'rooms',
  'friends',
  'messages',
  'moments',
  'games',
] as const;

const LINK_CLASS = 'underline underline-offset-2';

export function GuestHomePage() {
  const { t } = useTranslation();

  return (
    <div className="h-full overflow-y-auto bg-ola-primary">
      <LoginPage />
      <section className="px-6 pt-2 pb-8 text-ola-on-primary">
        <h1 className="text-lg leading-snug font-bold">
          {t('guestHome.title')}
        </h1>
        <p className="mt-2 text-sm leading-relaxed opacity-90">
          {t('guestHome.lead')}
        </p>
        <h2 className="mt-5 text-base font-semibold">
          {t('guestHome.featuresTitle')}
        </h2>
        <ul className="mt-2 space-y-2 text-sm leading-relaxed">
          {FEATURE_KEYS.map((key) => (
            <li key={key}>
              <strong>{t(`guestHome.features.${key}.title`)}</strong>
              {' — '}
              <span className="opacity-90">
                {t(`guestHome.features.${key}.description`)}
              </span>
            </li>
          ))}
        </ul>
        <nav className="mt-6 flex flex-wrap gap-x-4 gap-y-2 text-sm">
          <a href={STATIC_PAGES.about} className={LINK_CLASS}>
            {t('guestHome.about')}
          </a>
          <Link to={ROUTES.downloadApp} className={LINK_CLASS}>
            {t('guestHome.download')}
          </Link>
          <Link to={ROUTES.terms} className={LINK_CLASS}>
            {t('guestHome.terms')}
          </Link>
          <Link to={ROUTES.privacy} className={LINK_CLASS}>
            {t('guestHome.privacy')}
          </Link>
        </nav>
      </section>
    </div>
  );
}
