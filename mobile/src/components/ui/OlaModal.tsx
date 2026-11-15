import { Modal, type ModalProps } from 'react-native';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { AppLockOverlaySlot, useBlockedByAppLock } from '@components/applock/appLockModal';
import { useTrackOpenModal } from '@store/openModalStore';
import { SocialLimitOverlaySlot } from '@components/socialLimit/socialLimitSlot';

function noop() {}

export function OlaModal({ children, visible, onRequestClose, ...props }: ModalProps) {
  const blocked = useBlockedByAppLock();
  const shown = visible !== false;
  useTrackOpenModal(shown);
  return (
    <Modal {...props} visible={shown} onRequestClose={blocked ? noop : onRequestClose}>
      <SafeAreaProvider>
        {children}
        <SocialLimitOverlaySlot />
        <AppLockOverlaySlot />
      </SafeAreaProvider>
    </Modal>
  );
}
