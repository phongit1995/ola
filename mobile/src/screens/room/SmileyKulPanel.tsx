import { Image, Pressable, ScrollView, View } from 'react-native';
import { SMILEY_PANEL } from '../../lib/chatSmiley';
import { KUL_IMAGES } from '../../lib/kul';

interface SmileyKulPanelProps {
  tab: 'smiley' | 'kul';
  onPickEmoji: (code: string) => void;
  onSendKul: (index: number) => void;
}

export function SmileyKulPanel({ tab, onPickEmoji, onSendKul }: SmileyKulPanelProps) {
  return (
    <View
      className="bg-white"
      style={{ height: 220, borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
    >
      <ScrollView contentContainerClassName="flex-row flex-wrap p-2">
        {tab === 'smiley'
          ? SMILEY_PANEL.map((smiley, index) => (
              <Pressable
                key={index}
                onPress={() => onPickEmoji(smiley.code)}
                className="items-center justify-center"
                style={{ width: `${100 / 8}%`, height: 40 }}
              >
                <Image source={smiley.image} style={{ width: 26, height: 26 }} resizeMode="contain" />
              </Pressable>
            ))
          : KUL_IMAGES.map((image, index) => (
              <Pressable
                key={index}
                onPress={() => onSendKul(index + 1)}
                className="items-center justify-center p-1"
                style={{ width: `${100 / 6}%`, height: 64 }}
              >
                <Image source={image} style={{ width: 52, height: 52 }} resizeMode="contain" />
              </Pressable>
            ))}
      </ScrollView>
    </View>
  );
}
