import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import {
  FlatList,
  Text,
  useWindowDimensions,
  View,
  type GestureResponderEvent,
  type LayoutChangeEvent,
  type NativeScrollEvent,
  type NativeSyntheticEvent,
} from 'react-native';
import type { Reel, ReelTrayGroup } from '@ola/shared/types';
import { useReelStore } from '@ola/shared/stores/reel/reelStore';
import { useReelTray } from '@ola/shared/stores/reel/useReelTray';
import { REEL_GRID_COLUMNS } from '../constants';
import type { OpenReelViewer } from '../useReelOverlays';
import { ReelAddCard, ReelTrayCard } from './ReelTrayCard';

type ReelTrayLayout = 'row' | 'grid';

type TrayItem =
  | { kind: 'add'; key: string }
  | { kind: 'mine'; key: string; reel: Reel }
  | { kind: 'group'; key: string; group: ReelTrayGroup; reel: Reel };

const ROW_GAP = 8;
const GRID_PADDING = 12;
const END_DISTANCE_PX = 200;
const END_THRESHOLD = 0.5;

function RowGap() {
  return <View style={{ width: ROW_GAP }} />;
}

function keepTouchInTray(event: GestureResponderEvent) {
  event.stopPropagation();
}

interface ScrollMetrics {
  offset: number;
  viewport: number;
  content: number;
  measuredItems: number;
}

function isNearEnd({ offset, viewport, content }: ScrollMetrics) {
  return viewport > 0 && content - offset - viewport < END_DISTANCE_PX;
}

interface ReelTrayProps {
  layout?: ReelTrayLayout;
  onOpenViewer: OpenReelViewer;
  onAddReel: () => void;
}

export function ReelTray({ layout = 'row', onOpenViewer, onAddReel }: ReelTrayProps) {
  const { t } = useTranslation();
  const { width: windowWidth } = useWindowDimensions();
  const loadMore = useReelStore((s) => s.loadMore);
  const hasMore = useReelStore((s) => s.nextCursor != null);
  const pagingBusy = useReelStore((s) => s.loadingMore || s.refreshing);
  const tray = useReelTray();
  const metricsRef = useRef<ScrollMetrics>({ offset: 0, viewport: 0, content: 0, measuredItems: -1 });
  const horizontal = layout === 'row';
  const gridCardWidth =
    (windowWidth - GRID_PADDING * 2 - ROW_GAP * (REEL_GRID_COLUMNS - 1)) / REEL_GRID_COLUMNS;
  const cardWidth = horizontal ? undefined : gridCardWidth;

  const latestMine = tray.mine[tray.mine.length - 1];
  const items: TrayItem[] = [
    { kind: 'add', key: 'add' },
    ...(latestMine ? [{ kind: 'mine' as const, key: 'mine', reel: latestMine }] : []),
    ...tray.groups.flatMap((group) => {
      const first = group.reels[0];
      return first ? [{ kind: 'group' as const, key: group.author.id, group, reel: first }] : [];
    }),
  ];

  const itemCount = items.length;

  useEffect(() => {
    const metrics = metricsRef.current;
    if (pagingBusy || !hasMore || metrics.measuredItems !== itemCount) return;
    if (isNearEnd(metrics)) void loadMore();
  }, [pagingBusy, hasMore, itemCount, loadMore]);

  function handleEndReached() {
    void loadMore();
  }

  function handleScroll(event: NativeSyntheticEvent<NativeScrollEvent>) {
    const { contentOffset, contentSize, layoutMeasurement } = event.nativeEvent;
    metricsRef.current = {
      ...metricsRef.current,
      offset: horizontal ? contentOffset.x : contentOffset.y,
      viewport: horizontal ? layoutMeasurement.width : layoutMeasurement.height,
      content: horizontal ? contentSize.width : contentSize.height,
    };
  }

  function handleContentSizeChange(width: number, height: number) {
    metricsRef.current = {
      ...metricsRef.current,
      content: horizontal ? width : height,
      measuredItems: itemCount,
    };
  }

  function handleLayout(event: LayoutChangeEvent) {
    const { width, height } = event.nativeEvent.layout;
    metricsRef.current = { ...metricsRef.current, viewport: horizontal ? width : height };
  }

  function renderItem({ item }: { item: TrayItem }) {
    if (item.kind === 'add') {
      return <ReelAddCard width={cardWidth} onPress={onAddReel} />;
    }
    if (item.kind === 'mine') {
      return (
        <ReelTrayCard
          reel={item.reel}
          label={t('reel.mine')}
          ringed={false}
          width={cardWidth}
          onPress={() =>
            onOpenViewer([{ author: item.reel.author, reels: tray.mine }], item.reel.author.id, true)
          }
        />
      );
    }
    return (
      <ReelTrayCard
        reel={item.reel}
        label={item.group.author.fullName || item.group.author.username}
        ringed
        width={cardWidth}
        onPress={() => onOpenViewer(tray.groups, item.group.author.id, false)}
      />
    );
  }

  if (horizontal) {
    return (
      <View
        className="mb-2 bg-white py-3"
        style={{ elevation: 1, shadowColor: '#000000', shadowOpacity: 0.18, shadowRadius: 1, shadowOffset: { width: 0, height: 1 } }}
        onTouchStart={keepTouchInTray}
        onTouchMove={keepTouchInTray}
        onTouchEnd={keepTouchInTray}
      >
        <FlatList
          horizontal
          data={items}
          keyExtractor={(item) => item.key}
          renderItem={renderItem}
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={{ paddingHorizontal: GRID_PADDING }}
          ItemSeparatorComponent={RowGap}
          onEndReached={handleEndReached}
          onEndReachedThreshold={END_THRESHOLD}
          onScroll={handleScroll}
          onContentSizeChange={handleContentSizeChange}
          onLayout={handleLayout}
          scrollEventThrottle={64}
        />
      </View>
    );
  }

  return (
    <View className="flex-1">
      <FlatList
        data={items}
        numColumns={REEL_GRID_COLUMNS}
        keyExtractor={(item) => item.key}
        renderItem={renderItem}
        contentContainerStyle={{ padding: GRID_PADDING, gap: ROW_GAP }}
        columnWrapperStyle={{ gap: ROW_GAP }}
        onEndReached={handleEndReached}
        onEndReachedThreshold={END_THRESHOLD}
        onScroll={handleScroll}
        onContentSizeChange={handleContentSizeChange}
        onLayout={handleLayout}
        scrollEventThrottle={64}
        ListFooterComponent={
          tray.groups.length === 0 ? (
            <Text className="px-4 py-8 text-center text-sm" style={{ color: 'rgba(0,0,0,0.5)' }}>
              {t('reel.friendsEmpty')}
            </Text>
          ) : undefined
        }
      />
    </View>
  );
}
