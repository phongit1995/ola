import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, PanelRow } from '@components';
import { HomeHeader } from '@components/HomeHeader';
import { ROUTES } from '@constants';
import { formatKen, toast } from '@lib';
import { AuthService, SocketService } from '@services';
import { useAppNotificationStore } from '@ola/shared/stores/app-notification/appNotificationStore';
import { useSavedAccountsStore } from '@ola/shared/stores/savedAccountsStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { useAuthStore } from '@/store/authStore';
import { useLobbyWallpaperStyle } from '@hooks';
import kenIcon from '@/assets/icons/apps/ken.png';
import { PERSONAL_ITEMS, type AppItem } from '../apps/constants';
import { SocialConnectionsDialog } from '../apps/SocialConnectionsDialog';

export function PersonalPanel() {
  const wallpaperStyle = useLobbyWallpaperStyle();
  const { t } = useTranslation();
  const navigate = useNavigate();
  const openApp = useAppOverlayStore((s) => s.push);
  const notifUnread = useAppNotificationStore((s) => s.unreadCount);
  const user = useAuthStore((s) => s.user);
  const [logoutOpen, setLogoutOpen] = useState(false);
  const [removeAccountOpen, setRemoveAccountOpen] = useState(false);
  const [socialOpen, setSocialOpen] = useState(false);

  function handleOpen(item: AppItem): (() => void) | undefined {
    if (item.action === 'logout') return () => setLogoutOpen(true);
    if (item.action === 'remove-account') {
      return () => setRemoveAccountOpen(true);
    }
    if (item.action === 'social') return () => setSocialOpen(true);
    if (item.app) return () => openApp(item.app!);
    return undefined;
  }

  async function signOut() {
    try {
      await AuthService.logout();
    } catch {
      toast.error(t('chat.logoutError'));
    } finally {
      SocketService.disconnect();
      useAuthStore.getState().clearUser();
      navigate(ROUTES.login);
    }
  }

  async function confirmLogout() {
    setLogoutOpen(false);
    await signOut();
  }

  async function confirmRemoveAccount() {
    setRemoveAccountOpen(false);

    const currentUsername = useAuthStore.getState().user?.username;
    if (currentUsername != null) {
      const normalizedUsername = currentUsername.trim().toLowerCase();
      const savedAccount = useSavedAccountsStore
        .getState()
        .accounts.find(
          (account) =>
            account.username.trim().toLowerCase() === normalizedUsername
        );
      if (savedAccount != null) {
        useSavedAccountsStore.getState().removeAccount(savedAccount.username);
      }
    }

    await signOut();
  }

  return (
    <>
      <HomeHeader>
        <div className="flex w-full items-center gap-2 px-1">
          <span className="min-w-0 flex-1 truncate text-sm font-medium">
            {user?.username ? `@${user.username}` : ''}
          </span>
          <span className="shrink-0 text-lg font-medium">
            {t('home.tabPersonal')}
          </span>
          <div className="flex min-w-0 flex-1 justify-end">
            <button
              type="button"
              onClick={() => openApp('ken')}
              className="flex shrink-0 items-center gap-1 rounded-full bg-white/15 px-3 py-1 hover:bg-white/25"
            >
              <img src={kenIcon} alt="" className="h-4 w-4 object-contain" />
              <span className="text-sm font-bold">
                {formatKen(user?.ken ?? 0)}
              </span>
            </button>
          </div>
        </div>
      </HomeHeader>
      <main
        className="relative flex-1 overflow-y-auto bg-ola-border-strong"
        style={wallpaperStyle}
      >
        <ul className="min-h-full">
          {PERSONAL_ITEMS.map((item) => (
            <PanelRow
              key={item.titleKey}
              icon={item.icon}
              title={t(item.titleKey)}
              subtitle={item.subtitleKey ? t(item.subtitleKey) : undefined}
              badge={item.app === 'notifications' ? notifUnread : undefined}
              onClick={handleOpen(item)}
            />
          ))}
        </ul>
      </main>
      <ConfirmDialog
        open={logoutOpen}
        showIcon={false}
        danger
        title={t('dialog.logoutTitle')}
        message={t('dialog.logoutMessage')}
        confirmLabel={t('dialog.logoutButton')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => void confirmLogout()}
        onCancel={() => setLogoutOpen(false)}
      />
      <ConfirmDialog
        open={removeAccountOpen}
        danger
        title={t('dialog.removeAccountTitle')}
        message={t('dialog.removeAccountMessage', {
          username: user?.username ? `@${user.username}` : '',
        })}
        confirmLabel={t('dialog.removeAccountButton')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => void confirmRemoveAccount()}
        onCancel={() => setRemoveAccountOpen(false)}
      />
      <SocialConnectionsDialog
        open={socialOpen}
        onClose={() => setSocialOpen(false)}
      />
    </>
  );
}
