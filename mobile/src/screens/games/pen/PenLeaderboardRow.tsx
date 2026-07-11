import { Image, Text, View } from 'react-native';
import { formatKen } from '@ola/shared/lib';
import type { PenLeaderboardEntry } from '@ola/shared/types';
import { VipBadge } from '../../../components/VipBadge';
import { penAssets, penLeaderboardAssets } from './penAssets';
import { PEN_COLORS } from './penUi';

const COLS = { rank: 0.7, player: 2, ken: 1.3 };

const RANK_COLORS = [
  '#ffe14d',
  '#5cd6ff',
  '#8ff04d',
  '#ff7ec0',
  '#b47bff',
  '#ffa04d',
  '#4fe9bd',
];

interface PenLeaderboardRowProps {
  entry: PenLeaderboardEntry;
}

export function PenLeaderboardRow({ entry }: PenLeaderboardRowProps) {
  const name = entry.user.username;
  const medal = entry.rank <= 3 ? penLeaderboardAssets.medals[entry.rank - 1] : null;

  return (
    <View
      style={{
        height: 44,
        flexDirection: 'row',
        alignItems: 'center',
        gap: 8,
        borderBottomWidth: 1,
        borderBottomColor: 'rgba(255,255,255,0.08)',
        paddingHorizontal: 12,
      }}
    >
      <View style={{ flex: COLS.rank, alignItems: 'center' }}>
        {medal != null ? (
          <Image source={medal} style={{ width: 32, height: 32 }} resizeMode="contain" />
        ) : (
          <Text
            style={{
              fontSize: 18,
              fontWeight: '800',
              color: entry.rank <= 10 ? RANK_COLORS[entry.rank - 4] : 'rgba(255,255,255,0.9)',
            }}
          >
            {entry.rank}
          </Text>
        )}
      </View>
      <View style={{ flex: COLS.player, minWidth: 0, flexDirection: 'row', alignItems: 'center', gap: 8 }}>
        <VipBadge typeId={entry.user.vipTypeId} />
        <Text
          numberOfLines={1}
          style={{ flexShrink: 1, fontSize: 14, fontWeight: '500', color: 'rgba(255,255,255,0.9)' }}
        >
          @{name}
        </Text>
      </View>
      <View style={{ flex: COLS.ken, flexDirection: 'row', alignItems: 'center', justifyContent: 'flex-end', gap: 6 }}>
        <Text style={{ fontSize: 14, fontWeight: '800', color: PEN_COLORS.gold }}>
          {formatKen(entry.profit)}
        </Text>
        <Image source={penAssets.kenIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
      </View>
    </View>
  );
}
