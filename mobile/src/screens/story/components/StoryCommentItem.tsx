import { memo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { activeVipTypeId, colorForName, storyCommentAuthorName } from '@ola/shared/lib';
import type { StoryComment } from '@ola/shared/types';
import { renderRichText } from '@lib/richText';
import { Avatar } from '@components/ui/Avatar';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { ReportDialog } from '@components/ui/ReportDialog';
import { VipBadge } from '@components/ui/VipBadge';
import { useAppTypography } from '@components/AppFontProvider';
import { useThemeColors } from '@hooks/useThemeColors';
import { READER_PALETTES, ROW_SEPARATOR } from '../constants';
import { useStoryTextSize } from '../useStoryTextSize';
import { StoryCover } from './StoryCover';
import { StoryIcon } from './StoryIcons';

const moreIcon = require('@assets/icons/me/ic_more.png');
const replyIcon = require('@assets/icons/me/ic_action_reply_gray.png');
const likeIcon = require('@assets/icons/me/ic_like_gray.png');
const likeIconActive = require('@assets/icons/me/ic_like_selected.png');

const AVATAR_SIZE = 36;
const VIP_BADGE_SIZE = 16;
const ACTION_ICON_SIZE = 20;
const MORE_ICON_STYLE = { width: 16, height: 16 };
const CONTENT_FONT_SIZE = 14;
const MUTED = 'rgba(0,0,0,0.54)';
const STORY_CHIP_BACKGROUND = READER_PALETTES.light.panel;
const STORY_CHIP_COVER_WIDTH = 24;
const STORY_CHIP_ICON_SIZE = 16;

function ignoreMention() {}

interface StoryCommentItemProps {
  comment: StoryComment;
  time: string;
  onReply: (comment: StoryComment) => void;
  onDelete: (comment: StoryComment) => void;
  onToggleLike: (commentId: string) => void;
  onOpenStory?: (storyId: string) => void;
}

function StoryCommentItemComponent({
  comment,
  time,
  onReply,
  onDelete,
  onToggleLike,
  onOpenStory,
}: StoryCommentItemProps) {
  const { t } = useTranslation();
  const [menuOpen, setMenuOpen] = useState(false);
  const [reportOpen, setReportOpen] = useState(false);
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const { multiplier, systemFontScale } = useAppTypography();
  const { author, replyTo, story } = comment;
  const name = storyCommentAuthorName(comment);
  const fullName = author?.fullName ?? '';
  const vipTypeId = activeVipTypeId(author?.vipUsed, author?.vipEndTime);
  const menuOptions: ListOption[] = comment.mine
    ? [
        {
          key: 'delete',
          label: t('story.commentDeleteOption'),
          danger: true,
          onSelect: () => onDelete(comment),
        },
      ]
    : [{ key: 'report', label: t('report.comment'), onSelect: () => setReportOpen(true) }];
  const actionText = [textSize(12, 16), { color: MUTED }];
  const actionIconStyle = { width: ACTION_ICON_SIZE, height: ACTION_ICON_SIZE };

  return (
    <View
      className="flex-row gap-2.5 bg-white px-4 py-3"
      style={{ borderTopWidth: 1, borderTopColor: ROW_SEPARATOR }}
    >
      <Avatar
        name={name}
        uri={author?.avatar}
        color={colorForName(name)}
        size={AVATAR_SIZE}
      />
      <View className="min-w-0 flex-1">
        <View className="min-w-0 flex-row items-center gap-1">
          {vipTypeId != null && <VipBadge typeId={vipTypeId} size={VIP_BADGE_SIZE} />}
          <Text
            numberOfLines={1}
            className="min-w-0 shrink font-semibold text-ola-ink"
            style={textSize(14, 20)}
          >
            {name}
            {fullName !== '' && <Text className="font-normal" style={{ color: MUTED }}> · {fullName}</Text>}
          </Text>
          <Text className="ml-1" style={[textSize(12, 16), { color: MUTED }]}>
            {time}
          </Text>
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={t('story.commentMenu')}
            onPress={() => setMenuOpen(true)}
            hitSlop={8}
            className="ml-auto pl-2"
          >
            <Image source={moreIcon} style={MORE_ICON_STYLE} resizeMode="contain" />
          </Pressable>
        </View>
        {replyTo != null && (
          <View
            className="mt-1 pl-2"
            style={{ borderLeftWidth: 2, borderLeftColor: colors.primary }}
          >
            <Text numberOfLines={2} style={[textSize(12, 20), { color: MUTED }]}>
              <Text className="font-semibold">{replyTo.authorName}</Text>
              {`: ${replyTo.excerpt}`}
            </Text>
          </View>
        )}
        <Text className="mt-0.5 text-ola-ink" style={textSize(CONTENT_FONT_SIZE, 23)}>
          {renderRichText(comment.content, {
            own: false,
            fontSize: CONTENT_FONT_SIZE * multiplier * systemFontScale,
            accentColor: colors.primaryDarker,
            onMention: ignoreMention,
          })}
        </Text>
        {onOpenStory && story && (
          <Pressable
            accessibilityRole="button"
            onPress={() => onOpenStory(story.id)}
            className="mt-2 flex-row items-center gap-2 self-start rounded-lg py-1.5 pl-1.5 pr-2 active:opacity-80"
            style={{ maxWidth: '100%', backgroundColor: STORY_CHIP_BACKGROUND }}
          >
            <StoryCover
              title={story.title}
              coverUrl={story.coverUrl}
              size="xs"
              width={STORY_CHIP_COVER_WIDTH}
            />
            <Text
              numberOfLines={1}
              className="min-w-0 shrink font-medium text-ola-ink"
              style={textSize(12, 16)}
            >
              {story.title}
            </Text>
            <StoryIcon name="chevronRight" size={STORY_CHIP_ICON_SIZE} color={MUTED} />
          </Pressable>
        )}
        <View className="mt-1.5 flex-row items-center gap-4">
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={t('story.commentLike')}
            accessibilityState={{ selected: comment.liked }}
            onPress={() => onToggleLike(comment.id)}
            hitSlop={6}
            className="flex-row items-center gap-1"
          >
            <Image
              source={comment.liked ? likeIconActive : likeIcon}
              style={actionIconStyle}
              resizeMode="contain"
            />
            {comment.likeCount > 0 && (
              <Text
                className="font-medium"
                style={[actionText, { fontVariant: ['tabular-nums'] }]}
              >
                {comment.likeCount}
              </Text>
            )}
          </Pressable>
          <Pressable
            accessibilityRole="button"
            onPress={() => onReply(comment)}
            hitSlop={6}
            className="flex-row items-center gap-1"
          >
            <Image source={replyIcon} style={actionIconStyle} resizeMode="contain" />
            <Text className="font-medium" style={actionText}>
              {t('story.commentReply')}
            </Text>
          </Pressable>
        </View>
      </View>
      <ListOptionDialog
        visible={menuOpen}
        title={t('story.commentMenu')}
        options={menuOptions}
        onClose={() => setMenuOpen(false)}
      />
      {reportOpen && (
        <ReportDialog target={{ type: 'comment', id: comment.id }} onClose={() => setReportOpen(false)} />
      )}
    </View>
  );
}

export const StoryCommentItem = memo(StoryCommentItemComponent);
