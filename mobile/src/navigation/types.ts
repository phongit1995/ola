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
  [ROOT_ROUTES.ChatDetail]: { conversationId: string };
  [ROOT_ROUTES.ProfileView]: { userId: string; color?: string };
  [ROOT_ROUTES.EditProfile]: undefined;
};

export type RoomStackParamList = {
  [ROOM_ROUTES.RoomList]: undefined;
  [ROOM_ROUTES.RoomChat]: { roomId: string; roomName: string };
};
