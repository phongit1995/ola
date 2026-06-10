import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { ROUTES } from '@constants';
import { LanguageSwitcher } from '@components/LanguageSwitcher';
import { ConfirmDialog } from '@components';
import { useAuthStore } from '@/store/authStore';
import { HomeHeader } from '@components/HomeHeader';

export function MePanel() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const username = useAuthStore((s) => s.username);
  const logout = useAuthStore((s) => s.logout);
  const [logoutOpen, setLogoutOpen] = useState(false);

  const displayName = username ?? t('home.guest');

  function confirmLogout() {
    setLogoutOpen(false);
    logout();
    navigate(ROUTES.login);
  }

  return (
    <>
      <HomeHeader>
        <span className="flex-1 text-center text-base font-medium">
          {t('home.tabMe')}
        </span>
      </HomeHeader>
      <main className="relative flex-1 overflow-y-auto">
        <div className="flex flex-col items-center gap-4 p-8">
          <span className="flex h-20 w-20 items-center justify-center rounded-2xl bg-ola-primary text-3xl font-medium text-white">
            {displayName.charAt(0).toUpperCase()}
          </span>
          <p className="text-lg font-semibold text-gray-900">{displayName}</p>
          <LanguageSwitcher tone="dark" />
          <button
            type="button"
            onClick={() => setLogoutOpen(true)}
            className="rounded-sm border border-ola-primary-dark bg-ola-button px-6 py-2 text-white"
          >
            {t('home.logout')}
          </button>
        </div>
      </main>
      <ConfirmDialog
        open={logoutOpen}
        showIcon={false}
        danger
        title={t('dialog.logoutTitle')}
        message={t('dialog.logoutMessage')}
        confirmLabel={t('dialog.logoutButton')}
        cancelLabel={t('dialog.no')}
        onConfirm={confirmLogout}
        onCancel={() => setLogoutOpen(false)}
      />
    </>
  );
}
