import { BOARD_SIZE, JAIL_TILE } from '../logic/constants';
import { seatColor, SEAT_TINTS } from '../helpers/player';
import { pawnLayout, type PawnSpot } from '../helpers/pawnLayout';
import { tileCenter } from '../helpers/boardGeometry';
import { playSound } from '../audio';
import { coinFlight, coinFountain, confettiBurst, confettiRain, dust, ring, shards, sparks } from './particles';
import { animate, boardCenter, boardUnit, byId, centerOf, pawnEl, pawnFoot, podEl, reducedMotion, scaled, seatPoint, sleep, tileEl, tilePoint, type Point } from './runtime';
import charUrls from './charArt';
import { houseArt } from '../components/art';
import { MAX_HOUSES } from '../logic/constants';

const EASE_UP = 'cubic-bezier(.33,.66,.66,1)';
const EASE_DOWN = 'cubic-bezier(.33,0,.66,.34)';

function setMoving(pawn: HTMLElement | null, on: boolean): void {
  pawn?.toggleAttribute('data-moving', on);
}

export function clearMovingPawns(): void {
  document.querySelectorAll('[data-pawn][data-moving]').forEach((pawn) => pawn.removeAttribute('data-moving'));
}

function shakeBoard(amount: number): void {
  animate(
    byId('ty-s6-board'),
    [0, 1, 2, 3, 4, 5].map((i) => ({ transform: i === 5 ? 'none' : `translate(${(i % 2 ? -1 : 1) * amount}px,${(i % 2 ? 1 : -1) * amount * 0.5}px)` })),
    { duration: 240, easing: 'linear' },
  );
}

function vignette(tint: string, opacity: number, duration: number): void {
  const el = byId('ty-s6-vignette');
  el?.style.setProperty('--tint', tint);
  animate(el, [{ opacity: 0 }, { opacity, offset: 0.3 }, { opacity: 0 }], { duration, easing: 'ease-out' });
}

async function sweepBanner(text: string, tone: 'gold' | 'danger', duration: number): Promise<void> {
  const el = byId('ty-s6-banner');
  if (!el || reducedMotion()) return;
  el.className = `ty-s6-banner ty-s6-banner-${tone}`;
  el.textContent = text;
  el.hidden = false;
  await animate(
    el,
    [
      { transform: 'translate(-50%,-50%) translateX(-120%) skewX(-10deg)', opacity: 0 },
      { transform: 'translate(-50%,-50%) translateX(4%) skewX(-3deg)', opacity: 1, offset: 0.22 },
      { transform: 'translate(-50%,-50%) translateX(0) skewX(0)', opacity: 1, offset: 0.3 },
      { transform: 'translate(-50%,-50%) translateX(0) skewX(0)', opacity: 1, offset: 0.8 },
      { transform: 'translate(-50%,-50%) translateX(120%) skewX(10deg)', opacity: 0 },
    ],
    { duration, easing: 'cubic-bezier(.3,.8,.3,1)' },
  );
  el.hidden = true;
}

function popBust(pose: keyof typeof charUrls, seat: number, duration = 900): void {
  const el = byId('ty-s6-bust') as HTMLImageElement | null;
  if (!el || reducedMotion()) return;
  const at = seatPoint(seat);
  el.src = charUrls[pose];
  el.style.setProperty('--seat', seat >= 0 ? seatColor(seat) : 'var(--ty-navy)');
  el.style.left = `${Math.min(Math.max(at.x, 48), innerWidth - 48)}px`;
  el.style.top = `${at.y - 36}px`;
  el.hidden = false;
  void animate(
    el,
    [
      { transform: 'translate(-50%,-30%) scale(.3)', opacity: 0 },
      { transform: 'translate(-50%,-62%) scale(1.1)', opacity: 1, offset: 0.2 },
      { transform: 'translate(-50%,-56%) scale(1)', opacity: 1, offset: 0.3 },
      { transform: 'translate(-50%,-56%) scale(1)', opacity: 1, offset: 0.82 },
      { transform: 'translate(-50%,-30%) scale(.5)', opacity: 0 },
    ],
    { duration, easing: 'ease-out' },
  ).then(() => {
    el.hidden = true;
  });
}

