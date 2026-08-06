import { useEffect } from 'react';
import { View } from 'react-native';
import type { ChatBotType } from '@ola/shared/types';
import Animated, {
  useAnimatedStyle,
  useSharedValue,
  withDelay,
  withRepeat,
  withSequence,
  withTiming,
} from 'react-native-reanimated';
import { BotAvatar } from './BotAvatar';

const DOT_COLOR = 'rgba(0,0,0,0.4)';

function TypingDot({ delay }: { delay: number }) {
  const offset = useSharedValue(0);

  useEffect(() => {
    offset.value = withDelay(
      delay,
      withRepeat(
        withSequence(
          withTiming(-4, { duration: 300 }),
          withTiming(0, { duration: 300 })
        ),
        -1,
        false
      )
    );
  }, [delay, offset]);

  const style = useAnimatedStyle(() => ({
    transform: [{ translateY: offset.value }],
  }));

  return (
    <Animated.View
      style={[
        { width: 6, height: 6, borderRadius: 3, backgroundColor: DOT_COLOR },
        style,
      ]}
    />
  );
}

export function BotTypingRow({ bot }: { bot: ChatBotType }) {
  return (
    <View className="mt-1 flex-row items-end gap-1 px-2">
      <View className="self-start">
        <BotAvatar bot={bot} />
      </View>
      <View
        className="flex-row items-center gap-1 rounded-2xl rounded-tl-sm bg-white px-3 py-3"
        style={{
          shadowColor: '#000',
          shadowOpacity: 0.08,
          shadowRadius: 2,
          shadowOffset: { width: 0, height: 1 },
          elevation: 1,
        }}
      >
        <TypingDot delay={0} />
        <TypingDot delay={150} />
        <TypingDot delay={300} />
      </View>
    </View>
  );
}
