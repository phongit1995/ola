import { useEffect, useMemo, useState } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, Text, View } from 'react-native';
import { createTimeFormatter } from '@ola/shared/lib';
import type { WordChainWin } from '@ola/shared/types';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { useThemeColors } from '@hooks/useThemeColors';
import { WordChainStatusIcon } from './WordChainIcons';
import { WordChainListStatus, WordChainUserRow } from './WordChainList';
import { WordChainTabs } from './WordChainTabs';

type WinFilter = 'all' | 'mine';

function WinRow({
  win,
  index,
  highlighted,
  formatTime,
}: {
  win: WordChainWin;
  index: number;
  highlighted: boolean;
  formatTime: (iso: string) => string;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <WordChainUserRow
      name={win.username}
      avatar={win.avatar}
      highlighted={highlighted}
      divider={index > 0}
      trailing={<WordChainStatusIcon status="win" size={24} decorative />}
    >
      <Text numberOfLines={1} className="text-sm" style={{ color: 'rgba(0,0,0,0.8)' }}>
        <Trans
          i18nKey="wordChain.winHistoryItem"
          values={{ name: win.username, word: win.word }}
          components={{
            mention: <Text style={{ fontWeight: '600', color: 'rgba(0,0,0,0.87)' }} />,
            word: <Text style={{ fontWeight: '600', color: colors.primaryInk }} />,
          }}
        />
      </Text>
      <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
        {t('wordChain.winHistoryFrom', { word: win.previousWord })} · {formatTime(win.createdAt)}
      </Text>
    </WordChainUserRow>
  );
}

export function WordChainWinHistory() {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const [filter, setFilter] = useState<WinFilter>('all');
  const currentUserId = useAuthStore((store) => store.user?.id);
  const wins = useWordChainStore((store) => store.wins);
  const hasMore = useWordChainStore((store) => store.winsHasMore);
  const loading = useWordChainStore((store) => store.winsLoading);
  const failed = useWordChainStore((store) => store.winsFailed);
  const fetchWins = useWordChainStore((store) => store.fetchWins);
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const mine = filter === 'mine';

  useEffect(() => {
    void fetchWins({ mine });
  }, [mine, fetchWins]);

  const filters = [
    { key: 'all' as const, label: t('wordChain.winHistoryAll') },
    { key: 'mine' as const, label: t('wordChain.winHistoryMine') },
  ];

  return (
    <View className="flex-1" style={{ gap: 8 }}>
      <WordChainTabs variant="chips" items={filters} value={filter} onChange={setFilter} />
      {wins.length === 0 ? (
        <WordChainListStatus
          loading={loading}
          failed={failed}
          emptyText={t(mine ? 'wordChain.winHistoryMineEmpty' : 'wordChain.winHistoryEmpty')}
          errorText={t('wordChain.winsError')}
          onRetry={() => void fetchWins({ mine })}
        />
      ) : (
        <ScrollView className="flex-1" style={{ marginHorizontal: -8 }}>
          {wins.map((win, index) => (
            <WinRow
              key={win.id}
              win={win}
              index={index}
              highlighted={win.userId === currentUserId}
              formatTime={formatTime}
            />
          ))}
          {hasMore && (
            <Pressable
              accessibilityRole="button"
              disabled={loading}
              onPress={() => void fetchWins({ mine, more: true })}
              className="items-center justify-center py-3 active:bg-black/5"
              style={{ opacity: loading ? 0.6 : 1 }}
            >
              {loading ? (
                <ActivityIndicator color={colors.primary} size="small" />
              ) : (
                <Text className="text-sm font-medium" style={{ color: colors.primaryInk }}>
                  {t('wordChain.winHistoryMore')}
                </Text>
              )}
            </Pressable>
          )}
        </ScrollView>
      )}
    </View>
  );
}