function pulseSeat(seat: number, color: string, duration = 520): void {
  animate(podEl(seat), [{ boxShadow: `0 0 0 0 ${color}` }, { boxShadow: `0 0 0 6px ${color}`, offset: 0.4 }, { boxShadow: '0 0 0 0 transparent' }], { duration, easing: 'ease-out' });
}

// --- Xúc xắc ---

function diceWraps(): HTMLElement[] {
  return Array.from(document.querySelectorAll<HTMLElement>('[data-die]'));
}

export async function rollDice(values: [number, number]): Promise<void> {
  const wraps = diceWraps();
  const unit = boardUnit();
  const faces = wraps.map((wrap) => wrap.querySelector<HTMLElement>('[data-face]'));
  playSound('shake');
  const spin = reducedMotion()
    ? 0
    : setInterval(() => faces.forEach((face) => face && (face.dataset.face = String(1 + Math.floor(Math.random() * 6)))), scaled(70));
  setTimeout(() => playSound('roll'), scaled(260));
  await Promise.all(
    wraps.map((wrap, index) => {
      const dir = index ? 1 : -1;
      return animate(
        wrap,
        [
          { transform: `translate(${dir * unit * 8}px,${unit * 3}px) rotate(${dir * -90}deg)` },
          { transform: `translate(${dir * unit * 4}px,${-unit * 12}px) rotate(${dir * -45}deg) scale(1.2)`, offset: 0.34 },
          { transform: 'translate(0,0) rotate(0deg) scale(1.18,.82)', offset: 0.6 },
          { transform: `translate(0,${-unit * 3.5}px) scale(1.04)`, offset: 0.76 },
          { transform: 'translate(0,0) scale(1.1,.9)', offset: 0.9 },
          { transform: 'none' },
        ],
        { duration: 600, delay: index * 70, easing: 'cubic-bezier(.2,.75,.3,1)' },
      );
    }),
  );
  if (spin) clearInterval(spin);
  faces.forEach((face, index) => face && (face.dataset.face = String(values[index])));
  wraps.forEach((wrap) => dust({ x: centerOf(wrap).x, y: wrap.getBoundingClientRect().bottom }, 5));
}

export async function revealDiceTotal(double: boolean): Promise<void> {
  const total = byId('ty-s6-dice-total');
  if (double) {
    playSound('double');
    diceWraps().forEach((wrap) => sparks(centerOf(wrap), 10, '#F7C531', 3.6));
    const dice = byId('ty-s6-dice');
    if (dice) ring(centerOf(dice), boardUnit() * 20, '#F7C531');
  }
  animate(
    total,
    [
      { transform: 'translateY(-50%) scale(.2)', opacity: 0 },
      { transform: 'translateY(-50%) scale(1.3)', opacity: 1, offset: 0.6 },
      { transform: 'translateY(-50%) scale(1)', opacity: 1 },
    ],
    { duration: 240, easing: 'cubic-bezier(.22,1.2,.36,1)' },
  );
  await sleep(double ? 460 : 300);
}

// --- Quân cờ ---

export interface WalkOptions {
  seat: number;
  from: number;
  count: number;
  positions: number[];
  bankrupt: boolean[];
  turn: number;
  commit: () => void;
  alive: () => boolean;
}

function hopDurations(count: number): number[] {
  const base = count > 7 ? 112 : count > 4 ? 124 : 140;
  return Array.from({ length: count }, (_, i) => {
    if (i === 0) return Math.round(base * 1.2);
    if (i === count - 1) return Math.round(base * 1.3);
    if (i === count - 2 && count > 2) return Math.round(base * 1.1);
    return base;
  });
}

function fireLanding(tile: number): void {
  const el = tileEl(tile);
  playSound('hop');
  animate(el?.querySelector('[data-trail]'), [{ opacity: 0.8 }, { opacity: 0 }], { duration: 560, easing: 'ease-out' });
  if (tile % 8 === 0) {
    animate(el?.querySelector('[data-fig]'), [{ transform: 'scale(1)' }, { transform: 'scale(1.22)', offset: 0.4 }, { transform: 'scale(1)' }], { duration: 340, easing: 'cubic-bezier(.3,1.5,.5,1)' });
  }
}

