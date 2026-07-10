import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Animated, Image, Text, View } from 'react-native';
import { useRoomChatStore } from '@ola/shared/stores/roomChatStore';
import type { ReactionType } from '@ola/shared/types';
import { REACTION_IMAGE } from '../../lib/reactions';

const NOTICE_DURATION_MS = 2500;

export function RoomReactionNotice() {
  const { t } = useTranslation();
  const notice = useRoomChatStore((s) => s.reactionNotice);
  const clearReactionNotice = useRoomChatStore((s) => s.clearReactionNotice);
  const opacity = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    if (notice == null) return;
    const seq = notice.seq;
    opacity.setValue(0);
    Animated.timing(opacity, { toValue: 1, duration: 180, useNativeDriver: true }).start();
    const timer = setTimeout(() => clearReactionNotice(seq), NOTICE_DURATION_MS);
    return () => clearTimeout(timer);
  }, [notice, clearReactionNotice, opacity]);

  if (notice == null) return null;

  const image = REACTION_IMAGE[notice.type as ReactionType];

  return (
    <View pointerEvents="none" className="absolute inset-x-0 top-6 z-20 items-center px-4">
      <Animated.View
        style={{
          opacity,
          shadowColor: '#000',
          shadowOpacity: 0.18,
          shadowRadius: 20,
          shadowOffset: { width: 0, height: 6 },
          elevation: 6,
        }}
        className="max-w-full flex-row items-center gap-2 rounded-full bg-white py-1.5 pl-1.5 pr-4"
      >
        {image != null && (
          <View className="h-8 w-8 items-center justify-center rounded-full bg-ola-primary/15">
            <Image source={image} style={{ width: 20, height: 20 }} resizeMode="contain" />
          </View>
        )}
        <Text numberOfLines={1} className="text-sm">
          <Text className="font-semibold" style={{ color: 'rgba(0,0,0,0.85)' }}>
            @{notice.username}
          </Text>
          <Text style={{ color: 'rgba(0,0,0,0.5)' }}> {t('room.reactionNotice')}</Text>
        </Text>
      </Animated.View>
    </View>
  );
}
