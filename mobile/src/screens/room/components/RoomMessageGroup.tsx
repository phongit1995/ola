import { memo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  type ImageSourcePropType,
  Pressable,
  useWindowDimensions,
  View,
} from 'react-native';
import { colorForName, formatClockHM } from '@ola/shared/lib';
import type { RoomReplySnapshot } from '@ola/shared/types';
import { kulImageForText } from '@lib/kul';
import { reactionChips } from '@lib/reactions';
import { imageSizeForHeight } from '@lib/chatSmiley';
import { CachedImage } from '@components/ui/CachedImage';
import { ChatText as Text } from '@components/ui/ChatText';
import { RichTextView } from '@components/ui/RichTextView';
import { VipAvatar } from '@components/ui/VipAvatar';
import { useMediaViewerStore } from '@store/mediaViewerStore';
import type { AnchorRect } from './MessageActionSheet';
import type { BubblePosition, GroupedMessage, MessageGroup } from '../messageGroups';
import { OTHER_CORNERS, OWN_CORNERS, roomBubbleTextMaxWidth } from '../roomConstants';

const mentionIcon = require('@assets/icons/room/ic_tag_people.png');
const photoIcon = require('@assets/icons/chat/ic_local.png');
const resendIcon = require('@assets/icons/chat/btn_resend_d.png');

const IMAGE_MAX_WIDTH = 208;
const IMAGE_MAX_HEIGHT = 176;
const IMAGE_RADIUS = 8;

const imageRatioCache = new Map<string, number>();

function fitImageSize(ratio: number | null) {
  if (ratio == null || ratio <= 0) {
    return { width: IMAGE_MAX_HEIGHT, height: IMAGE_MAX_HEIGHT };
  }
  let width = IMAGE_MAX_WIDTH;
  let height = width / ratio;
  if (height > IMAGE_MAX_HEIGHT) {
    height = IMAGE_MAX_HEIGHT;
    width = height * ratio;
  }
  return { width, height };
}

interface RoomMessageGroupProps {
  group: MessageGroup;
  highlightedId?: string | null;
  onOpenProfile?: (nick: string, color: string) => void;
  onOpenUser?: (userId: string) => void;
  onQuickMention?: (name: string) => void;
  onLongPressMessage?: (
    id: string,
    anchor: AnchorRect,
    grouped: GroupedMessage,
    isOwn: boolean
  ) => void;
  onQuoteClick?: (messageId: string) => void;
  onShowReactions?: (id: string) => void;
  onResendImage?: (id: string) => void;
}

function QuoteBlock({
  replyTo,
  isOwn,
  onQuoteClick,
}: {
  replyTo: RoomReplySnapshot;
  isOwn: boolean;
  onQuoteClick?: (messageId: string) => void;
}) {
  const { t } = useTranslation();
  const { width: windowWidth } = useWindowDimensions();
  const isImage = replyTo.type === 'image';
  const excerpt = isImage
    ? t('room.replyImage')
    : kulImageForText(replyTo.excerpt) != null
      ? t('room.replySticker')
      : replyTo.excerpt;
  const name =
    replyTo.senderName != null && replyTo.senderName !== '' ? `@${replyTo.senderName}` : '';
  return (
    <Pressable
      onPress={() => onQuoteClick?.(replyTo.messageId)}
      className="mb-1 rounded py-0.5 pl-2 pr-1"
      style={{
        borderLeftWidth: 2,
        borderLeftColor: isOwn ? 'rgba(255,255,255,0.6)' : '#7cb342',
        backgroundColor: isOwn ? 'rgba(255,255,255,0.15)' : 'rgba(0,0,0,0.05)',
      }}
    >
      {name !== '' && (
        <Text
          numberOfLines={1}
          className="text-xs font-semibold"
          style={{ color: isOwn ? 'rgba(255,255,255,0.9)' : 'rgba(0,0,0,0.6)' }}
        >
          {name}
        </Text>
      )}
      <View className="flex-row items-center gap-1">
        {isImage && <Image source={photoIcon} style={{ width: 14, height: 14 }} resizeMode="contain" />}
        <RichTextView
          content={excerpt}
          own={isOwn}
          color={isOwn ? 'rgba(255,255,255,0.75)' : 'rgba(0,0,0,0.45)'}
          maxWidth={roomBubbleTextMaxWidth(windowWidth, isOwn) - (isImage ? 32 : 14)}
          fontSize={12}
          maxLines={2}
          onMention={() => onQuoteClick?.(replyTo.messageId)}
        />
      </View>
    </Pressable>
  );
}

