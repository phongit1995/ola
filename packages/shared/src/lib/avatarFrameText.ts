import type { TFunction } from 'i18next';
import { AVATAR_FRAME_PRIVACY_OPTIONS } from '../constants/avatarFrame';
import type {
  AvatarFramePrivacy,
  AvatarFramePurchaseItem,
  AvatarFrameTransferItem,
} from '../types/api/avatarFrame.type';
import { formatKen } from './number';

export type AvatarFrameHistoryTone = 'debit' | 'credit' | 'neutral';

export interface AvatarFrameHistoryLine {
  id: string;
  frameId: string;
  text: string;
  tone: AvatarFrameHistoryTone;
  amount?: string;
  createdAt: string;
}

export function avatarFramePrivacyLabelKey(privacy: AvatarFramePrivacy) {
  return (AVATAR_FRAME_PRIVACY_OPTIONS.find((option) => option.value === privacy) ?? AVATAR_FRAME_PRIVACY_OPTIONS[0])
    .labelKey;
}

export function avatarFramePurchaseLine(
  t: TFunction,
  item: AvatarFramePurchaseItem,
  myId: string | undefined,
): AvatarFrameHistoryLine {
  const paidByMe = item.buyer.id === myId;
  const receivedGift = item.recipient != null && !paidByMe;
  const text = receivedGift
    ? t('avatarFrame.history.receivedFrom', { name: item.buyer.username })
    : item.recipient != null
      ? t('avatarFrame.history.giftedTo', { name: item.recipient.username })
      : t('avatarFrame.history.bought');
  return {
    id: item.id,
    frameId: item.frameId,
    text,
    tone: receivedGift ? 'credit' : 'neutral',
    amount: paidByMe ? `-${t('avatarFrame.price', { price: formatKen(item.kenPrice) })}` : undefined,
    createdAt: item.createdAt,
  };
}

export function avatarFrameTransferLine(
  t: TFunction,
  item: AvatarFrameTransferItem,
  myId: string | undefined,
): AvatarFrameHistoryLine {
  const sent = item.from.id === myId;
  return {
    id: item.id,
    frameId: item.frameId,
    text: sent
      ? t('avatarFrame.history.sentTo', { name: item.to.username })
      : t('avatarFrame.history.receivedFrom', { name: item.from.username }),
    tone: sent ? 'debit' : 'credit',
    createdAt: item.createdAt,
  };
}
