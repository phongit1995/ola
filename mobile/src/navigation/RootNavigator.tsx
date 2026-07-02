import { ActivityIndicator, Image, View } from 'react-native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { useTranslation } from 'react-i18next';
import { useAuthStore } from '@ola/shared/stores/authStore';
import type { AuthStackParamList, MainTabParamList, RootStackParamList } from './types';
import { LoginScreen } from '../screens/auth/LoginScreen';
import { RegisterScreen } from '../screens/auth/RegisterScreen';
import { ForgotPasswordScreen } from '../screens/auth/ForgotPasswordScreen';
import { ChatListScreen } from '../screens/chat/ChatListScreen';
import { ChatDetailScreen } from '../screens/chat/ChatDetailScreen';
import { RoomListScreen } from '../screens/room/RoomListScreen';
import { RoomChatScreen } from '../screens/room/RoomChatScreen';
import { MeFeedScreen } from '../screens/me/MeFeedScreen';
import { ScreenPlaceholder } from '../components/ScreenPlaceholder';
import { TAB_ICONS } from '../assets/tabIcons';

const AuthStack = createNativeStackNavigator<AuthStackParamList>();
const Tabs = createBottomTabNavigator<MainTabParamList>();
const RootStack = createNativeStackNavigator<RootStackParamList>();

function AuthNavigator() {
  return (
    <AuthStack.Navigator screenOptions={{ headerShown: false }}>
      <AuthStack.Screen name="Login" component={LoginScreen} />
      <AuthStack.Screen name="Register" component={RegisterScreen} />
      <AuthStack.Screen name="ForgotPassword" component={ForgotPasswordScreen} />
    </AuthStack.Navigator>
  );
}

function RssTabScreen() {
  return <ScreenPlaceholder title="RSS" />;
}

function AppsTabScreen() {
  return <ScreenPlaceholder title="Apps" />;
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
        name="ChatTab"
        component={ChatListScreen}
        options={{ title: t('home.tabChat'), tabBarIcon: tabIcon('chat') }}
      />
      <Tabs.Screen
        name="RoomTab"
        component={RoomListScreen}
        options={{ title: t('home.tabRoom'), tabBarIcon: tabIcon('room') }}
      />
      <Tabs.Screen
        name="MeTab"
        component={MeFeedScreen}
        options={{ title: t('home.tabMe'), tabBarIcon: tabIcon('me') }}
      />
      <Tabs.Screen
        name="RssTab"
        component={RssTabScreen}
        options={{ title: t('home.tabRss'), tabBarIcon: tabIcon('rss') }}
      />
      <Tabs.Screen
        name="AppsTab"
        component={AppsTabScreen}
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
      <RootStack.Screen name="MainTabs" component={MainTabs} />
      <RootStack.Screen name="ChatDetail" component={ChatDetailScreen} />
      <RootStack.Screen name="RoomChat" component={RoomChatScreen} />
    </RootStack.Navigator>
  );
}
