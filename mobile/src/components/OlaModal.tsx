import { Modal, type ModalProps } from 'react-native';
import { SafeAreaProvider } from 'react-native-safe-area-context';

export function OlaModal({ children, ...props }: ModalProps) {
  return (
    <Modal {...props}>
      <SafeAreaProvider>{children}</SafeAreaProvider>
    </Modal>
  );
}
