import type { ReactNode } from 'react';
import { Image, Text, View } from 'react-native';
import { WORD_CHAIN_ICONS } from './wordChainAssets';

const KEN_ICON_SIZE = 14;

export function WordChainKen({
  children,
  tone = 'pill',
  color,
}: {
  children?: ReactNode;
  tone?: 'pill' | 'plain';
  color?: string;
}) {
  if (tone === 'plain') {
    return (
      <Text style={{ fontWeight: '600', color }}>
        {' '}
        {children}{' '}
        <Image
          source={WORD_CHAIN_ICONS.ken}
          style={{ width: KEN_ICON_SIZE, height: KEN_ICON_SIZE }}
          resizeMode="contain"
        />
      </Text>
    );
  }
  return (
    <View
      style={{
        flexDirection: 'row',
        alignItems: 'center',
        gap: 4,
        marginHorizontal: 2,
        paddingHorizontal: 8,
        borderRadius: 999,
        borderWidth: 1,
        borderColor: '#fde68a',
        backgroundColor: '#fffbeb',
        transform: [{ translateY: 3 }],
      }}
    >
      <Text className="text-sm font-semibold" style={{ color: '#b45309' }}>
        {children}
      </Text>
      <Image
        source={WORD_CHAIN_ICONS.ken}
        style={{ width: KEN_ICON_SIZE, height: KEN_ICON_SIZE }}
        resizeMode="contain"
      />
    </View>
  );
}
