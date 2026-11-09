import { reducedMotion, type Point } from './runtime';

const MAX_PARTICLES = 220;
const TAU = Math.PI * 2;

type Kind = 'coin' | 'dust' | 'confetti' | 'shard' | 'spark' | 'ring';

interface Particle {
  kind: Kind;
  x: number;
  y: number;
  vx: number;
  vy: number;
  gravity: number;
  drag: number;
  age: number;
  life: number;
  delay: number;
  size: number;
  color: string;
  rot: number;
  spin: number;
  from?: Point;
  to?: Point;
  lift?: number;
}

const particles: Particle[] = [];
let canvas: HTMLCanvasElement | null = null;
let ctx: CanvasRenderingContext2D | null = null;
let frame = 0;
let lastTime = 0;

function fit(): void {
  if (!canvas || !ctx) return;
  const ratio = Math.min(devicePixelRatio || 1, 2);
  canvas.width = innerWidth * ratio;
  canvas.height = innerHeight * ratio;
  ctx.setTransform(ratio, 0, 0, ratio, 0, 0);
}

export function attachParticles(el: HTMLCanvasElement): () => void {
  canvas = el;
  ctx = el.getContext('2d');
  fit();
  addEventListener('resize', fit);
  return () => {
    removeEventListener('resize', fit);
    if (frame) cancelAnimationFrame(frame);
    frame = 0;
    particles.length = 0;
    canvas = null;
    ctx = null;
  };
}

function add(partial: Partial<Particle> & Pick<Particle, 'kind' | 'x' | 'y'>): void {
  if (reducedMotion() || !ctx) return;
  if (particles.length >= MAX_PARTICLES) particles.shift();
  particles.push({ vx: 0, vy: 0, gravity: 0, drag: 1, age: 0, life: 500, delay: 0, size: 4, color: '#F2B807', rot: Math.random() * TAU, spin: 0, ...partial });
  if (!frame) {
    lastTime = performance.now();
    frame = requestAnimationFrame(tick);
  }
}

function drawCoin(g: CanvasRenderingContext2D, p: Particle): void {
  g.save();
  g.translate(p.x, p.y);
  g.scale(Math.max(Math.abs(Math.cos(p.rot)), 0.22), 1);
  g.beginPath();
  g.arc(0, 0, p.size, 0, TAU);
  g.fillStyle = '#FFC928';
  g.fill();
  g.lineWidth = 1.4;
  g.strokeStyle = '#8A5A00';
  g.stroke();
  g.beginPath();
  g.arc(0, 0, p.size * 0.58, 0, TAU);
  g.strokeStyle = '#FFF0A8';
  g.lineWidth = 1.2;
  g.stroke();
  g.restore();
}

function draw(g: CanvasRenderingContext2D, p: Particle, progress: number): void {
  g.globalAlpha = 1;
  switch (p.kind) {
    case 'coin':
      g.globalAlpha = progress > 0.9 ? (1 - progress) * 10 : 1;
      drawCoin(g, p);
      return;
    case 'dust':
      g.globalAlpha = (1 - progress) * 0.65;
      g.fillStyle = p.color;
      g.beginPath();
      g.arc(p.x, p.y, p.size * (1 + progress), 0, TAU);
      g.fill();
      return;
    case 'confetti':
    case 'shard':
      g.globalAlpha = progress > 0.75 ? (1 - progress) * 4 : 1;
      g.save();
      g.translate(p.x, p.y);
      g.rotate(p.rot);
      g.scale(1, Math.cos(p.rot * 1.7));
      g.fillStyle = p.color;
      g.fillRect(-p.size / 2, -p.size * 0.32, p.size, p.size * 0.64);
      g.restore();
      return;
    case 'spark':
      g.globalAlpha = 1 - progress;
      g.strokeStyle = p.color;
      g.lineCap = 'round';
      g.lineWidth = p.size * (1 - progress * 0.6);
      g.beginPath();
      g.moveTo(p.x, p.y);
      g.lineTo(p.x - p.vx * 2.4, p.y - p.vy * 2.4);
      g.stroke();
      return;
    case 'ring':
      g.globalAlpha = (1 - progress) * 0.9;
      g.strokeStyle = p.color;
      g.lineWidth = Math.max(0.5, 3.5 * (1 - progress));
      g.beginPath();
      g.arc(p.x, p.y, p.size * (0.3 + progress * 0.9), 0, TAU);
      g.stroke();
      return;
  }
}