// Cả quãng đường là một animation liền, không ghép từng bước, để không có khoảng hở giữa các ô.
export async function walkPawn({ seat, from, count, positions, bankrupt, turn, commit, alive }: WalkOptions): Promise<void> {
  const pawn = pawnEl(seat);
  const to = (from + count) % BOARD_SIZE;
  const start: PawnSpot | undefined = pawnLayout(positions, bankrupt, turn)[seat];
  const landing = [...positions];
  landing[seat] = to;
  const end: PawnSpot | undefined = pawnLayout(landing, bankrupt, turn)[seat];
  const parent = pawn?.offsetParent as HTMLElement | null;
  if (reducedMotion() || count <= 0 || !pawn || !parent || !start || !end) {
    commit();
    return;
  }
  setMoving(pawn, true);
  const move = pawn.querySelector('[data-pawn-move]')!;
  const body = pawn.querySelector('[data-pawn-body]')!;
  const shadow = pawn.querySelector('[data-pawn-shadow]')!;
  const unit = boardUnit();
  const perX = parent.clientWidth / 100;
  const perY = parent.clientHeight / 100;
  const hopHeight = unit * (count > 7 ? 3.4 : 4.4);
  const tail = scaled(160);
  const durations = hopDurations(count).map(scaled);
  const times = [0];
  durations.forEach((duration) => times.push(times[times.length - 1] + duration));
  const total = times[count];
  const full = total + tail;

  const points: Point[] = [{ x: 0, y: 0 }];
  for (let i = 1; i < count; i++) {
    const center = tileCenter((from + i) % BOARD_SIZE);
    points.push({ x: (center.x - start.x) * perX, y: (center.y - start.y) * perY });
  }
  points.push({ x: (end.x - start.x) * perX, y: (end.y - start.y) * perY });
  const moveFrames: Keyframe[] = points.map((point, i) => ({ transform: `translate(${point.x.toFixed(2)}px,${point.y.toFixed(2)}px)`, offset: times[i] / total, easing: 'linear' }));

  const bodyFrames: Keyframe[] = [];
  const shadowFrames: Keyframe[] = [];
  for (let i = 0; i < count; i++) {
    const ground = times[i];
    const apex = ground + durations[i] / 2;
    bodyFrames.push({ transform: `translateY(0) scale(${i === 0 ? '1.08,.92' : '1,1'})`, offset: ground / full, easing: EASE_UP });
    bodyFrames.push({ transform: `translateY(${(-hopHeight).toFixed(2)}px) scale(.97,1.05)`, offset: apex / full, easing: EASE_DOWN });
    shadowFrames.push({ transform: 'translateX(-50%) scale(1)', opacity: 1, offset: ground / full, easing: EASE_UP });
    shadowFrames.push({ transform: 'translateX(-50%) scale(.62)', opacity: 0.45, offset: apex / full, easing: EASE_DOWN });
  }
  bodyFrames.push({ transform: 'translateY(0) scale(1.16,.84)', offset: total / full, easing: 'cubic-bezier(.3,.7,.4,1)' });
  bodyFrames.push({ transform: 'translateY(0) scale(.96,1.05)', offset: (total + tail * 0.55) / full, easing: 'ease-out' });
  bodyFrames.push({ transform: 'translateY(0) scale(1,1)', offset: 1 });
  shadowFrames.push({ transform: 'translateX(-50%) scale(1.12)', opacity: 1, offset: total / full, easing: 'ease-out' });
  shadowFrames.push({ transform: 'translateX(-50%) scale(1)', opacity: 1, offset: 1 });

  const moving = move.animate(moveFrames, { duration: total, fill: 'forwards' });
  const hopping = body.animate(bodyFrames, { duration: full });
  const shadowing = shadow.animate(shadowFrames, { duration: full });
  let next = 1;
  const watch = () => {
    const now = Number(moving.currentTime ?? 0);
    while (next <= count && now >= times[next] - 8) fireLanding((from + next++) % BOARD_SIZE);
    if (next <= count && moving.playState === 'running') requestAnimationFrame(watch);
  };
  requestAnimationFrame(watch);
  await Promise.all([moving, hopping, shadowing].map((item) => item.finished.catch(() => undefined)));
  if (!alive()) return;
  commit();
  moving.cancel();
  dust(pawnFoot(seat), 4);
}