function BubbleContent({
  message,
  isOwn,
  kul,
  onMention,
  onLongPress,
  onResendImage,
}: {
  message: GroupedMessage;
  isOwn: boolean;
  kul: ImageSourcePropType | null;
  onMention: (nick: string) => void;
  onLongPress?: () => void;
  onResendImage?: (id: string) => void;
}) {
  const openViewer = useMediaViewerStore((s) => s.openViewer);
  const { width: windowWidth } = useWindowDimensions();
  const [imageRatio, setImageRatio] = useState<number | null>(() =>
    message.imageUrl != null ? (imageRatioCache.get(message.imageUrl) ?? null) : null
  );
  const isImage = message.type === 'image' && message.imageUrl != null && message.imageUrl !== '';
  const uploading = message.status === 'uploading';
  const failed = message.status === 'failed';

  if (isImage) {
    const size = fitImageSize(imageRatio);
    return (
      <Pressable
        onPress={() => {
          if (!uploading && !failed) openViewer([message.imageUrl!]);
        }}
        onLongPress={onLongPress}
        delayLongPress={300}
      >
        <CachedImage
          uri={message.imageUrl}
          onSize={({ width, height }) => {
            if (height > 0) {
              const ratio = width / height;
              if (message.imageUrl != null) imageRatioCache.set(message.imageUrl, ratio);
              setImageRatio(ratio);
            }
          }}
          style={{ ...size, borderRadius: IMAGE_RADIUS, opacity: uploading || failed ? 0.6 : 1 }}
          resizeMode="cover"
        />
        {uploading && (
          <View className="absolute inset-0 items-center justify-center">
            <ActivityIndicator color="#7cb342" />
          </View>
        )}
        {failed && (
          <Pressable
            onPress={() => onResendImage?.(message.id)}
            className="absolute inset-0 items-center justify-center"
            style={{ backgroundColor: 'rgba(0,0,0,0.4)', borderRadius: IMAGE_RADIUS }}
          >
            <Image source={resendIcon} style={{ width: 28, height: 28 }} resizeMode="contain" />
          </Pressable>
        )}
      </Pressable>
    );
  }

  if (kul != null) {
    return <Image source={kul} style={imageSizeForHeight(kul, 112)} resizeMode="contain" />;
  }

  return (
    <RichTextView
      content={message.content}
      own={isOwn}
      color={isOwn ? '#ffffff' : 'rgba(0,0,0,0.87)'}
      maxWidth={roomBubbleTextMaxWidth(windowWidth, isOwn)}
      onMention={onMention}
    />
  );
}

export function RoomBubbleBody({
  message,
  isOwn,
  position,
  highlighted = false,
  onMention,
  onLongPress,
  onQuoteClick,
  onResendImage,
}: {
  message: GroupedMessage;
  isOwn: boolean;
  position: BubblePosition;
  highlighted?: boolean;
  onMention: (nick: string) => void;
  onLongPress?: () => void;
  onQuoteClick?: (messageId: string) => void;
  onResendImage?: (id: string) => void;
}) {
  const isImage = message.type === 'image' && message.imageUrl != null && message.imageUrl !== '';
  const kul = isImage ? null : kulImageForText(message.content);
  const corners = isOwn ? OWN_CORNERS[position] : OTHER_CORNERS[position];
  const bare = (isImage || kul != null) && message.replyTo == null;

  return (
    <View
      className={bare ? 'rounded-xl' : `${corners} px-3.5 py-2`}
      style={[
        bare ? null : { backgroundColor: isOwn ? '#7cb342' : '#f1f8e9' },
        highlighted ? { borderWidth: 2, borderColor: 'rgba(124,179,66,0.6)' } : null,
      ]}
    >
      {message.replyTo != null && (
        <QuoteBlock replyTo={message.replyTo} isOwn={isOwn} onQuoteClick={onQuoteClick} />
      )}
      <BubbleContent
        message={message}
        isOwn={isOwn}
        kul={kul}
        onMention={onMention}
        onLongPress={onLongPress}
        onResendImage={onResendImage}
      />
    </View>
  );
}

