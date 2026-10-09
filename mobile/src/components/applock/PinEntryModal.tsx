import { OlaModal } from '@components/ui/OlaModal';
import { PinCreate } from './PinCreate';
import { PinVerify } from './PinVerify';

export type PinEntryMode = 'verify' | 'create';

interface PinEntryModalProps {
  visible: boolean;
  mode: PinEntryMode;
  title: string;
  allowBiometric?: boolean;
  onSuccess: (pin: string) => void;
  onCancel: () => void;
  onDismiss?: () => void;
}

export function PinEntryModal({
  visible,
  mode,
  title,
  allowBiometric = false,
  onSuccess,
  onCancel,
  onDismiss,
}: PinEntryModalProps) {
  return (
    <OlaModal
      visible={visible}
      animationType="slide"
      statusBarTranslucent
      navigationBarTranslucent
      onRequestClose={onCancel}
      onDismiss={onDismiss}
    >
      {mode === 'create' ? (
        <PinCreate onSuccess={onSuccess} onCancel={onCancel} />
      ) : (
        <PinVerify
          title={title}
          allowBiometric={allowBiometric}
          autoPrompt={allowBiometric}
          onSuccess={() => onSuccess('')}
          onCancel={onCancel}
        />
      )}
    </OlaModal>
  );
}
