import { useEffect, useState, type ComponentType } from 'react';
import { SocketService } from '@services';
import { BottomTabBar, type TabKey } from '@components/BottomTabBar';
import { ChatPanel } from '../chat/ChatPanel';
import { RoomPanel } from '../room/RoomPanel';
import { RssPanel } from '../rss/RssPanel';
import { MePanel } from '../me/MePanel';
import { AppsPanel } from '../apps/AppsPanel';

const PANELS: Record<TabKey, ComponentType> = {
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
    <div className="flex h-screen flex-col bg-white font-sans">
      <ActivePanel />

      <BottomTabBar active={tab} onChange={changeTab} badges={{ chat: 3 }} />
    </div>
  );
}
