import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { StoryAccess } from '@ola/shared/types';
import { OlaModal } from '@components/ui/OlaModal';
import { ERROR } from '@constants';
import { useStoryTextSize } from '../useStoryTextSize';
import { StoryIcon } from './StoryIcons';

const HEADER_HEIGHT = 48;
const POPOVER_GAP = 4;
const POPOVER_WIDTH = 256;
const POPOVER_RIGHT = 8;
const ICON_SIZE = 16;
const BODY_COLOR = 'rgba(0,0,0,0.6)';
const TITLE_COLOR = 'rgba(0,0,0,0.87)';

const POPOVER_SHADOW = {
  shadowColor: '#000',
  shadowOpacity: 0.18,
  shadowRadius: 12,
  shadowOffset: { width: 0, height: 4 },
  elevation: 8,
};

export function StoryFreeReadsBadge({ access }: { access: StoryAccess }) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const textSize = useStoryTextSize();
  const [open, setOpen] = useState(false);
  const left = Math.max(0, access.freeLimit - access.freeUsed);
  const summary =
    left > 0
      ? t('story.accessFree', { left, limit: access.freeLimit })
      : t('story.accessNoneLeft', { limit: access.freeLimit });

  return (
    <>
      <Pressable
        accessibilityRole="button"
        accessibilityLabel={summary}
        accessibilityState={{ expanded: open }}
        onPress={() => setOpen(true)}
        className="h-8 flex-row items-center gap-1 rounded-full px-2.5 active:opacity-80"
        style={{ backgroundColor: left > 0 ? 'rgba(255,255,255,0.15)' : ERROR }}
      >
        <StoryIcon name="menuBook" size={ICON_SIZE} color="#ffffff" />
        <Text
          className="font-semibold text-white"
          style={[textSize(14, 20), { fontVariant: ['tabular-nums'] }]}
        >
          {`${left}/${access.freeLimit}`}
        </Text>
      </Pressable>
      {open && (
        <OlaModal
          visible
          transparent
          statusBarTranslucent
          animationType="fade"
          onRequestClose={() => setOpen(false)}
        >
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={t('dialog.close')}
            onPress={() => setOpen(false)}
            style={StyleSheet.absoluteFill}
          />
          <View
            className="rounded-lg bg-white p-3"
            style={[
              {
                position: 'absolute',
                top: insets.top + HEADER_HEIGHT + POPOVER_GAP,
                right: POPOVER_RIGHT,
                width: POPOVER_WIDTH,
              },
              POPOVER_SHADOW,
            ]}
          >
            <Text
              className="font-semibold"
              style={[textSize(13, 20), { color: left > 0 ? TITLE_COLOR : ERROR }]}
            >
              {summary}
            </Text>
            <Text className="mt-1" style={[textSize(13, 20), { color: BODY_COLOR }]}>
              {t('story.lockedVip')}
            </Text>
            <Text style={[textSize(13, 20), { color: BODY_COLOR }]}>
              {t('story.commentUnlockHint', { count: access.commentMinChars })}
            </Text>
          </View>
        </OlaModal>
      )}
    </>
  );
}
