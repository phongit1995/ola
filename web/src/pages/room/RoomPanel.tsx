import { useTranslation } from 'react-i18next';
import { HomeHeader } from '@components/HomeHeader';
import { Placeholder } from '@components/Placeholder';

export function RoomPanel() {
  const { t } = useTranslation();
  return (
    <>
      <HomeHeader>
        <span className="flex-1 text-center text-base font-medium">
          {t('home.tabRoom')}
        </span>
      </HomeHeader>
      <main className="relative flex-1 overflow-y-auto">
        <Placeholder text={t('home.roomEmpty')} />
      </main>
    </>
  );
}
