import { memo } from 'react';
import { Text, View, useWindowDimensions } from 'react-native';
import { Avatar } from '@components/ui/Avatar';
import type { ChatBotMessage } from '@ola/shared/types';
import { groupingOf } from '../chatBotView';
import type { ChatBotViewer } from '../interface';
import { BotAvatar } from './BotAvatar';
import { BotMarkdown } from './BotMarkdown';

const BUBBLE_MAX_RATIO = 0.78;

interface BotMessageRowProps {
  message: ChatBotMessage;
  prev?: ChatBotMessage;
  next?: ChatBotMessage;
  viewer: ChatBotViewer;
}

function BotMessageRowComponent({
  message,
  prev,
  next,
  viewer,
}: BotMessageRowProps) {
  const group = groupingOf(message, prev, next);
  const { width } = useWindowDimensions();
  const maxWidth = Math.round(width * BUBBLE_MAX_RATIO);

  return (
    <View className={`px-2 ${group.spaced ? 'mt-2' : ''}`}>
      <View
        className={`flex-row items-end gap-1 ${group.isOut ? 'flex-row-reverse' : ''}`}
      >
        {group.firstInGroup ? (
          <View className="self-start">
            {group.isOut ? (
              <Avatar
                name={viewer.name}
                color={viewer.color}
                uri={viewer.avatar}
                size={32}
              />
            ) : (
              <BotAvatar />
            )}
          </View>
        ) : (
          <View style={{ width: 32 }} />
        )}
        <View
          className={`flex-row items-center gap-2 ${group.isOut ? 'flex-row-reverse' : ''}`}
          style={{ flexShrink: 1 }}
        >
          <View
            className={`rounded-2xl px-3 py-2 ${group.corners}`}
            style={[
              { backgroundColor: group.surface, maxWidth },
              group.isOut
                ? null
                : {
                    shadowColor: '#000',
                    shadowOpacity: 0.08,
                    shadowRadius: 2,
                    shadowOffset: { width: 0, height: 1 },
                    elevation: 1,
                  },
            ]}
          >
            {group.isOut ? (
              <Text className="text-sm text-ola-ink">{message.content}</Text>
            ) : (
              <BotMarkdown content={message.content} />
            )}
          </View>
          {group.showTime && (
            <Text className="text-[10px] text-ola-ink-faint">{group.time}</Text>
          )}
        </View>
      </View>
    </View>
  );
}

export const BotMessageRow = memo(BotMessageRowComponent);
