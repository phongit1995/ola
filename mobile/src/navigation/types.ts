import type { MiniGame } from '@ola/shared/types';
import { AUTH_ROUTES, ROOM_ROUTES, ROOT_ROUTES, TAB_ROUTES } from './routes';

export type AuthStackParamList = {
  [AUTH_ROUTES.Login]: undefined;
  [AUTH_ROUTES.Register]: undefined;
  [AUTH_ROUTES.ForgotPassword]: undefined;
  [AUTH_ROUTES.Terms]: undefined;
};

export type MainTabParamList = {
  [TAB_ROUTES.Chat]: undefined;
  [TAB_ROUTES.Room]: undefined;
  [TAB_ROUTES.Me]: undefined;
  [TAB_ROUTES.Rss]: undefined;
  [TAB_ROUTES.Apps]: undefined;
};

export type RootStackParamList = {
  [ROOT_ROUTES.MainTabs]: undefined;
  [ROOT_ROUTES.ChatDetail]: { conversationId?: string };
  [ROOT_ROUTES.ProfileView]: { userId: string; color?: string };
  [ROOT_ROUTES.EditProfile]: undefined;
  [ROOT_ROUTES.VipStore]: undefined;
  [ROOT_ROUTES.BuyVip]: { mode?: 'buy' | 'give' | 'giveDays' | 'extend' } | undefined;
  [ROOT_ROUTES.KenStore]: undefined;
  [ROOT_ROUTES.BuyKen]: undefined;
  [ROOT_ROUTES.MediaStore]: undefined;
  [ROOT_ROUTES.Settings]: undefined;
  [ROOT_ROUTES.PenGame]: undefined;
  [ROOT_ROUTES.SpinWheel]: undefined;
  [ROOT_ROUTES.EggGame]: undefined;
  [ROOT_ROUTES.ArcadeGame]: { game: MiniGame };
};

export type RoomStackParamList = {
  [ROOM_ROUTES.RoomList]: undefined;
  [ROOM_ROUTES.RoomChat]: { roomId: string; roomName: string };
};
