import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Modal,
  Pressable,
  StyleSheet,
  Text,
  View,
  useWindowDimensions,
} from 'react-native';
import { createTimeFormatter, formatKen } from '@ola/shared/lib';
import { WheelService } from '@ola/shared/services';
import type { WheelSpinHistoryFilter, WheelSpinHistoryItem } from '@ola/shared/types';
import { VipIconImage } from '@screens/vip/components/VipIconImage';
import { VerticalGradient, assetRatio } from '@screens/games/pen/penUi';
import { wheelAssets, wheelHistoryAssets } from './spinWheelAssets';
import { formatRewardKen, isKenKind, isVipDaysKind } from './spinWheelReward';
import {
  HISTORY_LABEL_STYLE,
  HISTORY_TAB_INACTIVE_STYLE,
  HISTORY_TITLE_STYLE,
} from './spinWheelStyles';

const PAGE_SIZE = 8;
const FILTERS: WheelSpinHistoryFilter[] = ['all', 'win', 'miss'];

interface SpinHistoryDialogProps {
  onClose: () => void;
}

interface OutcomeView {
  text: string;
  win: boolean;
  vipTypeId?: number;
  iconSource?: number;
}

function useOutcomeLabel() {
  const { t } = useTranslation();
  return useCallback(
    (item: WheelSpinHistoryItem): OutcomeView => {
      if (item.segmentKind === 'miss') {
        return { text: t('wheelGame.miss'), win: false, iconSource: wheelAssets.rewardMiss };
      }
      if (isKenKind(item.segmentKind)) {
        return {
          text: `${formatRewardKen(item.kenAmount ?? 0)} KEN`,
          win: true,
          iconSource: wheelAssets.spinCoin,
        };
      }
      if (isVipDaysKind(item.segmentKind)) {
        return {
          text: t('wheelGame.vipDays', { n: item.vipDays ?? 0 }),
          win: true,
          iconSource: wheelAssets.rewardVipDays,
        };
      }
      return {
        text: item.rewardLabel ?? t('wheelGame.rewardTitle'),
        win: true,
        vipTypeId: item.vipTypeId,
      };
    },
    [t]
  );
}

