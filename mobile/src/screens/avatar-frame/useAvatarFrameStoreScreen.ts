import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AVATAR_FRAME_PRIVACY_OPTIONS } from '@ola/shared/constants';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { useAvatarFrameCollection } from '@ola/shared/stores/avatar-frame/useAvatarFrameCollection';
import type { OwnedAvatarFrame } from '@ola/shared/types';
import type { ListOption } from '@components/ui/ListOptionDialog';

export function useAvatarFrameStoreScreen() {
  const { t } = useTranslation();
  const frames = useAvatarFrameCollection();
  const [menuFrame, setMenuFrame] = useState<OwnedAvatarFrame | null>(null);
  const [privacyOpen, setPrivacyOpen] = useState(false);

  function privacyOptions(): ListOption[] {
    return AVATAR_FRAME_PRIVACY_OPTIONS.map((option) => ({
      key: String(option.value),
      label: t(option.labelKey),
      onSelect: () => void frames.changePrivacy(option.value),
    }));
  }

  function menuOptions(frame: OwnedAvatarFrame): ListOption[] {
    return [
      frame.isEquipped
        ? { key: 'unequip', label: t('avatarFrame.actionUnequip'), onSelect: () => void frames.requestEquip(null) }
        : {
            key: 'equip',
            label: t('avatarFrame.actionEquip'),
            onSelect: () => void frames.requestEquip(frame.frameId),
          },
      { key: 'transfer', label: t('avatarFrame.actionTransfer'), onSelect: () => frames.requestTransfer(frame) },
    ];
  }

  const menuTitle = menuFrame != null ? avatarFrameLabel(menuFrame.frameId) : '';

  return {
    frames,
    store: frames.store,
    vipActive: frames.vipActive,
    equippedFrameId: frames.equippedFrameId,
    privacy: frames.privacy,
    menuFrame,
    setMenuFrame,
    menuTitle,
    menuOptions,
    transferFrameId: frames.transferFrameId,
    setTransferFrameId: frames.setTransferFrameId,
    privacyOpen,
    setPrivacyOpen,
    privacyOptions,
    vipPromptOpen: frames.vipPromptOpen,
    setVipPromptOpen: frames.setVipPromptOpen,
  };
}
