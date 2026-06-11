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

export function HomePage() {
  const [tab, setTab] = useState<TabKey>('chat');
  const ActivePanel = PANELS[tab];

  useEffect(() => {
    SocketService.connect();
    return () => SocketService.disconnect();
  }, []);

  return (
    <div className="flex h-screen flex-col bg-white font-sans">
      <ActivePanel />

      <BottomTabBar active={tab} onChange={setTab} badges={{ chat: 3 }} />
    </div>
  );
}
