import { lazy, Suspense, useEffect, useState, type ComponentType, type LazyExoticComponent } from 'react';
import { SocketService } from '@services';
import { BottomTabBar, type TabKey } from '@components/BottomTabBar';
import { useRoomChatStore } from '@/store/roomChatStore';

const ChatPanel = lazy(() => import('../chat/ChatPanel').then((m) => ({ default: m.ChatPanel })));
const RoomPanel = lazy(() => import('../room/RoomPanel').then((m) => ({ default: m.RoomPanel })));
const RssPanel = lazy(() => import('../rss/RssPanel').then((m) => ({ default: m.RssPanel })));
const MePanel = lazy(() => import('../me/MePanel').then((m) => ({ default: m.MePanel })));
const AppsPanel = lazy(() => import('../apps/AppsPanel').then((m) => ({ default: m.AppsPanel })));

const PANELS: Record<TabKey, LazyExoticComponent<ComponentType>> = {
  chat: ChatPanel,
  room: RoomPanel,
  rss: RssPanel,
  me: MePanel,
  apps: AppsPanel,
};

const ACTIVE_TAB_KEY = 'home.activeTab';

function readStoredTab(): TabKey {
  const stored = sessionStorage.getItem(ACTIVE_TAB_KEY);
  return stored != null && stored in PANELS ? (stored as TabKey) : 'chat';
}

export function HomePage() {
  const [tab, setTab] = useState<TabKey>(readStoredTab);
  const roomUnread = useRoomChatStore((state) => state.hasUnread);
  const ActivePanel = PANELS[tab];

  function changeTab(next: TabKey) {
    sessionStorage.setItem(ACTIVE_TAB_KEY, next);
    setTab(next);
  }

  useEffect(() => {
    SocketService.connect();
    return () => SocketService.disconnect();
  }, []);

  return (
    <div className="flex h-dvh flex-col bg-white font-sans">
      <div className="relative flex min-h-0 flex-1 flex-col">
        <Suspense fallback={<div className="flex-1" />}>
          <ActivePanel />
        </Suspense>
      </div>

      <BottomTabBar
        active={tab}
        onChange={changeTab}
        badges={{ chat: 3 }}
        dots={{ room: roomUnread && tab !== 'room' }}
      />
    </div>
  );
}
