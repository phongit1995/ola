import { useEffect, useRef } from 'react';
import { Graphics } from 'pixi.js';
import { useTick } from '@pixi/react';

interface Particle {
  x: number;
  y: number;
  vx: number;
  vy: number;
  r: number;
  color: number;
  life: number;
  maxLife: number;
}

const COLORS = [0xffd54f, 0xff6f61, 0x4fc3f7, 0x81c784, 0xba68c8, 0xfff176, 0xff8a65];
const GRAVITY = 520;
const PER_BURST = 64;
const VOLLEY_NORMAL = 3;
const VOLLEY_SUPER = 5;
const GAP_NORMAL = 0.35;
const GAP_SUPER = 0.2;

const noopDraw = () => {};

function pick<T>(list: T[]): T {
  return list[Math.floor(Math.random() * list.length)] ?? list[0]!;
}

function spawnBurst(out: Particle[], cx: number, cy: number) {
  const base = pick(COLORS);
  for (let i = 0; i < PER_BURST; i += 1) {
    const angle = (Math.PI * 2 * i) / PER_BURST + Math.random() * 0.18;
    const speed = 200 + Math.random() * 260;
    const life = 0.9 + Math.random() * 0.6;
    out.push({
      x: cx,
      y: cy,
      vx: Math.cos(angle) * speed,
      vy: Math.sin(angle) * speed,
      r: 2.5 + Math.random() * 2.5,
      color: Math.random() < 0.5 ? base : pick(COLORS),
      life,
      maxLife: life,
    });
  }
}

function spawnVolley(out: Particle[], width: number, height: number, count: number) {
  for (let b = 0; b < count; b += 1) {
    spawnBurst(out, width * (0.16 + Math.random() * 0.68), height * (0.14 + Math.random() * 0.4));
  }
}

interface FireworksProps {
  active: boolean;
  big: boolean;
  width: number;
  height: number;
}

export function Fireworks({ active, big, width, height }: FireworksProps) {
  const gfxRef = useRef<Graphics>(null);
  const particlesRef = useRef<Particle[]>([]);
  const activeRef = useRef(false);
  const gapTimerRef = useRef(0);
  const dirtyRef = useRef(false);
  const paramsRef = useRef({ width, height, big });

  useEffect(() => {
    paramsRef.current = { width, height, big };
  });

  useEffect(() => {
    activeRef.current = active;
    if (!active) return;
    const { width: w, height: h, big: superLucky } = paramsRef.current;
    spawnVolley(particlesRef.current, w, h, superLucky ? VOLLEY_SUPER : VOLLEY_NORMAL);
    gapTimerRef.current = superLucky ? GAP_SUPER : GAP_NORMAL;
  }, [active]);

  useTick((ticker) => {
    const g = gfxRef.current;
    if (g === null) return;
    const dt = Math.min(0.05, ticker.deltaMS / 1000);
    const particles = particlesRef.current;
    const { width: w, height: h, big: superLucky } = paramsRef.current;

    if (activeRef.current) {
      if (particles.length > 0) {
        gapTimerRef.current = superLucky ? GAP_SUPER : GAP_NORMAL;
      } else {
        gapTimerRef.current -= dt;
        if (gapTimerRef.current <= 0) {
          spawnVolley(particles, w, h, superLucky ? VOLLEY_SUPER : VOLLEY_NORMAL);
        }
      }
    }

    if (particles.length === 0) {
      if (dirtyRef.current) {
        g.clear();
        dirtyRef.current = false;
      }
      return;
    }
    dirtyRef.current = true;
    let alive = 0;
    for (let i = 0; i < particles.length; i += 1) {
      const p = particles[i];
      if (!p) continue;
      p.life -= dt;
      if (p.life <= 0) continue;
      p.vy += GRAVITY * dt;
      p.x += p.vx * dt;
      p.y += p.vy * dt;
      particles[alive] = p;
      alive += 1;
    }
    particles.length = alive;
    g.clear();
    for (let i = 0; i < particles.length; i += 1) {
      const p = particles[i]!;
      g.circle(p.x, p.y, p.r).fill({ color: p.color, alpha: Math.max(0, p.life / p.maxLife) });
    }
  });

  return <pixiGraphics ref={gfxRef} draw={noopDraw} eventMode="none" />;
}
