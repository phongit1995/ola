import { memo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Linking, Pressable, Text, View, type TextLayoutEventData, type NativeSyntheticEvent } from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSequence,
  withTiming,
  withDelay,
  runOnJS,
  type SharedValue,
} from 'react-native-reanimated';
import { colorForName } from '@ola/shared/lib';
import type { Post, PostAuthor, PostCheckIn } from '@ola/shared/types';
import { imageSizeForHeight } from '../../lib/chatSmiley';
import { renderRichText } from '../../lib/richText';
import { stickerImageForCode } from '../../lib/kul';
import { Avatar } from '../../components/Avatar';

const moreIcon = require('../../assets/icons/me/ic_more.png');
const replyIcon = require('../../assets/icons/me/ic_action_reply_gray.png');
const dislikeIcon = require('../../assets/icons/me/ic_dislike_gray.png');
const dislikeIconActive = require('../../assets/icons/me/ic_dislike_black.png');
const likeIcon = require('../../assets/icons/me/ic_like_gray.png');
const likeIconActive = require('../../assets/icons/me/ic_like_selected.png');
const likeStickerFly = require('../../assets/icons/me/sticker_like.png');
const checkInIcon = require('../../assets/icons/me/ic_check_in.png');
const pinIcon = require('../../assets/icons/me/ic_pin.png');

function formatLikeCount(count: number): string {
  return count > 9 ? '9+' : String(count);
}

