import { WORD_CHAIN_CODE } from '@constants';
import type { WordChainMessage } from '@app-types';

export type WordChainMoveStatus = 'correct' | 'win' | 'warning' | 'error';

export function resolveWordChainStatus(
  message: Pick<WordChainMessage, 'code' | 'reaction'>
): WordChainMoveStatus | undefined {
  switch (message.code) {
    case WORD_CHAIN_CODE.ok:
      return 'correct';
    case WORD_CHAIN_CODE.win:
      return 'win';
    case WORD_CHAIN_CODE.invalidFormat:
      return 'warning';
    case WORD_CHAIN_CODE.mismatch:
    case WORD_CHAIN_CODE.repeated:
    case WORD_CHAIN_CODE.notInDict:
      return 'error';
  }

  switch (message.reaction?.replace(/[\uFE0E\uFE0F]/g, '')) {
    case '✅':
      return 'correct';
    case '🏆':
      return 'win';
    case '⚠':
      return 'warning';
    case '❌':
      return 'error';
    default:
      return undefined;
  }
}
