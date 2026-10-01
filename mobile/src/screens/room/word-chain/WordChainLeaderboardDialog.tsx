import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ScrollView, Text, View, useWindowDimensions } from 'react-native';
import {
  WORD_CHAIN_LEADERBOARD_PERIOD,
  WORD_CHAIN_LEADERBOARD_PERIOD_LABEL_KEYS,
  WORD_CHAIN_LEADERBOARD_SORT,
  WORD_CHAIN_LEADERBOARD_TABS,
} from '@ola/shared/constants';
import { wordChainLeaderboardKey } from '@ola/shared/lib';
import type {
  WordChainLeaderboardEntry,
  WordChainLeaderboardPeriod,
  WordChainLeaderboardSort,
  WordChainLeaderboardTab,
} from '@ola/shared/types';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { Dialog } from '@components/ui/Dialog';
import { useThemeColors } from '@hooks/useThemeColors';
import { DIVIDER } from '@constants';
import { WordChainListStatus, WordChainUserRow } from './WordChainList';
import { WordChainTabs } from './WordChainTabs';
import { WordChainWinHistory } from './WordChainWinHistory';

const MEDALS = ['🥇', '🥈', '🥉'];
const PANEL_HEIGHT_RATIO = 0.64;
const PANEL_MAX_HEIGHT = 560;

function RankBadge({ rank }: { rank: number }) {
  const medal = MEDALS[rank - 1];
  return (
    <View style={{ width: 32 }} className="items-center">
      <Text className="text-sm font-semibold" style={{ color: 'rgba(0,0,0,0.54)' }}>
        {medal ?? `#${rank}`}
      </Text>
    </View>
  );
}

function LeaderboardRow({
  entry,
  sort,
  highlighted,
  divider,
}: {
  entry: WordChainLeaderboardEntry;
  sort: WordChainLeaderboardSort;
  highlighted: boolean;
  divider: boolean;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const points = t('wordChain.points', { value: entry.points });
  const wins = t('wordChain.wins', { value: entry.wins });
  const byWins = sort === WORD_CHAIN_LEADERBOARD_SORT.wins;
  return (
    <WordChainUserRow
      name={entry.username}
      avatar={entry.avatar}
      highlighted={highlighted}
      divider={divider}
      leading={<RankBadge rank={entry.rank} />}
      trailing={
        <Text className="text-sm font-semibold" style={{ color: colors.primaryInk }}>
          {byWins ? wins : points}
        </Text>
      }
    >
      <Text numberOfLines={1} className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
        {entry.username}
        {entry.fullName != null && entry.fullName !== '' && (
          <Text style={{ color: 'rgba(0,0,0,0.45)' }}> · {entry.fullName}</Text>
        )}
      </Text>
      <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
        {byWins ? points : wins}
      </Text>
    </WordChainUserRow>
  );
}

function LeaderboardPanel({
  sort,
  period,
  onPeriodChange,
}: {
  sort: WordChainLeaderboardSort;
  period: WordChainLeaderboardPeriod;
  onPeriodChange: (period: WordChainLeaderboardPeriod) => void;
}) {
  const { t } = useTranslation();
  const key = wordChainLeaderboardKey({ sort, period });
  const leaderboard = useWordChainStore((state) => state.leaderboards[key]);
  const loading = useWordChainStore((state) => state.leaderboardPending.includes(key));
  const failed = useWordChainStore((state) => state.leaderboardFailed.includes(key));
  const fetchLeaderboard = useWordChainStore((state) => state.fetchLeaderboard);

  useEffect(() => {
    void fetchLeaderboard({ sort, period });
  }, [sort, period, fetchLeaderboard]);

  const me = leaderboard?.me ?? null;
  const items = leaderboard?.items ?? [];
  const periods = Object.values(WORD_CHAIN_LEADERBOARD_PERIOD).map((item) => ({
    key: item,
    label: t(WORD_CHAIN_LEADERBOARD_PERIOD_LABEL_KEYS[item]),
  }));

  return (
    <View className="flex-1" style={{ gap: 8 }}>
      <WordChainTabs variant="chips" items={periods} value={period} onChange={onPeriodChange} />
      {items.length === 0 ? (
        <WordChainListStatus
          loading={loading && leaderboard == null}
          failed={failed}
          emptyText={t(
            sort === WORD_CHAIN_LEADERBOARD_SORT.wins
              ? 'wordChain.winsEmpty'
              : 'wordChain.leaderboardEmpty'
          )}
          errorText={t('wordChain.leaderboardError')}
          onRetry={() => void fetchLeaderboard({ sort, period })}
        />
      ) : (
        <ScrollView className="flex-1" style={{ marginHorizontal: -8 }}>
          {items.map((entry, index) => (
            <LeaderboardRow
              key={entry.userId}
              entry={entry}
              sort={sort}
              divider={index > 0}
              highlighted={entry.userId === me?.userId}
            />
          ))}
        </ScrollView>
      )}
      {me != null && (
        <View style={{ marginHorizontal: -8, paddingTop: 8, borderTopWidth: 1, borderTopColor: DIVIDER }}>
          <Text
            className="px-3 pb-1 text-xs font-medium uppercase"
            style={{ color: 'rgba(0,0,0,0.45)' }}
          >
            {t('wordChain.leaderboardMe')}
          </Text>
          <LeaderboardRow entry={me} sort={sort} highlighted divider={false} />
        </View>
      )}
      {items.length > 0 && (
        <Text className="text-center text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
          {t('wordChain.leaderboardTotal', { value: leaderboard?.total ?? 0 })}
        </Text>
      )}
    </View>
  );
}

export function WordChainLeaderboardDialog({
  visible,
  onClose,
}: {
  visible: boolean;
  onClose: () => void;
}) {
  const { t } = useTranslation();
  const { height } = useWindowDimensions();
  const [tab, setTab] = useState<WordChainLeaderboardTab>(WORD_CHAIN_LEADERBOARD_SORT.wins);
  const [period, setPeriod] = useState<WordChainLeaderboardPeriod>(
    WORD_CHAIN_LEADERBOARD_PERIOD.all
  );
  const tabs = WORD_CHAIN_LEADERBOARD_TABS.map((item) => ({
    key: item.key,
    label: t(item.labelKey),
  }));
  const panelHeight = Math.min(height * PANEL_HEIGHT_RATIO, PANEL_MAX_HEIGHT);

  return (
    <Dialog
      visible={visible}
      onClose={onClose}
      title={t('wordChain.leaderboardTitle')}
      showClose
      avoidKeyboard={false}
    >
      <View style={{ gap: 12 }}>
        <WordChainTabs variant="segmented" items={tabs} value={tab} onChange={setTab} />
        <View style={{ height: panelHeight }}>
          {tab === 'history' ? (
            <WordChainWinHistory />
          ) : (
            <LeaderboardPanel sort={tab} period={period} onPeriodChange={setPeriod} />
          )}
        </View>
      </View>
    </Dialog>
  );
}
