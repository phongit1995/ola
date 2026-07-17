import { useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, Text, useWindowDimensions, View } from 'react-native';
import { formatDuration, parseMessageMetadata } from '@ola/shared/lib';
import type { ChatReplySnapshot, Message } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { VoiceBubble } from '@components/ui/VoiceBubble';
import { kulImageForText } from '@lib/kul';
import { reactionChips } from '@lib/reactions';
import { imageSizeForHeight } from '@lib/chatSmiley';
import { RichTextView } from '@components/ui/RichTextView';
import type { AnchorRect } from '@screens/room/components/MessageActionSheet';

function chatBubbleTextMaxWidth(windowWidth: number, fromMe: boolean): number {
  const rowWidth = windowWidth - 24 - (fromMe ? 0 : 36);
  return Math.floor(rowWidth * 0.78 - 24) - 2;
}

const sentIcon = require('@assets/icons/chat/ic_message_sent.png');
const resendIcon = require('@assets/icons/chat/btn_resend_d.png');
const photoIcon = require('@assets/icons/chat/ic_local.png');

function ChatQuoteBlock({
  replyTo,
  maxWidth,
  onQuoteClick,
}: {
  replyTo: ChatReplySnapshot;
  maxWidth: number;
  onQuoteClick?: (messageId: string) => void;
}) {
  const { t } = useTranslation();
  const isImage = replyTo.type === 'image';
  const excerpt = isImage
    ? t('chat.replyImage')
    : replyTo.type === 'audio'
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
      style={{ borderLeftWidth: 2, borderLeftColor: '#7cb342', backgroundColor: 'rgba(0,0,0,0.05)' }}
    >
      {name !== '' && (
        <Text numberOfLines={1} className="text-xs font-semibold" style={{ color: 'rgba(0,0,0,0.6)' }}>
          {name}
        </Text>
      )}
      <View className="flex-row items-center gap-1">
        {isImage && <Image source={photoIcon} style={{ width: 14, height: 14 }} resizeMode="contain" />}
        <RichTextView
          content={excerpt}
          own={false}
          color="rgba(0,0,0,0.45)"
          maxWidth={maxWidth - (isImage ? 32 : 14)}
          fontSize={12}
          maxLines={2}
          onMention={() => onQuoteClick?.(replyTo.messageId)}
        />
      </View>
    </Pressable>
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
  peerName: string;
  peerAvatar?: string;
  timeLabel: string;
  onLongPress: (anchor: AnchorRect) => void;
  onResend: (id: string) => void;
  onOpenImage: (url: string) => void;
  onMention: (nick: string) => void;
  onShowReactions?: (id: string) => void;
  onQuoteClick?: (messageId: string) => void;
}

export function ChatBubble({
  message,
  fromMe,
  firstInGroup,
  lastInGroup,
  onOpenImage,
  onMention,
  onQuoteClick,
}: {
  message: Message;
  fromMe: boolean;
  firstInGroup: boolean;
  lastInGroup: boolean;
  onOpenImage: (url: string) => void;
  onMention: (nick: string) => void;
  onQuoteClick?: (messageId: string) => void;
}) {
  const meta = parseMessageMetadata(message.metadata);
  const { width: windowWidth } = useWindowDimensions();
  const failed = message.status === 'failed';
  const kul = message.type === 'text' ? kulImageForText(message.content) : null;

  if (kul != null) {
    return <Image source={kul} style={imageSizeForHeight(kul, 120)} resizeMode="contain" />;
  }

  if (message.type === 'image' && meta.url != null && meta.url !== '') {
    return (
      <Pressable onPress={() => onOpenImage(meta.url!)}>
        <Image source={{ uri: meta.url }} style={{ width: 200, height: 200, borderRadius: 8 }} resizeMode="cover" />
      </Pressable>
    );
  }

  if (message.type === 'audio') {
    return (
      <VoiceBubble
        url={meta.url}
        duration={formatDuration(meta.duration)}
        durationSec={meta.duration}
        isOut={fromMe}
      />
    );
  }

  const bg = failed ? '#f8d7d7' : fromMe ? '#dcedc8' : '#ffffff';
  const cornerClass = fromMe
    ? `${firstInGroup ? '' : 'rounded-tr-sm'} ${lastInGroup ? '' : 'rounded-br-sm'}`
    : `${firstInGroup ? '' : 'rounded-tl-sm'} ${lastInGroup ? '' : 'rounded-bl-sm'}`;

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
          onQuoteClick={onQuoteClick}
        />
      )}
      <RichTextView
        content={message.content}
        own={false}
        color="rgba(0,0,0,0.87)"
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
  peerName,
  peerAvatar,
  timeLabel,
  onLongPress,
  onResend,
  onOpenImage,
  onMention,
  onShowReactions,
  onQuoteClick,
}: ChatMessageRowProps) {
  const chips = reactionChips(message.reactions);
  const bubbleRef = useRef<View>(null);
  const showAvatar = !fromMe && firstInGroup;
  const pending = message.status === 'sending' || message.status === 'uploading';
  const failed = message.status === 'failed';
  const canAct = !pending && !failed;

  function handleLongPress() {
    if (!canAct) return;
    bubbleRef.current?.measureInWindow((x, y, width, height) => {
      onLongPress({ x, y, width, height });
    });
  }

  return (
    <View className={firstInGroup ? 'mt-2' : 'mt-0.5'}>
      <View
        className="flex-row items-end gap-1 px-3"
        style={{ flexDirection: fromMe ? 'row-reverse' : 'row' }}
      >
        {!fromMe &&
          (showAvatar ? (
            <View className="self-start">
              <Avatar name={peerName} uri={peerAvatar} size={32} />
            </View>
          ) : (
            <View style={{ width: 32 }} />
          ))}
        <View className="max-w-[78%]" style={{ alignItems: fromMe ? 'flex-end' : 'flex-start' }}>
          <View
            className="flex-row items-center gap-2"
            style={{ flexDirection: fromMe ? 'row-reverse' : 'row' }}
          >
            <Pressable ref={bubbleRef} onLongPress={handleLongPress} delayLongPress={300}>
              <ChatBubble
                message={message}
                fromMe={fromMe}
                firstInGroup={firstInGroup}
                lastInGroup={lastInGroup}
                onOpenImage={onOpenImage}
                onMention={onMention}
                onQuoteClick={onQuoteClick}
              />
            </Pressable>
            {showTime && (
              <Text className="text-[10px]" style={{ color: 'rgba(0,0,0,0.38)' }}>
                {timeLabel}
              </Text>
            )}
          </View>

          {chips.length > 0 && (
            <Pressable
              onPress={() => onShowReactions?.(message.id)}
              className="-mt-2 flex-row flex-wrap gap-1"
              style={{ alignSelf: fromMe ? 'flex-end' : 'flex-start' }}
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
          )}

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
