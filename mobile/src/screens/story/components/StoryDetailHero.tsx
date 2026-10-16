import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { formatCompactCount, formatDateSlashDMY, withAlpha } from '@ola/shared/lib';
import type { Story, StoryIconName } from '@ola/shared/types';
import { useThemeColors } from '@hooks/useThemeColors';
import { READER_FONTS } from '../constants';
import { useStoryTextSize } from '../useStoryTextSize';
import { StoryCover } from './StoryCover';
import { StoryIcon } from './StoryIcons';
import { StoryMeta, StoryStatusBadge, StoryTag } from './StoryTags';

const COVER_WIDTH = 112;
const BAND_HEIGHT = 112;
const STAT_ICON_SIZE = 16;
const READ_ICON_SIZE = 20;
const COMMENT_ICON_SIZE = 16;
const DATE_FONT = 12;
const INK = 'rgba(0,0,0,0.87)';
const MUTED = 'rgba(0,0,0,0.5)';
const HAIRLINE = 'rgba(0,0,0,0.06)';
const PROGRESS_TRACK = 'rgba(0,0,0,0.06)';

const CARD_SHADOW = {
  shadowColor: '#000',
  shadowOpacity: 0.06,
  shadowRadius: 4,
  shadowOffset: { width: 0, height: 1 },
  elevation: 1,
};

interface StatProps {
  icon: StoryIconName;
  label: string;
  value: string;
  divided: boolean;
}

function Stat({ icon, label, value, divided }: StatProps) {
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  return (
    <View
      className="flex-1 items-center gap-0.5"
      style={divided ? { borderLeftWidth: 1, borderLeftColor: HAIRLINE } : undefined}
    >
      <View className="flex-row items-center gap-1">
        <StoryIcon name={icon} size={STAT_ICON_SIZE} color={colors.primaryDark} />
        <Text
          className="font-bold"
          style={[textSize(16, 24), { color: INK, fontVariant: ['tabular-nums'] }]}
        >
          {value}
        </Text>
      </View>
      <Text style={[textSize(11, 16), { color: MUTED }]}>{label}</Text>
    </View>
  );
}

interface StoryDetailHeroProps {
  story: Story;
  isShort: boolean;
  readLabel: string;
  percent: number | null;
  onRead: () => void;
  onComments: () => void;
}

export function StoryDetailHero({
  story,
  isShort,
  readLabel,
  percent,
  onRead,
  onComments,
}: StoryDetailHeroProps) {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const locale = i18n.language;

  return (
    <View className="overflow-hidden bg-white p-4">
      <LinearGradient
        colors={[colors.primaryLight, withAlpha(colors.primaryLight, 0)]}
        style={{ position: 'absolute', left: 0, right: 0, top: 0, height: BAND_HEIGHT }}
      />
      <View className="flex-row gap-4">
        <StoryCover title={story.title} coverUrl={story.coverUrl} size="lg" width={COVER_WIDTH} />
        <View className="min-w-0 flex-1">
          <Text
            numberOfLines={3}
            className="font-bold"
            style={[textSize(20, 28), { color: INK, fontFamily: READER_FONTS.serif.family }]}
          >
            {story.title}
          </Text>
          <View className="mt-2 flex-row flex-wrap gap-1">
            <StoryStatusBadge status={story.status} />
            {isShort && <StoryTag>{t('story.kindShort')}</StoryTag>}
            {story.genres.map((genre) => (
              <StoryTag key={genre}>{genre}</StoryTag>
            ))}
          </View>
          <StoryMeta icon="schedule" fontSize={DATE_FONT} className="mt-auto pt-2">
            {formatDateSlashDMY(story.lastChapterAt ?? story.updatedAt)}
          </StoryMeta>
        </View>
      </View>

      <View
        className="mt-4 flex-row rounded-xl bg-white py-2.5"
        style={[{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.05)' }, CARD_SHADOW]}
      >
        <Stat
          icon="menuBook"
          label={t('story.statChapters')}
          value={story.chapterCount.toLocaleString(locale)}
          divided={false}
        />
        <Stat
          icon="visibility"
          label={t('story.statViews')}
          value={formatCompactCount(story.viewCount, locale)}
          divided
        />
        <Stat
          icon="article"
          label={t('story.statWords')}
          value={formatCompactCount(story.wordCount, locale)}
          divided
        />
      </View>

      <View className="mt-4 flex-row gap-2">
        <Pressable
          accessibilityRole="button"
          onPress={onRead}
          className="h-11 min-w-0 flex-1 flex-row items-center justify-center gap-1.5 overflow-hidden rounded-full px-4 active:opacity-90"
        >
          <LinearGradient
            colors={[colors.primary, colors.primaryDark]}
            start={{ x: 0, y: 0 }}
            end={{ x: 1, y: 0 }}
            style={StyleSheet.absoluteFill}
          />
          <StoryIcon name="menuBook" size={READ_ICON_SIZE} color={colors.onPrimary} />
          <Text
            numberOfLines={1}
            className="min-w-0 flex-shrink font-semibold"
            style={[textSize(14, 20), { color: colors.onPrimary }]}
          >
            {readLabel}
          </Text>
        </Pressable>
        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('story.comments')}
          onPress={onComments}
          className="h-11 flex-row items-center gap-1.5 rounded-full px-4 active:opacity-70"
          style={{ borderWidth: 1, borderColor: withAlpha(colors.primary, 0.6) }}
        >
          <StoryIcon name="chatBubble" size={COMMENT_ICON_SIZE} color={colors.primaryDark} />
          <Text
            className="font-semibold"
            style={[textSize(14, 20), { color: colors.primaryDark, fontVariant: ['tabular-nums'] }]}
          >
            {formatCompactCount(story.commentCount, locale)}
          </Text>
        </Pressable>
      </View>

      {percent != null && (
        <View className="mt-3 flex-row items-center gap-2">
          <View
            className="h-1 flex-1 overflow-hidden rounded-full"
            style={{ backgroundColor: PROGRESS_TRACK }}
          >
            <View
              className="h-full rounded-full"
              style={{ width: `${percent}%`, backgroundColor: colors.primary }}
            />
          </View>
          <Text style={[textSize(11, 16), { color: MUTED, fontVariant: ['tabular-nums'] }]}>
            {t('story.readPercent', { percent })}
          </Text>
        </View>
      )}
    </View>
  );
}
