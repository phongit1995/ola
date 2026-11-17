import type { VoiceIssue } from '../../src/sdk';

export const VOICE_MIC_PRIMED_KEY = 'thirteen.voice.micPrimed';
export const VOICE_CREATE_ROOM_KEY = 'thirteen.voice.createRoom';

export const VOICE_ISSUE_TEXT: Record<VoiceIssue, string> = {
  permission: 'Chưa dùng được micro. Hãy cho phép micro trong cài đặt hoặc cập nhật app Ola.',
  device: 'Không mở được micro trên máy này.',
  unsupported: 'Máy hoặc bản app này chưa hỗ trợ nói chuyện trong bàn.',
  interrupted: 'Micro vừa bị ngắt, có thể do đang có cuộc gọi khác.',
};

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
