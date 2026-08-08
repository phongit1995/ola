import { useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, useWindowDimensions, View } from 'react-native';
import { callMessageView, formatDuration, parseMessageMetadata } from '@ola/shared/lib';
import type { MessageMetadata } from '@ola/shared/lib';
import type { ChatReplySnapshot, Message } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { CachedImage } from '@components/ui/CachedImage';
import { ChatText as Text } from '@components/ui/ChatText';
import { VoiceBubble } from '@components/ui/VoiceBubble';
import { kulImageForText } from '@lib/kul';
import { ReactionChips } from '@components/chat/ReactionChips';
import { imageSizeForHeight } from '@lib/chatSmiley';
import { RichTextView } from '@components/ui/RichTextView';
import type { AnchorRect } from '@screens/room/components/MessageActionSheet';
import { PhoneIcon, VideoIcon } from '@screens/call/icons';
import { CHAT_MAX_FONT_SIZE_MULTIPLIER, PRIMARY } from '@constants';
import { MESSAGE_STATUS, MESSAGE_TYPE } from '@ola/shared/constants';

function chatBubbleTextMaxWidth(windowWidth: number, fromMe: boolean): number {
  const rowWidth = windowWidth - 24 - (fromMe ? 0 : 36);
  return Math.floor(rowWidth * 0.78 - 24) - 2;
}

const CHAT_IMAGE_MAX_WIDTH = 220;
const CHAT_IMAGE_MAX_HEIGHT = 240;

function fitChatImageSize(ratio: number | null) {
  if (ratio == null || ratio <= 0) {
    return { width: CHAT_IMAGE_MAX_WIDTH, height: CHAT_IMAGE_MAX_HEIGHT };
  }
  let width = CHAT_IMAGE_MAX_WIDTH;
  let height = width / ratio;
  if (height > CHAT_IMAGE_MAX_HEIGHT) {
    height = CHAT_IMAGE_MAX_HEIGHT;
    width = height * ratio;
  }
  return { width, height };
}

const sentIcon = require('@assets/icons/chat/ic_message_sent.png');
const resendIcon = require('@assets/icons/chat/btn_resend_d.png');
const photoIcon = require('@assets/icons/chat/ic_local.png');

function ChatQuoteBlock({
  replyTo,
  maxWidth,
  onPrimary,
  onQuoteClick,
}: {
  replyTo: ChatReplySnapshot;
  maxWidth: number;
  onPrimary: boolean;
  onQuoteClick?: (messageId: string) => void;
}) {
  const { t } = useTranslation();
  const isImage = replyTo.type === MESSAGE_TYPE.image;
  const excerpt = isImage
    ? t('chat.replyImage')
    : replyTo.type === MESSAGE_TYPE.audio
      ? t('chat.replyAudio')
      : kulImageForText(replyTo.excerpt) != null
        ? t('chat.replySticker')
        : replyTo.excerpt;
  const name =
    replyTo.senderName != null && replyTo.senderName !== '' ? `@${replyTo.senderName}` : '';
  return (
    <Pressable
      onPress={() => onQuoteClick?.(replyTo.messageId)}
      className="mb-1 rounded py-0.5 pl-2 pr-1"
      style={{
        borderLeftWidth: 2,
        borderLeftColor: onPrimary ? 'rgba(255,255,255,0.6)' : PRIMARY,
        backgroundColor: onPrimary ? 'rgba(255,255,255,0.15)' : 'rgba(0,0,0,0.05)',
      }}
    >
      {name !== '' && (
        <Text
          numberOfLines={1}
          className="text-xs font-semibold"
          style={{ color: onPrimary ? 'rgba(255,255,255,0.9)' : 'rgba(0,0,0,0.6)' }}
        >
          {name}
        </Text>
      )}
      <View className="flex-row items-center gap-1">
        {isImage && <Image source={photoIcon} style={{ width: 14, height: 14 }} resizeMode="contain" />}
        <RichTextView
          content={excerpt}
          own={onPrimary}
          color={onPrimary ? 'rgba(255,255,255,0.75)' : 'rgba(0,0,0,0.45)'}
          maxWidth={maxWidth - (isImage ? 32 : 14)}
          fontSize={12}
          maxLines={2}
          onMention={() => onQuoteClick?.(replyTo.messageId)}
        />
      </View>
    </Pressable>
  );
}

