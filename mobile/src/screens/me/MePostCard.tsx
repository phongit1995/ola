import { memo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Linking, Pressable, Text, View, type TextLayoutEventData, type NativeSyntheticEvent } from 'react-native';
import { colorForName } from '@ola/shared/lib';
import type { Post, PostCheckIn } from '@ola/shared/types';
import { renderRichText } from '../../lib/richText';
import { Avatar } from '../../components/Avatar';

const moreIcon = require('../../assets/icons/me/ic_more.png');
const replyIcon = require('../../assets/icons/me/ic_action_reply_gray.png');
const dislikeIcon = require('../../assets/icons/me/ic_dislike_gray.png');
const dislikeIconActive = require('../../assets/icons/me/ic_dislike_black.png');
const likeIcon = require('../../assets/icons/me/ic_like_gray.png');
const likeIconActive = require('../../assets/icons/me/ic_like_selected.png');
const checkInIcon = require('../../assets/icons/me/ic_check_in.png');

function formatLikeCount(count: number): string {
  return count > 9 ? '9+' : String(count);
}

function CheckInCard({ checkIn }: { checkIn: PostCheckIn }) {
  const address = checkIn.address?.trim() ?? '';
  const action = checkIn.action?.trim() ?? '';
  const hasAction = action !== '';
  const actionIcon = checkIn.actionIcon?.trim() ?? '';
  const hasCoords = checkIn.lat != null && checkIn.lng != null;
  const primary = hasAction ? `${actionIcon} ${action}`.trim() : checkIn.name;
  const secondary = hasAction ? checkIn.name : address;

  function openMap() {
    if (!hasCoords) return;
    void Linking.openURL(
      `https://www.google.com/maps/search/?api=1&query=${checkIn.lat},${checkIn.lng}`
    );
  }

  return (
    <Pressable
      onPress={openMap}
      disabled={!hasCoords}
      className="mx-4 mt-3 flex-row items-center gap-3 rounded bg-white px-3 py-2.5"
      style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.1)' }}
    >
      <Image source={checkInIcon} style={{ width: 28, height: 28 }} resizeMode="contain" />
      <View className="min-w-0 flex-1">
        <Text numberOfLines={1} className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
          {primary}
        </Text>
        {secondary !== '' && (
          <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {secondary}
          </Text>
        )}
      </View>
      {hasCoords && <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.4)' }}>›</Text>}
    </Pressable>
  );
}

function MediaCell({
  url,
  height,
  extra,
  onOpen,
}: {
  url: string;
  height: number;
  extra?: number;
  onOpen?: () => void;
}) {
  return (
    <Pressable onPress={onOpen} className="flex-1">
      <Image source={{ uri: url }} style={{ height, borderRadius: 4 }} resizeMode="cover" />
      {extra != null && extra > 0 && (
        <View
          className="absolute inset-0 items-center justify-center rounded"
          style={{ backgroundColor: 'rgba(0,0,0,0.5)' }}
        >
          <Text className="text-lg font-medium text-white">+{extra}</Text>
        </View>
      )}
    </Pressable>
  );
}

function MediaGrid({ photos, onOpen }: { photos: string[]; onOpen?: (index: number) => void }) {
  const count = photos.length;
  if (count === 0) return null;

  if (count === 1) {
    return (
      <Pressable onPress={() => onOpen?.(0)} className="mx-4 mt-3">
        <Image source={{ uri: photos[0] }} style={{ height: 260, borderRadius: 4 }} resizeMode="cover" />
      </Pressable>
    );
  }

  if (count === 2 || count === 4) {
    const height = count === 2 ? 170 : 150;
    const rows = count === 2 ? [photos] : [photos.slice(0, 2), photos.slice(2, 4)];
    return (
      <View className="mx-4 mt-3 gap-2">
        {rows.map((row, rowIndex) => (
          <View key={rowIndex} className="flex-row gap-2">
            {row.map((url, i) => (
              <MediaCell key={url} url={url} height={height} onOpen={() => onOpen?.(rowIndex * 2 + i)} />
            ))}
          </View>
        ))}
      </View>
    );
  }

  if (count === 3) {
    return (
      <View className="mx-4 mt-3 flex-row gap-2">
        {photos.map((url, i) => (
          <MediaCell key={url} url={url} height={110} onOpen={() => onOpen?.(i)} />
        ))}
      </View>
    );
  }

  const top = photos.slice(0, 2);
  const bottom = photos.slice(2, 5);
  const extra = count - 5;
  return (
    <View className="mx-4 mt-3 gap-2">
      <View className="flex-row gap-2">
        {top.map((url, i) => (
          <MediaCell key={url} url={url} height={160} onOpen={() => onOpen?.(i)} />
        ))}
      </View>
      <View className="flex-row gap-2">
        {bottom.map((url, i) => (
          <MediaCell
            key={url}
            url={url}
            height={110}
            extra={i === bottom.length - 1 ? extra : undefined}
            onOpen={() => onOpen?.(i + 2)}
          />
        ))}
      </View>
    </View>
  );
}

interface MePostCardProps {
  post: Post;
  timeLabel: string;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile?: (author: string, color: string) => void;
  onOpenComments?: (id: string) => void;
  onOpenMenu?: (id: string) => void;
  onOpenLikers?: (id: string) => void;
  onOpenPhotos?: (photos: string[], index: number) => void;
}

