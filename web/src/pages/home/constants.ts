import { lazy, type ComponentType, type LazyExoticComponent } from 'react';
import { type TabKey } from '@components/BottomTabBar';

const ChatPanel = lazy(() =>
  import('../chat/ChatPanel').then((m) => ({ default: m.ChatPanel }))
);
const RoomPanel = lazy(() =>
  import('../room/RoomPanel').then((m) => ({ default: m.RoomPanel }))
);
const RssPanel = lazy(() =>
  import('../rss/RssPanel').then((m) => ({ default: m.RssPanel }))
);
const MePanel = lazy(() =>
  import('../me/MePanel').then((m) => ({ default: m.MePanel }))
);
const AppsPanel = lazy(() =>
  import('../apps/AppsPanel').then((m) => ({ default: m.AppsPanel }))
);

export const PANELS: Record<TabKey, LazyExoticComponent<ComponentType>> = {
  chat: ChatPanel,
  room: RoomPanel,
  rss: RssPanel,
  me: MePanel,
  apps: AppsPanel,
};

export const ACTIVE_TAB_KEY = 'home.activeTab';
