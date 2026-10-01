import type {
  WordChainInputLock,
  WordChainLeaderboardTab,
} from '../types/client/wordChain.type';
import type {
  WordChainCode,
  WordChainLeaderboardPeriod,
  WordChainLeaderboardSort,
  WordChainMessageType,
  WordChainSenderType,
} from '../types/api/wordChain.type';

export const WORD_CHAIN_CODE = {
  ok: 'ok',
  win: 'win',
  mismatch: 'mismatch',
  repeated: 'repeated',
  notInDict: 'not_in_dict',
  invalidFormat: 'invalid_format',
} as const satisfies Record<string, WordChainCode>;

export const WORD_CHAIN_MESSAGE_TYPE = {
  move: 'move',
  win: 'win',
  gameStarted: 'game_started',
  sessionStarted: 'session_started',
  wrongAnswer: 'wrong_answer',
} as const satisfies Record<string, WordChainMessageType>;

export const WORD_CHAIN_SENDER_TYPE = {
  user: 'user',
  bot: 'bot',
} as const satisfies Record<string, WordChainSenderType>;

export const WORD_CHAIN_ERROR_CODE = {
  verifyFailed: 'WORD_CHAIN_VERIFY_FAILED',
  cooldown: 'WORD_CHAIN_COOLDOWN',
  noGuesses: 'WORD_CHAIN_NO_GUESSES',
  waitTurn: 'WORD_CHAIN_WAIT_TURN',
  noHint: 'WORD_CHAIN_NO_HINT',
  kenShort: 'WORD_CHAIN_INSUFFICIENT_KEN',
  disabled: 'WORD_CHAIN_DISABLED',
  wordChanged: 'WORD_CHAIN_WORD_CHANGED',
  unavailable: 'WORD_CHAIN_UNAVAILABLE',
} as const;

export const WORD_CHAIN_MESSAGE_PAGE_SIZE = 50;
export const WORD_CHAIN_WIN_PAGE_SIZE = 20;

export const WORD_CHAIN_LEADERBOARD_SORT = {
  points: 'points',
  wins: 'wins',
} as const satisfies Record<string, WordChainLeaderboardSort>;

export const WORD_CHAIN_LEADERBOARD_PERIOD = {
  day: 'day',
  week: 'week',
  month: 'month',
  all: 'all',
} as const satisfies Record<string, WordChainLeaderboardPeriod>;

export const WORD_CHAIN_LEADERBOARD_PERIOD_LABEL_KEYS = {
  day: 'wordChain.periodDay',
  week: 'wordChain.periodWeek',
  month: 'wordChain.periodMonth',
  all: 'wordChain.periodAll',
} as const satisfies Record<WordChainLeaderboardPeriod, string>;

export const WORD_CHAIN_LEADERBOARD_TABS = [
  { key: 'wins', labelKey: 'wordChain.leaderboardTabWins' },
  { key: 'points', labelKey: 'wordChain.leaderboardTabPoints' },
  { key: 'history', labelKey: 'wordChain.leaderboardTabHistory' },
] as const satisfies readonly { key: WordChainLeaderboardTab; labelKey: string }[];

export const WORD_CHAIN_INPUT_LOCK_HINT_KEYS = {
  waitTurn: 'wordChain.inputHintWaitTurn',
  noGuesses: 'wordChain.inputHintLocked',
} as const satisfies Record<WordChainInputLock, string>;

export const WORD_CHAIN_JOIN_ACK_TIMEOUT_MS = 10_000;
export const WORD_CHAIN_MOVE_MAX_LENGTH = 200;
export const WORD_CHAIN_LOOKUP_MAX_LENGTH = 80;