function MePostCardComponent({
  post,
  timeLabel,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
  onOpenComments,
  onOpenMenu,
  onOpenLikers,
  onOpenPhotos,
}: MePostCardProps) {
  const { t } = useTranslation();
  const [expanded, setExpanded] = useState(false);
  const [clamped, setClamped] = useState(false);

  const author = post.author?.username ?? '';
  const fullName = post.author?.fullName ?? '';
  const showFullName = fullName !== '' && fullName !== author;
  const liked = post.myReaction === 'like';
  const disliked = post.myReaction === 'dislike';
  const comments = post.commentCount;
  const likes = post.likeCount;
  const photos = post.images.map((image) => image.url);
  const sticker = post.sticker != null && post.sticker !== '' ? post.sticker : null;

  function onTextLayout(event: NativeSyntheticEvent<TextLayoutEventData>) {
    if (!clamped && event.nativeEvent.lines.length > 5) setClamped(true);
  }

  const openAuthor = () => onOpenProfile?.(author, colorForName(author));

  return (
    <View className="mb-2 bg-white" style={{ elevation: 1, shadowColor: '#000', shadowOpacity: 0.18, shadowRadius: 2, shadowOffset: { width: 0, height: 1 } }}>
      <View className="flex-row items-start gap-4 px-4 pt-4">
        <Pressable onPress={openAuthor} className="min-w-0 flex-1 flex-row items-start gap-4">
          <Avatar name={author} uri={post.author?.avatar ?? undefined} size={40} />
          <View className="min-w-0 flex-1">
            <View className="flex-row items-center gap-1">
              <Text numberOfLines={1} className="text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
                {author}
              </Text>
              {showFullName && (
                <Text numberOfLines={1} className="text-base" style={{ color: 'rgba(0,0,0,0.54)' }}>
                  {fullName}
                </Text>
              )}
              {post.isPinned && (
                <Text className="text-xs" style={{ color: '#7cb342' }}>📌</Text>
              )}
            </View>
            <Text className="mt-0.5 text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {timeLabel}
            </Text>
          </View>
        </Pressable>
        <Pressable onPress={() => onOpenMenu?.(post.id)} className="p-2">
          <Image source={moreIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
        </Pressable>
      </View>

      {(post.content != null && post.content !== '') || sticker != null ? (
        <View className="flex-row items-start gap-2 px-4 pt-3">
          {sticker != null && <Text style={{ fontSize: 40, lineHeight: 44 }}>{sticker}</Text>}
          <View className="min-w-0 flex-1">
            <Text
              onTextLayout={onTextLayout}
              numberOfLines={expanded ? undefined : 5}
              className="text-sm leading-relaxed"
              style={{ color: 'rgba(0,0,0,0.87)' }}
            >
              {renderRichText(post.content ?? '', {
                own: false,
                onMention: (nick) => onOpenProfile?.(nick, colorForName(nick)),
              })}
            </Text>
            {clamped && !expanded && (
              <Pressable onPress={() => setExpanded(true)}>
                <Text className="mt-0.5 text-sm" style={{ color: '#558b2f' }}>
                  {t('me.seeMore')}
                </Text>
              </Pressable>
            )}
          </View>
        </View>
      ) : null}

      {post.checkIn != null && <CheckInCard checkIn={post.checkIn} />}

      {photos.length > 0 && (
        <MediaGrid photos={photos} onOpen={(index) => onOpenPhotos?.(photos, index)} />
      )}

      <View className="mx-4 mt-4 flex-row items-end">
        <Pressable
          disabled={comments === 0}
          onPress={() => onOpenComments?.(post.id)}
          className="flex-1"
        >
          <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('me.commentCount', { count: comments })}
          </Text>
        </Pressable>
        {likes > 0 && (
          <Pressable onPress={() => onOpenLikers?.(post.id)}>
            <Text className="ml-2 text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {t('me.likeCount', { value: formatLikeCount(likes) })}
            </Text>
          </Pressable>
        )}
      </View>

      <View className="mx-4 mt-1" style={{ height: 1, backgroundColor: 'rgba(0,0,0,0.12)' }} />

      <View className="flex-row px-4 pb-3 pt-3">
        <Pressable
          onPress={() => onOpenComments?.(post.id)}
          className="h-7 flex-1 flex-row items-center justify-center gap-1"
        >
          <Image source={replyIcon} style={{ width: 26, height: 26 }} resizeMode="contain" />
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.26)' }}>{t('me.comment')}</Text>
        </Pressable>
        <Pressable
          onPress={() => onToggleDislike(post.id)}
          className="h-7 flex-1 flex-row items-center justify-center gap-1"
        >
          <Image
            source={disliked ? dislikeIconActive : dislikeIcon}
            style={{ width: 26, height: 26 }}
            resizeMode="contain"
          />
          <Text className="text-sm" style={{ color: disliked ? 'rgba(0,0,0,0.87)' : 'rgba(0,0,0,0.26)' }}>
            {t('me.dislike')}
          </Text>
        </Pressable>
        <Pressable
          onPress={() => onToggleLike(post.id)}
          className="h-7 flex-1 flex-row items-center justify-center gap-1"
        >
          <Image
            source={liked ? likeIconActive : likeIcon}
            style={{ width: 26, height: 26 }}
            resizeMode="contain"
          />
          <Text className="text-sm" style={{ color: liked ? '#7cb342' : 'rgba(0,0,0,0.26)' }}>
            {liked ? t('me.liked') : t('me.like')}
          </Text>
        </Pressable>
      </View>
    </View>
  );
}

export const MePostCard = memo(MePostCardComponent);
