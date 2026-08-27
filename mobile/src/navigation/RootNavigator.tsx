import { useState } from 'react';
import { ActivityIndicator, Image, View } from 'react-native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { useTranslation } from 'react-i18next';
import { useAppNotificationStore } from '@ola/shared/stores/app-notification/appNotificationStore';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { totalUnreadOf } from '@ola/shared/stores/chat/chatHelpers';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { useRoomChatStore } from '@ola/shared/stores/room/roomChatStore';
import { useThemeStore } from '@ola/shared/stores/themeStore';
import { themeOptionOf } from '@ola/shared/constants';
import type {
  AuthStackParamList,
  ChatStackParamList,
  MainTabParamList,
  RoomStackParamList,
  RootStackParamList,
} from './types';
import {
  AUTH_ROUTES,
  CHAT_ROUTES,
  ROOM_ROUTES,
  ROOT_ROUTES,
  TAB_ROUTES,
} from './routes';
import { LoginScreen } from '@screens/auth/LoginScreen';
import { RegisterScreen } from '@screens/auth/RegisterScreen';
import { ForgotPasswordScreen } from '@screens/auth/ForgotPasswordScreen';
import { TermsScreen } from '@screens/auth/TermsScreen';
import { PrivacyPolicyScreen } from '@screens/auth/PrivacyPolicyScreen';
import { ChatListScreen } from '@screens/chat/ChatListScreen';
import { ChatDetailScreen } from '@screens/chat/ChatDetailScreen';
import { ChatBotScreen } from '@screens/chat-bot/ChatBotScreen';
import { RoomListScreen } from '@screens/room/RoomListScreen';
import { RoomChatScreen } from '@screens/room/RoomChatScreen';
import { MeFeedScreen } from '@screens/me/MeFeedScreen';
import { GamesScreen } from '@screens/games/GamesScreen';
import { PersonalScreen } from '@screens/personal/PersonalScreen';
import { ProfileViewScreen } from '@screens/profile/ProfileViewScreen';
import { EditProfileScreen } from '@screens/profile/EditProfileScreen';
import { VipStoreScreen } from '@screens/vip/VipStoreScreen';
import { BuyVipScreen } from '@screens/vip/BuyVipScreen';
import { KenStoreScreen } from '@screens/ken/KenStoreScreen';
import { BuyKenScreen } from '@screens/ken/BuyKenScreen';
import { MediaStoreScreen } from '@screens/media/MediaStoreScreen';
import { NotificationsScreen } from '@screens/apps/NotificationsScreen';
import { SettingsScreen } from '@screens/settings/SettingsScreen';
import { PenGameScreen } from '@screens/games/pen/PenGameScreen';
import { SpinWheelGameScreen } from '@screens/games/spin-wheel/SpinWheelGameScreen';
import { EggGameScreen } from '@screens/games/egg/EggGameScreen';
import { MeVisitorsScreen } from '@screens/me/MeVisitorsScreen';
import { MeLikedPostsScreen } from '@screens/me/MeLikedPostsScreen';
import { MeNotificationsScreen } from '@screens/me/MeNotificationsScreen';
import { MarriageScreen } from '@screens/me/marriage/MarriageScreen';
import {
  ClanBansRouteScreen,
  ClanHomeRouteScreen,
  ClanManageRouteScreen,
  ClanMembersRouteScreen,
  ClanRouteScreen,
} from '@screens/clan/ClanRoutes';
import { FriendRequestsScreen } from '@screens/friends/FriendRequestsScreen';
import { SuggestedFriendsScreen } from '@screens/friends/SuggestedFriendsScreen';
import { TAB_ICONS } from '@assets/tabIcons';
import { AnnouncementBanner } from '@components/ui/AnnouncementBanner';
import { KenBalanceBadge } from '@components/ui/KenBalanceBadge';
import { TabBarGradient } from '@components/TabBarGradient';
import { TAB_BAR_BORDER } from '@constants/colors';
import { useAppTypography } from '@components/AppFontProvider';
import { mmkvStorage } from '@platform/storage';

const AuthStack = createNativeStackNavigator<AuthStackParamList>();
const Tabs = createBottomTabNavigator<MainTabParamList>();
const RootStack = createNativeStackNavigator<RootStackParamList>();
const RoomStack = createNativeStackNavigator<RoomStackParamList>();
const ChatStack = createNativeStackNavigator<ChatStackParamList>();

function ChatNavigator() {
  return (
    <ChatStack.Navigator screenOptions={{ headerShown: false }}>
      <ChatStack.Screen name={CHAT_ROUTES.ChatList} component={ChatListScreen} />
      <ChatStack.Screen name={CHAT_ROUTES.ChatBot} component={ChatBotScreen} />
    </ChatStack.Navigator>
  );
}