function RoomBubble({
  message,
  isOwn,
  position,
  highlighted,
  onMention,
  onLongPressMessage,
  onQuoteClick,
  onResendImage,
}: {
  message: GroupedMessage;
  isOwn: boolean;
  position: BubblePosition;
  highlighted: boolean;
  onMention: (nick: string) => void;
  onLongPressMessage?: (
    id: string,
    anchor: AnchorRect,
    grouped: GroupedMessage,
    isOwn: boolean
  ) => void;
  onQuoteClick?: (messageId: string) => void;
  onResendImage?: (id: string) => void;
}) {
  const uploading = message.status === 'uploading';
  const failed = message.status === 'failed';
  const bubbleRef = useRef<View>(null);

  function handleLongPress() {
    if (uploading || failed) return;
    bubbleRef.current?.measureInWindow((x, y, width, height) => {
      onLongPressMessage?.(message.id, { x, y, width, height }, message, isOwn);
    });
  }

  return (
    <Pressable
      ref={bubbleRef}
      onLongPress={handleLongPress}
      delayLongPress={300}
      style={{ alignSelf: isOwn ? 'flex-end' : 'flex-start', maxWidth: '100%' }}
    >
      <RoomBubbleBody
        message={message}
        isOwn={isOwn}
        position={position}
        highlighted={highlighted}
        onMention={onMention}
        onLongPress={handleLongPress}
        onQuoteClick={onQuoteClick}
        onResendImage={onResendImage}
      />
    </Pressable>
  );
}

function ReactionChipsRow({
  message,
  isOwn,
  onShowReactions,
}: {
  message: GroupedMessage;
  isOwn: boolean;
  onShowReactions?: (id: string) => void;
}) {
  const chips = reactionChips(message.reactions);
  if (chips.length === 0) return null;
  return (
    <Pressable
      onPress={() => onShowReactions?.(message.id)}
      className="-mt-2 flex-row flex-wrap gap-1"
      style={{ alignSelf: isOwn ? 'flex-end' : 'flex-start' }}
    >
      {chips.map((chip) => (
        <View
          key={chip.type}
          className="flex-row items-center gap-1 rounded-full bg-white py-0.5 pl-1 pr-1.5"
          style={{
            borderWidth: 1,
            borderColor: 'rgba(0,0,0,0.05)',
            shadowColor: '#000',
            shadowOpacity: 0.12,
            shadowRadius: 3,
            shadowOffset: { width: 0, height: 1 },
            elevation: 1,
          }}
        >
          {chip.image != null && (
            <Image source={chip.image} style={{ width: 16, height: 16 }} resizeMode="contain" />
          )}
          <Text className="text-[11px] font-medium" style={{ color: 'rgba(0,0,0,0.55)' }}>
            {chip.count}
          </Text>
        </View>
      ))}
    </Pressable>
  );
}

