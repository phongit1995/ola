import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Linking, Pressable, Text, View, type TextLayoutEvent } from 'react-native';
import { createTimeFormatter } from '@ola/shared/lib';
import {
  announcementPublishedAt,
  selectFeedAnnouncement,
  useAnnouncementStore,
} from '@ola/shared/stores/announcementStore';
import { useThemeColors } from '@hooks/useThemeColors';

const olaLogo = require('@assets/ola-logo.png');
const COLLAPSED_LINES = 5;

export function MeAnnouncementCard() {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const announcement = useAnnouncementStore(selectFeedAnnouncement);
  const dismissFromFeed = useAnnouncementStore((s) => s.dismissFromFeed);
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const [expanded, setExpanded] = useState(false);
  const [clamped, setClamped] = useState(false);

  if (announcement == null) return null;

  function onContentLayout(event: TextLayoutEvent) {
    setClamped(event.nativeEvent.lines.length > COLLAPSED_LINES);
  }

  return (
    <View
      className="mb-2 pb-3"
      style={{
        backgroundColor: colors.primaryLight,
        elevation: 1,
        shadowColor: '#000',
        shadowOpacity: 0.18,
        shadowRadius: 2,
        shadowOffset: { width: 0, height: 1 },
      }}
    >
      <View className="flex-row items-start gap-4 px-4 pt-4">
        <View className="items-center justify-center rounded-full bg-ola-primary" style={{ width: 40, height: 40 }}>
          <Image source={olaLogo} style={{ width: 24, height: 24 }} resizeMode="contain" />
        </View>
        <View className="min-w-0 flex-1">
          <View className="flex-row items-center gap-1">
            <Text numberOfLines={1} className="shrink text-base text-ola-ink">
              {t('announcement.feedAuthor')}
            </Text>
            <View
              className="items-center justify-center"
              style={{ width: 14, height: 14, borderRadius: 7, backgroundColor: colors.primary }}
            >
              <Text style={{ color: colors.onPrimary, fontSize: 9, fontWeight: '700', lineHeight: 11 }}>✓</Text>
            </View>
            <View className="ml-1 rounded-full px-2" style={{ backgroundColor: colors.primary }}>
              <Text style={{ color: colors.onPrimary, fontSize: 11, fontWeight: '500' }}>
                {t('announcement.feedBadge')}
              </Text>
            </View>
          </View>
          <Text className="mt-0.5 text-xs text-ola-ink-soft">
            {formatTime(announcementPublishedAt(announcement))}
          </Text>
        </View>
        <Pressable
          onPress={dismissFromFeed}
          accessibilityRole="button"
          accessibilityLabel={t('announcement.dismiss')}
          hitSlop={10}
          className="items-center justify-center"
          style={{ width: 28, height: 28 }}
        >
          <Text style={{ color: colors.primaryInk, fontSize: 16, fontWeight: '700' }}>✕</Text>
        </Pressable>
      </View>

      <Text className="px-4 pt-3 text-sm font-bold text-ola-ink">{announcement.title}</Text>
      {announcement.content !== '' && (
        <View className="px-4 pt-3">
          <Text numberOfLines={expanded ? undefined : COLLAPSED_LINES} className="text-sm leading-relaxed text-ola-ink">
            {announcement.content}
          </Text>
          <View pointerEvents="none" style={{ position: 'absolute', left: 16, right: 16, opacity: 0 }}>
            <Text onTextLayout={onContentLayout} className="text-sm leading-relaxed text-ola-ink">
              {announcement.content}
            </Text>
          </View>
          {clamped && !expanded && (
            <Pressable onPress={() => setExpanded(true)}>
              <Text className="mt-0.5 text-sm" style={{ color: colors.primaryDark }}>
                {t('me.seeMore')}
              </Text>
            </Pressable>
          )}
        </View>
      )}
      {announcement.link !== '' && (
        <Pressable onPress={() => void Linking.openURL(announcement.link)} className="mt-2 px-4">
          <Text className="text-sm font-medium" style={{ color: colors.primaryDark }}>
            {t('announcement.feedOpenLink')}
          </Text>
        </Pressable>
      )}
    </View>
  );
}