function RoomNavigator() {
  return (
    <RoomStack.Navigator screenOptions={{ headerShown: false }}>
      <RoomStack.Screen name={ROOM_ROUTES.RoomList} component={RoomListScreen} />
      <RoomStack.Screen
        name={ROOM_ROUTES.RoomChat}
        component={RoomChatScreen}
        options={{ gestureEnabled: false }}
      />
    </RoomStack.Navigator>
  );
}

function AuthNavigator() {
  return (
    <AuthStack.Navigator screenOptions={{ headerShown: false }}>
      <AuthStack.Screen name={AUTH_ROUTES.Login} component={LoginScreen} />
      <AuthStack.Screen name={AUTH_ROUTES.Register} component={RegisterScreen} />
      <AuthStack.Screen name={AUTH_ROUTES.ForgotPassword} component={ForgotPasswordScreen} />
      <AuthStack.Screen name={AUTH_ROUTES.Terms} component={TermsScreen} />
      <AuthStack.Screen name={AUTH_ROUTES.PrivacyPolicy} component={PrivacyPolicyScreen} />
    </AuthStack.Navigator>
  );
}

function tabIcon(key: keyof typeof TAB_ICONS) {
  return function TabIcon({ focused }: { focused: boolean }) {
    const source = focused ? TAB_ICONS[key].active : TAB_ICONS[key].normal;
    return <Image source={source} style={{ width: 24, height: 24 }} resizeMode="contain" />;
  };
}

function renderTabBarBackground() {
  return <TabBarGradient />;
}

const ACTIVE_TAB_KEY = 'ola.home.activeTab';
const VISIBLE_TABS: (keyof MainTabParamList)[] = [
  TAB_ROUTES.Chat,
  TAB_ROUTES.Room,
  TAB_ROUTES.Me,
  TAB_ROUTES.Game,
  TAB_ROUTES.Personal,
];

function readStoredTab(): keyof MainTabParamList {
  const stored = mmkvStorage.getItem(ACTIVE_TAB_KEY);
  return VISIBLE_TABS.includes(stored as keyof MainTabParamList)
    ? (stored as keyof MainTabParamList)
    : TAB_ROUTES.Chat;
}

function MainTabs() {
  const { t } = useTranslation();
  const { multiplier: fontMultiplier } = useAppTypography();
  const [initialTab] = useState(readStoredTab);
  const [activeTab, setActiveTab] = useState<string>(initialTab);
  const chatUnread = useChatStore((state) => totalUnreadOf(state.conversations));
  const roomUnread = useRoomChatStore((state) => state.hasUnread);
  const notifUnread = useAppNotificationStore((state) => state.unreadCount);
  const theme = useThemeStore((state) => state.theme);
  return (
    <View style={{ flex: 1 }}>
      <Tabs.Navigator
        initialRouteName={initialTab}
        screenListeners={{
          state: (event) => {
            const state = event.data.state;
            const name = state.routes[state.index]?.name;
            if (name == null || name === activeTab) return;
            mmkvStorage.setItem(ACTIVE_TAB_KEY, name);
            setActiveTab(name);
          },
        }}
        screenOptions={{
          headerShown: false,
          tabBarActiveTintColor: themeOptionOf(theme).ink,
          tabBarInactiveTintColor: '#9e9e9e',
          tabBarLabelStyle: {
            fontSize: 10 * fontMultiplier,
          },
          tabBarBackground: renderTabBarBackground,
          tabBarStyle: {
            backgroundColor: 'transparent',
            borderTopColor: TAB_BAR_BORDER,
            elevation: 0,
          },
        }}
      >
        <Tabs.Screen
          name={TAB_ROUTES.Chat}
          component={ChatNavigator}
          options={{
            title: t('home.tabChat'),
            tabBarIcon: tabIcon('chat'),
            tabBarBadge:
              chatUnread > 0 ? (chatUnread > 99 ? '99+' : chatUnread) : undefined,
            tabBarBadgeStyle: {
              backgroundColor: '#ff4081',
              color: '#ffffff',
              fontSize: 10 * fontMultiplier,
              fontWeight: 'bold',
            },
          }}
        />
        <Tabs.Screen
          name={TAB_ROUTES.Room}
          component={RoomNavigator}
          options={{
            title: t('home.tabRoom'),
            tabBarIcon: tabIcon('room'),
            tabBarBadge: roomUnread && activeTab !== TAB_ROUTES.Room ? '' : undefined,
            tabBarBadgeStyle: {
              backgroundColor: '#ff9800',
              borderWidth: 2,
              borderColor: '#ffffff',
              minWidth: 12,
              maxWidth: 12,
              height: 12,
              borderRadius: 6,
            },
          }}
        />
        <Tabs.Screen
          name={TAB_ROUTES.Me}
          component={MeFeedScreen}
          options={{ title: t('home.tabMe'), tabBarIcon: tabIcon('me') }}
        />
        {/* TODO: mở lại tab RSS khi có tính năng thật
        <Tabs.Screen
          name={TAB_ROUTES.Rss}
          component={RssTabScreen}
          options={{ title: t('home.tabRss'), tabBarIcon: tabIcon('rss') }}
        /> */}
        <Tabs.Screen
          name={TAB_ROUTES.Game}
          component={GamesScreen}
          options={{ title: t('home.tabGame'), tabBarIcon: tabIcon('game') }}
        />
        <Tabs.Screen
          name={TAB_ROUTES.Personal}
          component={PersonalScreen}
          options={{
            title: t('home.tabPersonal'),
            tabBarIcon: tabIcon('personal'),
            tabBarBadge:
              notifUnread > 0 ? (notifUnread > 99 ? '99+' : notifUnread) : undefined,
            tabBarBadgeStyle: {
              backgroundColor: '#ff4081',
              color: '#ffffff',
              fontSize: 10 * fontMultiplier,
              fontWeight: 'bold',
            },
          }}
        />
      </Tabs.Navigator>
      <AnnouncementBanner />
      <KenBalanceBadge />
    </View>
  );
}

