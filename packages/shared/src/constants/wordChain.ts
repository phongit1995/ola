import type {
  WordChainCode,
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
} as const;

export const WORD_CHAIN_MESSAGE_PAGE_SIZE = 50;
export const WORD_CHAIN_JOIN_ACK_TIMEOUT_MS = 10_000;
export const WORD_CHAIN_MOVE_MAX_LENGTH = 200;
export const WORD_CHAIN_LOOKUP_MAX_LENGTH = 80;
