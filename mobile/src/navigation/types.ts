export type AuthStackParamList = {
  Login: undefined;
  Register: undefined;
  ForgotPassword: undefined;
};

export type MainTabParamList = {
  ChatTab: undefined;
  RoomTab: undefined;
  MeTab: undefined;
  RssTab: undefined;
  AppsTab: undefined;
};

export type RootStackParamList = {
  MainTabs: undefined;
  ChatDetail: { conversationId: string };
  RoomChat: { roomId: string; roomName: string };
  ProfileView: { userId: string };
};
