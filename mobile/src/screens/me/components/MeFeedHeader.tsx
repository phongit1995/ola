import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { DIVIDER } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import type { MeTab } from '../types';

const menuIcon = require('@assets/icons/me/header/ic_header_menu.png');
const bellIcon = require('@assets/icons/me/header/ic_header_notification.png');
const searchIcon = require('@assets/icons/me/header/ic_header_search.png');
const tabCommunity = require('@assets/icons/me/header/ic_header_community.png');
const tabPersonal = require('@assets/icons/me/header/ic_header_personal.png');
const tabClan = require('@assets/icons/me/header/ic_header_clan.png');

const ME_TABS = [
  { key: 'community' as const, labelKey: 'me.tabCommunity' as const, icon: tabCommunity, opticalSize: 28, opticalOffsetY: 0 },
  { key: 'personal' as const, labelKey: 'me.tabPersonal' as const, icon: tabPersonal, opticalSize: 28, opticalOffsetY: 0 },
  { key: 'clan' as const, labelKey: 'me.tabClan' as const, icon: tabClan, opticalSize: 32, opticalOffsetY: 1 },
];

interface MeFeedHeaderProps {
  tab: MeTab;
  unreadCount: number;
  onChangeTab: (tab: MeTab) => void;
  onOpenDrawer: () => void;
  onOpenNotif: () => void;
  onOpenSearch: () => void;
}

export function MeFeedHeader({
  tab,
  unreadCount,
  onChangeTab,
  onOpenDrawer,
  onOpenNotif,
  onOpenSearch,
}: MeFeedHeaderProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const colors = useThemeColors();

  return (
    <View
      className="flex-row items-center bg-ola-primary px-2"
      style={{ paddingTop: insets.top, borderBottomWidth: 1, borderBottomColor: DIVIDER }}
    >
      <Pressable
        accessibilityRole="button"
        accessibilityLabel={t('me.openMenu')}
        onPress={onOpenDrawer}
        className="h-12 w-10 items-center justify-center"
      >
        <Image
          source={menuIcon}
          style={{ width: 18, height: 18, tintColor: colors.onPrimary }}
          resizeMode="contain"
        />
      </Pressable>
      <View className="flex-1 flex-row items-center justify-center gap-8">
        {ME_TABS.map((item) => {
          const active = item.key === tab;
          return (
            <Pressable
              key={item.key}
              accessibilityRole="button"
              accessibilityLabel={t(item.labelKey)}
              accessibilityState={{ selected: active }}
              onPress={() => onChangeTab(item.key)}
              className="h-12 w-12 items-center justify-center"
              style={{ opacity: active ? 1 : 0.6 }}
            >
              <Image
                source={item.icon}
                style={{
                  width: item.opticalSize,
                  height: item.opticalSize,
                  transform: [{ translateY: item.opticalOffsetY }],
                  tintColor: colors.onPrimary,
                }}
                resizeMode="contain"
              />
            </Pressable>
          );
        })}
      </View>
      <Pressable
        accessibilityRole="button"
        accessibilityLabel={t('me.notifTitle')}
        onPress={onOpenNotif}
        className="h-12 w-10 items-center justify-center"
      >
        <View>
          <Image source={bellIcon} style={{ width: 22, height: 22, tintColor: colors.onPrimary }} resizeMode="contain" />
          {unreadCount > 0 && (
            <View
              className="absolute h-4 min-w-4 items-center justify-center rounded-full bg-ola-accent px-1"
              style={{ top: -4, right: 0, borderWidth: 2, borderColor: '#ffffff' }}
            >
              <Text className="text-[10px] font-bold text-white">
                {unreadCount > 99 ? '99+' : unreadCount}
              </Text>
            </View>
          )}
        </View>
      </Pressable>
      <Pressable
        accessibilityRole="button"
        accessibilityLabel={t('me.openSearch')}
        onPress={onOpenSearch}
        className="h-12 w-10 items-center justify-center"
      >
        <Image source={searchIcon} style={{ width: 22, height: 22, tintColor: colors.onPrimary }} resizeMode="contain" />
      </Pressable>
    </View>
  );
}
