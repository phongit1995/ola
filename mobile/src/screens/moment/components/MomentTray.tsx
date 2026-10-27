import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import {
  FlatList,
  View,
  type GestureResponderEvent,
  type LayoutChangeEvent,
  type NativeScrollEvent,
  type NativeSyntheticEvent,
} from 'react-native';
import type { Moment, MomentTrayGroup } from '@ola/shared/types';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import { useMomentTray } from '@ola/shared/stores/moment/useMomentTray';
import type { OpenMomentViewer } from '../useMomentOverlays';
import { MomentAddCard, MomentTrayCard } from './MomentTrayCard';

type TrayItem =
  | { kind: 'add'; key: string }
  | { kind: 'mine'; key: string; moment: Moment }
  | { kind: 'group'; key: string; group: MomentTrayGroup; moment: Moment };

const ROW_GAP = 8;
const ROW_PADDING = 12;
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

interface MomentTrayProps {
  onOpenViewer: OpenMomentViewer;
  onAddMoment: () => void;
}

export function MomentTray({ onOpenViewer, onAddMoment }: MomentTrayProps) {
  const { t } = useTranslation();
  const loadMore = useMomentStore((s) => s.loadMore);
  const hasMore = useMomentStore((s) => s.nextCursor != null);
  const pagingBusy = useMomentStore((s) => s.loadingMore || s.refreshing);
  const tray = useMomentTray();
  const metricsRef = useRef<ScrollMetrics>({ offset: 0, viewport: 0, content: 0, measuredItems: -1 });

  const latestMine = tray.mine[tray.mine.length - 1];
  const items: TrayItem[] = [
    { kind: 'add', key: 'add' },
    ...(latestMine ? [{ kind: 'mine' as const, key: 'mine', moment: latestMine }] : []),
    ...tray.groups.flatMap((group) => {
      const first = group.moments[0];
      return first ? [{ kind: 'group' as const, key: group.author.id, group, moment: first }] : [];
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
      offset: contentOffset.x,
      viewport: layoutMeasurement.width,
      content: contentSize.width,
    };
  }

  function handleContentSizeChange(width: number) {
    metricsRef.current = {
      ...metricsRef.current,
      content: width,
      measuredItems: itemCount,
    };
  }

  function handleLayout(event: LayoutChangeEvent) {
    metricsRef.current = { ...metricsRef.current, viewport: event.nativeEvent.layout.width };
  }

  function renderItem({ item }: { item: TrayItem }) {
    if (item.kind === 'add') {
      return <MomentAddCard onPress={onAddMoment} />;
    }
    if (item.kind === 'mine') {
      return (
        <MomentTrayCard
          moment={item.moment}
          label={t('moment.mine')}
          ringed={false}
          onPress={() =>
            onOpenViewer([{ author: item.moment.author, moments: tray.mine }], item.moment.author.id, true)
          }
        />
      );
    }
    return (
      <MomentTrayCard
        moment={item.moment}
        label={item.group.author.fullName || item.group.author.username}
        ringed
        onPress={() => onOpenViewer(tray.groups, item.group.author.id, false)}
      />
    );
  }

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
        contentContainerStyle={{ paddingHorizontal: ROW_PADDING }}
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
