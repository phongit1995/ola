import type { ChatMessageData, PlayerInfo } from '../../src/sdk';

export interface SeatChatBubble {
  seat: number;
  text: string;
  key: number;
}

export const CHAT_BUBBLE_MS = 3000;
const CHAT_HISTORY = 50;

interface MatchChatState {
  matchChat: ChatMessageData[];
  chatUnread: number;
  chatBubbles: SeatChatBubble[];
  chatOpen: boolean;
  players: PlayerInfo[];
  user: { id: string } | null;
}

export function receiveMatchChat(
  state: MatchChatState,
  message: ChatMessageData,
  key: number,
): Pick<MatchChatState, 'matchChat' | 'chatUnread' | 'chatBubbles'> {
  const seat = state.players.findIndex((player) => player.id === message.userId);
  const fromMe = message.userId === state.user?.id;
  return {
    matchChat: [...state.matchChat.slice(-(CHAT_HISTORY - 1)), message],
    chatUnread: state.chatOpen || fromMe ? state.chatUnread : state.chatUnread + 1,
    chatBubbles:
      seat < 0
        ? state.chatBubbles
        : [...state.chatBubbles.filter((bubble) => bubble.seat !== seat), { seat, text: message.text, key }],
  };
}
