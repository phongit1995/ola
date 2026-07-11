import { useTranslation } from 'react-i18next';
import { Image, Pressable, ScrollView, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';
import { APP_ITEMS, type AppItem } from './constants';

export function AppsScreen() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const push = useToastStore((s) => s.push);

  function handleOpen(item: AppItem) {
    if (item.action === 'profile') {
      navigation.navigate(ROOT_ROUTES.EditProfile);
      return;
    }
    if (item.action === 'vip') {
      navigation.navigate(ROOT_ROUTES.VipStore);
      return;
    }
    if (item.action === 'ken') {
      navigation.navigate(ROOT_ROUTES.KenStore);
      return;
    }
    if (item.action === 'media') {
      navigation.navigate(ROOT_ROUTES.MediaStore);
      return;
    }
    push('info', t('chat.comingSoon'));
  }

  return (
    <View className="flex-1" style={{ backgroundColor: '#d5d5d5' }}>
      <View className="bg-ola-primary" style={{ paddingTop: insets.top }}>
        <View className="h-12 items-center justify-center px-2">
          <Text className="text-base font-medium text-white">{t('home.tabApps')}</Text>
        </View>
      </View>
      <ScrollView className="flex-1">
        {APP_ITEMS.map((item) => (
          <Pressable
            key={item.titleKey}
            onPress={() => handleOpen(item)}
            className="min-h-[72px] flex-row items-center gap-4 px-4 active:opacity-70"
            style={{
              backgroundColor: 'rgba(255,255,255,0.8)',
              borderBottomWidth: 1,
              borderBottomColor: 'rgba(0,0,0,0.12)',
            }}
          >
            <Image source={item.icon} className="h-10 w-10" resizeMode="contain" />
            <View className="min-w-0 flex-1">
              <Text numberOfLines={1} className="text-base font-bold text-black/87">
                {t(item.titleKey)}
              </Text>
              {item.subtitleKey != null && (
                <Text numberOfLines={1} className="text-sm text-black/54">
                  {t(item.subtitleKey)}
                </Text>
              )}
            </View>
          </Pressable>
        ))}
      </ScrollView>
    </View>
  );
}
