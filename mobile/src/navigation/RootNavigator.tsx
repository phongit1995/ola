import { ActivityIndicator, Image, View } from 'react-native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { useTranslation } from 'react-i18next';
import { useAuthStore } from '@ola/shared/stores/authStore';
import type {
  AuthStackParamList,
  MainTabParamList,
  RoomStackParamList,
  RootStackParamList,
} from './types';
import { AUTH_ROUTES, ROOM_ROUTES, ROOT_ROUTES, TAB_ROUTES } from './routes';
import { LoginScreen } from '../screens/auth/LoginScreen';
import { RegisterScreen } from '../screens/auth/RegisterScreen';
import { ForgotPasswordScreen } from '../screens/auth/ForgotPasswordScreen';
import { TermsScreen } from '../screens/auth/TermsScreen';
import { ChatListScreen } from '../screens/chat/ChatListScreen';
import { ChatDetailScreen } from '../screens/chat/ChatDetailScreen';
import { RoomListScreen } from '../screens/room/RoomListScreen';
import { RoomChatScreen } from '../screens/room/RoomChatScreen';
import { MeFeedScreen } from '../screens/me/MeFeedScreen';
import { AppsScreen } from '../screens/apps/AppsScreen';
import { ProfileViewScreen } from '../screens/profile/ProfileViewScreen';
import { EditProfileScreen } from '../screens/profile/EditProfileScreen';
import { VipStoreScreen } from '../screens/vip/VipStoreScreen';
import { BuyVipScreen } from '../screens/vip/BuyVipScreen';
import { KenStoreScreen } from '../screens/ken/KenStoreScreen';
import { BuyKenScreen } from '../screens/ken/BuyKenScreen';
import { MediaStoreScreen } from '../screens/media/MediaStoreScreen';
import { SettingsScreen } from '../screens/settings/SettingsScreen';
import { PenGameScreen } from '../screens/games/pen/PenGameScreen';
import { TAB_ICONS } from '../assets/tabIcons';

const AuthStack = createNativeStackNavigator<AuthStackParamList>();
const Tabs = createBottomTabNavigator<MainTabParamList>();
const RootStack = createNativeStackNavigator<RootStackParamList>();
const RoomStack = createNativeStackNavigator<RoomStackParamList>();

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
    </AuthStack.Navigator>
  );
}

function tabIcon(key: keyof typeof TAB_ICONS) {
  return function TabIcon({ focused }: { focused: boolean }) {
    const source = focused ? TAB_ICONS[key].active : TAB_ICONS[key].normal;
    return <Image source={source} style={{ width: 24, height: 24 }} resizeMode="contain" />;
  };
}

function MainTabs() {
  const { t } = useTranslation();
  return (
    <Tabs.Navigator
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: '#7cb342',
        tabBarInactiveTintColor: '#9e9e9e',
      }}
    >
      <Tabs.Screen
        name={TAB_ROUTES.Chat}
        component={ChatListScreen}
        options={{ title: t('home.tabChat'), tabBarIcon: tabIcon('chat') }}
      />
      <Tabs.Screen
        name={TAB_ROUTES.Room}
        component={RoomNavigator}
        options={{ title: t('home.tabRoom'), tabBarIcon: tabIcon('room') }}
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
        name={TAB_ROUTES.Apps}
        component={AppsScreen}
        options={{ title: t('home.tabApps'), tabBarIcon: tabIcon('apps') }}
      />
    </Tabs.Navigator>
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
      <RootStack.Screen name={ROOT_ROUTES.Settings} component={SettingsScreen} />
      <RootStack.Screen name={ROOT_ROUTES.PenGame} component={PenGameScreen} />
    </RootStack.Navigator>
  );
}