export async function flyPawn(seat: number, color: string, commit: () => void): Promise<void> {
  const pawn = pawnEl(seat);
  if (!pawn || reducedMotion()) {
    commit();
    return;
  }
  const unit = boardUnit();
  const before = pawn.getBoundingClientRect();
  setMoving(pawn, true);
  commit();
  const after = pawn.getBoundingClientRect();
  const duration = 640;
  animate(pawn.querySelector('[data-pawn-shadow]'), [{ opacity: 1 }, { opacity: 0.2, offset: 0.5 }, { opacity: 1 }], { duration });
  animate(pawn.querySelector('[data-pawn-move]'), [{ transform: `translate(${before.left - after.left}px,${before.top - after.top}px)` }, { transform: 'translate(0,0)' }], { duration, easing: 'cubic-bezier(.45,.05,.55,.95)' });
  const trail = setInterval(() => sparks(pawnFoot(seat), 1, color, 1.2), 90);
  await animate(
    pawn.querySelector('[data-pawn-body]'),
    [
      { transform: 'translateY(0) scale(1)', easing: EASE_UP },
      { transform: `translateY(${-unit * 15}px) scale(1.3)`, offset: 0.48, easing: EASE_DOWN },
      { transform: 'translateY(0) scale(1.16,.84)', offset: 0.88, easing: 'ease-out' },
      { transform: 'translateY(0) scale(1)' },
    ],
    { duration },
  );
  clearInterval(trail);
  setMoving(pawn, false);
  dust(pawnFoot(seat), 7);
  const tile = pawn.dataset.pawnTile;
  if (tile != null) ring(tilePoint(Number(tile)), unit * 11, color);
}

export function policeWhistle(seat: number): void {
  playSound('whistle');
  vignette('#E4573D', 0.3, 420);
  popBust('canh-point', seat, 800);
}

export function landOnTile(tile: number, by: number, owner: number): void {
  const el = tileEl(tile);
  playSound('land');
  ring(tilePoint(tile), boardUnit() * 12);
  animate(el, [{ transform: 'scale(1)' }, { transform: 'scale(1.2)', offset: 0.4 }, { transform: 'scale(.97)', offset: 0.75 }, { transform: 'scale(1)' }], { duration: 300, easing: 'ease-out' });
  setMoving(pawnEl(by), false);
  if (owner >= 0 && owner !== by) pulseSeat(owner, seatColor(owner));
}

// --- Tiền ---

export interface PayFx {
  from: number;
  to: number;
  amount: number;
  reason?: string;
  tile?: number;
  debit: () => void;
  credit: () => void;
}

const POSE_FOR_REASON = new Set(['tax', 'fine', 'repair']);

export async function payMoney({ from, to, amount, reason, tile, debit, credit }: PayFx): Promise<void> {
  const big = amount >= 500;
  const start = from >= 0 ? seatPoint(from) : reason === 'salary' ? tilePoint(0) : tile != null ? tilePoint(tile) : boardCenter();
  const end = to >= 0 ? seatPoint(to) : tile != null ? tilePoint(tile) : boardCenter();
  if (reason === 'salary') {
    coinFountain(start, 8);
    ring(start, boardUnit() * 13);
    animate(tileEl(0), [{ filter: 'brightness(1)' }, { filter: 'brightness(1.3) saturate(1.4)', offset: 0.3 }, { filter: 'brightness(1)' }], { duration: 520 });
    await sleep(140);
  }
  coinFlight(start, end, Math.min(12, 5 + Math.floor(amount / 60)));
  playSound('coin');
  const clink = setInterval(() => playSound('coin'), 170);
  setTimeout(() => clearInterval(clink), 480);
  if (from >= 0) {
    debit();
    animate(podEl(from), [-3, 3, -3, 2, -1, 0].map((px) => ({ transform: `translateX(${px}px)` })), { duration: 260, easing: 'linear' });
    if (big) sparks(seatPoint(from), 8, '#E4573D');
  }
  if (reason && POSE_FOR_REASON.has(reason)) popBust('ngan-point', from >= 0 ? from : to, 800);
  await sleep(330);
  if (to >= 0) {
    credit();
    animate(podEl(to), [{ transform: 'translateY(0)' }, { transform: 'translateY(-5px) scale(1.04)', offset: 0.4 }, { transform: 'translateY(0)' }], { duration: 300, easing: 'ease-out' });
  } else if (from < 0) {
    credit();
  }
  await sleep(300);
}

