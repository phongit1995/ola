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
  Game: 'GameTab',
  Personal: 'PersonalTab',
} as const;

export const CHAT_ROUTES = {
  ChatList: 'ChatList',
  ChatBot: 'ChatBot',
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
  Notifications: 'Notifications',
  Settings: 'Settings',
  PenGame: 'PenGame',
  SpinWheel: 'SpinWheel',
  EggGame: 'EggGame',
  MeVisitors: 'MeVisitors',
  MeLikedPosts: 'MeLikedPosts',
  MeNotifications: 'MeNotifications',
  Marriage: 'Marriage',
  ClanHome: 'ClanHome',
  Clan: 'Clan',
  ClanManage: 'ClanManage',
  ClanMembers: 'ClanMembers',
  ClanBans: 'ClanBans',
  FriendRequests: 'FriendRequests',
  SuggestedFriends: 'SuggestedFriends',
} as const;

export const ROOM_ROUTES = {
  RoomList: 'RoomList',
  RoomChat: 'RoomChat',
} as const;
