import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, ScrollView, Text, View } from 'react-native';
import { PEN_LEADERBOARD_PAGE, usePenLeaderboardStore } from '@ola/shared/stores/penLeaderboardStore';
import type { PenLeaderboardPeriod } from '@ola/shared/types';
import { penLeaderboardAssets, penShootAssets } from './penAssets';
import { PenBg, PenPanel, penTextShadow, sizeByHeight } from './penUi';
import { PenPagination } from './PenPagination';
import { PenLeaderboardRow } from './PenLeaderboardRow';

const COLS = { rank: 0.7, player: 2, ken: 1.3 };

interface PenLeaderboardModalProps {
  onClose: () => void;
}

export function PenLeaderboardModal({ onClose }: PenLeaderboardModalProps) {
  const { t } = useTranslation();
  const period = usePenLeaderboardStore((s) => s.period);
  const page = usePenLeaderboardStore((s) => s.page);
  const loading = usePenLeaderboardStore((s) => s.loading);
  const items = usePenLeaderboardStore((s) => s.cache[s.period]);
  const setPeriod = usePenLeaderboardStore((s) => s.setPeriod);
  const setPage = usePenLeaderboardStore((s) => s.setPage);
  const load = usePenLeaderboardStore((s) => s.load);
  const reset = usePenLeaderboardStore((s) => s.reset);

  useEffect(() => {
    void load('day');
    return reset;
  }, [load, reset]);

  const rows = items ?? [];
  const pageCount = Math.max(1, Math.ceil(rows.length / PEN_LEADERBOARD_PAGE));
  const paged = rows.slice(page * PEN_LEADERBOARD_PAGE, (page + 1) * PEN_LEADERBOARD_PAGE);

  const tabs: { key: PenLeaderboardPeriod; label: string }[] = [
    { key: 'day', label: t('penGame.leaderboard.topDay') },
    { key: 'week', label: t('penGame.leaderboard.topWeek') },
  ];

  return (
    <View
      style={{
        position: 'absolute',
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        zIndex: 40,
        alignItems: 'center',
        justifyContent: 'center',
        paddingHorizontal: 8,
      }}
    >
      <Pressable
        accessibilityLabel={t('penGame.close')}
        onPress={onClose}
        style={{
          position: 'absolute',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          backgroundColor: 'rgba(0,0,0,0.55)',
        }}
      />
      <View style={{ width: '100%', maxHeight: '92%' }}>
        <PenPanel style={{ maxHeight: '100%' }}>
          <View
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              gap: 8,
              paddingHorizontal: 12,
              paddingTop: 20,
              paddingBottom: 16,
            }}
          >
            <View style={{ width: 36, height: 36 }} />
            <View
              style={{
                flex: 1,
                minWidth: 0,
                flexDirection: 'row',
                alignItems: 'center',
                justifyContent: 'center',
                gap: 8,
              }}
            >
              <Image
                source={penLeaderboardAssets.cup}
                style={sizeByHeight(penLeaderboardAssets.cup, 32)}
                resizeMode="contain"
              />
              <Text
                numberOfLines={1}
                style={[
                  {
                    color: '#ffffff',
                    fontSize: 20,
                    fontWeight: '800',
                    fontStyle: 'italic',
                    letterSpacing: 1,
                  },
                  penTextShadow,
                ]}
              >
                {t('penGame.leaderboard.title')}
              </Text>
            </View>
            <Pressable
              accessibilityLabel={t('penGame.close')}
              onPress={onClose}
              style={{
                width: 36,
                height: 36,
                alignItems: 'center',
                justifyContent: 'center',
              }}
            >
              <PenBg source={penShootAssets.closeBtn} />
              <Image
                source={penShootAssets.closeIcon}
                style={{ width: 16, height: 16 }}
                resizeMode="contain"
              />
            </Pressable>
          </View>

          <View
            style={{
              flexDirection: 'row',
              gap: 8,
              paddingHorizontal: 12,
              paddingTop: 8,
              paddingBottom: 8,
            }}
          >
            {tabs.map((item) => {
              const active = item.key === period;
              return (
                <Pressable
                  key={item.key}
                  onPress={() => setPeriod(item.key)}
                  style={{
                    flex: 1,
                    alignItems: 'center',
                    paddingVertical: 12,
                    opacity: active ? 1 : 0.4,
                  }}
                >
                  <PenBg source={penLeaderboardAssets.tab} />
                  <Text
                    numberOfLines={1}
                    style={[
                      { color: '#ffffff', fontSize: 14, fontWeight: '800', letterSpacing: 0.5 },
                      penTextShadow,
                    ]}
                  >
                    {item.label}
                  </Text>
                </Pressable>
              );
            })}
          </View>

          <View
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              gap: 8,
              borderTopWidth: 1,
              borderBottomWidth: 1,
              borderColor: 'rgba(255,255,255,0.1)',
              paddingHorizontal: 12,
              paddingVertical: 6,
            }}
          >
            <Text style={{ flex: COLS.rank, textAlign: 'center', fontSize: 11, fontWeight: '600', letterSpacing: 0.5, textTransform: 'uppercase', color: '#7cc4ff' }}>
              {t('penGame.leaderboard.colRank')}
            </Text>
            <Text style={{ flex: COLS.player, fontSize: 11, fontWeight: '600', letterSpacing: 0.5, textTransform: 'uppercase', color: '#7cc4ff' }}>
              {t('penGame.leaderboard.colPlayer')}
            </Text>
            <Text style={{ flex: COLS.ken, textAlign: 'right', fontSize: 11, fontWeight: '600', letterSpacing: 0.5, textTransform: 'uppercase', color: '#7cc4ff' }}>
              {t('penGame.leaderboard.colKenWon')}
            </Text>
          </View>

          <ScrollView style={{ height: 450, flexShrink: 1 }}>
            {loading && rows.length === 0 ? (
              <View style={{ alignItems: 'center', paddingVertical: 40 }}>
                <ActivityIndicator color="#5aa0e0" />
              </View>
            ) : rows.length === 0 ? (
              <Text
                style={{
                  paddingHorizontal: 16,
                  paddingVertical: 40,
                  textAlign: 'center',
                  fontSize: 14,
                  color: 'rgba(255,255,255,0.55)',
                }}
              >
                {t('penGame.leaderboard.empty')}
              </Text>
            ) : (
              paged.map((entry) => <PenLeaderboardRow key={entry.user.id} entry={entry} />)
            )}
          </ScrollView>

          <View style={{ paddingVertical: 12 }}>
            <PenPagination page={page} pageCount={pageCount} loading={loading} onPage={setPage} />
          </View>
        </PenPanel>
      </View>
    </View>
  );
}
