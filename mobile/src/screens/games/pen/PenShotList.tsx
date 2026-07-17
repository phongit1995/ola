import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, ScrollView, Text, View, type StyleProp, type ViewStyle } from 'react-native';
import { createTimeFormatter, formatKen } from '@ola/shared/lib';
import type { PenShotView } from '@ola/shared/types';
import { VipBadge } from '@components/ui/VipBadge';
import { PenButton } from './PenButton';
import { PenPagination } from './PenPagination';
import { penAssets } from './penAssets';
import { PEN_COLORS } from './penUi';

interface PenShotListProps {
  shots: PenShotView[];
  loading?: boolean;
  page: number;
  pageCount: number;
  onPage: (page: number) => void;
  onSelect: (shot: PenShotView) => void;
  style?: StyleProp<ViewStyle>;
}

const COLS = { shooter: 1.9, bet: 1, time: 1.2, action: 0.95 };

export function PenShotList({
  shots,
  loading,
  page,
  pageCount,
  onPage,
  onSelect,
  style,
}: PenShotListProps) {
  const { t, i18n } = useTranslation();
  const formatTime = createTimeFormatter(i18n.language);

  return (
    <View
      style={[
        {
          minHeight: 0,
          overflow: 'hidden',
          borderRadius: 16,
          borderWidth: 1,
          borderColor: 'rgba(255,255,255,0.12)',
          backgroundColor: 'rgba(0,24,51,0.4)',
        },
        style,
      ]}
    >
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          gap: 6,
          paddingHorizontal: 12,
          paddingVertical: 6,
        }}
      >
        <Image
          source={penAssets.shotListIcon}
          style={{ width: 14, height: 14 }}
          resizeMode="contain"
        />
        <Text style={{ fontSize: 11, fontWeight: '700', letterSpacing: 0.5, color: '#ffffff' }}>
          {t('penGame.waitingTitle')}
        </Text>
      </View>

      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          gap: 6,
          borderTopWidth: 1,
          borderBottomWidth: 1,
          borderColor: 'rgba(255,255,255,0.1)',
          backgroundColor: '#001c3e',
          paddingHorizontal: 12,
          paddingVertical: 4,
        }}
      >
        <Text style={{ flex: COLS.shooter, fontSize: 10, fontWeight: '600', letterSpacing: 0.5, textTransform: 'uppercase', color: 'rgba(255,255,255,0.45)' }}>
          {t('penGame.columns.shooter')}
        </Text>
        <Text style={{ flex: COLS.bet, fontSize: 10, fontWeight: '600', letterSpacing: 0.5, textTransform: 'uppercase', color: 'rgba(255,255,255,0.45)' }}>
          {t('penGame.columns.bet')}
        </Text>
        <Text style={{ flex: COLS.time, textAlign: 'right', fontSize: 10, fontWeight: '600', letterSpacing: 0.5, textTransform: 'uppercase', color: 'rgba(255,255,255,0.45)' }}>
          {t('penGame.columns.time')}
        </Text>
        <View style={{ flex: COLS.action }} />
      </View>

      <ScrollView style={{ flex: 1, minHeight: 0 }}>
        {loading ? (
          <View style={{ alignItems: 'center', paddingVertical: 32 }}>
            <ActivityIndicator color="#5aa0e0" />
          </View>
        ) : shots.length === 0 ? (
          <Text
            style={{
              paddingHorizontal: 16,
              paddingVertical: 32,
              textAlign: 'center',
              fontSize: 12,
              color: 'rgba(255,255,255,0.55)',
            }}
          >
            {t('penGame.emptyShots')}
          </Text>
        ) : (
          shots.map((shot) => {
            const username = shot.shooter?.username ?? '';
            return (
              <View
                key={shot.id}
                style={{
                  flexDirection: 'row',
                  alignItems: 'center',
                  gap: 6,
                  borderBottomWidth: 1,
                  borderBottomColor: 'rgba(255,255,255,0.05)',
                  paddingHorizontal: 12,
                  paddingVertical: 4,
                }}
              >
                <View
                  style={{
                    flex: COLS.shooter,
                    minWidth: 0,
                    flexDirection: 'row',
                    alignItems: 'center',
                    gap: 6,
                  }}
                >
                  <VipBadge typeId={shot.shooter?.vipTypeId} />
                  <Text
                    numberOfLines={1}
                    style={{ flexShrink: 1, fontSize: 14, color: 'rgba(255,255,255,0.85)' }}
                  >
                    @{username}
                  </Text>
                </View>
                <View
                  style={{ flex: COLS.bet, flexDirection: 'row', alignItems: 'center', gap: 4 }}
                >
                  <Image
                    source={penAssets.kenIcon}
                    style={{ width: 14, height: 14 }}
                    resizeMode="contain"
                  />
                  <Text style={{ fontSize: 11, fontWeight: '600', color: PEN_COLORS.gold }}>
                    {formatKen(shot.betAmount)}
                  </Text>
                </View>
                <Text
                  numberOfLines={1}
                  style={{
                    flex: COLS.time,
                    textAlign: 'right',
                    fontSize: 10,
                    color: 'rgba(255,255,255,0.55)',
                  }}
                >
                  {formatTime(shot.createdAt)}
                </Text>
                <PenButton
                  bg={penAssets.selectBtn}
                  icon={penAssets.gloveIcon}
                  iconSize={16}
                  gap={4}
                  label={t('penGame.select')}
                  onPress={() => onSelect(shot)}
                  style={{ flex: COLS.action, height: 28, paddingHorizontal: 4 }}
                  labelStyle={{ fontSize: 10 }}
                />
              </View>
            );
          })
        )}
      </ScrollView>

      <View style={{ paddingVertical: 4 }}>
        <PenPagination page={page} pageCount={pageCount} loading={loading ?? false} onPage={onPage} />
      </View>
    </View>
  );
}
