import lobbyBg from './assets/lobby/bg.webp';
import lobbyAvatarFrame from './assets/lobby/avatar-frame.webp';
import lobbyNameFrame from './assets/lobby/name-frame.webp';
import lobbyKenFrame from './assets/lobby/ken-frame.webp';
import lobbyIcKen from './assets/lobby/ic-ken.webp';
import lobbyBtnPlus from './assets/lobby/btn-plus.webp';
import lobbyIcPlus from './assets/lobby/ic-plus.webp';
import lobbyModeFrame from './assets/lobby/mode-frame.webp';
import lobbyIcBot from './assets/lobby/ic-bot.webp';
import lobbyIcRanked from './assets/lobby/ic-ranked.webp';
import lobbyBottomFrame from './assets/lobby/bottom-frame.webp';
import lobbyIcHistory from './assets/lobby/ic-history.webp';
import lobbyIcLeaderboard from './assets/lobby/ic-leaderboard.webp';
import lobbyIcExit from './assets/lobby/ic-exit.webp';
import lobbyPickBg from './assets/lobby/pick-bg.webp';
import lobbyPickTitle from './assets/lobby/pick-title.webp';
import lobbyPickLevel from './assets/lobby/pick-level.webp';
import lobbyPickClose from './assets/lobby/pick-close.webp';
import lobbyPickX from './assets/lobby/pick-x.webp';
import lobbyConfirmBg from './assets/lobby/confirm-bg.webp';
import lobbyConfirmTitle from './assets/lobby/confirm-title.webp';
import lobbyConfirmDoor from './assets/lobby/confirm-door.webp';
import lobbyBtnRed from './assets/lobby/btn-red.webp';
import lobbyBtnNavy from './assets/lobby/btn-navy.webp';

const LOBBY_CRITICAL_ASSETS = {
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
} as const;

const LOBBY_MODAL_ASSETS = {
  pickBg: lobbyPickBg,
  pickTitle: lobbyPickTitle,
  pickLevel: lobbyPickLevel,
  pickClose: lobbyPickClose,
  pickX: lobbyPickX,
  confirmBg: lobbyConfirmBg,
  confirmTitle: lobbyConfirmTitle,
  confirmDoor: lobbyConfirmDoor,
  btnRed: lobbyBtnRed,
  btnNavy: lobbyBtnNavy,
} as const;

export const LOBBY_ASSETS = {
  ...LOBBY_CRITICAL_ASSETS,
  ...LOBBY_MODAL_ASSETS,
} as const;

import rankedBg from './assets/ranked/bg.webp';
import rankedTitleFrame from './assets/ranked/title-frame.webp';
import rankedCup from './assets/ranked/ic-cup.webp';
import rankedTable from './assets/ranked/table.webp';
import rankedSlotOpen from './assets/ranked/slot-open.webp';
import rankedSlotFull from './assets/ranked/slot-full.webp';
import rankedLock from './assets/ranked/ic-lock.webp';
import rankedPageBtn from './assets/ranked/page-btn.webp';
import rankedMenuBtn from './assets/ranked/menu-btn.webp';
import createPanel from './assets/create/panel.webp';
import createTitleFrame from './assets/create/title-frame.webp';
import createLabelFrame from './assets/create/label-frame.webp';
import createInputFrame from './assets/create/input-frame.webp';
import createBtnOk from './assets/create/btn-ok.webp';
import createBtnClose from './assets/create/btn-close.webp';
import createIcX from './assets/create/ic-x.webp';
import createPasswordLock from './assets/create/ic-password-lock.webp';
import createPasswordEye from './assets/create/ic-password-eye.webp';
import resultBg from './assets/result/bg.webp';
import resultTitleFrame from './assets/result/title-frame.webp';
import resultCupWin from './assets/result/cup-win.webp';
import resultCupLose from './assets/result/cup-lose.webp';
import resultBrushWin from './assets/result/brush-win.webp';
import resultBrushLose from './assets/result/brush-lose.webp';
import resultKenFrame from './assets/result/ken-frame.webp';
import resultIcKen from './assets/result/ic-ken.webp';
import resultBtnClose from './assets/result/btn-close.webp';
import resultBtnReplayWin from './assets/result/btn-replay-win.webp';
import resultBtnCloseWin from './assets/result/btn-close-win.webp';
import resultBtnReplayLose from './assets/result/btn-replay-lose.webp';
import resultBtnCloseLose from './assets/result/btn-close-lose.webp';
import boardBg from './assets/board/bg.webp';
import boardFrame from './assets/board/board-frame.webp';
import boardX from './assets/board/x.webp';
import boardO from './assets/board/o.webp';
import boardTimerFrame from './assets/board/timer-frame.webp';
import boardTimerFrameMine from './assets/board/timer-frame-mine.webp';
import boardTurnLeft from './assets/board/turn-left.webp';
import boardTurnRight from './assets/board/turn-right.webp';
import boardAvatarFrame from './assets/board/avatar-frame.webp';
import boardMenuBtn from './assets/board/menu-btn.webp';
import boardForfeitIcon from './assets/board/ic-forfeit.webp';
import boardChatFrame from './assets/board/chat-frame-clean.webp';
import boardSendIcon from './assets/board/send-icon.webp';
import boardReactionIcon from './assets/board/reaction-icon.webp';
import reactionLike from './assets/reactions/like.webp';
import reactionLove from './assets/reactions/love.webp';
import reactionHaha from './assets/reactions/haha.webp';
import reactionWow from './assets/reactions/wow.webp';
import reactionSad from './assets/reactions/sad.webp';
import reactionAngry from './assets/reactions/angry.webp';
import leaderboardTitleFrame from './assets/leaderboard/title-frame.webp';
import leaderboardCup from './assets/leaderboard/cup.webp';
import leaderboardCloseFrame from './assets/leaderboard/close-frame.webp';
import leaderboardCloseX from './assets/leaderboard/close-x.webp';
import leaderboardTabActive from './assets/leaderboard/tab-active.webp';
import leaderboardTabInactive from './assets/leaderboard/tab-inactive.webp';
import leaderboardRank1 from './assets/leaderboard/rank-1.webp';
import leaderboardRank2 from './assets/leaderboard/rank-2.webp';
import leaderboardRank3 from './assets/leaderboard/rank-3.webp';
import leaderboardRank4 from './assets/leaderboard/rank-4.webp';
import leaderboardRank5 from './assets/leaderboard/rank-5-violet.webp';
import leaderboardRank6 from './assets/leaderboard/rank-6-emerald.webp';
import leaderboardRank7 from './assets/leaderboard/rank-7-crimson.webp';
import leaderboardRank8 from './assets/leaderboard/rank-8-cyan.webp';
import leaderboardRank9 from './assets/leaderboard/rank-9-magenta.webp';
import leaderboardRank10 from './assets/leaderboard/rank-10-graphite.webp';
import leaderboardPageArrow from './assets/leaderboard/page-arrow.webp';
import leaderboardPageNumber from './assets/leaderboard/page-number.webp';
import leaderboardPanel from './assets/leaderboard/panel.webp';
import leaderboardDivider from './assets/leaderboard/divider.webp';
import leaderboardKen from './assets/leaderboard/ken.webp';
import historyPanel from './assets/history/panel.webp';
import historyTitleFrame from './assets/history/title-frame.webp';
import historyIcon from './assets/history/icon.webp';
import historyCloseFrame from './assets/history/close-frame.webp';
import historyCloseX from './assets/history/close-x.webp';
import historyTable from './assets/history/table.webp';
import historyPageBtn from './assets/history/page-btn.webp';
import historyKen from './assets/history/ken.webp';

