import { useEffect, useState } from 'react';
import { StyleSheet, View, type LayoutChangeEvent } from 'react-native';
import Animated, {
  Easing,
  useAnimatedStyle,
  useSharedValue,
  withTiming,
  type SharedValue,
} from 'react-native-reanimated';

const CONFETTI_COLORS = [
  '#ffd54f',
  '#ffb300',
  '#7cb342',
  '#ff4081',
  '#4fc3f7',
  '#ba68c8',
  '#ff7043',
];
const PIECES_PER_CANNON = 45;
const GRAVITY = 1500;
const TERMINAL_VELOCITY = 360;
const HORIZONTAL_DRAG = -Math.log(0.12);
const LAUNCH_ANGLE = Math.PI / 3;
const LAUNCH_SPREAD = Math.PI / 6;
const LAUNCH_Y_RATIO = 0.85;
const MIN_RISE_RATIO = 0.5;
const MAX_RISE_RATIO = 0.95;
const CONFETTI_DURATION_MS = 3200;
const CONFETTI_FADE_MS = 700;
const ROUND_PIECE_CHANCE = 0.3;

interface ConfettiPiece {
  id: number;
  x: number;
  y: number;
  vx: number;
  vy: number;
  angle: number;
  spin: number;
  flip: number;
  flipSpeed: number;
  width: number;
  height: number;
  color: string;
  round: boolean;
}

function randomBetween(min: number, max: number) {
  return min + Math.random() * (max - min);
}

function createPieces(width: number, height: number): ConfettiPiece[] {
  const pieces: ConfettiPiece[] = [];
  for (const direction of [1, -1]) {
    const originX = direction > 0 ? 0 : width;
    for (let i = 0; i < PIECES_PER_CANNON; i += 1) {
      const angle = LAUNCH_ANGLE + randomBetween(-0.5, 0.5) * LAUNCH_SPREAD;
      const rise = height * randomBetween(MIN_RISE_RATIO, MAX_RISE_RATIO);
      const speed = Math.sqrt(2 * GRAVITY * rise) / Math.sin(angle);
      pieces.push({
        id: pieces.length,
        x: originX,
        y: height * LAUNCH_Y_RATIO,
        vx: direction * Math.cos(angle) * speed,
        vy: -Math.sin(angle) * speed,
        angle: randomBetween(0, Math.PI * 2),
        spin: randomBetween(-8, 8),
        flip: randomBetween(0, Math.PI * 2),
        flipSpeed: randomBetween(6, 14),
        width: randomBetween(6, 10),
        height: randomBetween(9, 14),
        color: CONFETTI_COLORS[Math.floor(Math.random() * CONFETTI_COLORS.length)]!,
        round: Math.random() < ROUND_PIECE_CHANCE,
      });
    }
  }
  return pieces;
}

function pieceOffsetY(piece: ConfettiPiece, seconds: number) {
  'worklet';
  const reachTerminal = (TERMINAL_VELOCITY - piece.vy) / GRAVITY;
  if (seconds <= reachTerminal) {
    return piece.vy * seconds + 0.5 * GRAVITY * seconds * seconds;
  }
  const atTerminal =
    piece.vy * reachTerminal + 0.5 * GRAVITY * reachTerminal * reachTerminal;
  return atTerminal + TERMINAL_VELOCITY * (seconds - reachTerminal);
}

function ConfettiSprite({
  piece,
  elapsed,
}: {
  piece: ConfettiPiece;
  elapsed: SharedValue<number>;
}) {
  const style = useAnimatedStyle(() => {
    const seconds = elapsed.value / 1000;
    const x =
      piece.x + (piece.vx * (1 - Math.exp(-HORIZONTAL_DRAG * seconds))) / HORIZONTAL_DRAG;
    const y = piece.y + pieceOffsetY(piece, seconds);
    const fade = Math.min(1, (CONFETTI_DURATION_MS - elapsed.value) / CONFETTI_FADE_MS);
    return {
      opacity: elapsed.value <= 0 ? 0 : Math.max(0, fade),
      transform: [
        { translateX: x - piece.width / 2 },
        { translateY: y - piece.height / 2 },
        { rotate: `${piece.angle + piece.spin * seconds}rad` },
        { scaleY: Math.cos(piece.flip + piece.flipSpeed * seconds) },
      ],
    };
  });
  return (
    <Animated.View
      style={[
        {
          position: 'absolute',
          left: 0,
          top: 0,
          width: piece.width,
          height: piece.round ? piece.width : piece.height,
          borderRadius: piece.round ? piece.width / 2 : 1,
          backgroundColor: piece.color,
        },
        style,
      ]}
    />
  );
}

export function WordChainConfetti() {
  const [pieces, setPieces] = useState<ConfettiPiece[] | null>(null);
  const elapsed = useSharedValue(0);

  useEffect(() => {
    if (pieces == null) return;
    elapsed.value = withTiming(CONFETTI_DURATION_MS, {
      duration: CONFETTI_DURATION_MS,
      easing: Easing.linear,
    });
  }, [pieces, elapsed]);

  function handleLayout(event: LayoutChangeEvent) {
    if (pieces != null) return;
    const { width, height } = event.nativeEvent.layout;
    if (width > 0 && height > 0) setPieces(createPieces(width, height));
  }

  return (
    <View pointerEvents="none" style={StyleSheet.absoluteFill} onLayout={handleLayout}>
      {pieces?.map((piece) => (
        <ConfettiSprite key={piece.id} piece={piece} elapsed={elapsed} />
      ))}
    </View>
  );
}
