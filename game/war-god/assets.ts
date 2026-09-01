import { Assets, Texture } from 'pixi.js';
import bg from './assets/bg.webp';
import boardFrame from './assets/board/frame.webp';
import boardCell from './assets/board/cell.webp';
import boardSelMine from './assets/board/sel-mine.webp';
import boardSelFoe from './assets/board/sel-foe.webp';
import itemSword from './assets/items/sword.webp';
import itemPeach from './assets/items/peach.webp';
import itemHeart from './assets/items/heart.webp';
import itemWater from './assets/items/water.webp';
import itemShield from './assets/items/shield.webp';
import itemLightning from './assets/items/lightning.webp';
import specialFireSword from './assets/items/fire-sword-v1.webp';
import specialGreaterHeart from './assets/items/greater-heart-v1.webp';
import itemFlyingDart from './assets/items/flying-dart-v2.webp';
import ultimateHeartVacuum from './assets/ultimate/heart-vacuum.webp';
import cardBorderActive from './assets/hud/card-border-active.webp';
import cardBorderIdle from './assets/hud/card-border-idle.webp';
import ringActive from './assets/hud/ring-active.webp';
import ringIdle from './assets/hud/ring-idle.webp';
import rankFrame from './assets/hud/rank-frame.webp';
import ultLeftOn from './assets/hud/ult-left-on.webp';
import ultLeftOff from './assets/hud/ult-left-off.webp';
import ultRightOn from './assets/hud/ult-right-on.webp';
import ultRightOff from './assets/hud/ult-right-off.webp';
import flameOn from './assets/hud/flame-on.webp';
import flameOff from './assets/hud/flame-off.webp';
import icHp from './assets/hud/ic-hp.webp';
import icMp from './assets/hud/ic-mp.webp';
import turnBanner from './assets/hud/turn-banner.webp';
import noteStrip from './assets/hud/note-strip.webp';
import menuBtnBlue from './assets/menu/btn-blue.webp';
import menuBtnForfeit from './assets/menu/btn-forfeit-v2.webp';
import menuBtnExit from './assets/menu/btn-exit-v2.webp';
import menuIcRestart from './assets/menu/ic-restart.webp';
import menuIcForfeit from './assets/menu/ic-forfeit.webp';
import menuIcExit from './assets/menu/ic-exit.webp';
import chatFrame from './assets/chat/frame.webp';
import chatInput from './assets/chat/input.webp';
import chatBtnSend from './assets/chat/btn-send.webp';
import chatIcSmiley from './assets/chat/ic-smiley.webp';
import reactionLike from '../caro/assets/reactions/like.webp';
import reactionLove from '../caro/assets/reactions/love.webp';
import reactionHaha from '../caro/assets/reactions/haha.webp';
import reactionWow from '../caro/assets/reactions/wow.webp';
import reactionSad from '../caro/assets/reactions/sad.webp';
import reactionAngry from '../caro/assets/reactions/angry.webp';
import fxUlt from './assets/fx/ult.webp';
import lobbyBg from './assets/lobby/bg.webp';
import lobbyLogo from './assets/lobby/logo.webp';
import lobbyAvatarFrame from './assets/lobby/avatar-frame.webp';
import lobbyNameFrame from './assets/lobby/name-frame.webp';
import lobbyKenFrame from './assets/lobby/ken-frame.webp';
import lobbyCoin from './assets/lobby/coin.webp';
import lobbyBtnPlus from './assets/lobby/btn-plus.webp';
import lobbyIcPlus from './assets/lobby/ic-plus.webp';
import lobbyBtnWood from './assets/lobby/btn-wood.webp';
import lobbyIcBot from './assets/lobby/ic-bot.webp';
import lobbyIcPvp from './assets/lobby/ic-pvp.webp';
import lobbyMenuPill from './assets/lobby/menu-pill.webp';
import lobbyRing from './assets/lobby/ring.webp';
import lobbyIcHistory from './assets/lobby/ic-history.webp';
import lobbyIcLeaderboard from './assets/lobby/ic-leaderboard.webp';
import lobbyIcSoundOn from './assets/lobby/ic-sound-on.webp';
import lobbyIcSoundOff from './assets/lobby/ic-sound-off.webp';
import lobbyIcGuide from './assets/lobby/ic-guide.webp';
import lobbyBtnExit from './assets/lobby/btn-exit.webp';
import lobbyPvpTitle from './assets/lobby/pvp-title.webp';
import lobbyTableFrame from './assets/lobby/table-frame.webp';
import lobbyTableList from './assets/lobby/table-list.webp';
import lobbySlotFull from './assets/lobby/slot-full.webp';
import lobbySlotOpen from './assets/lobby/slot-open.webp';
import lobbyLock from './assets/lobby/lock.webp';
import lobbyBtnBlue from './assets/lobby/btn-blue.webp';
import lobbyPageCurrent from './assets/lobby/page-current.webp';
import lobbyPageArrow from './assets/lobby/page-arrow.webp';
import lobbyParchment from './assets/lobby/parchment.webp';
import lobbyCreatePanel from './assets/lobby/create-panel.webp';
import lobbyCreateTitle from './assets/lobby/create-title.webp';
import lobbyFieldLabel from './assets/lobby/field-label.webp';
import lobbyFieldInput from './assets/lobby/field-input.webp';
import lobbyBtnOk from './assets/lobby/btn-ok.webp';
import lobbyBtnX from './assets/lobby/btn-x.webp';
import lobbyIcX from './assets/lobby/ic-x.webp';
import pickPanel from './assets/pick/panel.webp';
import pickTitle from './assets/pick/title.webp';
import pickCloseBase from './assets/pick/close-base.webp';
import pickCloseX from './assets/pick/close-x.webp';
import pickLevelEasy from './assets/pick/level-easy.webp';
import pickLevelMid from './assets/pick/level-mid.webp';
import pickLevelHard from './assets/pick/level-hard.webp';
import pickLevelExpert from './assets/pick/level-expert.webp';
import confirmPanel from './assets/confirm/panel.webp';
import confirmHeader from './assets/confirm/header.webp';
import confirmBtnCancel from './assets/confirm/btn-cancel.webp';
import confirmBtnOk from './assets/confirm/btn-ok.webp';
import battleConfirmPanel from './assets/confirm/panel-v2.webp';
import battleConfirmBtnSafe from './assets/confirm/btn-safe-v2.webp';
import resultPanel from './assets/result/panel.webp';
import resultTitleFrame from './assets/result/title-frame.webp';
import resultKenFrame from './assets/result/ken-frame.webp';
import resultCupWin from './assets/result/cup-win.webp';
import resultShieldLose from './assets/result/shield-lose.webp';
import resultBrushWin from './assets/result/brush-win.webp';
import resultBrushLose from './assets/result/brush-lose.webp';
import resultBtnReplay from './assets/result/btn-replay.webp';
import resultBtnClose from './assets/result/btn-close.webp';
import resultKen from './assets/result/ken.webp';
import resultStarGold from './assets/result/star-gold-v1.png';
import historyPanelFill from './assets/history/panel-fill.webp';
import historyPanelFrame from './assets/history/panel-frame.webp';
import historyTitleFrame from './assets/history/title-frame.webp';
import historyTable from './assets/history/table.webp';
import historyCloseBase from './assets/history/close-base.webp';
import historyCloseX from './assets/history/close-x.webp';
import historyOutcomeWin from './assets/history/outcome-win.webp';
import historyOutcomeLose from './assets/history/outcome-lose.webp';
import historyPageNumber from './assets/history/page-number.webp';
import historyPageArrow from './assets/history/page-arrow.webp';
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
    flyingDart: itemFlyingDart,
    flyingDartHorizontal: itemFlyingDart,
    flyingDartVertical: itemFlyingDart,
    flyingDartCross: itemFlyingDart,
  },
  ultimate: {
    heartVacuum: ultimateHeartVacuum,
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
    btnForfeit: menuBtnForfeit,
    btnExit: menuBtnExit,
    icRestart: menuIcRestart,
    icForfeit: menuIcForfeit,
    icExit: menuIcExit,
  },
  chat: {
    frame: chatFrame,
    input: chatInput,
    btnSend: chatBtnSend,
    icSmiley: chatIcSmiley,
    reactions: {
      like: reactionLike,
      love: reactionLove,
      haha: reactionHaha,
      wow: reactionWow,
      sad: reactionSad,
      angry: reactionAngry,
    },
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
    icLeaderboard: lobbyIcLeaderboard,
    icSoundOn: lobbyIcSoundOn,
    icSoundOff: lobbyIcSoundOff,
    icGuide: lobbyIcGuide,
    btnExit: lobbyBtnExit,
    pvpTitle: lobbyPvpTitle,
    tableFrame: lobbyTableFrame,
    tableList: lobbyTableList,
    slotFull: lobbySlotFull,
    slotOpen: lobbySlotOpen,
    lock: lobbyLock,
    btnBlue: lobbyBtnBlue,
    pageCurrent: lobbyPageCurrent,
    pageArrow: lobbyPageArrow,
    parchment: lobbyParchment,
    createPanel: lobbyCreatePanel,
    createTitle: lobbyCreateTitle,
    fieldLabel: lobbyFieldLabel,
    fieldInput: lobbyFieldInput,
    btnOk: lobbyBtnOk,
    btnX: lobbyBtnX,
    icX: lobbyIcX,
  },
  pick: {
    panel: pickPanel,
    title: pickTitle,
    closeBase: pickCloseBase,
    closeX: pickCloseX,
    levelEasy: pickLevelEasy,
    levelMid: pickLevelMid,
    levelHard: pickLevelHard,
    levelExpert: pickLevelExpert,
  },
  confirm: {
    panel: confirmPanel,
    header: confirmHeader,
    btnCancel: confirmBtnCancel,
    btnOk: confirmBtnOk,
  },
  battleConfirm: {
    panel: battleConfirmPanel,
    btnSafe: battleConfirmBtnSafe,
  },
  result: {
    panel: resultPanel,
    titleFrame: resultTitleFrame,
    kenFrame: resultKenFrame,
    cupWin: resultCupWin,
    shieldLose: resultShieldLose,
    brushWin: resultBrushWin,
    brushLose: resultBrushLose,
    btnReplay: resultBtnReplay,
    btnClose: resultBtnClose,
    ken: resultKen,
    starGold: resultStarGold,
  },
  history: {
    panelFill: historyPanelFill,
    panelFrame: historyPanelFrame,
    titleFrame: historyTitleFrame,
    table: historyTable,
    closeBase: historyCloseBase,
    closeX: historyCloseX,
    outcomeWin: historyOutcomeWin,
    outcomeLose: historyOutcomeLose,
    pageNumber: historyPageNumber,
    pageArrow: historyPageArrow,
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

export async function loadAssets(onProgress?: (fraction: number) => void): Promise<void> {
  const serifFont = new FontFace('DejaVuSerif', `url(${serifFontUrl})`);
  const robotoFont = new FontFace('RobotoCondensed', `url(${robotoCondensedUrl})`, {
    weight: '100 900',
  });
  const [loaded] = await Promise.all([
    Assets.load(collectUrls(withoutDeferredAssets()), (fraction) =>
      onProgress?.(Math.min(fraction * 0.96, 0.96))
    ) as Promise<Record<string, Texture>>,
    serifFont.load().then((f) => document.fonts.add(f)),
    robotoFont.load().then((f) => document.fonts.add(f)),
  ]);
  Object.assign(textureCache, loaded);
  onProgress?.(1);

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