export function RootNavigator() {
  const user = useAuthStore((s) => s.user);
  const authReady = useAuthStore((s) => s.authReady);

  if (!authReady) {
    return (
      <View className="flex-1 items-center justify-center bg-ola-primary">
        <ActivityIndicator color="#ffffff" size="large" />
      </View>
    );
  }

  if (user == null) {
    return <AuthNavigator />;
  }

  return (
    <RootStack.Navigator screenOptions={{ headerShown: false }}>
      <RootStack.Screen name={ROOT_ROUTES.MainTabs} component={MainTabs} />
      <RootStack.Screen name={ROOT_ROUTES.ChatDetail} component={ChatDetailScreen} />
      <RootStack.Screen name={ROOT_ROUTES.ProfileView} component={ProfileViewScreen} />
      <RootStack.Screen name={ROOT_ROUTES.EditProfile} component={EditProfileScreen} />
      <RootStack.Screen name={ROOT_ROUTES.VipStore} component={VipStoreScreen} />
      <RootStack.Screen name={ROOT_ROUTES.BuyVip} component={BuyVipScreen} />
      <RootStack.Screen name={ROOT_ROUTES.KenStore} component={KenStoreScreen} />
      <RootStack.Screen name={ROOT_ROUTES.BuyKen} component={BuyKenScreen} />
      <RootStack.Screen name={ROOT_ROUTES.MediaStore} component={MediaStoreScreen} />
      <RootStack.Screen name={ROOT_ROUTES.Notifications} component={NotificationsScreen} />
      <RootStack.Screen name={ROOT_ROUTES.Settings} component={SettingsScreen} />
      <RootStack.Screen name={ROOT_ROUTES.PenGame} component={PenGameScreen} />
      <RootStack.Screen name={ROOT_ROUTES.SpinWheel} component={SpinWheelGameScreen} />
      <RootStack.Screen name={ROOT_ROUTES.EggGame} component={EggGameScreen} />
      <RootStack.Screen name={ROOT_ROUTES.MeVisitors} component={MeVisitorsScreen} />
      <RootStack.Screen name={ROOT_ROUTES.MeLikedPosts} component={MeLikedPostsScreen} />
      <RootStack.Screen name={ROOT_ROUTES.MeNotifications} component={MeNotificationsScreen} />
      <RootStack.Screen name={ROOT_ROUTES.Marriage} component={MarriageScreen} />
      <RootStack.Screen name={ROOT_ROUTES.ClanHome} component={ClanHomeRouteScreen} />
      <RootStack.Screen name={ROOT_ROUTES.Clan} component={ClanRouteScreen} />
      <RootStack.Screen name={ROOT_ROUTES.ClanManage} component={ClanManageRouteScreen} />
      <RootStack.Screen name={ROOT_ROUTES.ClanMembers} component={ClanMembersRouteScreen} />
      <RootStack.Screen name={ROOT_ROUTES.ClanBans} component={ClanBansRouteScreen} />
      <RootStack.Screen name={ROOT_ROUTES.FriendRequests} component={FriendRequestsScreen} />
      <RootStack.Screen name={ROOT_ROUTES.SuggestedFriends} component={SuggestedFriendsScreen} />
      <RootStack.Screen name={ROOT_ROUTES.Terms} component={TermsScreen} />
      <RootStack.Screen name={ROOT_ROUTES.PrivacyPolicy} component={PrivacyPolicyScreen} />
    </RootStack.Navigator>
  );
}