// --- Đất và nhà ---

export async function stampDeed(tile: number, seat: number, commit: () => void, fullGroup: number[] | null): Promise<void> {
  const el = tileEl(tile);
  const at = tilePoint(tile);
  const unit = boardUnit();
  await animate(el, [{ transform: 'scaleX(1)' }, { transform: 'scaleX(0)' }], { duration: 120, easing: 'cubic-bezier(.5,0,.9,.5)' });
  commit();
  playSound('stamp');
  await animate(el, [{ transform: 'scale(0,1.3)', zIndex: 8 }, { transform: 'scale(1.3,1.3)', zIndex: 8, offset: 0.5 }, { transform: 'scale(1)', zIndex: 8 }], { duration: 220, easing: 'cubic-bezier(.22,1.2,.36,1)' });
  animate(el?.querySelector('[data-owner-dot]'), [{ transform: 'translateY(-220%)', opacity: 0 }, { transform: 'translateY(15%)', opacity: 1, offset: 0.7 }, { transform: 'none', opacity: 1 }], { duration: 260, easing: 'cubic-bezier(.22,1.2,.36,1)' });
  ring(at, unit * 12, seatColor(seat));
  confettiBurst(at, 18, [seatColor(seat), '#F7C531', '#FFFFFF']);
  if (fullGroup) {
    playSound('fanfare');
    shakeBoard(unit * 0.6);
    void sweepBanner('TRỌN NHÓM!', 'gold', 1000);
    fullGroup.forEach((idx, i) => {
      setTimeout(() => {
        animate(tileEl(idx), [0, 1, 2, 3, 4, 5].map((n) => ({ filter: n % 2 ? 'brightness(1.4)' : 'brightness(1)' })), { duration: 480, easing: 'cubic-bezier(.22,1.2,.36,1)' });
        confettiBurst(tilePoint(idx), 14, [seatColor(seat), '#F7C531']);
      }, scaled(i * 90));
    });
    await sleep(520);
  }
  await sleep(220);
}

function tileCallout(tile: number, seat: number, title: string, from: number, to: number): void {
  const host = document.querySelector('.ty-board-screen');
  const at = tilePoint(tile);
  if (!host) return;
  const tag = document.createElement('div');
  tag.className = `ty-s6-callout ${to < from ? 'ty-s6-callout-down' : ''}`;
  tag.style.left = `${at.x}px`;
  tag.style.top = `${at.y}px`;
  tag.style.setProperty('--seat', seatColor(seat));
  const art = houseArt(Math.max(from, to));
  if (art) {
    const img = document.createElement('img');
    img.src = art;
    img.alt = '';
    tag.append(img);
  }
  const label = document.createElement('span');
  label.textContent = title;
  const levels = document.createElement('b');
  levels.textContent = `Lv${from} → Lv${to}`;
  tag.append(label, levels);
  host.append(tag);
  const hold = Math.max(700, scaled(1300));
  const remove = () => tag.remove();
  if (reducedMotion()) {
    setTimeout(remove, hold);
    return;
  }
  tag
    .animate(
      [
        { transform: 'translate(-50%, -40%) scale(.6)', opacity: 0 },
        { transform: 'translate(-50%, -115%) scale(1.06)', opacity: 1, offset: 0.12 },
        { transform: 'translate(-50%, -110%) scale(1)', opacity: 1, offset: 0.2 },
        { transform: 'translate(-50%, -118%) scale(1)', opacity: 1, offset: 0.85 },
        { transform: 'translate(-50%, -150%) scale(.96)', opacity: 0 },
      ],
      { duration: hold, easing: 'cubic-bezier(.22,1,.36,1)' },
    )
    .finished.then(remove, remove);
}

