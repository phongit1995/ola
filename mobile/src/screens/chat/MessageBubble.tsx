import { Image, Pressable, Text, View } from 'react-native';
import { formatDuration, parseMessageMetadata } from '@ola/shared/lib';
import type { Message } from '@ola/shared/types';

const REACTION_EMOJI: Record<string, string> = {
  LIKE: '👍',
  LOVE: '❤️',
  HAHA: '😆',
  WOW: '😮',
  SAD: '😢',
  ANGRY: '😡',
};

function reactionSummary(message: Message): string {
  const reactions = message.reactions;
  if (reactions == null) return '';
  return Object.entries(reactions)
    .filter(([, users]) => users.length > 0)
    .map(([type, users]) => `${REACTION_EMOJI[type] ?? ''}${users.length > 1 ? users.length : ''}`)
    .join(' ');
}

interface MessageBubbleProps {
  message: Message;
  fromMe: boolean;
  onPress?: () => void;
  onLongPress?: () => void;
}

export function MessageBubble({ message, fromMe, onPress, onLongPress }: MessageBubbleProps) {
  const meta = parseMessageMetadata(message.metadata);
  const failed = message.status === 'failed';
  const pending = message.status === 'sending' || message.status === 'uploading';
  const summary = reactionSummary(message);

  return (
    <View className={`my-0.5 flex-row px-3 ${fromMe ? 'justify-end' : 'justify-start'}`}>
      <Pressable
        className={`max-w-[78%] overflow-hidden rounded-2xl ${
          fromMe ? 'bg-ola-primary-light' : 'bg-neutral-100'
        } ${failed ? 'border border-ola-error' : ''} ${pending ? 'opacity-60' : ''}`}
        onPress={onPress}
        onLongPress={onLongPress}
        delayLongPress={300}
      >
        {message.type === 'image' && meta.url != null && meta.url !== '' ? (
          <Image source={{ uri: meta.url }} className="h-48 w-48" resizeMode="cover" />
        ) : message.type === 'audio' ? (
          <View className="flex-row items-center gap-2 px-3 py-2">
            <Text className="text-lg">🎤</Text>
            <Text className="text-sm text-neutral-700">{formatDuration(meta.duration)}</Text>
          </View>
        ) : (
          <Text className="px-3 py-2 text-base text-neutral-900">{message.content}</Text>
        )}
        {summary !== '' && (
          <Text className="px-3 pb-1 text-xs text-neutral-500">{summary}</Text>
        )}
      </Pressable>
      {failed && <Text className="ml-1 self-end text-xs text-ola-error">!</Text>}
    </View>
  );
}
