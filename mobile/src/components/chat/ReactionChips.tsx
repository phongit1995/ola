import type { RefObject } from 'react';
import { Image, Pressable, Text, View } from 'react-native';
import { reactionChips } from '@lib/reactions';

interface ReactionChipsProps {
  reactions?: Record<string, readonly unknown[]>;
  isOwn: boolean;
  anchorRef?: RefObject<View | null>;
  onPress?: () => void;
  onLongPress?: () => void;
  textMaxFontSizeMultiplier?: number;
}

export function ReactionChips({
  reactions,
  isOwn,
  anchorRef,
  onPress,
  onLongPress,
  textMaxFontSizeMultiplier,
}: ReactionChipsProps) {
  const chips = reactionChips(reactions);
  if (chips.length === 0) return null;

  return (
    <Pressable
      ref={anchorRef}
      onPress={onPress}
      onLongPress={onLongPress}
      className="-mt-2 flex-row flex-wrap gap-1"
      style={{ alignSelf: isOwn ? 'flex-end' : 'flex-start' }}
    >
      {chips.map(chip => (
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
            <Image
              source={chip.image}
              style={{ width: 16, height: 16 }}
              resizeMode="contain"
            />
          )}
          <Text
            className="text-[11px] font-medium"
            style={{ color: 'rgba(0,0,0,0.55)' }}
            maxFontSizeMultiplier={textMaxFontSizeMultiplier}
          >
            {chip.count}
          </Text>
        </View>
      ))}
    </Pressable>
  );
}
