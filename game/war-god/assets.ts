import { Assets, Texture } from 'pixi.js';
import bg from './assets/bg.png';
import boardFrame from './assets/board/frame.png';
import boardCell from './assets/board/cell.png';
import itemSword from './assets/items/sword.png';
import itemFire from './assets/items/fire.png';
import itemHeart from './assets/items/heart.png';
import itemWater from './assets/items/water.png';
import itemShield from './assets/items/shield.png';
import itemStone from './assets/items/stone.png';
import cardBorderActive from './assets/hud/card-border-active.png';
import cardBorderIdle from './assets/hud/card-border-idle.png';
import ringActive from './assets/hud/ring-active.png';
import ringIdle from './assets/hud/ring-idle.png';
import rankFrame from './assets/hud/rank-frame.png';
import ultLeftOn from './assets/hud/ult-left-on.png';
import ultLeftOff from './assets/hud/ult-left-off.png';
import ultRightOn from './assets/hud/ult-right-on.png';
import ultRightOff from './assets/hud/ult-right-off.png';
import flameOn from './assets/hud/flame-on.png';
import flameOff from './assets/hud/flame-off.png';
import icHp from './assets/hud/ic-hp.png';
import icMp from './assets/hud/ic-mp.png';
import turnBanner from './assets/hud/turn-banner.png';
import noteStrip from './assets/hud/note-strip.png';
import menuBtnBlue from './assets/menu/btn-blue.png';
import menuIcRestart from './assets/menu/ic-restart.png';
import menuIcForfeit from './assets/menu/ic-forfeit.png';
import menuIcExit from './assets/menu/ic-exit.png';
import chatFrame from './assets/chat/frame.png';
import chatInput from './assets/chat/input.png';
import chatBtnSend from './assets/chat/btn-send.png';
import chatIcSmiley from './assets/chat/ic-smiley.png';
import fxUlt from './assets/fx/ult.png';

export const A = {
  bg,
  board: { frame: boardFrame, cell: boardCell },
  items: {
    sword: itemSword,
    fire: itemFire,
    heart: itemHeart,
    water: itemWater,
    shield: itemShield,
    stone: itemStone,
  },
  hud: {
    cardBorderActive,
    cardBorderIdle,
    ringActive,
    ringIdle,
    rankFrame,
    ultLeftOn,
    ultLeftOff,
    ultRightOn,
    ultRightOff,
    flameOn,
    flameOff,
    icHp,
    icMp,
    turnBanner,
    noteStrip,
  },
  menu: {
    btnBlue: menuBtnBlue,
    icRestart: menuIcRestart,
    icForfeit: menuIcForfeit,
    icExit: menuIcExit,
  },
  chat: {
    frame: chatFrame,
    input: chatInput,
    btnSend: chatBtnSend,
    icSmiley: chatIcSmiley,
  },
  fx: { ult: fxUlt },
} as const;

function collectUrls(node: unknown): string[] {
  if (typeof node === 'string') return [node];
  return Object.values(node as Record<string, unknown>).flatMap(collectUrls);
}

export const tex: Record<string, Texture> = {};

export async function loadAssets(): Promise<void> {
  const loaded: Record<string, Texture> = await Assets.load(collectUrls(A));
  Object.assign(tex, loaded);
  for (const t of Object.values(tex)) {
    t.source.autoGenerateMipmaps = true;
  }
}
