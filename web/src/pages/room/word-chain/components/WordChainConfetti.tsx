import { useEffect, useRef } from 'react';

const CONFETTI_COLORS = [
  '#ffd54f',
  '#ffb300',
  '#7cb342',
  '#ff4081',
  '#4fc3f7',
  '#ba68c8',
  '#ff7043',
];
const PIECES_PER_CANNON = 60;
const GRAVITY = 1500;
const TERMINAL_VELOCITY = 360;
const HORIZONTAL_KEEP_PER_SECOND = 0.12;
const LAUNCH_ANGLE = Math.PI / 3;
const LAUNCH_SPREAD = Math.PI / 6;
const LAUNCH_Y_RATIO = 0.85;
const MIN_RISE_RATIO = 0.5;
const MAX_RISE_RATIO = 0.95;
const MAX_FRAME_SECONDS = 0.05;
const CONFETTI_DURATION_MS = 3200;
const CONFETTI_FADE_MS = 700;
const ROUND_PIECE_CHANCE = 0.3;
const REDUCED_MOTION_QUERY = '(prefers-reduced-motion: reduce)';

interface ConfettiPiece {
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
        color:
          CONFETTI_COLORS[Math.floor(Math.random() * CONFETTI_COLORS.length)]!,
        round: Math.random() < ROUND_PIECE_CHANCE,
      });
    }
  }
  return pieces;
}

function stepPiece(piece: ConfettiPiece, seconds: number) {
  piece.vx *= HORIZONTAL_KEEP_PER_SECOND ** seconds;
  piece.vy = Math.min(piece.vy + GRAVITY * seconds, TERMINAL_VELOCITY);
  piece.x += piece.vx * seconds;
  piece.y += piece.vy * seconds;
  piece.angle += piece.spin * seconds;
  piece.flip += piece.flipSpeed * seconds;
}

function drawPiece(context: CanvasRenderingContext2D, piece: ConfettiPiece) {
  context.save();
  context.translate(piece.x, piece.y);
  context.rotate(piece.angle);
  context.scale(1, Math.cos(piece.flip));
  context.fillStyle = piece.color;
  if (piece.round) {
    context.beginPath();
    context.arc(0, 0, piece.width / 2, 0, Math.PI * 2);
    context.fill();
  } else {
    context.fillRect(
      -piece.width / 2,
      -piece.height / 2,
      piece.width,
      piece.height
    );
  }
  context.restore();
}

export function WordChainConfetti() {
  const canvasRef = useRef<HTMLCanvasElement>(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    const context = canvas?.getContext('2d');
    if (canvas == null || context == null) return;
    if (window.matchMedia(REDUCED_MOTION_QUERY).matches) return;

    const { width, height } = canvas.getBoundingClientRect();
    const ratio = window.devicePixelRatio || 1;
    canvas.width = Math.round(width * ratio);
    canvas.height = Math.round(height * ratio);
    context.setTransform(ratio, 0, 0, ratio, 0, 0);

    const pieces = createPieces(width, height);
    const startedAt = performance.now();
    let lastFrame = startedAt;
    let frame = 0;

    const tick = (now: number) => {
      const elapsed = now - startedAt;
      const seconds = Math.min((now - lastFrame) / 1000, MAX_FRAME_SECONDS);
      lastFrame = now;
      context.clearRect(0, 0, width, height);
      if (elapsed >= CONFETTI_DURATION_MS) return;
      context.globalAlpha = Math.min(
        1,
        (CONFETTI_DURATION_MS - elapsed) / CONFETTI_FADE_MS
      );
      for (const piece of pieces) {
        stepPiece(piece, seconds);
        if (piece.y < height + piece.height) drawPiece(context, piece);
      }
      frame = requestAnimationFrame(tick);
    };
    frame = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(frame);
  }, []);

  return (
    <canvas
      ref={canvasRef}
      aria-hidden="true"
      className="pointer-events-none absolute inset-0 h-full w-full"
    />
  );
}