const CREATE_MODAL_ASSETS = {
  createPanel,
  createTitleFrame,
  createLabelFrame,
  createInputFrame,
  createBtnOk,
  createBtnClose,
  createIcX,
  createPasswordLock,
  createPasswordEye,
} as const;

export const BOARD_ASSETS = {
  boardBg,
  boardFrame,
  boardX,
  boardO,
  boardTimerFrame,
  boardTimerFrameMine,
  boardTurnLeft,
  boardTurnRight,
  boardAvatarFrame,
  boardMenuBtn,
  boardForfeitIcon,
  chatFrame: boardChatFrame,
  sendIcon: boardSendIcon,
  reactionIcon: boardReactionIcon,
} as const;

export const REACTION_ASSETS = {
  reactionLike,
  reactionLove,
  reactionHaha,
  reactionWow,
  reactionSad,
  reactionAngry,
} as const;

const RANKED_SCREEN_ASSETS = {
  rankedBg,
  rankedTitleFrame,
  rankedCup,
  rankedTable,
  rankedSlotOpen,
  rankedSlotFull,
  rankedLock,
  rankedPageBtn,
  rankedMenuBtn,
} as const;

export const RANKED_ASSETS = {
  ...RANKED_SCREEN_ASSETS,
  ...CREATE_MODAL_ASSETS,
} as const;

export const RESULT_ASSETS = {
  resultBg,
  resultTitleFrame,
  resultCupWin,
  resultCupLose,
  resultBrushWin,
  resultBrushLose,
  resultKenFrame,
  resultIcKen,
  resultBtnClose,
  resultBtnReplayWin,
  resultBtnCloseWin,
  resultBtnReplayLose,
  resultBtnCloseLose,
} as const;

export const LEADERBOARD_ASSETS = {
  leaderboardTitleFrame,
  leaderboardCup,
  leaderboardCloseFrame,
  leaderboardCloseX,
  leaderboardTabActive,
  leaderboardTabInactive,
  leaderboardRank1,
  leaderboardRank2,
  leaderboardRank3,
  leaderboardRank4,
  leaderboardRank5,
  leaderboardRank6,
  leaderboardRank7,
  leaderboardRank8,
  leaderboardRank9,
  leaderboardRank10,
  leaderboardPageArrow,
  leaderboardPageNumber,
  leaderboardPanel,
  leaderboardDivider,
  leaderboardKen,
} as const;

