import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog } from '@components';
import { HomeHeader } from '@components/HomeHeader';
import { ROUTES } from '@constants';
import { formatKen, toast } from '@lib';
import { AuthService, SocketService } from '@services';
import { useAppNotificationStore } from '@ola/shared/stores/app-notification/appNotificationStore';
import { useSavedAccountsStore } from '@ola/shared/stores/savedAccountsStore';
import { useGameOverlayStore } from '@/store/gameOverlayStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { useArcadeStore } from '@/store/arcadeStore';
import { useArcadeOverlayStore } from '@/store/arcadeOverlayStore';
import { useAuthStore } from '@/store/authStore';
import iconGameDefault from '@/assets/icons/apps/game.png';
import kenIcon from '@/assets/icons/apps/ken.png';
import { APP_ITEMS, type AppItem } from './constants';
import { SocialConnectionsDialog } from './SocialConnectionsDialog';
import { useLobbyWallpaperStyle } from '@hooks';

interface PanelRowProps {
  icon: string;
  title: string;
  subtitle?: string;
  badge?: number;
  onClick?: () => void;
}

function PanelRow({ icon, title, subtitle, badge, onClick }: PanelRowProps) {
  return (
    <li className="border-b border-black/12 last:border-b-0">
      <button
        type="button"
        onClick={onClick}
        className="flex min-h-[72px] w-full items-center gap-4 bg-white/80 px-4 text-left active:bg-black/5"
      >
        <img
          src={icon}
          alt=""
          className="h-10 w-10 shrink-0 rounded-lg object-contain"
        />
        <span className="min-w-0 flex-1">
          <span className="block truncate text-base font-bold text-black/87">
            {title}
          </span>
          {subtitle && (
            <span className="block truncate text-sm text-black/54">
              {subtitle}
            </span>
          )}
        </span>
        {badge != null && badge > 0 && (
          <span className="flex h-5 min-w-5 shrink-0 items-center justify-center rounded-full bg-ola-accent px-1.5 text-xs font-bold text-white">
            {badge > 99 ? '99+' : badge}
          </span>
        )}
      </button>
    </li>
  );
}

export function AppsPanel() {
  const wallpaperStyle = useLobbyWallpaperStyle();
  const { t } = useTranslation();
  const navigate = useNavigate();
  const openGame = useGameOverlayStore((s) => s.open);
  const openApp = useAppOverlayStore((s) => s.push);
  const miniGames = useArcadeStore((s) => s.games);
  const fetchGames = useArcadeStore((s) => s.fetchGames);
  const openArcade = useArcadeOverlayStore((s) => s.open);
  const notifUnread = useAppNotificationStore((s) => s.unreadCount);
  const user = useAuthStore((s) => s.user);
  const [logoutOpen, setLogoutOpen] = useState(false);
  const [removeAccountOpen, setRemoveAccountOpen] = useState(false);
  const [socialOpen, setSocialOpen] = useState(false);

  useEffect(() => {
    void fetchGames();
  }, [fetchGames]);

  function handleOpen(item: AppItem): (() => void) | undefined {
    if (item.action === 'logout') return () => setLogoutOpen(true);
    if (item.action === 'remove-account') {
      return () => setRemoveAccountOpen(true);
    }
    if (item.action === 'social') return () => setSocialOpen(true);
    if (item.overlay) return () => openGame(item.overlay!);
    if (item.app) return () => openApp(item.app!);
    return undefined;
  }

  async function confirmLogout() {
    setLogoutOpen(false);
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

  function handleOpenArcade(game: (typeof miniGames)[number]) {
    if (!openArcade(game)) toast.info(t('arcade.alreadyRunning'));
  }

  function renderAppItem(item: AppItem) {
    return (
      <PanelRow
        key={item.titleKey}
        icon={item.icon}
        title={t(item.titleKey)}
        subtitle={item.subtitleKey ? t(item.subtitleKey) : undefined}
        badge={item.app === 'notifications' ? notifUnread : undefined}
        onClick={handleOpen(item)}
      />
    );
  }

  return (
    <>
      <HomeHeader>
        <div className="flex w-full items-center gap-2 px-1">
          <span className="min-w-0 flex-1 truncate text-sm font-medium">
            {user?.username ? `@${user.username}` : ''}
          </span>
          <span className="shrink-0 text-lg font-medium">
            {t('home.tabApps')}
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
          {APP_ITEMS.slice(0, 1).map(renderAppItem)}
          {miniGames.map((game) => (
            <PanelRow
              key={game.id}
              icon={game.iconUrl || iconGameDefault}
              title={game.name}
              subtitle={game.description || undefined}
              onClick={() => handleOpenArcade(game)}
            />
          ))}
          {APP_ITEMS.slice(1).map(renderAppItem)}
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
