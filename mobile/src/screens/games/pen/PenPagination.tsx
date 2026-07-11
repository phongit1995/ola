import { Pressable, Text, View } from 'react-native';
import { penHistoryAssets } from './penAssets';
import { PenBg } from './penUi';

function PageNav({
  dir,
  disabled,
  onPress,
}: {
  dir: 'prev' | 'next';
  disabled: boolean;
  onPress: () => void;
}) {
  return (
    <Pressable
      disabled={disabled}
      onPress={onPress}
      accessibilityLabel={dir}
      style={({ pressed }) => ({
        width: 36,
        height: 36,
        alignItems: 'center',
        justifyContent: 'center',
        opacity: disabled ? 0.3 : 1,
        transform: [{ scale: pressed ? 0.95 : 1 }],
      })}
    >
      <PenBg source={penHistoryAssets.pageNext} />
      <Text
        style={{
          color: '#ffffff',
          fontSize: 14,
          fontWeight: '800',
          transform: [{ scaleX: dir === 'prev' ? -1 : 1 }],
        }}
      >
        ❯
      </Text>
    </Pressable>
  );
}

export function PenPagination({
  page,
  pageCount,
  loading,
  onPage,
  style,
}: {
  page: number;
  pageCount: number;
  loading: boolean;
  onPage: (page: number) => void;
  style?: { marginTop?: number };
}) {
  return (
    <View
      style={[
        { flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 8 },
        style,
      ]}
    >
      <PageNav dir="prev" disabled={loading || page <= 0} onPress={() => onPage(page - 1)} />
      <View
        style={{
          height: 36,
          minWidth: 64,
          alignItems: 'center',
          justifyContent: 'center',
          paddingHorizontal: 12,
        }}
      >
        <PenBg source={penHistoryAssets.pageCurrent} />
        <Text style={{ color: '#ffffff', fontSize: 14, fontWeight: '800' }}>{page + 1}</Text>
      </View>
      <PageNav dir="next" disabled={loading || page >= pageCount - 1} onPress={() => onPage(page + 1)} />
    </View>
  );
}
