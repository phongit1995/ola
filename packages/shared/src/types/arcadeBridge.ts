import type {
  ARCADE_ATTENTION_REASON,
  ARCADE_BRIDGE_EVENT,
} from '../constants/arcadeBridge';

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
