import { Assets, Texture } from 'pixi.js';
import bg from './assets/bg.png';
import boardFrame from './assets/board/frame.png';
import boardCell from './assets/board/cell.png';
import boardSelMine from './assets/board/sel-mine.png';
import boardSelFoe from './assets/board/sel-foe.png';
import itemSword from './assets/items/sword.png';
import itemPeach from './assets/items/peach.png';
import itemHeart from './assets/items/heart.png';
import itemWater from './assets/items/water.png';
import itemShield from './assets/items/shield.png';
import itemLightning from './assets/items/lightning.png';
import specialFireSword from './assets/items/fire-sword-v1.png';
import specialGreaterHeart from './assets/items/greater-heart-v1.png';
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
import lobbyBg from './assets/lobby/bg.png';
import lobbyLogo from './assets/lobby/logo.png';
import lobbyAvatarFrame from './assets/lobby/avatar-frame.png';
import lobbyNameFrame from './assets/lobby/name-frame.png';
import lobbyKenFrame from './assets/lobby/ken-frame.png';
import lobbyCoin from './assets/lobby/coin.png';
import lobbyBtnPlus from './assets/lobby/btn-plus.png';
import lobbyIcPlus from './assets/lobby/ic-plus.png';
import lobbyBtnWood from './assets/lobby/btn-wood.png';
import lobbyIcBot from './assets/lobby/ic-bot.png';
import lobbyIcPvp from './assets/lobby/ic-pvp.png';
import lobbyMenuPill from './assets/lobby/menu-pill.png';
import lobbyRing from './assets/lobby/ring.png';
import lobbyIcHistory from './assets/lobby/ic-history.png';
import lobbyIcSoundOn from './assets/lobby/ic-sound-on.png';
import lobbyIcSoundOff from './assets/lobby/ic-sound-off.png';
import lobbyIcGuide from './assets/lobby/ic-guide.png';
import lobbyBtnExit from './assets/lobby/btn-exit.png';
import pickPanel from './assets/pick/panel.png';
import pickTitle from './assets/pick/title.png';
import pickCloseBase from './assets/pick/close-base.png';
import pickCloseX from './assets/pick/close-x.png';
import pickLevelEasy from './assets/pick/level-easy.png';
import pickLevelMid from './assets/pick/level-mid.png';
import pickLevelHard from './assets/pick/level-hard.png';
import confirmPanel from './assets/confirm/panel.png';
import confirmHeader from './assets/confirm/header.png';
import confirmBtnCancel from './assets/confirm/btn-cancel.png';
import confirmBtnOk from './assets/confirm/btn-ok.png';
import resultPanel from './assets/result/panel.webp';
import resultTitleFrame from './assets/result/title-frame.webp';
import resultKenFrame from './assets/result/ken-frame.webp';
import resultCupWin from './assets/result/cup-win.webp';
import resultShieldLose from './assets/result/shield-lose.webp';
import resultBrushWin from './assets/result/brush-win.webp';
import resultBrushLose from './assets/result/brush-lose.webp';
import resultBtnClose from './assets/result/btn-close.webp';
import resultKen from './assets/result/ken.webp';
import serifFontUrl from './assets/fonts/DejaVuSerif-Bold.ttf';
import robotoCondensedUrl from './assets/fonts/RobotoCondensed-VF.ttf';

