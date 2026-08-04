import { Image, Pressable, Text, View, type ImageSourcePropType } from 'react-native';
import { wheelAssets } from './spinWheelAssets';
import { CHIP_TEXT_STYLE } from './spinWheelStyles';

interface WheelActionButtonProps {
  icon: ImageSourcePropType;
  label: string;
  onPress: () => void;
}

export function WheelActionButton({ icon, label, onPress }: WheelActionButtonProps) {
  return (
    <Pressable onPress={onPress} style={{ flex: 1, height: 44 }}>
      <Image
        source={wheelAssets.bottomButtonFrame}
        style={{ position: 'absolute', left: 0, top: 0, width: '100%', height: '100%' }}
        resizeMode="stretch"
      />
      <View
        style={{
          position: 'absolute',
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'center',
          gap: 4,
          paddingHorizontal: 4,
        }}
      >
        <Image source={icon} style={{ width: 18, height: 18 }} resizeMode="contain" />
        <Text
          numberOfLines={1}
          adjustsFontSizeToFit
          minimumFontScale={0.75}
          style={[{ fontSize: 12, fontWeight: '700' }, CHIP_TEXT_STYLE]}
        >
          {label}
        </Text>
      </View>
    </Pressable>
  );
}
