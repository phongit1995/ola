import type { BuyVipMode, ChatBotType } from '@ola/shared/types';
import {
  AUTH_ROUTES,
  CHAT_ROUTES,
  ROOM_ROUTES,
  ROOT_ROUTES,
  TAB_ROUTES,
} from './routes';

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
  [TAB_ROUTES.Game]: undefined;
  [TAB_ROUTES.Personal]: undefined;
};

export type RootStackParamList = {
  [ROOT_ROUTES.MainTabs]: undefined;
  [ROOT_ROUTES.ChatDetail]: { conversationId?: string };
  [ROOT_ROUTES.ProfileView]: { userId: string; color?: string };
  [ROOT_ROUTES.EditProfile]: undefined;
  [ROOT_ROUTES.VipStore]: undefined;
  [ROOT_ROUTES.BuyVip]: { mode?: BuyVipMode } | undefined;
  [ROOT_ROUTES.KenStore]: undefined;
  [ROOT_ROUTES.BuyKen]: undefined;
  [ROOT_ROUTES.MediaStore]: undefined;
  [ROOT_ROUTES.Notifications]: undefined;
  [ROOT_ROUTES.Settings]: undefined;
  [ROOT_ROUTES.PenGame]: undefined;
  [ROOT_ROUTES.SpinWheel]: undefined;
  [ROOT_ROUTES.EggGame]: undefined;
  [ROOT_ROUTES.MeVisitors]: undefined;
  [ROOT_ROUTES.MeLikedPosts]: undefined;
  [ROOT_ROUTES.MeNotifications]: undefined;
  [ROOT_ROUTES.Marriage]: undefined;
  [ROOT_ROUTES.ClanHome]: undefined;
  [ROOT_ROUTES.Clan]: { handle?: string; id?: string };
  [ROOT_ROUTES.ClanManage]: { clanId: string };
  [ROOT_ROUTES.ClanMembers]: { clanId: string };
  [ROOT_ROUTES.ClanBans]: { clanId: string };
  [ROOT_ROUTES.FriendRequests]: undefined;
  [ROOT_ROUTES.SuggestedFriends]: undefined;
};

export type ChatStackParamList = {
  [CHAT_ROUTES.ChatList]: undefined;
  [CHAT_ROUTES.ChatBot]: { bot?: ChatBotType } | undefined;
};

export type RoomStackParamList = {
  [ROOM_ROUTES.RoomList]: undefined;
  [ROOM_ROUTES.RoomChat]: { roomId: string; roomName: string };
};
