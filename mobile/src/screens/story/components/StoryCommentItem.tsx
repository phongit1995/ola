import { memo } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { activeVipTypeId, colorForName } from '@ola/shared/lib';
import type { StoryComment } from '@ola/shared/types';
import { renderRichText } from '@lib/richText';
import { Avatar } from '@components/ui/Avatar';
import { VipBadge } from '@components/ui/VipBadge';
import { useAppTypography } from '@components/AppFontProvider';
import { useThemeColors } from '@hooks/useThemeColors';
import { ROW_SEPARATOR } from '../constants';
import { storyCommentAuthorName } from '../storyComment';
import { useStoryTextSize } from '../typography';

const replyIcon = require('@assets/icons/me/ic_action_reply_gray.png');
const likeIcon = require('@assets/icons/me/ic_like_gray.png');
const likeIconActive = require('@assets/icons/me/ic_like_selected.png');

const AVATAR_SIZE = 36;
const VIP_BADGE_SIZE = 16;
const ACTION_ICON_SIZE = 20;
const CONTENT_FONT_SIZE = 14;
const MUTED = 'rgba(0,0,0,0.54)';

function ignoreMention() {}

interface StoryCommentItemProps {
  comment: StoryComment;
  time: string;
  onReply: (comment: StoryComment) => void;
  onDelete: (commentId: string) => void;
  onToggleLike: (commentId: string) => void;
}

function StoryCommentItemComponent({
  comment,
  time,
  onReply,
  onDelete,
  onToggleLike,
}: StoryCommentItemProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const { multiplier, systemFontScale } = useAppTypography();
  const { author, replyTo } = comment;
  const name = storyCommentAuthorName(comment);
  const vipTypeId = activeVipTypeId(author?.vipUsed, author?.vipEndTime);
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
        color={colorForName(author?.username || name)}
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
          </Text>
          <Text className="ml-1" style={[textSize(12, 16), { color: MUTED }]}>
            {time}
          </Text>
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
          {comment.mine && (
            <Pressable accessibilityRole="button" onPress={() => onDelete(comment.id)} hitSlop={6}>
              <Text className="font-medium" style={actionText}>
                {t('story.commentDelete')}
              </Text>
            </Pressable>
          )}
        </View>
      </View>
    </View>
  );
}

export const StoryCommentItem = memo(StoryCommentItemComponent);
