import type { TFunction } from 'i18next';
import type { Conversation } from '../types/api/chat.type';
import type { PublicProfile } from '../types/api/user.type';
import type { CallerBrief } from '../types/client/call.type';
import type { MessageMetadata } from '../types/lib.type';
import { CALL_STATUS, CALL_TYPE } from '../constants/call';
import { CONVERSATION_KIND } from '../constants/chat';

export function formatCallDuration(seconds: number): string {
  const safe = Math.max(0, Math.floor(seconds));
  const minutes = Math.floor(safe / 60);
  const rest = safe % 60;
  return `${minutes}:${rest.toString().padStart(2, '0')}`;
}

export function peerDisplayName(peer: CallerBrief, fallback: string): string {
  return peer.fullName ?? peer.username ?? fallback;
}

export function withCallPeerFrame(
  peer: CallerBrief,
  conversation: Conversation | null | undefined,
  peerProfile: PublicProfile | null | undefined
): CallerBrief {
  if (peer.avatarFrameId != null) return peer;
  const other =
    conversation?.type === CONVERSATION_KIND.direct && conversation.otherUser?.id === peer.id
      ? conversation.otherUser
      : null;
  const profile = peerProfile?.id === peer.id ? peerProfile : null;
  const avatarFrameId = other?.avatarFrameId ?? profile?.avatarFrameId;
  return avatarFrameId != null ? { ...peer, avatarFrameId } : peer;
}

export interface CallPeerNameView {
  title: string;
  subtitle: string | null;
}

export function callPeerNameView(
  peer: CallerBrief,
  fallback: string
): CallPeerNameView {
  const username = peer.username ?? '';
  const fullName = peer.fullName ?? '';
  if (username === '') {
    return { title: fullName === '' ? fallback : fullName, subtitle: null };
  }
  return { title: `@${username}`, subtitle: fullName === '' ? null : fullName };
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
  const isVideo = meta.callType === CALL_TYPE.video;
  const missed = meta.callStatus === CALL_STATUS.missed || meta.callStatus === CALL_STATUS.declined;
  const detail =
    meta.callStatus === CALL_STATUS.missed
      ? t('call.missedCall')
      : meta.callStatus === CALL_STATUS.declined
        ? t('call.declinedCall')
        : formatCallDuration(meta.durationSeconds ?? 0);
  return {
    isVideo,
    missed,
    title: isVideo ? t('call.videoCall') : t('call.voiceCall'),
    detail,
  };
}
