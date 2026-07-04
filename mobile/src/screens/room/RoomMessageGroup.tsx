import { memo } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { colorForName } from '@ola/shared/lib';
import type { RoomReplySnapshot } from '@ola/shared/types';
import { kulImageForText } from '../../lib/kul';
import { reactionChips } from '../../lib/reactions';
import { renderRichText } from '../../lib/richText';
import { VipAvatar } from '../../components/VipAvatar';
import type { BubblePosition, GroupedMessage, MessageGroup } from './messageGroups';
import { OTHER_CORNERS, OWN_CORNERS } from './roomConstants';

const mentionIcon = require('../../assets/icons/room/ic_tag_people.png');

function clock(iso: string): string {
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return '';
  return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}

interface RoomMessageGroupProps {
  group: MessageGroup;
  highlightedId?: string | null;
  onOpenProfile?: (nick: string, color: string) => void;
  onOpenUser?: (userId: string) => void;
  onQuickMention?: (name: string) => void;
  onLongPressMessage?: (id: string) => void;
  onQuoteClick?: (messageId: string) => void;
  onShowReactions?: (id: string) => void;
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
  const excerpt = kulImageForText(replyTo.excerpt) != null ? t('room.replySticker') : replyTo.excerpt;
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
      <Text
        numberOfLines={2}
        className="text-xs"
        style={{ color: isOwn ? 'rgba(255,255,255,0.75)' : 'rgba(0,0,0,0.45)' }}
      >
        {excerpt}
      </Text>
    </Pressable>
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
}: {
  message: GroupedMessage;
  isOwn: boolean;
  position: BubblePosition;
  highlighted: boolean;
  onMention: (nick: string) => void;
  onLongPressMessage?: (id: string) => void;
  onQuoteClick?: (messageId: string) => void;
}) {
  const kul = kulImageForText(message.content);
  const corners = isOwn ? OWN_CORNERS[position] : OTHER_CORNERS[position];

  const content =
    kul != null ? (
      <Image source={kul} style={{ width: 112, height: 112 }} resizeMode="contain" />
    ) : (
      <Text
        className="text-base"
        style={{ color: isOwn ? '#ffffff' : 'rgba(0,0,0,0.87)' }}
      >
        {renderRichText(message.content, { own: isOwn, onMention })}
      </Text>
    );

  const bareKul = kul != null && message.replyTo == null;

  return (
    <Pressable
      onLongPress={() => onLongPressMessage?.(message.id)}
      delayLongPress={300}
      style={{ alignSelf: isOwn ? 'flex-end' : 'flex-start', maxWidth: '100%' }}
    >
      <View
        className={bareKul ? '' : `${corners} px-3.5 py-2`}
        style={[
          bareKul ? null : { backgroundColor: isOwn ? '#7cb342' : '#f1f8e9' },
          highlighted ? { borderWidth: 2, borderColor: 'rgba(124,179,66,0.4)' } : null,
        ]}
      >
        {message.replyTo != null && (
          <QuoteBlock replyTo={message.replyTo} isOwn={isOwn} onQuoteClick={onQuoteClick} />
        )}
        {content}
      </View>
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
}: RoomMessageGroupProps) {
  const { isOwn, senderName } = group;
  const onMention = (nick: string) => onOpenProfile?.(nick, colorForName(nick));
  const time = clock(group.messages[0]!.createdAt);
  const openSender = () => onOpenUser?.(group.senderId);
  const lastIndex = group.messages.length - 1;

  return (
    <View className="gap-0.5">
      <Text className="text-center text-xs" style={{ color: 'rgba(0,0,0,0.26)' }}>
        {time}
      </Text>
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
          <Text numberOfLines={1} className="text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
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
              />
            );
            const withQuickMention = !isOwn && index === lastIndex;
            return (
              <View
                key={message.id}
                className="gap-0.5"
                style={{ alignItems: isOwn ? 'flex-end' : 'flex-start' }}
              >
                {withQuickMention ? (
                  <View className="flex-row items-end gap-1">
                    {bubble}
                    <Pressable
                      onPress={() => onQuickMention?.(senderName)}
                      className="h-7 w-7 items-center justify-center rounded-full"
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

export const RoomMessageGroup = memo(RoomMessageGroupComponent);
