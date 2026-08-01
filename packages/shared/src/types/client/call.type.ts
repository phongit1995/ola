import type { StoreApi } from 'zustand';
import type { CallType } from '../api/call.type';
import type { IncomingCallEvent } from '../realtime/call.type';

export type CallMode = 'idle' | 'incoming' | 'outgoing' | 'active';

export interface CallerBrief {
  id: string;
  username?: string;
  fullName?: string;
  avatar?: string;
}

export interface ActiveCall {
  callId: string;
  conversationId: string;
  callType: CallType;
  roomName: string;
  wsUrl: string;
  token: string;
  peer: CallerBrief;
}

export interface IncomingCall extends IncomingCallEvent {
  caller: CallerBrief;
}

export interface WidgetPosition {
  x: number;
  y: number;
}

export interface CallState {
  mode: CallMode;
  incoming: IncomingCall | null;
  active: ActiveCall | null;
  expanded: boolean;
  miniPos: WidgetPosition | null;
  incomingPos: WidgetPosition | null;
  localVideoPos: WidgetPosition | null;
  localVideoWidth: number | null;
  selectedMicId: string | null;
  selectedCamId: string | null;
  selectedSpeakerId: string | null;
  micMuted: boolean;
  camOff: boolean;
  locallyEndedCallId: string | null;

  startCall: (
    conversationId: string,
    callType: CallType,
    peer: CallerBrief
  ) => Promise<void>;
  answerIncoming: () => Promise<void>;
  declineIncoming: () => void;
  endActive: () => void;
  markRemoteJoined: () => void;
  setExpanded: (expanded: boolean) => void;
  setMiniPos: (pos: WidgetPosition) => void;
  setIncomingPos: (pos: WidgetPosition) => void;
  setLocalVideoPos: (pos: WidgetPosition) => void;
  setLocalVideoWidth: (width: number) => void;
  setSelectedMicId: (id: string | null) => void;
  setSelectedCamId: (id: string | null) => void;
  setSelectedSpeakerId: (id: string | null) => void;
  setMicMuted: (muted: boolean) => void;
  setCamOff: (off: boolean) => void;
  reset: () => void;
}

export type CallSet = StoreApi<CallState>['setState'];
export type CallGet = StoreApi<CallState>['getState'];

export type CallStateData = Pick<
  CallState,
  | 'mode'
  | 'incoming'
  | 'active'
  | 'expanded'
  | 'miniPos'
  | 'incomingPos'
  | 'localVideoPos'
  | 'localVideoWidth'
  | 'selectedMicId'
  | 'selectedCamId'
  | 'selectedSpeakerId'
  | 'micMuted'
  | 'camOff'
  | 'locallyEndedCallId'
>;