export async function buildHouse(tile: number, houses: number, seat: number, levelUp?: { from: number; to: number }): Promise<void> {
  const hotel = houses >= MAX_HOUSES;
  const el = tileEl(tile);
  const at = tilePoint(tile);
  const unit = boardUnit();
  playSound(hotel ? 'double' : 'pop');
  if (levelUp) tileCallout(tile, seat, 'Nâng cấp', levelUp.from, levelUp.to);
  dust({ x: at.x, y: at.y + unit }, 7);
  sparks(at, hotel ? 10 : 3, hotel ? '#E4573D' : '#2FA86F', 2.6);
  await animate(
    el?.querySelector('[data-houses]')?.lastElementChild,
    [
      { transform: `translateY(${-unit * 7}px) scaleY(.4)`, opacity: 0, easing: 'cubic-bezier(.6,0,.9,.5)' },
      { transform: 'translateY(0) scale(1.3,.7)', opacity: 1, offset: 0.55 },
      { transform: 'translateY(0) scale(.9,1.2)', offset: 0.78 },
      { transform: 'translateY(0) scale(1)' },
    ],
    { duration: 300, easing: 'cubic-bezier(.22,1.2,.36,1)' },
  );
  if (hotel) {
    shakeBoard(unit * 0.6);
    ring(at, unit * 16, '#F7C531');
  }
}

export async function sellHouse(tile: number, seat: number, houses: number): Promise<void> {
  const at = tilePoint(tile);
  tileCallout(tile, seat, 'Hạ cấp', houses + 1, houses);
  shards(at, 6, '#2FA86F');
  coinFlight(at, seatPoint(seat), 3);
  playSound('crack');
  await sleep(260);
}

export async function celebrateFestival(tile: number): Promise<void> {
  const at = tilePoint(tile);
  const unit = boardUnit();
  playSound('fanfare');
  ring(tilePoint(16), unit * 12, '#FFD34D');
  [0, 160, 340].forEach((delay, i) => {
    setTimeout(() => {
      const spot = { x: at.x + (i - 1) * unit * 3, y: at.y - i * unit };
      sparks(spot, 12, ['#FFD34D', '#E4573D', '#39ABEF'][i], 3.6);
      ring(spot, unit * 8, '#FFD34D');
    }, delay);
  });
  confettiBurst(at, 16, ['#FFD34D', '#E4573D', '#FFFFFF']);
  animate(tileEl(tile), [{ transform: 'scale(1)' }, { transform: 'scale(1.3)', offset: 0.35 }, { transform: 'scale(1)' }], { duration: 480, easing: 'cubic-bezier(.3,1.5,.5,1)' });
  await sleep(520);
}

export async function travelWiggle(): Promise<void> {
  animate(tileEl(24)?.querySelector('[data-fig]'), [{ transform: 'translateY(0)' }, { transform: 'translateY(-14%) rotate(-8deg)', offset: 0.4 }, { transform: 'translateY(0)' }], { duration: 420, easing: 'ease-out' });
  await sleep(300);
}

// --- Thẻ ---

function deckEl(deck: 'chance' | 'chest'): HTMLElement | null {
  return byId(`ty-s6-deck-${deck}`);
}

export async function shakeDeck(deck: 'chance' | 'chest'): Promise<void> {
  playSound('card');
  await animate(deckEl(deck), [-2, 2, -2, 2, 0].map((deg) => ({ transform: `rotate(${deg}deg)` })), { duration: 200, easing: 'linear' });
}