export function SpinHistoryDialog({ onClose }: SpinHistoryDialogProps) {
  const { t, i18n } = useTranslation();
  const { width: windowWidth, height: windowHeight } = useWindowDimensions();
  const [items, setItems] = useState<WheelSpinHistoryItem[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);
  const [filter, setFilter] = useState<WheelSpinHistoryFilter>('all');
  const [page, setPage] = useState(0);

  const outcomeLabel = useOutcomeLabel();
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  useEffect(() => {
    let cancelled = false;
    setLoading(true);
    setError(false);
    WheelService.listSpins(PAGE_SIZE, page * PAGE_SIZE, filter)
      .then((result) => {
        if (cancelled) return;
        setTotal(result.total);
        setItems(result.items);
        setLoading(false);
      })
      .catch(() => {
        if (cancelled) return;
        setError(true);
        setLoading(false);
      });
    return () => {
      cancelled = true;
    };
  }, [page, filter]);

  const selectFilter = (next: WheelSpinHistoryFilter) => {
    setFilter(next);
    setPage(0);
  };

  const totalPages = Math.max(1, Math.ceil(total / PAGE_SIZE));
  const canPrev = page > 0 && !loading;
  const canNext = page < totalPages - 1 && !loading;
  const placeholders = Math.max(0, PAGE_SIZE - items.length);

  const panelWidth = Math.min(windowWidth * 0.9, (windowHeight * 0.62 * 1043) / 1458);
  const panelHeight = (panelWidth * 1458) / 1043;
  const contentWidth = panelWidth - panelWidth * 0.18;
  const pageButtonWidth = contentWidth * 0.18;
  const pageButtonHeight = (pageButtonWidth * 1519) / 2008;
  const arrowHeight = pageButtonHeight * 0.52;
  const bannerWidth = panelWidth * 0.74;
  const bannerHeight = (bannerWidth * 576) / 1935;
  const closeWidth = panelWidth * 0.14;
  const closeHeight = (closeWidth * 831) / 813;
  const closeMarkWidth = closeWidth * 0.46;

  return (
    <Modal transparent animationType="fade" visible onRequestClose={onClose}>
      <View
        style={{
          flex: 1,
          alignItems: 'center',
          justifyContent: 'center',
          backgroundColor: 'rgba(0,0,0,0.55)',
          paddingHorizontal: 12,
        }}
      >
        <Pressable style={StyleSheet.absoluteFill} onPress={onClose} />
        <View style={{ width: panelWidth, height: panelHeight }}>
          <View
            style={{
              position: 'absolute',
              left: panelWidth * 0.035,
              right: panelWidth * 0.035,
              top: panelHeight * 0.035,
              bottom: panelHeight * 0.035,
              borderRadius: 24,
              backgroundColor: '#fff4f1',
            }}
          />
          <View style={StyleSheet.absoluteFill} pointerEvents="none">
            <Image
              source={wheelHistoryAssets.frame}
              style={{ width: '100%', height: '100%' }}
              resizeMode="stretch"
            />
          </View>

          <View
            style={{
              position: 'absolute',
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              paddingHorizontal: panelWidth * 0.09,
              paddingTop: panelHeight * 0.105,
              paddingBottom: panelHeight * 0.05,
            }}
          >
            <View
              style={{
                flexDirection: 'row',
                gap: 2,
                paddingHorizontal: 8,
                marginBottom: -4,
              }}
            >
              {FILTERS.map((f) => {
                const activeTab = filter === f;
                return (
                  <Pressable
                    key={f}
                    onPress={() => selectFilter(f)}
                    style={{ flex: 1, aspectRatio: 1254 / 425 }}
                  >
                    <Image
                      source={activeTab ? wheelHistoryAssets.tabActive : wheelHistoryAssets.tabInactive}
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
                        alignItems: 'center',
                        justifyContent: 'center',
                        paddingHorizontal: 6,
                      }}
                    >
                      <Text
                        numberOfLines={1}
                        adjustsFontSizeToFit
                        minimumFontScale={0.7}
                        style={[
                          { fontSize: 14, fontWeight: '800' },
                          activeTab ? HISTORY_LABEL_STYLE : HISTORY_TAB_INACTIVE_STYLE,
                        ]}
                      >
                        {t(`wheelGame.historyFilter.${f}`)}
                      </Text>
                    </View>
                  </Pressable>
                );
              })}
            </View>

            <View
              style={{
                flex: 1,
                borderRadius: 16,
                borderWidth: 2,
                borderColor: 'rgba(255,143,163,0.55)',
                overflow: 'hidden',
                paddingHorizontal: 12,
                paddingVertical: 6,
              }}
            >
              <VerticalGradient
                stops={[
                  { color: '#ffffff', pos: 0 },
                  { color: '#fff1ee', pos: 1 },
                ]}
                style={{
                  position: 'absolute',
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  zIndex: -1,
                }}
              />
              {error ? (
                <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
                  <Text style={{ fontSize: 14, fontWeight: '700', color: '#c0392b' }}>
                    {t('wheelGame.error')}
                  </Text>
                </View>
              ) : loading ? (
                <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
                  <ActivityIndicator color="#f04b7b" />
                </View>
              ) : items.length === 0 ? (
                <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
                  <Text style={{ fontSize: 14, fontWeight: '700', color: '#b98a97' }}>
                    {t('wheelGame.historyEmpty')}
                  </Text>
                </View>
              ) : (
                <View style={{ flex: 1 }}>
                  {items.map((item) => {
                    const outcome = outcomeLabel(item);
                    return (
                      <View
                        key={item.id}
                        style={{
                          flex: 1,
                          flexDirection: 'row',
                          alignItems: 'center',
                          justifyContent: 'space-between',
                          gap: 8,
                          paddingVertical: 2,
                          overflow: 'hidden',
                          borderBottomWidth: 1,
                          borderBottomColor: 'rgba(246,207,203,0.7)',
                        }}
                      >
                        <View
                          style={{
                            flexDirection: 'row',
                            alignItems: 'center',
                            gap: 8,
                            flexShrink: 1,
                          }}
                        >
                          <View style={{ width: 36, alignItems: 'center' }}>
                            {outcome.vipTypeId != null ? (
                              <VipIconImage typeId={outcome.vipTypeId} size={32} rounded />
                            ) : outcome.iconSource != null ? (
                              <Image
                                source={outcome.iconSource}
                                style={{ width: 32, height: 32 }}
                                resizeMode="contain"
                              />
                            ) : null}
                          </View>
                          <Text
                            numberOfLines={1}
                            style={{
                              flexShrink: 1,
                              fontSize: 16,
                              fontWeight: '800',
                              color: outcome.win ? '#0b8f32' : '#2b1717',
                            }}
                          >
                            {outcome.text}
                          </Text>
                        </View>
                        <View style={{ alignItems: 'flex-end' }}>
                          <Text style={{ fontSize: 12, fontWeight: '500', color: '#8a8a8a' }}>
                            {formatTime(item.createdAt)}
                          </Text>
                          <Text style={{ fontSize: 12, fontWeight: '700', color: '#ff1e1e' }}>
                            {item.isFree
                              ? t('wheelGame.freeToday')
                              : `-${formatKen(item.kenCost)} KEN`}
                          </Text>
                        </View>
                      </View>
                    );
                  })}
                  {Array.from({ length: placeholders }).map((_, index) => (
                    <View
                      key={`empty-${index}`}
                      style={{
                        flex: 1,
                        borderBottomWidth: index === placeholders - 1 ? 0 : 1,
                        borderBottomColor: 'rgba(246,207,203,0.7)',
                      }}
                    />
                  ))}
                </View>
              )}
            </View>

            <View
              style={{
                marginTop: 6,
                flexDirection: 'row',
                alignItems: 'center',
                justifyContent: 'center',
                gap: 16,
              }}
            >
              <Pressable
                onPress={() => setPage((p) => Math.max(0, p - 1))}
                disabled={!canPrev}
                style={{
                  width: pageButtonWidth,
                  height: pageButtonHeight,
                  opacity: canPrev ? 1 : 0.4,
                }}
              >
                <Image
                  source={wheelHistoryAssets.pageButton}
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
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}
                >
                  <Image
                    source={wheelHistoryAssets.pagePrev}
                    style={{
                      width: arrowHeight * assetRatio(wheelHistoryAssets.pagePrev),
                      height: arrowHeight,
                    }}
                    resizeMode="contain"
                  />
                </View>
              </Pressable>
              <Text style={[{ fontSize: 18, fontWeight: '800' }, HISTORY_LABEL_STYLE]}>
                {t('wheelGame.historyPage', { n: page + 1 })}
              </Text>
              <Pressable
                onPress={() => setPage((p) => Math.min(totalPages - 1, p + 1))}
                disabled={!canNext}
                style={{
                  width: pageButtonWidth,
                  height: pageButtonHeight,
                  opacity: canNext ? 1 : 0.4,
                }}
              >
                <Image
                  source={wheelHistoryAssets.pageButton}
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
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}
                >
                  <Image
                    source={wheelHistoryAssets.pageNext}
                    style={{
                      width: arrowHeight * assetRatio(wheelHistoryAssets.pageNext),
                      height: arrowHeight,
                    }}
                    resizeMode="contain"
                  />
                </View>
              </Pressable>
            </View>
          </View>

          <View
            style={{
              position: 'absolute',
              left: (panelWidth - bannerWidth) / 2,
              top: -bannerHeight / 2,
              width: bannerWidth,
              height: bannerHeight,
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'center',
              gap: 8,
            }}
          >
            <Image
              source={wheelHistoryAssets.headerBanner}
              style={{ position: 'absolute', left: 0, top: 0, width: bannerWidth, height: bannerHeight }}
              resizeMode="stretch"
            />
            <Image
              source={wheelAssets.historyIcon}
              style={{
                width: bannerHeight * 0.38 * assetRatio(wheelAssets.historyIcon),
                height: bannerHeight * 0.38,
              }}
              resizeMode="contain"
            />
            <Text style={[{ fontSize: 20, fontWeight: '800' }, HISTORY_TITLE_STYLE]}>
              {t('wheelGame.historyTitle')}
            </Text>
          </View>

          <Pressable
            accessibilityLabel={t('wheelGame.close')}
            onPress={onClose}
            style={{
              position: 'absolute',
              right: -panelWidth * 0.01,
              top: -panelHeight * 0.02,
              width: closeWidth,
              height: closeHeight,
            }}
          >
            <Image
              source={wheelHistoryAssets.closeButton}
              style={{ position: 'absolute', left: 0, top: 0, width: closeWidth, height: closeHeight }}
              resizeMode="stretch"
            />
            <Image
              source={wheelHistoryAssets.closeMark}
              style={{
                position: 'absolute',
                left: (closeWidth - closeMarkWidth) / 2,
                top:
                  (closeHeight - closeMarkWidth / assetRatio(wheelHistoryAssets.closeMark)) / 2,
                width: closeMarkWidth,
                height: closeMarkWidth / assetRatio(wheelHistoryAssets.closeMark),
              }}
              resizeMode="contain"
            />
          </Pressable>
        </View>
      </View>
    </Modal>
  );
}