function CallLogBubble({
  meta,
  bg,
  cornerClass,
  fromMe,
  onPrimary,
}: {
  meta: MessageMetadata;
  bg: string;
  cornerClass: string;
  fromMe: boolean;
  onPrimary: boolean;
}) {
  const { t } = useTranslation();
  const view = callMessageView(t, meta);
  const CallIcon = view.isVideo ? VideoIcon : PhoneIcon;
  const missedColor = onPrimary ? '#ffcdd2' : '#e53935';
  return (
    <View
      className={`flex-row items-center gap-2.5 rounded-2xl px-3 py-2 ${cornerClass}`}
      style={[
        { backgroundColor: bg },
        fromMe
          ? null
          : { shadowColor: '#000', shadowOpacity: 0.08, shadowRadius: 2, shadowOffset: { width: 0, height: 1 }, elevation: 1 },
      ]}
    >
      <View
        className="items-center justify-center rounded-full"
        style={{
          width: 36,
          height: 36,
          backgroundColor: onPrimary
            ? 'rgba(255,255,255,0.2)'
            : view.missed
              ? 'rgba(229,57,53,0.1)'
              : 'rgba(124,179,66,0.15)',
        }}
      >
        <CallIcon
          size={20}
          color={view.missed ? missedColor : onPrimary ? '#ffffff' : '#558b2f'}
        />
      </View>
      <View className="pr-1">
        <Text
          className="text-sm font-medium"
          style={{ color: onPrimary ? '#ffffff' : 'rgba(0,0,0,0.87)' }}
        >
          {view.title}
        </Text>
        <Text
          className="text-xs"
          style={{
            color: view.missed
              ? missedColor
              : onPrimary
                ? 'rgba(255,255,255,0.8)'
                : 'rgba(0,0,0,0.54)',
          }}
        >
          {view.detail}
        </Text>
      </View>
    </View>
  );
}

interface ChatMessageRowProps {
  message: Message;
  fromMe: boolean;
  firstInGroup: boolean;
  lastInGroup: boolean;
  showTime: boolean;
  isLastOwn: boolean;
  seen: boolean;
  highlighted?: boolean;
  peerName: string;
  peerAvatar?: string;
  timeLabel: string;
  onLongPress: (anchor: AnchorRect) => void;
  onResend: (id: string) => void;
  onOpenImage: (url: string) => void;
  onMention: (nick: string) => void;
  onShowReactions?: (id: string) => void;
  onQuoteClick?: (messageId: string) => void;
  onOpenProfile?: () => void;
}

export function ChatBubble({
  message,
  fromMe,
  firstInGroup,
  lastInGroup,
  onOpenImage,
  onMention,
  onLongPress,
  onQuoteClick,
}: {
  message: Message;
  fromMe: boolean;
  firstInGroup: boolean;
  lastInGroup: boolean;
  onOpenImage: (url: string) => void;
  onMention: (nick: string) => void;
  onLongPress?: () => void;
  onQuoteClick?: (messageId: string) => void;
}) {
  const meta = parseMessageMetadata(message.metadata);
  const { width: windowWidth } = useWindowDimensions();
  const [imageRatio, setImageRatio] = useState<number | null>(null);
  const failed = message.status === MESSAGE_STATUS.failed;
  const bg = failed ? '#f8d7d7' : fromMe ? PRIMARY : '#ffffff';
  const onPrimary = fromMe && !failed;
  const cornerClass = fromMe
    ? `${firstInGroup ? '' : 'rounded-tr-sm'} ${lastInGroup ? '' : 'rounded-br-sm'}`
    : `${firstInGroup ? '' : 'rounded-tl-sm'} ${lastInGroup ? '' : 'rounded-bl-sm'}`;

  const quotedWrap = (content: ReactNode) =>
    message.replyTo != null ? (
      <View
        className={`rounded-2xl px-3 py-2 ${cornerClass}`}
        style={[
          { backgroundColor: bg },
          fromMe
            ? null
            : { shadowColor: '#000', shadowOpacity: 0.08, shadowRadius: 2, shadowOffset: { width: 0, height: 1 }, elevation: 1 },
        ]}
      >
        <ChatQuoteBlock
          replyTo={message.replyTo}
          maxWidth={chatBubbleTextMaxWidth(windowWidth, fromMe)}
          onPrimary={onPrimary}
          onQuoteClick={onQuoteClick}
        />
        {content}
      </View>
    ) : (
      content
    );

  const kul = message.type === MESSAGE_TYPE.text ? kulImageForText(message.content) : null;

  if (kul != null) {
    return quotedWrap(
      <Image source={kul} style={imageSizeForHeight(kul, 120)} resizeMode="contain" />
    );
  }

  if (message.type === MESSAGE_TYPE.image && meta.url != null && meta.url !== '') {
    return quotedWrap(
      <Pressable
        onPress={() => onOpenImage(meta.url!)}
        onLongPress={onLongPress}
        delayLongPress={300}
      >
        <CachedImage
          uri={meta.url}
          onSize={({ width, height }) => {
            if (height > 0) setImageRatio(width / height);
          }}
          style={{ ...fitChatImageSize(imageRatio), borderRadius: 8 }}
          resizeMode="cover"
        />
      </Pressable>
    );
  }

  if (message.type === MESSAGE_TYPE.audio) {
    return (
      <VoiceBubble
        url={meta.url}
        duration={formatDuration(meta.duration)}
        durationSec={meta.duration}
        waveform={meta.waveform}
        isOut={fromMe}
        onLongPress={onLongPress}
      />
    );
  }

  if (message.type === MESSAGE_TYPE.call) {
    return (
      <CallLogBubble
        meta={meta}
        bg={bg}
        cornerClass={cornerClass}
        fromMe={fromMe}
        onPrimary={onPrimary}
      />
    );
  }

  return (
    <View
      className={`rounded-2xl px-3 py-2 ${cornerClass}`}
      style={[
        { backgroundColor: bg },
        fromMe
          ? null
          : { shadowColor: '#000', shadowOpacity: 0.08, shadowRadius: 2, shadowOffset: { width: 0, height: 1 }, elevation: 1 },
      ]}
    >
      {message.replyTo != null && (
        <ChatQuoteBlock
          replyTo={message.replyTo}
          maxWidth={chatBubbleTextMaxWidth(windowWidth, fromMe)}
          onPrimary={onPrimary}
          onQuoteClick={onQuoteClick}
        />
      )}
      <RichTextView
        content={message.content}
        own={onPrimary}
        color={onPrimary ? '#ffffff' : 'rgba(0,0,0,0.87)'}
        maxWidth={chatBubbleTextMaxWidth(windowWidth, fromMe)}
        onMention={onMention}
      />
    </View>
  );
}