export const HISTORY_ASSETS = {
  historyPanel,
  historyTitleFrame,
  historyIcon,
  historyCloseFrame,
  historyCloseX,
  historyTable,
  historyPageBtn,
  historyKen,
} as const;

const ALL_ASSETS = {
  ...LOBBY_ASSETS,
  ...BOARD_ASSETS,
  ...REACTION_ASSETS,
  ...RANKED_ASSETS,
  ...RESULT_ASSETS,
  ...LEADERBOARD_ASSETS,
  ...HISTORY_ASSETS,
} as const;

export type AssetKey = keyof typeof ALL_ASSETS;

export function assetSrc(key: AssetKey): string {
  return ALL_ASSETS[key];
}

export function assetBg(key: AssetKey): { backgroundImage: string } {
  return { backgroundImage: `url('${ALL_ASSETS[key]}')` };
}

export function preloadAssets(
  onProgress?: (loaded: number, total: number) => void,
  timeoutMs = 15000,
): Promise<void> {
  return preloadUrls(Object.values(LOBBY_CRITICAL_ASSETS), onProgress, timeoutMs);
}

const IMAGE_LOADS = new Map<string, Promise<void>>();

function preloadUrl(url: string): Promise<void> {
  const existing = IMAGE_LOADS.get(url);
  if (existing) return existing;
  const pending = new Promise<void>((resolve) => {
    const img = new Image();
    img.onload = () => resolve();
    img.onerror = () => {
      IMAGE_LOADS.delete(url);
      resolve();
    };
    img.src = url;
  });
  IMAGE_LOADS.set(url, pending);
  return pending;
}

function preloadUrls(
  urls: readonly string[],
  onProgress?: (loaded: number, total: number) => void,
  timeoutMs = 15000,
): Promise<void> {
  const uniqueUrls = [...new Set(urls)];
  const total = uniqueUrls.length;
  let loaded = 0;
  onProgress?.(0, total);
  const loadAll = Promise.all(
    uniqueUrls.map((url) =>
      preloadUrl(url).then(() => {
        loaded++;
        onProgress?.(loaded, total);
      }),
    ),
  ).then(() => undefined);
  return new Promise<void>((resolve) => {
    let settled = false;
    const finish = (): void => {
      if (settled) return;
      settled = true;
      resolve();
    };
    const timer = window.setTimeout(finish, timeoutMs);
    void loadAll.then(() => {
      window.clearTimeout(timer);
      finish();
    });
  });
}

function waitForIdle(timeout = 1200): Promise<void> {
  return new Promise((resolve) => {
    const idleWindow = window as typeof window & {
      requestIdleCallback?: (callback: () => void, options?: { timeout: number }) => number;
    };
    if (idleWindow.requestIdleCallback) {
      idleWindow.requestIdleCallback(resolve, { timeout });
      return;
    }
    window.setTimeout(resolve, 120);
  });
}

async function preloadUrlsInIdleBatches(urls: readonly string[], batchSize = 3): Promise<void> {
  const uniqueUrls = [...new Set(urls)];
  for (let index = 0; index < uniqueUrls.length; index += batchSize) {
    await waitForIdle();
    await Promise.all(uniqueUrls.slice(index, index + batchSize).map(preloadUrl));
  }
}

const preloadTasks = new Map<string, Promise<void>>();

function preloadGroup(key: string, urls: readonly string[], timeoutMs = 30000): Promise<void> {
  const existing = preloadTasks.get(key);
  if (existing) return existing;
  const pending = preloadUrls(urls, undefined, timeoutMs);
  preloadTasks.set(key, pending);
  return pending;
}

export function preloadLobbyModalAssets(): void {
  void preloadGroup('lobby-modal', Object.values(LOBBY_MODAL_ASSETS));
}

export function preloadRankedAssets(): void {
  void preloadGroup('ranked', Object.values(RANKED_SCREEN_ASSETS));
}

export function preloadBoardAssets(): void {
  void preloadGroup('board', Object.values(BOARD_ASSETS));
}

export function preloadCreateModalAssets(): void {
  void preloadGroup('create-modal', Object.values(CREATE_MODAL_ASSETS));
}

export function preloadResultAssets(): void {
  void preloadGroup('result', Object.values(RESULT_ASSETS));
}

export function preloadLeaderboardAssets(): void {
  void preloadGroup('leaderboard', Object.values(LEADERBOARD_ASSETS));
}

export function preloadHistoryAssets(): void {
  void preloadGroup('history', Object.values(HISTORY_ASSETS));
}

export function preloadReactionAssets(): void {
  void preloadGroup('reactions', Object.values(REACTION_ASSETS));
}

let priorityPreload: Promise<void> | null = null;

/** Warm likely next screens without flooding the decoder/network queue. */
export function preloadPriorityAssets(): void {
  priorityPreload ??= (async () => {
    await preloadUrlsInIdleBatches(Object.values(RANKED_SCREEN_ASSETS));
    await preloadUrlsInIdleBatches(Object.values(BOARD_ASSETS));
    await preloadUrlsInIdleBatches(Object.values(LOBBY_MODAL_ASSETS));
  })();
}

export const VIP_DEFAULT_ICON = '/ola_smiley_online.png';
