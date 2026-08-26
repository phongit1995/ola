import { useEffect, useRef, useState } from 'react';
import { Animated, Easing, Image, Linking, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import {
  selectVisibleAnnouncement,
  useAnnouncementStore,
} from '@ola/shared/stores/announcementStore';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useThemeColors } from '@hooks/useThemeColors';
import { Dialog, DialogButton } from './Dialog';

const MARQUEE_SPEED_PX_PER_SECOND = 40;
const MARQUEE_MIN_DURATION_MS = 8000;
const MARQUEE_MAX_DURATION_MS = 45000;
const MARQUEE_EXTRA_DELAY_MS = 300;
const EXPAND_DELAY_MS = 600;
const EXPAND_DURATION_MS = 500;
const PILL_COLLAPSED_WIDTH = 44;
const PILL_MAX_WIDTH = 320;
const MARQUEE_TRACK_WIDTH = 4000;
const OFFSCREEN_RIGHT = 1000;

const megaphoneIcon = require('../../assets/icons/announcement-megaphone.png');

interface BannerPillProps {
  title: string;
  onOpenDetail: () => void;
  onDismiss: () => void;
  onMarqueeDone: () => void;
}

function BannerPill({ title, onOpenDetail, onDismiss, onMarqueeDone }: BannerPillProps) {
  const colors = useThemeColors();
  const [clipWidth, setClipWidth] = useState(0);
  const [textWidth, setTextWidth] = useState(0);
  const [expanded, setExpanded] = useState(false);
  const pillMaxWidth = useRef(new Animated.Value(PILL_COLLAPSED_WIDTH)).current;
  const marqueeX = useRef(new Animated.Value(OFFSCREEN_RIGHT)).current;
  const marqueeStartedRef = useRef(false);
  const marqueeAnimRef = useRef<Animated.CompositeAnimation | null>(null);

  useEffect(() => {
    const expand = Animated.timing(pillMaxWidth, {
      toValue: PILL_MAX_WIDTH,
      duration: EXPAND_DURATION_MS,
      delay: EXPAND_DELAY_MS,
      easing: Easing.out(Easing.ease),
      useNativeDriver: false,
    });
    expand.start(({ finished }) => {
      if (finished) setExpanded(true);
    });
    return () => expand.stop();
  }, [pillMaxWidth]);

  useEffect(() => {
    if (marqueeStartedRef.current || !expanded || clipWidth <= 0 || textWidth <= 0) return;
    marqueeStartedRef.current = true;
    marqueeX.setValue(clipWidth);
    const durationMs = Math.min(
      MARQUEE_MAX_DURATION_MS,
      Math.max(
        MARQUEE_MIN_DURATION_MS,
        ((clipWidth + textWidth) / MARQUEE_SPEED_PX_PER_SECOND) * 1000,
      ),
    );
    const marquee = Animated.timing(marqueeX, {
      toValue: -textWidth,
      duration: durationMs,
      delay: MARQUEE_EXTRA_DELAY_MS,
      easing: Easing.linear,
      useNativeDriver: true,
    });
    marqueeAnimRef.current = marquee;
    marquee.start(({ finished }) => {
      if (finished) onMarqueeDone();
    });
  }, [expanded, clipWidth, textWidth, marqueeX, onMarqueeDone]);

  useEffect(() => () => marqueeAnimRef.current?.stop(), []);

  return (
    <Animated.View
      className="h-9 flex-row items-center self-center overflow-hidden rounded-full bg-white/95 pl-3 pr-1"
      style={{
        maxWidth: pillMaxWidth,
        gap: 4,
        borderWidth: 1,
        borderColor: 'rgba(0,0,0,0.1)',
        shadowColor: '#000',
        shadowOpacity: 0.22,
        shadowRadius: 14,
        shadowOffset: { width: 0, height: 4 },
        elevation: 6,
      }}
    >
      <Image source={megaphoneIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
      <Pressable
        className="h-full flex-1 justify-center overflow-hidden"
        style={{ minWidth: 0 }}
        onPress={onOpenDetail}
        onLayout={(event) => setClipWidth(event.nativeEvent.layout.width)}
      >
        <Animated.View
          className="absolute inset-y-0 left-0 justify-center"
          style={{ width: MARQUEE_TRACK_WIDTH, alignItems: 'flex-start', transform: [{ translateX: marqueeX }] }}
        >
          <Text
            className="text-sm font-semibold"
            style={{ color: colors.primaryInk }}
            onLayout={(event) => setTextWidth(Math.ceil(event.nativeEvent.layout.width))}
          >
            {title}
          </Text>
        </Animated.View>
      </Pressable>
      <Pressable
        onPress={onDismiss}
        className="h-7 w-7 items-center justify-center rounded-full active:bg-black/10"
      >
        <Text className="text-sm font-semibold" style={{ color: 'rgba(0,0,0,0.54)' }}>
          ✕
        </Text>
      </Pressable>
    </Animated.View>
  );
}

export function AnnouncementBanner() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const userId = useAuthStore((s) => s.user?.id);
  const announcement = useAnnouncementStore((s) => s.announcement);
  const visible = useAnnouncementStore(selectVisibleAnnouncement);
  const detailOpen = useAnnouncementStore((s) => s.detailOpen);
  const openDetail = useAnnouncementStore((s) => s.openDetail);
  const closeDetail = useAnnouncementStore((s) => s.closeDetail);
  const hide = useAnnouncementStore((s) => s.hide);
  const dismiss = useAnnouncementStore((s) => s.dismiss);

  useEffect(() => {
    if (userId != null) void useAnnouncementStore.getState().load();
  }, [userId]);

  if (announcement == null) return null;

  return (
    <>
      {visible != null && (
        <View
          pointerEvents="box-none"
          style={{
            position: 'absolute',
            left: 24,
            right: 24,
            top: insets.top + 56,
            zIndex: 50,
          }}
        >
          <BannerPill
            key={visible.id}
            title={visible.title}
            onOpenDetail={openDetail}
            onDismiss={dismiss}
            onMarqueeDone={hide}
          />
        </View>
      )}
      <Dialog
        visible={detailOpen}
        onClose={closeDetail}
        title={t('announcement.detailTitle')}
        showClose
        footer={
          announcement.link ? (
            <DialogButton
              variant="green"
              onPress={() => void Linking.openURL(announcement.link)}
            >
              {t('announcement.openLink')}
            </DialogButton>
          ) : undefined
        }
      >
        <Text className="mb-1 font-bold" style={{ color: '#3a3839' }}>
          {announcement.title}
        </Text>
        {announcement.content ? (
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {announcement.content}
          </Text>
        ) : null}
      </Dialog>
    </>
  );
}