function LikerStack({ likers }: { likers: PostAuthor[] }) {
  if (likers.length === 0) return null;
  return (
    <View className="flex-row">
      {likers.map((liker, index) => (
        <View
          key={liker.id ?? index}
          style={{
            marginLeft: index === 0 ? 0 : -6,
            borderRadius: 999,
            borderWidth: 2,
            borderColor: '#ffffff',
          }}
        >
          <Avatar name={liker.username} uri={liker.avatar ?? undefined} size={18} />
        </View>
      ))}
    </View>
  );
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
        <Image source={{ uri: photos[0] }} style={{ height: 384, borderRadius: 4 }} resizeMode="cover" />
      </Pressable>
    );
  }

  if (count === 2 || count === 4) {
    const height = count === 2 ? 176 : 160;
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
          <MediaCell key={url} url={url} height={112} onOpen={() => onOpen?.(i)} />
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
          <MediaCell key={url} url={url} height={176} onOpen={() => onOpen?.(i)} />
        ))}
      </View>
      <View className="flex-row gap-2">
        {bottom.map((url, i) => (
          <MediaCell
            key={url}
            url={url}
            height={112}
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
  onOpenComments?: (id: string, focusInput?: boolean) => void;
  onQuickComment?: (id: string) => void;
  onOpenMenu?: (id: string) => void;
  onOpenLikers?: (id: string) => void;
  onOpenPhotos?: (photos: string[], index: number) => void;
  onOpenClan?: (handle: string) => void;
}

function MePostCardComponent({
  post,
  timeLabel,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
  onOpenComments,
  onQuickComment,
  onOpenMenu,
  onOpenLikers,
  onOpenPhotos,
  onOpenClan,
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
  const topLikers = post.topLikers ?? [];
  const photos = post.images.map((image) => image.url);
  const sticker = post.sticker != null && post.sticker !== '' ? post.sticker : null;
  const stickerImg = stickerImageForCode(post.sticker);

  function handleCommentIcon() {
    if (onQuickComment != null) onQuickComment(post.id);
    else onOpenComments?.(post.id, true);
  }

  const likeScale = useSharedValue(1);
  const dislikeScale = useSharedValue(1);
  const flyProgress = useSharedValue(0);
  const [flying, setFlying] = useState(false);

  function pop(shared: SharedValue<number>, peak: number) {
    shared.value = withSequence(
      withTiming(peak, { duration: 100 }),
      withDelay(200, withTiming(1, { duration: 100 }))
    );
  }

  function handleLike() {
    const becomingLiked = !liked;
    pop(likeScale, becomingLiked ? 1.5 : 0.8);
    if (becomingLiked) {
      setFlying(true);
      flyProgress.value = 0;
      flyProgress.value = withTiming(1, { duration: 1500 }, (finished) => {
        if (finished) runOnJS(setFlying)(false);
      });
    }
    onToggleLike(post.id);
  }

  function handleDislike() {
    pop(dislikeScale, disliked ? 0.8 : 1.5);
    onToggleDislike(post.id);
  }

  const likeIconStyle = useAnimatedStyle(() => ({ transform: [{ scale: likeScale.value }] }));
  const dislikeIconStyle = useAnimatedStyle(() => ({ transform: [{ scale: dislikeScale.value }] }));
  const flyStyle = useAnimatedStyle(() => ({
    opacity: 0.7 * (1 - flyProgress.value),
    transform: [
      { translateY: -288 * flyProgress.value },
      { scale: 0.5 + 0.5 * flyProgress.value },
    ],
  }));

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
              <Text numberOfLines={1} className="min-w-0 shrink text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
                {author}
                {showFullName && (
                  <Text style={{ color: 'rgba(0,0,0,0.54)' }}> · {fullName}</Text>
                )}
              </Text>
              {post.isPinned && (
                <Image source={pinIcon} style={{ width: 14, height: 14 }} resizeMode="contain" />
              )}
              {post.clanHandle != null && post.clanHandle !== '' && (
                <Text
                  onPress={
                    onOpenClan == null ? undefined : () => onOpenClan(post.clanHandle ?? '')
                  }
                  className="shrink-0 text-xs font-bold"
                  style={{ color: '#33691e' }}
                >
                  #{post.clanHandle}
                </Text>
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
          {stickerImg != null ? (
            <Image source={stickerImg} style={imageSizeForHeight(stickerImg, 84)} resizeMode="contain" />
          ) : sticker != null ? (
            <Text style={{ fontSize: 48, lineHeight: 48 }}>{sticker}</Text>
          ) : null}
          <View className="min-w-0 flex-1">
            <Text
              onTextLayout={onTextLayout}
              numberOfLines={expanded ? undefined : 5}
              className="text-sm leading-relaxed"
              style={{ color: 'rgba(0,0,0,0.87)' }}
            >
              {renderRichText(post.content ?? '', {
                own: false,
                fontSize: 14,
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

      <View className="mx-4 mt-4 flex-row items-end gap-1">
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
          <Pressable
            onPress={() => onOpenLikers?.(post.id)}
            className="ml-2 flex-row items-center gap-1"
          >
            <LikerStack likers={topLikers} />
            <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {t('me.likeCount', { value: formatLikeCount(likes) })}
            </Text>
          </Pressable>
        )}
      </View>

      <View className="mx-4 mt-1" style={{ height: 1, backgroundColor: 'rgba(0,0,0,0.12)' }} />

      <View className="flex-row px-4 pb-3 pt-3">
        <Pressable
          onPress={handleCommentIcon}
          className="h-7 flex-1 flex-row items-center justify-center gap-1"
        >
          <Image source={replyIcon} style={{ width: 28, height: 28 }} resizeMode="contain" />
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.26)' }}>{t('me.comment')}</Text>
        </Pressable>
        <Pressable
          onPress={handleDislike}
          className="h-7 flex-1 flex-row items-center justify-center gap-1"
        >
          <Animated.Image
            source={disliked ? dislikeIconActive : dislikeIcon}
            style={[{ width: 28, height: 28 }, dislikeIconStyle]}
            resizeMode="contain"
          />
          <Text className="text-sm" style={{ color: disliked ? 'rgba(0,0,0,0.87)' : 'rgba(0,0,0,0.26)' }}>
            {t('me.dislike')}
          </Text>
        </Pressable>
        <Pressable
          onPress={handleLike}
          className="h-7 flex-1 flex-row items-center justify-center gap-1"
        >
          <Animated.Image
            source={liked ? likeIconActive : likeIcon}
            style={[{ width: 28, height: 28 }, likeIconStyle]}
            resizeMode="contain"
          />
          <Text className="text-sm" style={{ color: liked ? '#7cb342' : 'rgba(0,0,0,0.26)' }}>
            {liked ? t('me.liked') : t('me.like')}
          </Text>
        </Pressable>
      </View>

      {flying && (
        <View
          pointerEvents="none"
          className="absolute flex-row px-4"
          style={{ left: 0, right: 0, bottom: 6 }}
        >
          <View className="flex-1" />
          <View className="flex-1" />
          <View className="flex-1 items-center">
            <Animated.Image
              source={likeStickerFly}
              style={[{ width: 96, height: 96 }, flyStyle]}
              resizeMode="contain"
            />
          </View>
        </View>
      )}
    </View>
  );
}

export const MePostCard = memo(MePostCardComponent);
