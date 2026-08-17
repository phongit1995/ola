import type { ImageSourcePropType } from 'react-native';

export const TAB_ICONS: Record<string, { normal: ImageSourcePropType; active: ImageSourcePropType }> = {
  chat: { normal: require('./icons/message.png'), active: require('./icons/message-active.png') },
  room: { normal: require('./icons/room.png'), active: require('./icons/room-active.png') },
  me: { normal: require('./icons/me.png'), active: require('./icons/me-active.png') },
  rss: { normal: require('./icons/rss.png'), active: require('./icons/rss-active.png') },
  apps: { normal: require('./icons/apps.png'), active: require('./icons/apps-active.png') },
  game: { normal: require('./icons/game.png'), active: require('./icons/game-active.png') },
  personal: { normal: require('./icons/personal.png'), active: require('./icons/personal-active.png') },
};
