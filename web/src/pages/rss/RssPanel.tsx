import { useTranslation } from 'react-i18next';
import { HomeHeader } from '@components/HomeHeader';
import { Placeholder } from '@components/Placeholder';

export function RssPanel() {
  const { t } = useTranslation();
  return (
    <>
      <HomeHeader>
        <div className="flex w-full items-center gap-2">
          <input
            placeholder={t('home.search')}
            className="flex-1 rounded bg-white/20 px-3 py-1.5 text-base text-white outline-none placeholder:text-white/70"
          />
          <button
            type="button"
            aria-label={t('common.menu')}
            className="px-2 text-xl"
          >
            ⋮
          </button>
        </div>
      </HomeHeader>
      <main className="relative flex-1 overflow-y-auto">
        <Placeholder text={t('home.rssEmpty')} />
      </main>
    </>
  );
}
