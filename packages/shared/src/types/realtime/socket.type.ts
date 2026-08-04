export type ConnectionStatus = 'offline' | 'connected' | 'reconnecting';

export interface SessionReplacedData {
  reason?: string;
}

export interface ForceLogoutData {
  reason?: string;
}

export type EnvelopeHandler = (data: unknown) => void;
export type ReconnectHandler = () => void;
export type ConnectionStatusListener = () => void;
export type SessionReplacedHandler = (data: SessionReplacedData) => void;
export type ForceLogoutHandler = (data: ForceLogoutData) => void;

export type RealtimeRegistration =
  | 'app-notification'
  | 'call'
  | 'chat'
  | 'ken'
  | 'room';
