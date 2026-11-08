import { useState } from 'react';
import i18n from 'i18next';
import { AVATAR_FRAME_ERROR_CODE, AVATAR_FRAME_PRIVACY } from '../../constants/avatarFrame';
import { toApiError } from '../../lib/apiError';
import { avatarFrameErrorKey } from '../../lib/avatarFrameErrors';
import { toast } from '../../lib/toast';
import type { AvatarFramePrivacy, OwnedAvatarFrame } from '../../types/api/avatarFrame.type';
import { useMyAvatarFrames } from './useMyAvatarFrames';

export function useAvatarFrameCollection() {
  const frames = useMyAvatarFrames();
  const [transferFrameId, setTransferFrameId] = useState<string | null>(null);
  const [vipPromptOpen, setVipPromptOpen] = useState(false);
  const { store, busy, equip, setPrivacy } = frames;
  const items = store?.items ?? [];
  const equippedFrameId = store?.equippedFrameId ?? null;
  const vipActive = store?.vipActive ?? false;
  const privacy: AvatarFramePrivacy = store?.privacy ?? AVATAR_FRAME_PRIVACY.public;

  async function requestEquip(frameId: string | null) {
    if (busy) return;
    if (frameId != null && !vipActive) {
      setVipPromptOpen(true);
      return;
    }
    try {
      await equip(frameId);
      toast.success(i18n.t(frameId != null ? 'avatarFrame.toastEquipped' : 'avatarFrame.toastUnequipped'));
    } catch (error) {
      if (toApiError(error).code === AVATAR_FRAME_ERROR_CODE.vipRequired) {
        setVipPromptOpen(true);
        return;
      }
      toast.error(i18n.t(avatarFrameErrorKey(error)));
    }
  }

  async function changePrivacy(value: AvatarFramePrivacy) {
    if (busy || value === privacy) return;
    try {
      await setPrivacy(value);
      toast.success(i18n.t('avatarFrame.privacyChanged'));
    } catch (error) {
      toast.error(i18n.t(avatarFrameErrorKey(error)));
    }
  }

  function requestTransfer(frame: OwnedAvatarFrame) {
    if (frame.isEquipped) {
      toast.info(i18n.t('avatarFrame.errors.inUse'));
      return;
    }
    setTransferFrameId(frame.frameId);
  }

  return {
    ...frames,
    items,
    equippedFrameId,
    vipActive,
    privacy,
    transferFrameId,
    setTransferFrameId,
    vipPromptOpen,
    setVipPromptOpen,
    requestEquip,
    changePrivacy,
    requestTransfer,
  };
}
