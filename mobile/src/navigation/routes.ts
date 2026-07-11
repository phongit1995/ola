export const AUTH_ROUTES = {
  Login: 'Login',
  Register: 'Register',
  ForgotPassword: 'ForgotPassword',
  Terms: 'Terms',
} as const;

export const TAB_ROUTES = {
  Chat: 'ChatTab',
  Room: 'RoomTab',
  Me: 'MeTab',
  Rss: 'RssTab',
  Apps: 'AppsTab',
} as const;

export const ROOT_ROUTES = {
  MainTabs: 'MainTabs',
  ChatDetail: 'ChatDetail',
  ProfileView: 'ProfileView',
  EditProfile: 'EditProfile',
  VipStore: 'VipStore',
  BuyVip: 'BuyVip',
  KenStore: 'KenStore',
  BuyKen: 'BuyKen',
  MediaStore: 'MediaStore',
  Settings: 'Settings',
} as const;

export const ROOM_ROUTES = {
  RoomList: 'RoomList',
  RoomChat: 'RoomChat',
} as const;
