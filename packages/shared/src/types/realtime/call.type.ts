import type { CallType } from '../api/call.type';

export interface IncomingCallEvent {
  callId: string;
  conversationId: string;
  callerId: string;
  callType: CallType;
  roomName: string;
  startedAt: string;
  ringTimeoutSeconds?: number;
}

export interface CallAcceptedEvent {
  callId: string;
  conversationId: string;
  answeredBy: string;
}

export interface CallDeclinedEvent {
  callId: string;
  conversationId: string;
  declinedBy: string;
}

export type CallEndedStatus = 'ended' | 'missed';

export interface CallEndedEvent {
  callId: string;
  conversationId: string;
  endedBy?: string;
  status: CallEndedStatus;
  durationSeconds: number;
}