export function ChatMessageRow({
  message,
  fromMe,
  firstInGroup,
  lastInGroup,
  showTime,
  isLastOwn,
  seen,
  highlighted = false,
  peerName,
  peerAvatar,
  timeLabel,
  onLongPress,
  onResend,
  onOpenImage,
  onMention,
  onShowReactions,
  onQuoteClick,
  onOpenProfile,
}: ChatMessageRowProps) {
  const bubbleRef = useRef<View>(null);
  const chipsRef = useRef<View>(null);
  const showAvatar = !fromMe && firstInGroup;
  const pending = message.status === MESSAGE_STATUS.sending || message.status === MESSAGE_STATUS.uploading;
  const failed = message.status === MESSAGE_STATUS.failed;
  const canAct = !pending && !failed;

  function openActions(ref: typeof bubbleRef) {
    if (!canAct) return;
    ref.current?.measureInWindow((x, y, width, height) => {
      onLongPress({ x, y, width, height });
    });
  }

  function handleLongPress() {
    openActions(bubbleRef);
  }

  return (
    <View className={firstInGroup ? 'mt-2' : 'mt-0.5'}>
      <View
        className="flex-row items-end gap-1 px-2"
        style={{ flexDirection: fromMe ? 'row-reverse' : 'row' }}
      >
        {!fromMe &&
          (showAvatar ? (
            <Pressable className="self-start" onPress={onOpenProfile} disabled={onOpenProfile == null}>
              <Avatar name={peerName} uri={peerAvatar} size={32} />
            </Pressable>
          ) : (
            <View style={{ width: 32 }} />
          ))}
        <View className="max-w-[78%]" style={{ alignItems: fromMe ? 'flex-end' : 'flex-start' }}>
          <View
            className="flex-row items-center gap-2"
            style={{ flexDirection: fromMe ? 'row-reverse' : 'row' }}
          >
            <Pressable
              ref={bubbleRef}
              onPress={() => openActions(bubbleRef)}
              onLongPress={handleLongPress}
              delayLongPress={300}
              style={{
                borderWidth: 2,
                margin: -2,
                borderRadius: 18,
                borderColor: highlighted ? 'rgba(124,179,66,0.4)' : 'transparent',
              }}
            >
              <ChatBubble
                message={message}
                fromMe={fromMe}
                firstInGroup={firstInGroup}
                lastInGroup={lastInGroup}
                onOpenImage={onOpenImage}
                onMention={onMention}
                onLongPress={handleLongPress}
                onQuoteClick={onQuoteClick}
              />
            </Pressable>
            {showTime && (
              <Text className="text-[10px] text-ola-ink-faint">
                {timeLabel}
              </Text>
            )}
          </View>

          <ReactionChips
            reactions={message.reactions}
            isOwn={fromMe}
            anchorRef={chipsRef}
            onPress={() => openActions(chipsRef)}
            onLongPress={() => onShowReactions?.(message.id)}
            textMaxFontSizeMultiplier={CHAT_MAX_FONT_SIZE_MULTIPLIER}
          />

          {fromMe && isLastOwn && !pending && !failed && (
            seen ? (
              <View style={{ marginTop: 4 }}>
                <Avatar name={peerName} uri={peerAvatar} size={16} />
              </View>
            ) : (
              <Image source={sentIcon} style={{ width: 16, height: 16, marginTop: 4, opacity: 0.6 }} resizeMode="contain" />
            )
          )}
        </View>

        {fromMe && pending && (
          <ActivityIndicator size="small" color="rgba(0,0,0,0.2)" style={{ alignSelf: 'center' }} />
        )}
        {fromMe && failed && (
          <Pressable onPress={() => onResend(message.id)} className="self-center">
            <Image source={resendIcon} style={{ width: 20, height: 20 }} resizeMode="contain" />
          </Pressable>
        )}
      </View>
    </View>
  );
}
