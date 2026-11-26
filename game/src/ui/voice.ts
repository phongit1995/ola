import type { VoiceIssue, VoiceState } from '../sdk';

export const VOICE_ISSUE_TEXT: Record<VoiceIssue, string> = {
  permission: 'Chưa dùng được micro. Hãy cho phép micro trong cài đặt hoặc cập nhật app Ola.',
  device: 'Không mở được micro trên máy này.',
  unsupported: 'Máy hoặc bản app này chưa hỗ trợ nói chuyện trong bàn.',
  interrupted: 'Micro vừa bị ngắt, có thể do đang có cuộc gọi khác.',
};

export const VOICE_RETRY_TEXT = 'Đang kết nối lại voice…';

export function newVoiceIssueText(previous: VoiceState, next: VoiceState): string | null {
  return next.issue && next.issue !== previous.issue ? VOICE_ISSUE_TEXT[next.issue] : null;
}

export function peerMuteToastText(name: string, nowMuted: boolean): string {
  return nowMuted ? `Đã tắt tiếng ${name} trên máy bạn` : `Đã bật lại tiếng ${name}`;
}

export function readVoiceFlag(key: string): boolean {
  try {
    return localStorage.getItem(key) === '1';
  } catch {
    return false;
  }
}

export function writeVoiceFlag(key: string, value: boolean): void {
  try {
    localStorage.setItem(key, value ? '1' : '0');
  } catch {
    return;
  }
}

export type SelfMicState = 'on' | 'busy' | 'error' | 'off';

export interface SelfMicView {
  state: SelfMicState;
  busy: boolean;
  speaking: boolean;
  label: string;
}

export function selfMicView(voice: VoiceState, userId: string): SelfMicView | null {
  if (!userId || voice.status === 'off' || (voice.status === 'connected' && !voice.canSpeak)) return null;
  const failed = voice.status === 'failed';
  const busy = !failed && (voice.status !== 'connected' || voice.micBusy);
  const blocked = failed || (!voice.micOn && voice.issue != null);
  const state: SelfMicState = voice.micOn ? 'on' : busy ? 'busy' : blocked ? 'error' : 'off';
  const label = voice.micOn
    ? 'Mic đang bật, chạm để tắt'
    : failed
      ? 'Voice bị gián đoạn, chạm để kết nối lại'
      : busy
        ? 'Đang kết nối voice'
        : 'Mic đang tắt, chạm để bật';
  return { state, busy, speaking: voice.micOn && voice.speakingIds.includes(userId), label };
}

export type PeerVoiceState = 'on' | 'off' | 'muted';

export interface PeerVoiceView {
  state: PeerVoiceState;
  muted: boolean;
  speaking: boolean;
  label: string;
}

export function peerVoiceView(voice: VoiceState, userId: string, name: string): PeerVoiceView | null {
  if (!userId || voice.status === 'off' || !voice.presentIds.includes(userId)) return null;
  const muted = voice.mutedIds.includes(userId);
  const micOn = voice.micOnIds.includes(userId);
  const speaking = micOn && voice.speakerOn && !muted && voice.speakingIds.includes(userId);
  const label = muted
    ? `Bạn đã tắt tiếng ${name}, chạm để bật lại`
    : `${speaking ? `${name} đang nói` : micOn ? `${name} đang mở mic` : `${name} đang tắt mic`}, chạm để tắt tiếng`;
  return { state: muted ? 'muted' : micOn ? 'on' : 'off', muted, speaking, label };
}
