import back from './assets/cards/back.webp';
import c3s from './assets/cards/3s.webp';
import c3c from './assets/cards/3c.webp';
import c3d from './assets/cards/3d.webp';
import c3h from './assets/cards/3h.webp';
import c4s from './assets/cards/4s.webp';
import c4c from './assets/cards/4c.webp';
import c4d from './assets/cards/4d.webp';
import c4h from './assets/cards/4h.webp';
import c5s from './assets/cards/5s.webp';
import c5c from './assets/cards/5c.webp';
import c5d from './assets/cards/5d.webp';
import c5h from './assets/cards/5h.webp';
import c6s from './assets/cards/6s.webp';
import c6c from './assets/cards/6c.webp';
import c6d from './assets/cards/6d.webp';
import c6h from './assets/cards/6h.webp';
import c7s from './assets/cards/7s.webp';
import c7c from './assets/cards/7c.webp';
import c7d from './assets/cards/7d.webp';
import c7h from './assets/cards/7h.webp';
import c8s from './assets/cards/8s.webp';
import c8c from './assets/cards/8c.webp';
import c8d from './assets/cards/8d.webp';
import c8h from './assets/cards/8h.webp';
import c9s from './assets/cards/9s.webp';
import c9c from './assets/cards/9c.webp';
import c9d from './assets/cards/9d.webp';
import c9h from './assets/cards/9h.webp';
import c10s from './assets/cards/10s.webp';
import c10c from './assets/cards/10c.webp';
import c10d from './assets/cards/10d.webp';
import c10h from './assets/cards/10h.webp';
import cjs from './assets/cards/js.webp';
import cjc from './assets/cards/jc.webp';
import cjd from './assets/cards/jd.webp';
import cjh from './assets/cards/jh.webp';
import cqs from './assets/cards/qs.webp';
import cqc from './assets/cards/qc.webp';
import cqd from './assets/cards/qd.webp';
import cqh from './assets/cards/qh.webp';
import cks from './assets/cards/ks.webp';
import ckc from './assets/cards/kc.webp';
import ckd from './assets/cards/kd.webp';
import ckh from './assets/cards/kh.webp';
import cas from './assets/cards/as.webp';
import cac from './assets/cards/ac.webp';
import cad from './assets/cards/ad.webp';
import cah from './assets/cards/ah.webp';
import c2s from './assets/cards/2s.webp';
import c2c from './assets/cards/2c.webp';
import c2d from './assets/cards/2d.webp';
import c2h from './assets/cards/2h.webp';
import reactionLike from '../caro/assets/reactions/like.webp';
import reactionLove from '../caro/assets/reactions/love.webp';
import reactionHaha from '../caro/assets/reactions/haha.webp';
import reactionWow from '../caro/assets/reactions/wow.webp';
import reactionSad from '../caro/assets/reactions/sad.webp';
import reactionAngry from '../caro/assets/reactions/angry.webp';

export const CARD_BACK = back;

// Thứ tự khớp mã bài wire: card = rank*4 + suit, suit ♠♣♦♥.
const CARD_FACES = [
  c3s, c3c, c3d, c3h,
  c4s, c4c, c4d, c4h,
  c5s, c5c, c5d, c5h,
  c6s, c6c, c6d, c6h,
  c7s, c7c, c7d, c7h,
  c8s, c8c, c8d, c8h,
  c9s, c9c, c9d, c9h,
  c10s, c10c, c10d, c10h,
  cjs, cjc, cjd, cjh,
  cqs, cqc, cqd, cqh,
  cks, ckc, ckd, ckh,
  cas, cac, cad, cah,
  c2s, c2c, c2d, c2h,
] as const;

export function cardAsset(card: number): string {
  return CARD_FACES[card] ?? CARD_BACK;
}

export const REACTION_ASSETS = {
  LIKE: reactionLike,
  LOVE: reactionLove,
  HAHA: reactionHaha,
  WOW: reactionWow,
  SAD: reactionSad,
  ANGRY: reactionAngry,
} as const;

export type ReactionKey = keyof typeof REACTION_ASSETS;

export function preloadCardAssets(onProgress?: (loaded: number, total: number) => void): Promise<void> {
  const urls = [...CARD_FACES, CARD_BACK, ...Object.values(REACTION_ASSETS)];
  let loaded = 0;
  return new Promise((resolve) => {
    const done = (): void => {
      loaded += 1;
      onProgress?.(loaded, urls.length);
      if (loaded >= urls.length) resolve();
    };
    for (const url of urls) {
      const img = new Image();
      img.onload = done;
      img.onerror = done;
      img.src = url;
    }
  });
}
