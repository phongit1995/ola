import type { ImageSourcePropType } from 'react-native';
import type { WordChainMoveStatus } from '@ola/shared/types';

export const WORD_CHAIN_ICONS = {
  room: require('@assets/icons/word-chain/room-02.webp'),
  bot: require('@assets/icons/word-chain/bot-06.webp'),
  lookup: require('@assets/icons/word-chain/lookup.webp'),
  leaderboard: require('@assets/icons/word-chain/leaderboard.webp'),
  rules: require('@assets/icons/word-chain/rules.webp'),
  hint: require('@assets/icons/word-chain/hint-star.webp'),
  minimize: require('@assets/icons/word-chain/minimize.webp'),
  buyGuesses: require('@assets/icons/word-chain/buy-guesses.webp'),
  ken: require('@assets/icons/apps/ken.png'),
} as const satisfies Record<string, ImageSourcePropType>;

export const WORD_CHAIN_STATUS_ICONS = {
  correct: {
    source: require('@assets/icons/word-chain/status/correct.webp'),
    label: 'wordChain.statusCorrect',
  },
  win: {
    source: require('@assets/icons/word-chain/status/win.webp'),
    label: 'wordChain.statusWin',
  },
  warning: {
    source: require('@assets/icons/word-chain/status/warning.webp'),
    label: 'wordChain.statusWarning',
  },
  error: {
    source: require('@assets/icons/word-chain/status/error.webp'),
    label: 'wordChain.statusError',
  },
} as const satisfies Record<
  WordChainMoveStatus,
  { source: ImageSourcePropType; label: string }
>;
