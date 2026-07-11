import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Animated, BackHandler, Image, ImageBackground, Pressable, ScrollView, Text, View } from 'react-native';
import { Avatar } from '../../components/Avatar';

const noteIcon = require('../../assets/icons/me/ic_indicate_note.png');
const boxIcon = require('../../assets/icons/me/ic_indicate_box.png');
const likeIcon = require('../../assets/icons/me/ic_section_like.png');
const visitorIcon = require('../../assets/icons/me/ic_action_tab_follower.png');
const eggIcon = require('../../assets/icons/me/ic_indicate_broken_egg.png');
const androidIcon = require('../../assets/icons/me/ic_indicate_android.png');
const olaIcon = require('../../assets/icons/me/ic_indicate_me.png');
const funnyIcon = require('../../assets/icons/me/ic_indicate_funny.png');
const publicIcon = require('../../assets/icons/me/ic_indicate_public.png');
const rssIcon = require('../../assets/icons/me/ic_indicate_rss.png');

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
    { key: 'diary', icon: noteIcon, label: t('me.drawerDiary'), tint: undefined },
    { key: 'marriage', icon: boxIcon, label: t('me.drawerMarriage'), tint: undefined },
    { key: 'likes', icon: likeIcon, label: t('me.drawerLikes'), tint: undefined },
    { key: 'visitors', icon: visitorIcon, label: t('me.tabVisitors'), tint: 'rgba(0,0,0,0.6)' },
    { key: 'egg', icon: eggIcon, label: t('me.drawerEgg'), tint: undefined },
    { key: 'android', icon: androidIcon, label: '#Android', tint: undefined },
    { key: 'ola', icon: olaIcon, label: '#Ola', tint: undefined },
    { key: 'funny', icon: funnyIcon, label: t('me.drawerFunny'), tint: undefined },
    { key: 'public', icon: publicIcon, label: t('me.drawerPublic'), tint: undefined },
    { key: 'rss', icon: rssIcon, label: 'RSS', tint: undefined },
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
          <ImageBackground
            source={coverUrl != null ? { uri: coverUrl } : undefined}
            className="flex-1 justify-end bg-ola-primary-dark"
          >
            <View>
              <View className="absolute inset-0">
                <View style={{ flex: 1, backgroundColor: 'rgba(0,0,0,0.05)' }} />
                <View style={{ flex: 1, backgroundColor: 'rgba(0,0,0,0.25)' }} />
                <View style={{ flex: 1, backgroundColor: 'rgba(0,0,0,0.5)' }} />
                <View style={{ flex: 1, backgroundColor: 'rgba(0,0,0,0.7)' }} />
              </View>
              <View className="flex-row items-center gap-2 px-2 pb-2 pt-8">
                <Avatar name={displayName} uri={avatarUrl} size={40} />
                <Text numberOfLines={1} className="flex-1 text-base font-medium text-white">
                  {displayName}
                </Text>
              </View>
            </View>
          </ImageBackground>
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
                  style={{ width: 24, height: 24, tintColor: item.tint }}
                  resizeMode="contain"
                />
              </View>
              <Text numberOfLines={1} className="flex-1 text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
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
