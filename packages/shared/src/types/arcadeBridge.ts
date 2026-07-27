export const ARCADE_BRIDGE_SOURCE = {
  Game: 'ola-game',
  Host: 'ola-host',
} as const;

export const ARCADE_BRIDGE_EVENT = {
  Ready: 'ready',
  GameOver: 'game_over',
  TurnChanged: 'turn_changed',
  AttentionRequired: 'attention_required',
  RefreshUser: 'refresh_user',
  KenUpdated: 'ken_updated',
  Exit: 'exit',
  GetToken: 'get_token',
  Token: 'token',
} as const;

export const ARCADE_ATTENTION_REASON = {
  YourTurn: 'your_turn',
  MatchStarted: 'match_started',
  OpponentJoined: 'opponent_joined',
  OpponentReady: 'opponent_ready',
  OpponentLeft: 'opponent_left',
  RoomKicked: 'room_kicked',
  OpponentDisconnected: 'opponent_disconnected',
  NewChat: 'new_chat',
  GameOver: 'game_over',
} as const;

export type ArcadeBridgeEvent =
  (typeof ARCADE_BRIDGE_EVENT)[keyof typeof ARCADE_BRIDGE_EVENT];
export type ArcadeAttentionReason =
  (typeof ARCADE_ATTENTION_REASON)[keyof typeof ARCADE_ATTENTION_REASON];

export interface ArcadeBridgeMessage<TData = unknown> {
  source?: string;
  type?: string;
  data?: TData;
}

export interface ArcadeAttentionData {
  reason: ArcadeAttentionReason;
  roomId?: string;
  matchId?: string;
}

export interface ArcadeKenUpdatedData {
  ken: number;
}
