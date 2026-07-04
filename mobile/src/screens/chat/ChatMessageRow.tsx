import { Image, Pressable, Text, View } from 'react-native';
import { formatDuration, parseMessageMetadata } from '@ola/shared/lib';
import type { Message } from '@ola/shared/types';
import { Avatar } from '../../components/Avatar';
import { kulImageForText } from '../../lib/kul';
import { reactionChips } from '../../lib/reactions';
import { renderRichText } from '../../lib/richText';

const sentIcon = require('../../assets/icons/chat/ic_message_sent.png');
const resendIcon = require('../../assets/icons/chat/btn_resend_d.png');

interface ChatMessageRowProps {
  message: Message;
  fromMe: boolean;
  firstInGroup: boolean;
  lastInGroup: boolean;
  showTime: boolean;
  isLastOwn: boolean;
  peerName: string;
  peerAvatar?: string;
  timeLabel: string;
  onLongPress: () => void;
  onResend: (id: string) => void;
  onOpenImage: (url: string) => void;
}

function ChatBubble({
  message,
  fromMe,
  firstInGroup,
  lastInGroup,
  onOpenImage,
}: {
  message: Message;
  fromMe: boolean;
  firstInGroup: boolean;
  lastInGroup: boolean;
  onOpenImage: (url: string) => void;
}) {
  const meta = parseMessageMetadata(message.metadata);
  const failed = message.status === 'failed';
  const kul = message.type === 'text' ? kulImageForText(message.content) : null;

  if (kul != null) {
    return <Image source={kul} style={{ width: 112, height: 112 }} resizeMode="contain" />;
  }

  if (message.type === 'image' && meta.url != null && meta.url !== '') {
    return (
      <Pressable onPress={() => onOpenImage(meta.url!)}>
        <Image source={{ uri: meta.url }} style={{ width: 200, height: 200, borderRadius: 8 }} resizeMode="cover" />
      </Pressable>
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
      {message.type === 'audio' ? (
        <View className="flex-row items-center gap-2">
          <Text className="text-lg">🎤</Text>
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.7)' }}>
            {formatDuration(meta.duration)}
          </Text>
        </View>
      ) : (
        <Text className="text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
          {renderRichText(message.content, { own: false, onMention: () => undefined })}
        </Text>
      )}
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
  peerName,
  peerAvatar,
  timeLabel,
  onLongPress,
  onResend,
  onOpenImage,
}: ChatMessageRowProps) {
  const chips = reactionChips(message.reactions);
  const showAvatar = !fromMe && firstInGroup;
  const pending = message.status === 'sending' || message.status === 'uploading';
  const failed = message.status === 'failed';

  return (
    <View className={firstInGroup ? 'mt-2' : ''}>
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
            <Pressable
              onLongPress={onLongPress}
              delayLongPress={300}
              onPress={() => {
                if (failed) onResend(message.id);
              }}
              style={pending ? { opacity: 0.6 } : undefined}
            >
              <ChatBubble
                message={message}
                fromMe={fromMe}
                firstInGroup={firstInGroup}
                lastInGroup={lastInGroup}
                onOpenImage={onOpenImage}
              />
            </Pressable>
            {showTime && (
              <Text className="text-[10px]" style={{ color: 'rgba(0,0,0,0.38)' }}>
                {timeLabel}
              </Text>
            )}
          </View>

          {chips.length > 0 && (
            <View
              className="mt-0.5 flex-row flex-wrap gap-1"
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
            </View>
          )}

          {fromMe && isLastOwn && !pending && !failed && (
            <Image source={sentIcon} style={{ width: 16, height: 16, marginTop: 4, opacity: 0.6 }} resizeMode="contain" />
          )}
        </View>

        {fromMe && failed && (
          <Pressable onPress={() => onResend(message.id)} className="self-center">
            <Image source={resendIcon} style={{ width: 20, height: 20 }} resizeMode="contain" />
          </Pressable>
        )}
      </View>
    </View>
  );
}
