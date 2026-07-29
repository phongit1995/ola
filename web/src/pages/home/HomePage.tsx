import { Suspense, lazy, useEffect, useState } from 'react';
import { SocketService } from '@services';
import { BottomTabBar, type TabKey } from '@components/BottomTabBar';
import { KenBalanceBadge } from '@components';
import { useDevicePlatform } from '@hooks';
import { useAppNotificationStore } from '@ola/shared/stores/appNotificationStore';
import { totalUnreadOf } from '@ola/shared/stores/chat/chatHelpers';
import { useAuthStore } from '@/store/authStore';
import { useRoomChatStore } from '@/store/roomChatStore';
import { useChatStore } from '@/store/chat/chatStore';
import { useGameOverlayStore } from '@/store/gameOverlayStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { ActiveConversationOverlay } from '../chat/ActiveConversationOverlay';
import { GameOverlay } from '../games/GameOverlay';
import { RoomChatOverlay } from '../room/RoomChatOverlay';
import { AppOverlay } from '../apps/AppOverlay';
import { ClanOverlayHost } from '../clan/ClanOverlayHost';
import { useClanOverlayStore } from '@/store/clanOverlayStore';
import { useDownloadGuideStore } from '@/store/downloadGuideStore';
import { DownloadFab } from '../download/DownloadFab';
import {
  DOWNLOAD_FAB_DISMISSED_KEY,
  DOWNLOAD_FAB_REAPPEAR_CHANCE,
} from '../download/constants';
import { ACTIVE_TAB_KEY, PANELS } from './constants';

const DownloadGuideOverlay = lazy(() =>
  import('../download/DownloadGuideOverlay').then((m) => ({ default: m.DownloadGuideOverlay }))
);

function readStoredTab(): TabKey {
  const stored = sessionStorage.getItem(ACTIVE_TAB_KEY);
  return stored != null && stored in PANELS ? (stored as TabKey) : 'chat';
}

function rollDownloadFabVisible(): boolean {
  if (localStorage.getItem(DOWNLOAD_FAB_DISMISSED_KEY) !== '1') return true;
  return Math.random() < DOWNLOAD_FAB_REAPPEAR_CHANCE;
}

export function HomePage() {
  const [tab, setTab] = useState<TabKey>(readStoredTab);
  const roomUnread = useRoomChatStore((state) => state.hasUnread);
  const chatUnread = useChatStore((state) => totalUnreadOf(state.conversations));
  const notifUnread = useAppNotificationStore((state) => state.unreadCount);
  const ActivePanel = PANELS[tab];
  const authReady = useAuthStore((state) => state.authReady);
  const ken = useAuthStore((state) => state.user?.ken);
  const gameActive = useGameOverlayStore((state) => state.active != null);
  const appActive = useAppOverlayStore((state) => state.stack.length > 0);
  const clanActive = useClanOverlayStore((state) => state.stack.length > 0);
  const hideKenBadge = gameActive || appActive || clanActive;
  const { isStandalone } = useDevicePlatform();
  const guideOpen = useDownloadGuideStore((state) => state.visible);
  const openGuide = useDownloadGuideStore((state) => state.open);
  const closeGuide = useDownloadGuideStore((state) => state.close);
  const [fabVisible, setFabVisible] = useState(rollDownloadFabVisible);
  const downloadFabMounted = fabVisible && !isStandalone;

  function changeTab(next: TabKey) {
    sessionStorage.setItem(ACTIVE_TAB_KEY, next);
    setTab(next);
  }

  function dismissFab() {
    localStorage.setItem(DOWNLOAD_FAB_DISMISSED_KEY, '1');
    setFabVisible(false);
  }

  useEffect(() => {
    void useChatStore.getState().loadConversations();
  }, []);

  useEffect(() => {
    if (!authReady) return;
    SocketService.connect();
    return () => SocketService.disconnect();
  }, [authReady]);

  return (
    <div className="flex h-dvh flex-col bg-white font-sans">
      <div className="relative flex min-h-0 flex-1 flex-col">
        {!hideKenBadge && <KenBalanceBadge ken={ken} />}
        <Suspense fallback={<div className="flex-1" />}>
          <ActivePanel />
        </Suspense>
        <RoomChatOverlay visible={tab === 'room'} />
        {downloadFabMounted && (
          <DownloadFab
            hidden={hideKenBadge || guideOpen}
            onOpen={openGuide}
            onDismiss={dismissFab}
          />
        )}
      </div>

      <BottomTabBar
        active={tab}
        onChange={changeTab}
        badges={{ chat: chatUnread, apps: notifUnread }}
        dots={{ room: roomUnread && tab !== 'room' }}
      />

      <ActiveConversationOverlay />
      <GameOverlay />
      <AppOverlay />
      <ClanOverlayHost />

      {guideOpen && (
        <Suspense fallback={null}>
          <DownloadGuideOverlay onClose={closeGuide} />
        </Suspense>
      )}
    </div>
  );
}
