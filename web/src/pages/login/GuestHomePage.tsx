import { useTranslation } from 'react-i18next';
import { Link } from 'react-router-dom';
import { ROUTES, STATIC_PAGES } from '@constants';
import { LoginPage } from './LoginPage';

const FEATURE_KEYS = [
  'friends',
  'moments',
  'feed',
  'messages',
  'rooms',
] as const;

const TOPIC_PAGES = [
  { href: STATIC_PAGES.socialNetwork, labelKey: 'guestHome.socialNetwork' },
  { href: STATIC_PAGES.findFriends, labelKey: 'guestHome.findFriends' },
  { href: STATIC_PAGES.shareMoments, labelKey: 'guestHome.shareMoments' },
  { href: STATIC_PAGES.chatRooms, labelKey: 'guestHome.chatRooms' },
  { href: STATIC_PAGES.about, labelKey: 'guestHome.about' },
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
        <h2 className="mt-5 text-base font-semibold">
          {t('guestHome.explore')}
        </h2>
        <nav className="mt-2 flex flex-wrap gap-x-4 gap-y-2 text-sm">
          {TOPIC_PAGES.map((page) => (
            <a key={page.href} href={page.href} className={LINK_CLASS}>
              {t(page.labelKey)}
            </a>
          ))}
        </nav>
        <nav className="mt-4 flex flex-wrap gap-x-4 gap-y-2 text-sm opacity-90">
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