function RoomMessageGroupComponent({
  group,
  highlightedId,
  onOpenProfile,
  onOpenUser,
  onQuickMention,
  onLongPressMessage,
  onQuoteClick,
  onShowReactions,
  onResendImage,
}: RoomMessageGroupProps) {
  const { isOwn, senderName } = group;
  const onMention = (nick: string) => onOpenProfile?.(nick, colorForName(nick));
  const time = formatClockHM(group.messages[0]!.createdAt);
  const openSender = () => onOpenUser?.(group.senderId);
  const lastIndex = group.messages.length - 1;

  return (
    <View className="gap-0.5">
      {group.showTime && (
        <Text className="text-center text-xs text-ola-ink-hint">
          {time}
        </Text>
      )}
      {isOwn ? (
        <Text
          numberOfLines={1}
          className="mr-12 self-end text-sm"
          style={{ color: 'rgba(0,0,0,0.54)', maxWidth: '80%' }}
        >
          {senderName}
        </Text>
      ) : (
        <Pressable onPress={openSender} className="ml-12 self-start" style={{ maxWidth: '85%' }}>
          <Text numberOfLines={1} className="text-sm text-ola-ink-soft">
            {senderName}
          </Text>
        </Pressable>
      )}
      <View
        className="flex-row items-start gap-2"
        style={{
          alignSelf: isOwn ? 'flex-end' : 'flex-start',
          maxWidth: isOwn ? '80%' : '85%',
          flexDirection: isOwn ? 'row-reverse' : 'row',
        }}
      >
        <Pressable onPress={openSender} disabled={isOwn}>
          <VipAvatar typeId={group.senderVipTypeId} size={32} />
        </Pressable>
        <View className="min-w-0 gap-0.5" style={{ alignItems: isOwn ? 'flex-end' : 'flex-start' }}>
          {group.messages.map((message, index) => {
            const bubble = (
              <RoomBubble
                message={message}
                isOwn={isOwn}
                position={message.position}
                highlighted={highlightedId === message.id}
                onMention={onMention}
                onLongPressMessage={onLongPressMessage}
                onQuoteClick={onQuoteClick}
                onResendImage={onResendImage}
              />
            );
            const withQuickMention = !isOwn && index === lastIndex;
            return (
              <View
                key={message.key}
                className="gap-0.5"
                style={{ alignItems: isOwn ? 'flex-end' : 'flex-start' }}
              >
                {withQuickMention ? (
                  <View>
                    {bubble}
                    <Pressable
                      onPress={() => onQuickMention?.(senderName)}
                      className="absolute h-7 w-7 items-center justify-center rounded-full"
                      style={{ left: '100%', bottom: 0, marginLeft: 4 }}
                    >
                      <Image source={mentionIcon} style={{ width: 24, height: 24 }} />
                    </Pressable>
                  </View>
                ) : (
                  bubble
                )}
                <ReactionChipsRow
                  message={message}
                  isOwn={isOwn}
                  onShowReactions={onShowReactions}
                />
              </View>
            );
          })}
        </View>
      </View>
    </View>
  );
}

function sameReply(
  a: RoomReplySnapshot | null | undefined,
  b: RoomReplySnapshot | null | undefined
): boolean {
  if (a == null || b == null) return a == null && b == null;
  return (
    a.messageId === b.messageId &&
    a.excerpt === b.excerpt &&
    a.senderName === b.senderName &&
    a.type === b.type
  );
}

function sameMessages(a: GroupedMessage[], b: GroupedMessage[]): boolean {
  if (a.length !== b.length) return false;
  for (let i = 0; i < a.length; i++) {
    const x = a[i]!;
    const y = b[i]!;
    if (
      x.id !== y.id ||
      x.key !== y.key ||
      x.content !== y.content ||
      x.type !== y.type ||
      x.imageUrl !== y.imageUrl ||
      x.status !== y.status ||
      x.position !== y.position ||
      x.reactions !== y.reactions ||
      !sameReply(x.replyTo, y.replyTo)
    ) {
      return false;
    }
  }
  return true;
}

function groupHasMessage(group: MessageGroup, id: string | null | undefined): boolean {
  return id != null && group.messages.some((message) => message.id === id);
}

function areGroupPropsEqual(prev: RoomMessageGroupProps, next: RoomMessageGroupProps): boolean {
  const pg = prev.group;
  const ng = next.group;
  if (
    pg.key !== ng.key ||
    pg.isOwn !== ng.isOwn ||
    pg.senderId !== ng.senderId ||
    pg.senderName !== ng.senderName ||
    pg.senderVipTypeId !== ng.senderVipTypeId ||
    pg.showTime !== ng.showTime
  ) {
    return false;
  }
  if (!sameMessages(pg.messages, ng.messages)) return false;
  if (
    prev.highlightedId !== next.highlightedId &&
    (groupHasMessage(pg, prev.highlightedId) || groupHasMessage(ng, next.highlightedId))
  ) {
    return false;
  }
  return true;
}

export const RoomMessageGroup = memo(RoomMessageGroupComponent, areGroupPropsEqual);
