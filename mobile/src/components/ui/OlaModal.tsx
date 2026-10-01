import { Modal, type ModalProps } from 'react-native';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { AppLockOverlaySlot, useBlockedByAppLock } from '@components/applock/appLockModal';

function noop() {}

export function OlaModal({ children, visible, onRequestClose, ...props }: ModalProps) {
  const blocked = useBlockedByAppLock();
  return (
    <Modal {...props} visible={visible !== false} onRequestClose={blocked ? noop : onRequestClose}>
      <SafeAreaProvider>
        {children}
        <AppLockOverlaySlot />
      </SafeAreaProvider>
    </Modal>
  );
}
