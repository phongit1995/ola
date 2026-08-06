import type { TFunction } from 'i18next';
import type { CallerBrief } from '../types/client/call.type';
import type { MessageMetadata } from '../types/lib.type';

export function formatCallDuration(seconds: number): string {
  const safe = Math.max(0, Math.floor(seconds));
  const minutes = Math.floor(safe / 60);
  const rest = safe % 60;
  return `${minutes}:${rest.toString().padStart(2, '0')}`;
}

export function peerDisplayName(peer: CallerBrief, fallback: string): string {
  return peer.fullName ?? peer.username ?? fallback;
}

export interface CallMessageView {
  isVideo: boolean;
  missed: boolean;
  title: string;
  detail: string;
}

export function callMessageView(
  t: TFunction,
  meta: MessageMetadata
): CallMessageView {
  const isVideo = meta.callType === 'video';
  const missed = meta.callStatus === 'missed' || meta.callStatus === 'declined';
  const detail =
    meta.callStatus === 'missed'
      ? t('call.missedCall')
      : meta.callStatus === 'declined'
        ? t('call.declinedCall')
        : formatCallDuration(meta.durationSeconds ?? 0);
  return {
    isVideo,
    missed,
    title: isVideo ? t('call.videoCall') : t('call.voiceCall'),
    detail,
  };
}
