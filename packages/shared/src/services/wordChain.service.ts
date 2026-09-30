import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  WordChainHint,
  WordChainLeaderboard,
  WordChainLookup,
  WordChainMessagesParams,
  WordChainMessagesResult,
  WordChainMoveRequest,
  WordChainMoveResult,
  WordChainOverview,
} from '../types/api/wordChain.type';

export class WordChainService {
  static overview(): Promise<WordChainOverview> {
    return http.get<WordChainOverview>(API_PATH.wordChain.overview);
  }

  static messages(params: WordChainMessagesParams = {}): Promise<WordChainMessagesResult> {
    return http.get<WordChainMessagesResult>(API_PATH.wordChain.messages, { params });
  }

  static move(payload: WordChainMoveRequest): Promise<WordChainMoveResult> {
    return http.post<WordChainMoveResult>(API_PATH.wordChain.moves, payload);
  }

  static hint(): Promise<WordChainHint> {
    return http.post<WordChainHint>(API_PATH.wordChain.hints);
  }

  static leaderboard(): Promise<WordChainLeaderboard> {
    return http.get<WordChainLeaderboard>(API_PATH.wordChain.leaderboard);
  }

  static lookup(word: string): Promise<WordChainLookup> {
    return http.get<WordChainLookup>(API_PATH.wordChain.lookup, { params: { word } });
  }
}