function tick(now: number): void {
  const g = ctx;
  if (!g) {
    frame = 0;
    return;
  }
  const dt = Math.min(now - lastTime, 40);
  lastTime = now;
  g.clearRect(0, 0, innerWidth, innerHeight);
  const scale = dt / 16.67;
  for (let i = particles.length - 1; i >= 0; i--) {
    const p = particles[i];
    p.age += dt;
    if (p.age < p.delay) continue;
    const progress = (p.age - p.delay) / p.life;
    if (progress >= 1) {
      particles.splice(i, 1);
      continue;
    }
    if (p.from && p.to) {
      const eased = progress < 0.5 ? 2 * progress * progress : 1 - (-2 * progress + 2) ** 2 / 2;
      p.x = p.from.x + (p.to.x - p.from.x) * eased;
      p.y = p.from.y + (p.to.y - p.from.y) * eased - Math.sin(progress * Math.PI) * (p.lift ?? 40);
    } else {
      p.vy += p.gravity * scale;
      p.vx *= p.drag ** scale;
      p.vy *= p.drag ** scale;
      p.x += p.vx * scale;
      p.y += p.vy * scale;
    }
    p.rot += p.spin * scale;
    draw(g, p, progress);
  }
  g.globalAlpha = 1;
  frame = particles.length ? requestAnimationFrame(tick) : 0;
  if (!frame) g.clearRect(0, 0, innerWidth, innerHeight);
}

export function coinFlight(from: Point, to: Point, count: number, delay = 0): void {
  for (let i = 0; i < count; i++) {
    add({
      kind: 'coin',
      x: from.x,
      y: from.y,
      life: 460,
      delay: delay + i * 34,
      size: 6.5,
      spin: 0.32,
      from: { x: from.x + (Math.random() - 0.5) * 18, y: from.y + (Math.random() - 0.5) * 12 },
      to: { x: to.x + (Math.random() - 0.5) * 14, y: to.y + (Math.random() - 0.5) * 8 },
      lift: 34 + Math.random() * 34,
    });
  }
}

export function coinFountain(at: Point, count: number): void {
  for (let i = 0; i < count; i++) {
    const angle = -Math.PI / 2 + (Math.random() - 0.5) * 1.5;
    const speed = 3.4 + Math.random() * 3;
    add({ kind: 'coin', x: at.x, y: at.y, vx: Math.cos(angle) * speed, vy: Math.sin(angle) * speed, gravity: 0.24, life: 620, size: 6, spin: 0.34, delay: i * 18 });
  }
}

export function dust(at: Point, count = 4, color = '#D9CDB0'): void {
  for (let i = 0; i < count; i++) {
    const angle = Math.random() * TAU;
    add({ kind: 'dust', x: at.x, y: at.y, vx: Math.cos(angle) * 1.1, vy: Math.sin(angle) * 0.55 - 0.2, drag: 0.9, life: 300, size: 2.2 + Math.random() * 1.8, color });
  }
}

export function sparks(at: Point, count: number, color = '#F2B807', power = 4.2): void {
  for (let i = 0; i < count; i++) {
    const angle = (i / count) * TAU + Math.random() * 0.3;
    const speed = power * (0.7 + Math.random() * 0.6);
    add({ kind: 'spark', x: at.x, y: at.y, vx: Math.cos(angle) * speed, vy: Math.sin(angle) * speed, drag: 0.91, life: 420, size: 2.6, color });
  }
}

export function confettiBurst(at: Point, count: number, colors: string[], power = 5.5): void {
  for (let i = 0; i < count; i++) {
    const angle = Math.random() * TAU;
    const speed = 1.5 + Math.random() * power;
    add({
      kind: 'confetti',
      x: at.x,
      y: at.y,
      vx: Math.cos(angle) * speed,
      vy: Math.sin(angle) * speed - 2.4,
      gravity: 0.16,
      drag: 0.975,
      life: 900 + Math.random() * 500,
      size: 5 + Math.random() * 3.5,
      color: colors[i % colors.length],
      spin: (Math.random() - 0.5) * 0.4,
    });
  }
}

export function confettiRain(colors: string[], count: number): void {
  for (let i = 0; i < count; i++) {
    add({
      kind: 'confetti',
      x: Math.random() * innerWidth,
      y: -14,
      vx: (Math.random() - 0.5) * 1.6,
      vy: 2 + Math.random() * 2.2,
      gravity: 0.025,
      life: 2500,
      delay: Math.random() * 1200,
      size: 6 + Math.random() * 4,
      color: colors[i % colors.length],
      spin: (Math.random() - 0.5) * 0.35,
    });
  }
}

export function shards(at: Point, count: number, color: string): void {
  for (let i = 0; i < count; i++) {
    const angle = -Math.PI / 2 + (Math.random() - 0.5) * 2.4;
    const speed = 1.4 + Math.random() * 2.6;
    add({ kind: 'shard', x: at.x, y: at.y, vx: Math.cos(angle) * speed, vy: Math.sin(angle) * speed, gravity: 0.22, life: 460, size: 4 + Math.random() * 3, color, spin: 0.3 });
  }
}

export function ring(at: Point, size: number, color = '#F2B807', delay = 0): void {
  add({ kind: 'ring', x: at.x, y: at.y, life: 420, size, color, delay });
}
