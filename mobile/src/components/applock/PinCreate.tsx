import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { PinEntryView } from './PinEntryView';

interface PinCreateProps {
  onSuccess: (pin: string) => void;
  onCancel: () => void;
}

export function PinCreate({ onSuccess, onCancel }: PinCreateProps) {
  const { t } = useTranslation();
  const [firstPin, setFirstPin] = useState<string | null>(null);
  const [mismatch, setMismatch] = useState(false);
  const [round, setRound] = useState(0);

  function handleSubmit(pin: string): boolean {
    if (firstPin == null) {
      setFirstPin(pin);
      setMismatch(false);
      setRound((value) => value + 1);
      return true;
    }
    if (pin === firstPin) {
      onSuccess(pin);
      return true;
    }
    setFirstPin(null);
    setMismatch(true);
    setRound((value) => value + 1);
    return false;
  }

  return (
    <PinEntryView
      title={firstPin == null ? t('appLock.createPin') : t('appLock.confirmPin')}
      errorText={mismatch ? t('appLock.pinMismatch') : null}
      onSubmit={handleSubmit}
      onCancel={onCancel}
      resetKey={round}
    />
  );
}
