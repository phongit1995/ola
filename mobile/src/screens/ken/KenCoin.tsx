import { Text, View } from 'react-native';

export function KenCoin({ size = 18 }: { size?: number }) {
  return (
    <View
      className="items-center justify-center"
      style={{
        width: size,
        height: size,
        borderRadius: size / 2,
        backgroundColor: '#ffca28',
        borderWidth: 1.5,
        borderColor: '#f9a825',
      }}
    >
      <Text
        style={{ fontSize: size * 0.55, lineHeight: size * 0.7, fontWeight: '700', color: '#f57f17' }}
      >
        K
      </Text>
    </View>
  );
}