export async function flyCardIn(deck: 'chance' | 'chest'): Promise<void> {
  const box = byId('ty-s6-cardbox');
  const card = box?.querySelector('[data-card]');
  const origin = deckEl(deck);
  if (!box || !card || !origin) return;
  const from = origin.getBoundingClientRect();
  const to = box.getBoundingClientRect();
  await animate(
    card,
    [
      { transform: `translate(${from.left + from.width / 2 - (to.left + to.width / 2)}px,${from.top + from.height / 2 - (to.top + to.height / 2)}px) scale(${from.width / to.width}) rotateY(180deg)`, easing: 'cubic-bezier(.3,.7,.3,1)' },
      { transform: 'translate(0,-3%) scale(1.04) rotateY(180deg)', offset: 0.42, easing: 'cubic-bezier(.5,0,.3,1)' },
      { transform: 'translate(0,0) scale(1) rotateY(0deg)' },
    ],
    { duration: 640 },
  );
  sparks(centerOf(box), 8, deck === 'chance' ? '#F2772E' : '#39ABEF', 3.2);
}

export async function flyCardBack(deck: 'chance' | 'chest'): Promise<void> {
  const box = byId('ty-s6-cardbox');
  const origin = deckEl(deck);
  if (!box || !origin) return;
  const from = box.getBoundingClientRect();
  const to = origin.getBoundingClientRect();
  await animate(
    box.querySelector('[data-card]'),
    [
      { transform: 'translate(0,0) scale(1)', opacity: 1 },
      { transform: `translate(${to.left + to.width / 2 - (from.left + from.width / 2)}px,${to.top + to.height / 2 - (from.top + from.height / 2)}px) scale(.22)`, opacity: 0.2 },
    ],
    { duration: 280, easing: 'cubic-bezier(.5,0,.8,.6)', fill: 'forwards' },
  );
}

// --- Tù, phá sản ---

export async function jailDoorClose(seat: number): Promise<void> {
  playSound('bars');
  await animate(byId('ty-s6-bars'), [{ transform: 'scaleY(0)' }, { transform: 'scaleY(1.06)', offset: 0.7 }, { transform: 'scaleY(1)' }], { duration: 260, easing: 'cubic-bezier(.6,0,.9,.6)' });
  shakeBoard(boardUnit() * 0.7);
  dust(tilePoint(JAIL_TILE), 8);
  popBust('teo-sad', seat, 900);
  await sleep(320);
}

export async function jailDoorOpen(): Promise<void> {
  playSound('pop');
  await animate(byId('ty-s6-bars'), [{ transform: 'scaleY(1)' }, { transform: 'scaleY(0)' }], { duration: 240, easing: 'ease-in' });
}

export async function bankruptSeat(seat: number, name: string, tiles: number[]): Promise<void> {
  const pod = podEl(seat);
  const pawn = pawnEl(seat);
  const unit = boardUnit();
  playSound('crack');
  vignette('#1F2A44', 0.34, 1100);
  shakeBoard(unit * 0.9);
  shards(seatPoint(seat), 12, seatColor(seat));
  animate(pod, [-5, 5, -4, 4, -2, 0].map((px) => ({ transform: `translateX(${px}px)` })), { duration: 340, easing: 'linear' });
  animate(pod?.querySelector('[data-crack]'), [{ opacity: 0 }, { opacity: 1 }], { duration: 300, fill: 'forwards' });
  void sweepBanner(`${name.toUpperCase()} PHÁ SẢN`, 'danger', 1200);
  popBust('loc-sad', seat, 1100);
  await animate(
    pawn?.querySelector('[data-pawn-body]'),
    [
      { transform: 'translateY(0) rotate(0)', opacity: 1, easing: 'ease-out' },
      { transform: `translateY(${-unit * 3}px) rotate(-14deg)`, opacity: 1, offset: 0.25, easing: 'ease-in' },
      { transform: `translateY(${unit * 12}px) rotate(92deg)`, opacity: 0 },
    ],
    { duration: 560, fill: 'forwards' },
  );
  tiles.forEach((idx, i) => {
    const el = tileEl(idx);
    setTimeout(() => {
      sparks(tilePoint(idx), 4, seatColor(seat), 2);
      animate(el?.querySelector('[data-owner-dot]'), [{ transform: 'scale(1)' }, { transform: 'scale(1.8)', opacity: 1, offset: 0.5 }, { transform: 'scale(0)', opacity: 0 }], { duration: 240 });
      animate(el, [{ filter: 'grayscale(0)' }, { filter: 'grayscale(1)', offset: 0.5 }, { filter: 'grayscale(0)' }], { duration: 420 });
    }, i * 55);
  });
  await sleep(520 + tiles.length * 40);
}

