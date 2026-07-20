import lobbyBg from './assets/lobby/bg.png';
import lobbyAvatarFrame from './assets/lobby/avatar-frame.png';
import lobbyNameFrame from './assets/lobby/name-frame.png';
import lobbyKenFrame from './assets/lobby/ken-frame.png';
import lobbyIcKen from './assets/lobby/ic-ken.png';
import lobbyBtnPlus from './assets/lobby/btn-plus.png';
import lobbyIcPlus from './assets/lobby/ic-plus.png';
import lobbyModeFrame from './assets/lobby/mode-frame.png';
import lobbyIcBot from './assets/lobby/ic-bot.png';
import lobbyIcRanked from './assets/lobby/ic-ranked.png';
import lobbyBottomFrame from './assets/lobby/bottom-frame.png';
import lobbyIcHistory from './assets/lobby/ic-history.png';
import lobbyIcLeaderboard from './assets/lobby/ic-leaderboard.png';
import lobbyIcExit from './assets/lobby/ic-exit.png';
import lobbyPickBg from './assets/lobby/pick-bg.png';
import lobbyPickTitle from './assets/lobby/pick-title.png';
import lobbyPickLevel from './assets/lobby/pick-level.png';
import lobbyPickClose from './assets/lobby/pick-close.png';
import lobbyPickX from './assets/lobby/pick-x.png';

export const LOBBY_ASSETS = {
  bg: lobbyBg,
  avatarFrame: lobbyAvatarFrame,
  nameFrame: lobbyNameFrame,
  kenFrame: lobbyKenFrame,
  icKen: lobbyIcKen,
  btnPlus: lobbyBtnPlus,
  icPlus: lobbyIcPlus,
  modeFrame: lobbyModeFrame,
  icBot: lobbyIcBot,
  icRanked: lobbyIcRanked,
  bottomFrame: lobbyBottomFrame,
  icHistory: lobbyIcHistory,
  icLeaderboard: lobbyIcLeaderboard,
  icExit: lobbyIcExit,
  pickBg: lobbyPickBg,
  pickTitle: lobbyPickTitle,
  pickLevel: lobbyPickLevel,
  pickClose: lobbyPickClose,
  pickX: lobbyPickX,
} as const;

import rankedBg from './assets/ranked/bg.png';
import rankedTitleFrame from './assets/ranked/title-frame.png';
import rankedCup from './assets/ranked/ic-cup.png';
import rankedTable from './assets/ranked/table.png';
import rankedSlotOpen from './assets/ranked/slot-open.png';
import rankedSlotFull from './assets/ranked/slot-full.png';
import rankedLock from './assets/ranked/ic-lock.png';
import rankedPageBtn from './assets/ranked/page-btn.png';
import rankedMenuBtn from './assets/ranked/menu-btn.png';
import createPanel from './assets/create/panel.png';
import createTitleFrame from './assets/create/title-frame.png';
import createLabelFrame from './assets/create/label-frame.png';
import createInputFrame from './assets/create/input-frame.png';
import createBtnOk from './assets/create/btn-ok.png';
import createBtnClose from './assets/create/btn-close.png';
import createIcX from './assets/create/ic-x.png';
import boardBg from './assets/board/bg.png';
import boardFrame from './assets/board/board-frame.png';
import boardX from './assets/board/x.png';
import boardO from './assets/board/o.png';
import boardTimerFrame from './assets/board/timer-frame.png';
import boardTurnLeft from './assets/board/turn-left.png';
import boardTurnRight from './assets/board/turn-right.png';
import boardAvatarFrame from './assets/board/avatar-frame.png';
import boardMenuBtn from './assets/board/menu-btn.png';

export const BOARD_ASSETS = {
  boardBg,
  boardFrame,
  boardX,
  boardO,
  boardTimerFrame,
  boardTurnLeft,
  boardTurnRight,
  boardAvatarFrame,
  boardMenuBtn,
} as const;

export const RANKED_ASSETS = {
  rankedBg,
  rankedTitleFrame,
  rankedCup,
  rankedTable,
  rankedSlotOpen,
  rankedSlotFull,
  rankedLock,
  rankedPageBtn,
  rankedMenuBtn,
  createPanel,
  createTitleFrame,
  createLabelFrame,
  createInputFrame,
  createBtnOk,
  createBtnClose,
  createIcX,
} as const;

const ALL_ASSETS = { ...LOBBY_ASSETS, ...BOARD_ASSETS, ...RANKED_ASSETS } as const;

export type AssetKey = keyof typeof ALL_ASSETS;

export function applyAssets(root: ParentNode): void {
  root.querySelectorAll<HTMLImageElement>('img[data-asset]').forEach((img) => {
    const key = img.dataset.asset as AssetKey;
    if (ALL_ASSETS[key]) img.src = ALL_ASSETS[key];
  });
  root.querySelectorAll<HTMLElement>('[data-asset-bg]').forEach((node) => {
    const key = node.dataset.assetBg as AssetKey;
    if (ALL_ASSETS[key]) node.style.backgroundImage = `url('${ALL_ASSETS[key]}')`;
  });
  document.documentElement.style.setProperty('--asset-board-x', `url('${BOARD_ASSETS.boardX}')`);
  document.documentElement.style.setProperty('--asset-board-o', `url('${BOARD_ASSETS.boardO}')`);
}

export function preloadAssets(
  onProgress?: (loaded: number, total: number) => void,
  timeoutMs = 15000,
): Promise<void> {
  const urls = Object.values(ALL_ASSETS);
  const total = urls.length;
  let loaded = 0;
  onProgress?.(0, total);
  const loadAll = Promise.all(
    urls.map(
      (url) =>
        new Promise<void>((resolve) => {
          const done = (): void => {
            loaded++;
            onProgress?.(loaded, total);
            resolve();
          };
          const img = new Image();
          img.onload = done;
          img.onerror = done;
          img.src = url;
        }),
    ),
  ).then(() => undefined);
  const timeout = new Promise<void>((resolve) => setTimeout(resolve, timeoutMs));
  return Promise.race([loadAll, timeout]);
}

export function vipIconUrl(vipType: string | null | undefined): string | null {
  if (vipType == null || vipType === '') return null;
  const id = Number(vipType);
  if (!Number.isFinite(id) || id <= 0) return null;
  return `/vip-icons/vip_${String(id).padStart(3, '0')}.png`;
}
