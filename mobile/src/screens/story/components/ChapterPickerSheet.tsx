import { useTranslation } from 'react-i18next';
import { Pressable, Text, View, useWindowDimensions } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import type { StoryChapterItem } from '@ola/shared/types';
import { useThemeColors } from '@hooks/useThemeColors';
import type { ReaderPalette } from '../interface';
import { useStoryTextSize } from '../typography';
import { ReaderSheet } from './ReaderSheet';
import { NewBadge } from './StoryTags';

const ROW_HEIGHT = 44;
const LIST_MAX_RATIO = 0.6;

interface ChapterPickerSheetProps {
  chapters: StoryChapterItem[];
  currentPosition: number;
  palette: ReaderPalette;
  onPick: (position: number) => void;
  onClose: () => void;
}

export function ChapterPickerSheet({
  chapters,
  currentPosition,
  palette,
  onPick,
  onClose,
}: ChapterPickerSheetProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const { height: windowHeight } = useWindowDimensions();
  const currentIndex = Math.max(
    0,
    chapters.findIndex((chapter) => chapter.position === currentPosition)
  );
  const listHeight = Math.min(chapters.length * ROW_HEIGHT, windowHeight * LIST_MAX_RATIO);

  return (
    <ReaderSheet title={t('story.toc')} palette={palette} onClose={onClose}>
      <View style={{ height: listHeight }}>
        <FlashList
          data={chapters}
          keyExtractor={(chapter) => chapter.id}
          initialScrollIndex={currentIndex}
          renderItem={({ item }) => {
            const current = item.position === currentPosition;
            return (
              <Pressable
                onPress={() => onPick(item.position)}
                className="flex-row items-center gap-2 px-4"
                style={{
                  height: ROW_HEIGHT,
                  borderTopWidth: 1,
                  borderTopColor: palette.border,
                  backgroundColor: current ? palette.background : undefined,
                }}
              >
                <Text
                  numberOfLines={1}
                  className={`min-w-0 flex-1 ${current ? 'font-semibold' : ''}`}
                  style={[textSize(14, 20), { color: current ? colors.primaryInk : palette.text }]}
                >
                  {item.title}
                </Text>
                {item.isNew && <NewBadge label={t('story.newBadge')} />}
              </Pressable>
            );
          }}
        />
      </View>
    </ReaderSheet>
  );
}