export const A = {
  bg,
  board: { frame: boardFrame, cell: boardCell, selMine: boardSelMine, selFoe: boardSelFoe },
  items: {
    sword: itemSword,
    peach: itemPeach,
    heart: itemHeart,
    water: itemWater,
    shield: itemShield,
    lightning: itemLightning,
    fireSword: specialFireSword,
    greaterHeart: specialGreaterHeart,
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
  lobby: {
    bg: lobbyBg,
    logo: lobbyLogo,
    avatarFrame: lobbyAvatarFrame,
    nameFrame: lobbyNameFrame,
    kenFrame: lobbyKenFrame,
    coin: lobbyCoin,
    btnPlus: lobbyBtnPlus,
    icPlus: lobbyIcPlus,
    btnWood: lobbyBtnWood,
    icBot: lobbyIcBot,
    icPvp: lobbyIcPvp,
    menuPill: lobbyMenuPill,
    ring: lobbyRing,
    icHistory: lobbyIcHistory,
    icSoundOn: lobbyIcSoundOn,
    icSoundOff: lobbyIcSoundOff,
    icGuide: lobbyIcGuide,
    btnExit: lobbyBtnExit,
  },
  pick: {
    panel: pickPanel,
    title: pickTitle,
    closeBase: pickCloseBase,
    closeX: pickCloseX,
    levelEasy: pickLevelEasy,
    levelMid: pickLevelMid,
    levelHard: pickLevelHard,
  },
  confirm: {
    panel: confirmPanel,
    header: confirmHeader,
    btnCancel: confirmBtnCancel,
    btnOk: confirmBtnOk,
  },
  result: {
    panel: resultPanel,
    titleFrame: resultTitleFrame,
    kenFrame: resultKenFrame,
    cupWin: resultCupWin,
    shieldLose: resultShieldLose,
    brushWin: resultBrushWin,
    brushLose: resultBrushLose,
    btnClose: resultBtnClose,
    ken: resultKen,
  },
} as const;

function collectUrls(node: unknown): string[] {
  if (typeof node === 'string') return [node];
  return Object.values(node as Record<string, unknown>).flatMap(collectUrls);
}

const textureCache: Partial<Record<string, Texture>> = {};

export function texture(url: string): Texture {
  const loaded = textureCache[url];
  if (!loaded) throw new Error(`War God texture was used before loading: ${url}`);
  return loaded;
}

// Compatibility index for existing render code. Unlike a plain Record cast,
// every lookup is checked at runtime and fails with the missing asset URL.
export const tex: Record<string, Texture> = new Proxy(textureCache as Record<string, Texture>, {
  get(_target, property): Texture {
    if (typeof property !== 'string') {
      throw new TypeError(`Invalid War God texture key: ${String(property)}`);
    }
    return texture(property);
  },
});
let ultTexturePromise: Promise<Texture> | null = null;

function configureBoardTexture(texture: Texture): void {
  // These sprites are fixed-size, front-facing UI. Sampling the original with
  // bilinear filtering stays crisp at the renderer's DPR; generated mipmaps
  // prefilter away the thin painted outlines and make every board item soft.
  texture.source.magFilter = 'linear';
  texture.source.minFilter = 'linear';
  texture.source.autoGenerateMipmaps = false;
}

function withoutDeferredAssets(): Omit<typeof A, 'fx'> {
  const { fx: _deferred, ...startupAssets } = A;
  return startupAssets;
}

export async function loadAssets(): Promise<void> {
  const serifFont = new FontFace('DejaVuSerif', `url(${serifFontUrl})`);
  const robotoFont = new FontFace('RobotoCondensed', `url(${robotoCondensedUrl})`, {
    weight: '100 900',
  });
  const [loaded] = await Promise.all([
    Assets.load(collectUrls(withoutDeferredAssets())) as Promise<Record<string, Texture>>,
    serifFont.load().then((f) => document.fonts.add(f)),
    robotoFont.load().then((f) => document.fonts.add(f)),
  ]);
  Object.assign(textureCache, loaded);

  const scaledUrls = [
    A.board.frame,
    A.board.cell,
    A.board.selMine,
    A.board.selFoe,
    ...Object.values(A.items),
  ];
  scaledUrls.forEach((url) => configureBoardTexture(texture(url)));
}

export function loadUltTexture(): Promise<Texture> {
  const cached = textureCache[A.fx.ult];
  if (cached) return Promise.resolve(cached);
  if (!ultTexturePromise) {
    ultTexturePromise = Assets.load<Texture>(A.fx.ult)
      .then((texture) => {
        texture.source.autoGenerateMipmaps = false;
        textureCache[A.fx.ult] = texture;
        return texture;
      })
      .catch((error: unknown) => {
        ultTexturePromise = null;
        throw error;
      });
  }
  return ultTexturePromise;
}