export function debtAlarm(seat: number): void {
  animate(podEl(seat), [0, 1, 2, 3].map((i) => ({ boxShadow: i % 2 ? '0 0 0 5px #E4573D' : '0 0 0 0 #E4573D' })), { duration: 640 });
}

// --- Vòng, lượt, kết ván ---

export function flipRound(final: boolean): void {
  animate(byId('ty-s6-round'), [{ transform: 'rotateX(90deg)', opacity: 0 }, { transform: 'rotateX(0)', opacity: 1 }], { duration: 260, easing: 'ease-out' });
  if (!final) return;
  void sweepBanner('VÒNG CUỐI!', 'gold', 1100);
  animate(byId('ty-s6-board'), [0, 1, 2, 3, 4, 5, 6].map((i) => ({ boxShadow: i % 2 ? '0 0 0 5px #FFD34D' : '0 0 0 0 #FFD34D' })), { duration: 1000 });
}

export interface TurnBanner {
  seat: number;
  mine: boolean;
  name: string;
  avatar?: string;
  tip?: string;
}

export async function showTurnBanner({ seat, mine, name, avatar, tip }: TurnBanner): Promise<void> {
  const el = byId('ty-s6-announce');
  if (!el) return;
  el.className = `ty-s6-announce ${mine ? 'ty-s6-announce-me' : ''}`;
  el.style.setProperty('--seat', seatColor(seat));
  el.style.setProperty('--soft', SEAT_TINTS[seat] ?? SEAT_TINTS[0]);
  el.replaceChildren();
  let img: HTMLImageElement | null = null;
  if (avatar) {
    img = document.createElement('img');
    img.src = avatar;
    img.alt = '';
    el.append(img);
  }
  const copy = document.createElement('span');
  const title = document.createElement('b');
  title.textContent = mine ? 'ĐẾN LƯỢT BẠN' : `LƯỢT CỦA ${name.toUpperCase()}`;
  copy.append(title);
  if (mine && tip) {
    const note = document.createElement('small');
    note.textContent = tip;
    copy.append(note);
  }
  el.append(copy);
  el.hidden = false;
  if (reducedMotion()) {
    await sleep(mine ? 900 : 500);
    el.hidden = true;
    return;
  }
  if (mine) {
    playSound('turn');
    animate(podEl(seat), [{ boxShadow: '0 0 0 0 #FFD34D' }, { boxShadow: '0 0 0 8px #FFD34D', offset: 0.35 }, { boxShadow: '0 0 0 2px #1F2A44' }], { duration: 760, easing: 'ease-out' });
  }
  animate(img, [{ transform: 'scale(.4) rotate(-20deg)' }, { transform: 'scale(1.12) rotate(4deg)', offset: 0.6 }, { transform: 'scale(1) rotate(0)' }], { duration: 360, delay: 110, easing: 'ease-out', fill: 'backwards' });
  await animate(
    el,
    [
      { transform: 'translateY(-50%) translateX(-102%)', easing: 'cubic-bezier(.16,1,.3,1)' },
      { transform: 'translateY(-50%) translateX(0)', offset: 0.3 },
      { transform: 'translateY(-50%) translateX(0)', offset: 0.82, easing: 'cubic-bezier(.7,0,.84,0)' },
      { transform: 'translateY(-50%) translateX(102%)' },
    ],
    { duration: mine ? 1250 : 800 },
  );
  el.hidden = true;
}

export function celebrateResult(won: boolean, winnerSeat: number): void {
  playSound('fanfare');
  confettiRain([seatColor(winnerSeat), '#FFD34D', '#FFFFFF', '#E4573D', '#39ABEF'], won ? 110 : 60);
}
