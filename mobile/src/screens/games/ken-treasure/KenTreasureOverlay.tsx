import { useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Animated,
  Image,
  PanResponder,
  Pressable,
  StyleSheet,
  Text,
  View,
  useWindowDimensions,
  type StyleProp,
  type TextStyle,
  type ViewStyle,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { formatKen } from '@ola/shared/lib';
import {
  useKenTreasureStore,
  useKenTreasurePositionStore,
  type KenTreasureChest,
} from '@ola/shared/stores/kenTreasureStore';
import { assetRatio } from '../pen/penUi';
import { kenTreasureAssets, openingFrames } from './kenTreasureAssets';

const STACK_OFFSET_PX = 150;
const OPENING_FRAME_MS = Math.max(120, Math.floor(1000 / openingFrames.length));

const goldTextStyle: TextStyle = {
  color: '#ffe27a',
  textShadowColor: 'rgba(0,0,0,0.45)',
  textShadowOffset: { width: 0, height: 2 },
  textShadowRadius: 3,
};

const whiteTextStyle: TextStyle = {
  color: '#ffffff',
  textShadowColor: 'rgba(0,0,0,0.4)',
  textShadowOffset: { width: 0, height: 2 },
  textShadowRadius: 3,
};

function formatCountdown(ms: number): string {
  const total = Math.max(0, Math.ceil(ms / 1000));
  const minutes = Math.floor(total / 60);
  const seconds = total % 60;
  return `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
}

function useRemaining(expiresAt: string, onExpire: () => void): number {
  const [remaining, setRemaining] = useState(0);
  const onExpireRef = useRef(onExpire);
  onExpireRef.current = onExpire;

  useEffect(() => {
    let expired = false;
    const target = new Date(expiresAt).getTime();
    const tick = () => {
      const left = target - Date.now();
      setRemaining(left);
      if (left <= 0 && !expired) {
        expired = true;
        onExpireRef.current();
      }
    };
    tick();
    const id = setInterval(tick, 250);
    return () => clearInterval(id);
  }, [expiresAt]);

  return remaining;
}

function ImageButton({
  source,
  width,
  label,
  labelStyle,
  fontSize,
  style,
  onPress,
}: {
  source: number;
  width: number;
  label: string;
  labelStyle: TextStyle;
  fontSize: number;
  style?: StyleProp<ViewStyle>;
  onPress: () => void;
}) {
  const height = width / assetRatio(source);
  return (
    <Pressable onPress={onPress} style={[{ width, height }, style]}>
      <Image source={source} style={{ position: 'absolute', width, height }} resizeMode="stretch" />
      <View style={StyleSheet.absoluteFill} className="items-center justify-center">
        <Text
          style={[{ fontSize, fontWeight: '800', textTransform: 'uppercase' }, labelStyle]}
          numberOfLines={1}
        >
          {label}
        </Text>
      </View>
    </Pressable>
  );
}

function CloseBadge({ size, onPress }: { size: number; onPress: () => void }) {
  return (
    <Pressable
      onPress={onPress}
      style={{ position: 'absolute', right: -4, top: 0, width: size, height: size, zIndex: 20 }}
    >
      <Image
        source={kenTreasureAssets.buttonClose}
        style={{ position: 'absolute', width: size, height: size }}
        resizeMode="contain"
      />
      <View style={StyleSheet.absoluteFill} className="items-center justify-center">
        <Image
          source={kenTreasureAssets.closeX}
          style={{ width: size / 2, height: size / 2 }}
          resizeMode="contain"
        />
      </View>
    </Pressable>
  );
}

function Crown({ panelWidth, panelHeight }: { panelWidth: number; panelHeight: number }) {
  const width = panelWidth * 0.24;
  const height = width / assetRatio(kenTreasureAssets.crown);
  return (
    <Image
      source={kenTreasureAssets.crown}
      style={{
        position: 'absolute',
        left: (panelWidth - width) / 2,
        top: -panelHeight * 0.09,
        width,
        height,
      }}
      resizeMode="contain"
    />
  );
}

const DRAG_START_DISTANCE = 6;

function clampValue(value: number, min: number, max: number): number {
  return Math.min(max, Math.max(min, value));
}

function ClosedChestPanel({ chest, stackIndex }: { chest: KenTreasureChest; stackIndex: number }) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const { width: windowWidth, height: windowHeight } = useWindowDimensions();
  const openChest = useKenTreasureStore((s) => s.open);
  const dismiss = useKenTreasureStore((s) => s.dismiss);
  const positionX = useKenTreasurePositionStore((s) => s.x);
  const positionY = useKenTreasurePositionStore((s) => s.y);
  const remaining = useRemaining(chest.expiresAt, () => dismiss(chest.id));
  const dragBase = useRef({ x: 0, y: 0 });

  const panelWidth = 140;
  const panelHeight = panelWidth / assetRatio(kenTreasureAssets.frameBackground);
  const chestWidth = panelWidth * 0.48;
  const chestHeight = chestWidth / assetRatio(kenTreasureAssets.chestClosed);
  const timeWidth = panelWidth * 0.56;
  const timeHeight = timeWidth / assetRatio(kenTreasureAssets.frameTime);
  const hourglassWidth = timeWidth * 0.26;
  const hourglassHeight = hourglassWidth / assetRatio(kenTreasureAssets.buttonHourglass);
  const openWidth = panelWidth * 0.54;
  const openHeight = openWidth / assetRatio(kenTreasureAssets.frameOpen);

  const stackShift = stackIndex * STACK_OFFSET_PX;
  const baseLeft = windowWidth - 16 - panelWidth;
  const baseTop = windowHeight - insets.bottom - 76 - panelHeight;
  const minTranslateX = 8 - baseLeft;
  const maxTranslateX = windowWidth - panelWidth - 8 - baseLeft;
  const minTranslateY = insets.top + 8 - baseTop;
  const maxTranslateY = windowHeight - insets.bottom - 8 - panelHeight - baseTop;
  const translateX = clampValue(positionX - stackShift, minTranslateX, maxTranslateX);
  const translateY = clampValue(positionY, minTranslateY, maxTranslateY);

  const pan = useRef(new Animated.ValueXY({ x: translateX, y: translateY })).current;
  useEffect(() => {
    pan.setValue({ x: translateX, y: translateY });
  }, [pan, translateX, translateY]);

  const panResponder = useMemo(() => {
    const shouldDrag = (_event: unknown, gesture: { dx: number; dy: number }) =>
      Math.abs(gesture.dx) + Math.abs(gesture.dy) > DRAG_START_DISTANCE;
    const dragTranslate = (gesture: { dx: number; dy: number }) => ({
      x: clampValue(
        dragBase.current.x + gesture.dx - stackShift,
        minTranslateX,
        maxTranslateX
      ),
      y: clampValue(dragBase.current.y + gesture.dy, minTranslateY, maxTranslateY),
    });
    const commit = (gesture: { dx: number; dy: number }) => {
      const next = dragTranslate(gesture);
      useKenTreasurePositionStore.getState().setPosition(next.x + stackShift, next.y);
    };
    return PanResponder.create({
      onMoveShouldSetPanResponder: shouldDrag,
      onMoveShouldSetPanResponderCapture: shouldDrag,
      onPanResponderGrant: () => {
        const { x, y } = useKenTreasurePositionStore.getState();
        dragBase.current = { x, y };
      },
      onPanResponderMove: (_event, gesture) => {
        pan.setValue(dragTranslate(gesture));
      },
      onPanResponderRelease: (_event, gesture) => commit(gesture),
      onPanResponderTerminate: (_event, gesture) => commit(gesture),
    });
  }, [pan, minTranslateX, maxTranslateX, minTranslateY, maxTranslateY, stackShift]);

  return (
    <Animated.View
      {...panResponder.panHandlers}
      style={{
        position: 'absolute',
        right: 16,
        bottom: insets.bottom + 76,
        width: panelWidth,
        height: panelHeight,
        transform: [{ translateX: pan.x }, { translateY: pan.y }],
      }}
    >
      <Image
        source={kenTreasureAssets.frameBackground}
        style={{ position: 'absolute', width: panelWidth, height: panelHeight }}
        resizeMode="stretch"
      />
      <Crown panelWidth={panelWidth} panelHeight={panelHeight} />
      <CloseBadge size={panelWidth * 0.13} onPress={() => dismiss(chest.id)} />

      <Text
        style={[
          {
            position: 'absolute',
            top: panelHeight * 0.06,
            left: panelWidth * 0.15,
            width: panelWidth * 0.7,
            textAlign: 'center',
            fontSize: 12,
            fontWeight: '800',
            textTransform: 'uppercase',
          },
          goldTextStyle,
        ]}
        numberOfLines={1}
      >
        {t('kenTreasure.title')}
      </Text>

      <Image
        source={kenTreasureAssets.chestClosed}
        style={{
          position: 'absolute',
          left: (panelWidth - chestWidth) / 2,
          top: panelHeight * 0.23,
          width: chestWidth,
          height: chestHeight,
        }}
        resizeMode="contain"
      />

      <View
        style={{
          position: 'absolute',
          left: (panelWidth - timeWidth) / 2,
          top: panelHeight * 0.68,
          width: timeWidth,
          height: timeHeight,
        }}
      >
        <Image
          source={kenTreasureAssets.frameTime}
          style={{ position: 'absolute', width: timeWidth, height: timeHeight }}
          resizeMode="stretch"
        />
        <Image
          source={kenTreasureAssets.buttonHourglass}
          style={{
            position: 'absolute',
            left: -timeWidth * 0.08,
            top: (timeHeight - hourglassHeight) / 2,
            width: hourglassWidth,
            height: hourglassHeight,
          }}
          resizeMode="contain"
        />
        <View
          style={[StyleSheet.absoluteFill, { paddingLeft: timeWidth * 0.1 }]}
          className="items-center justify-center"
        >
          <Text style={[{ fontSize: 11, fontWeight: '800' }, goldTextStyle]}>
            {formatCountdown(remaining)}
          </Text>
        </View>
      </View>

      <ImageButton
        source={kenTreasureAssets.frameOpen}
        width={openWidth}
        label={t('kenTreasure.open')}
        labelStyle={whiteTextStyle}
        fontSize={13}
        style={{
          position: 'absolute',
          left: (panelWidth - openWidth) / 2,
          bottom: panelHeight * 0.07 - openHeight / 2,
        }}
        onPress={() => void openChest(chest.id)}
      />
    </Animated.View>
  );
}

function OpeningChest() {
  const { width: windowWidth } = useWindowDimensions();
  const [index, setIndex] = useState(0);

  useEffect(() => {
    let current = 0;
    const id = setInterval(() => {
      current = Math.min(openingFrames.length - 1, current + 1);
      setIndex(current);
      if (current >= openingFrames.length - 1) clearInterval(id);
    }, OPENING_FRAME_MS);
    return () => clearInterval(id);
  }, []);

  const frame = openingFrames[index] ?? kenTreasureAssets.chestWithEffect;
  const width = Math.min(windowWidth * 0.62, 280);
  const height = width / assetRatio(frame);

  return (
    <View
      style={[StyleSheet.absoluteFill, { backgroundColor: 'rgba(0,0,0,0.4)' }]}
      className="items-center justify-center"
    >
      <Image source={frame} style={{ width, height }} resizeMode="contain" />
    </View>
  );
}

function ResultView({
  result,
  onClose,
}: {
  result: KenTreasureChest['result'];
  onClose: () => void;
}) {
  const { t } = useTranslation();
  const { width: windowWidth } = useWindowDimensions();
  const isEmpty = result?.isEmpty ?? false;
  const amount = result?.kenAmount ?? 0;

  const panelWidth = Math.min(330, windowWidth - 32);
  const panelHeight = panelWidth / assetRatio(kenTreasureAssets.resultBackground);
  const chestSource = isEmpty ? kenTreasureAssets.resultChestEmpty : kenTreasureAssets.resultChestWin;
  const chestWidth = panelWidth * 0.46;
  const chestHeight = chestWidth / assetRatio(chestSource);
  const rowWidth = panelWidth * 0.78;
  const rowHeight = rowWidth / assetRatio(kenTreasureAssets.resultKenCount);
  const coinWidth = rowWidth * 0.24;
  const coinHeight = coinWidth / assetRatio(kenTreasureAssets.resultKenCoin);
  const closeWidth = panelWidth * 0.56;
  const closeHeight = closeWidth / assetRatio(kenTreasureAssets.resultClose);

  return (
    <View
      style={[StyleSheet.absoluteFill, { backgroundColor: 'rgba(0,0,0,0.4)' }]}
      className="items-center justify-center"
    >
      <Pressable style={StyleSheet.absoluteFill} onPress={onClose} />
      <View style={{ width: panelWidth, height: panelHeight }}>
        <Image
          source={kenTreasureAssets.resultBackground}
          style={{ position: 'absolute', width: panelWidth, height: panelHeight }}
          resizeMode="stretch"
        />
        <Crown panelWidth={panelWidth} panelHeight={panelHeight} />
        <CloseBadge size={panelWidth * 0.13} onPress={onClose} />

        <Text
          style={[
            {
              position: 'absolute',
              top: panelHeight * 0.07,
              left: panelWidth * 0.13,
              width: panelWidth * 0.74,
              textAlign: 'center',
              fontSize: 20,
              fontWeight: '800',
              textTransform: 'uppercase',
            },
            goldTextStyle,
          ]}
          numberOfLines={1}
        >
          {t('kenTreasure.resultTitle')}
        </Text>

        <Image
          source={chestSource}
          style={{
            position: 'absolute',
            left: (panelWidth - chestWidth) / 2,
            top: panelHeight * 0.13,
            width: chestWidth,
            height: chestHeight,
          }}
          resizeMode="contain"
        />

        <Text
          style={[
            {
              position: 'absolute',
              top: panelHeight * 0.55,
              left: panelWidth * 0.1,
              width: panelWidth * 0.8,
              textAlign: 'center',
              fontSize: 26,
              fontWeight: '800',
              textTransform: 'uppercase',
            },
            goldTextStyle,
          ]}
          numberOfLines={1}
        >
          {isEmpty ? t('kenTreasure.emptyTitle') : t('kenTreasure.congrats')}
        </Text>

        <Text
          style={{
            position: 'absolute',
            top: panelHeight * 0.63,
            left: panelWidth * 0.1,
            width: panelWidth * 0.8,
            textAlign: 'center',
            fontSize: 13,
            fontWeight: '600',
            color: '#5a2b12',
          }}
          numberOfLines={1}
        >
          {isEmpty ? t('kenTreasure.emptyDesc') : t('kenTreasure.youWon')}
        </Text>

        {!isEmpty && (
          <View
            style={{
              position: 'absolute',
              left: (panelWidth - rowWidth) / 2,
              top: panelHeight * 0.68,
              width: rowWidth,
              height: rowHeight,
            }}
          >
            <Image
              source={kenTreasureAssets.resultKenCount}
              style={{ position: 'absolute', width: rowWidth, height: rowHeight }}
              resizeMode="stretch"
            />
            <Image
              source={kenTreasureAssets.resultKenCoin}
              style={{
                position: 'absolute',
                left: rowWidth * 0.06,
                top: (rowHeight - coinHeight) / 2,
                width: coinWidth,
                height: coinHeight,
              }}
              resizeMode="contain"
            />
            <View
              style={[StyleSheet.absoluteFill, { paddingLeft: rowWidth * 0.16 }]}
              className="items-center justify-center"
            >
              <Text style={[{ fontSize: 19, fontWeight: '800' }, goldTextStyle]} numberOfLines={1}>
                {`${formatKen(amount)} ${t('kenTreasure.kenSuffix')}`}
              </Text>
            </View>
          </View>
        )}

        <ImageButton
          source={kenTreasureAssets.resultClose}
          width={closeWidth}
          label={t('kenTreasure.close')}
          labelStyle={whiteTextStyle}
          fontSize={19}
          style={{
            position: 'absolute',
            left: (panelWidth - closeWidth) / 2,
            bottom: panelHeight * 0.06 - closeHeight / 2,
          }}
          onPress={onClose}
        />
      </View>
    </View>
  );
}

export function KenTreasureOverlay() {
  const chests = useKenTreasureStore((s) => s.chests);
  const dismiss = useKenTreasureStore((s) => s.dismiss);

  const list = Object.values(chests);
  if (list.length === 0) return null;

  const active = list.find((c) => c.phase === 'opening' || c.phase === 'result');
  const closed = list.filter((c) => c.phase === 'closed');

  return (
    <View style={StyleSheet.absoluteFill} pointerEvents="box-none">
      {closed.map((chest, i) => (
        <ClosedChestPanel key={chest.id} chest={chest} stackIndex={i} />
      ))}
      {active?.phase === 'opening' && <OpeningChest key={active.id} />}
      {active?.phase === 'result' && (
        <ResultView key={active.id} result={active.result} onClose={() => dismiss(active.id)} />
      )}
    </View>
  );
}
