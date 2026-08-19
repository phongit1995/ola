import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Animated, BackHandler, Image, Pressable, ScrollView, StyleSheet, Text, View } from 'react-native';
import Svg, { Defs, LinearGradient, Rect, Stop } from 'react-native-svg';
import { useThemeColors } from '@hooks/useThemeColors';
import { Avatar } from '@components/ui/Avatar';
import { CachedImageBackground } from '@components/ui/CachedImage';

const personalIcon = require('@assets/icons/me/header/ic_header_personal.png');
const marriageIcon = require('@assets/icons/me/header/ic_header_marriage.png');
const favoriteIcon = require('@assets/icons/me/header/ic_header_favorite.png');
const visitorsIcon = require('@assets/icons/me/header/ic_header_visitors.png');
const clanIcon = require('@assets/icons/me/header/ic_header_clan.png');
// TODO: các mục chưa có action, ẩn tạm — bật lại khi làm xong
// const eggIcon = require('@assets/icons/me/ic_indicate_broken_egg.png');
// const androidIcon = require('@assets/icons/me/ic_indicate_android.png');
// const olaIcon = require('@assets/icons/me/ic_indicate_me.png');
// const funnyIcon = require('@assets/icons/me/ic_indicate_funny.png');
// const publicIcon = require('@assets/icons/me/ic_indicate_public.png');
// const rssIcon = require('@assets/icons/me/ic_indicate_rss.png');

const WIDTH = 240;

interface MeLeftDrawerProps {
  displayName: string;
  avatarUrl?: string;
  coverUrl?: string;
  onClose: () => void;
  onSelect: (key: string) => void;
  onViewProfile: () => void;
  onLogout: () => void;
}

export function MeLeftDrawer({
  displayName,
  avatarUrl,
  coverUrl,
  onClose,
  onSelect,
  onViewProfile,
  onLogout,
}: MeLeftDrawerProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const translateX = useRef(new Animated.Value(-WIDTH)).current;
  const backdrop = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.parallel([
      Animated.timing(translateX, { toValue: 0, duration: 200, useNativeDriver: true }),
      Animated.timing(backdrop, { toValue: 1, duration: 200, useNativeDriver: true }),
    ]).start();
  }, [translateX, backdrop]);

  useEffect(() => {
    const sub = BackHandler.addEventListener('hardwareBackPress', () => {
      onClose();
      return true;
    });
    return () => sub.remove();
  }, [onClose]);

  const items = [
    { key: 'personal', icon: personalIcon, label: t('me.drawerPersonal') },
    { key: 'marriage', icon: marriageIcon, label: t('me.drawerMarriage') },
    { key: 'likes', icon: favoriteIcon, label: t('me.drawerLikes') },
    { key: 'visitors', icon: visitorsIcon, label: t('me.tabVisitors') },
    { key: 'clan', icon: clanIcon, label: t('me.drawerClan'), opticalSize: 28, opticalOffsetY: 1 },
    // TODO: các mục chưa có action, ẩn tạm — bật lại khi làm xong
    // { key: 'egg', icon: eggIcon, label: t('me.drawerEgg') },
    // { key: 'android', icon: androidIcon, label: '#Android' },
    // { key: 'ola', icon: olaIcon, label: '#Ola' },
    // { key: 'funny', icon: funnyIcon, label: t('me.drawerFunny') },
    // { key: 'public', icon: publicIcon, label: t('me.drawerPublic') },
    // { key: 'rss', icon: rssIcon, label: 'RSS' },
  ];

  return (
    <View className="absolute inset-0">
      <Animated.View style={{ flex: 1, opacity: backdrop }} className="bg-black/30">
        <Pressable className="flex-1" onPress={onClose} />
      </Animated.View>
      <Animated.View
        className="absolute inset-y-0 left-0 bg-white"
        style={{ width: WIDTH, transform: [{ translateX }] }}
      >
        <Pressable onPress={onViewProfile} style={{ height: 112 }}>
          <CachedImageBackground
            uri={coverUrl}
            style={{ flex: 1, justifyContent: 'flex-end', backgroundColor: colors.primaryDark }}
          >
            <View>
              <Svg style={StyleSheet.absoluteFill} width="100%" height="100%">
                <Defs>
                  <LinearGradient id="me-drawer-cover-shade" x1="0" y1="0" x2="0" y2="1">
                    <Stop offset="0" stopColor="#000000" stopOpacity="0" />
                    <Stop offset="1" stopColor="#000000" stopOpacity="0.7" />
                  </LinearGradient>
                </Defs>
                <Rect width="100%" height="100%" fill="url(#me-drawer-cover-shade)" />
              </Svg>
              <View className="flex-row items-center gap-2 px-2 pb-2 pt-8">
                <Avatar name={displayName} uri={avatarUrl} size={40} />
                <Text numberOfLines={1} className="flex-1 text-base font-medium text-white">
                  {displayName}
                </Text>
              </View>
            </View>
          </CachedImageBackground>
        </Pressable>

        <ScrollView className="flex-1">
          {items.map((item) => (
            <Pressable
              key={item.key}
              onPress={() => onSelect(item.key)}
              className="h-12 flex-row items-center gap-2 px-2 active:bg-ola-primary-light"
            >
              <View className="h-8 w-8 items-center justify-center">
                <Image
                  source={item.icon}
                  style={{
                    width: item.opticalSize ?? 24,
                    height: item.opticalSize ?? 24,
                    transform: [{ translateY: item.opticalOffsetY ?? 0 }],
                    opacity: 0.26,
                  }}
                  resizeMode="contain"
                />
              </View>
              <Text numberOfLines={1} className="flex-1 text-base text-ola-ink">
                {item.label}
              </Text>
            </Pressable>
          ))}
        </ScrollView>

        <Pressable
          onPress={onLogout}
          className="h-12 flex-row items-center gap-2 border-t px-4 active:bg-black/5"
          style={{ borderTopColor: 'rgba(0,0,0,0.1)' }}
        >
          <Text className="text-base font-medium" style={{ color: '#e34545' }}>
            {t('home.logout')}
          </Text>
        </Pressable>
      </Animated.View>
    </View>
  );
}
