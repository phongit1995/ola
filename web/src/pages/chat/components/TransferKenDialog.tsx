import { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, Dialog, DialogButton } from '@components';
import { formatKen, toApiError, toast } from '@lib';
import { KenService } from '@services';
import { useAuthStore } from '@/store/authStore';
import kenIcon from '@/assets/icons/apps/ken.png';

const KEN_TRANSFER_MIN = 1000;
const KEN_TRANSFER_MAX = 10_000_000;

interface TransferKenReceiver {
  id: string;
  name: string;
  fullName?: string;
  avatar?: string;
  color: string;
}

interface TransferKenDialogProps {
  open: boolean;
  onClose: () => void;
  receiver: TransferKenReceiver;
}

function onlyDigits(value: string): string {
  return value.replace(/\D/g, '').slice(0, 12);
}

export function TransferKenDialog({ open, onClose, receiver }: TransferKenDialogProps) {
  const { t } = useTranslation();
  const myId = useAuthStore((s) => s.user?.id ?? '');
  const balance = useAuthStore((s) => s.user?.ken ?? 0);
  const setUser = useAuthStore((s) => s.setUser);

  const [step, setStep] = useState<'input' | 'confirm'>('input');
  const [amountDigits, setAmountDigits] = useState('');
  const [password, setPassword] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const amountInputRef = useRef<HTMLInputElement>(null);

  const amount = amountDigits === '' ? 0 : Number(amountDigits);
  const displayAmount = amountDigits === '' ? '' : formatKen(amount);

  function goToConfirm() {
    if (amount <= 0) {
      toast.error(t('chat.transferKenErrEmpty'));
      return;
    }
    if (receiver.id === myId) {
      toast.error(t('chat.transferKenErrSelf'));
      return;
    }
    if (amount < KEN_TRANSFER_MIN) {
      toast.error(t('chat.transferKenErrMin', { min: formatKen(KEN_TRANSFER_MIN) }));
      return;
    }
    if (amount > KEN_TRANSFER_MAX) {
      toast.error(t('chat.transferKenErrMax', { max: formatKen(KEN_TRANSFER_MAX) }));
      return;
    }
    if (amount > balance) {
      toast.error(t('chat.transferKenErrNotEnough'));
      return;
    }
    setStep('confirm');
  }

  async function submitTransfer() {
    if (password.trim() === '') {
      toast.error(t('chat.transferKenErrPasswordEmpty'));
      return;
    }
    setSubmitting(true);
    try {
      const result = await KenService.transfer({ toUserId: receiver.id, amount, password });
      const current = useAuthStore.getState().user;
      if (current != null) setUser({ ...current, ken: result.kenBalance });
      toast.success(t('chat.transferKenSuccess', { name: receiver.name }));
      onClose();
    } catch (error) {
      const apiError = toApiError(error);
      if (apiError.status === 0) {
        toast.error(t('chat.transferKenError'));
      } else if (apiError.status === 401) {
        toast.error(t('chat.transferKenErrPassword'));
      } else if (apiError.status === 403) {
        toast.error(t('chat.transferKenErrBlocked'));
      } else {
        toast.error(apiError.message);
      }
    } finally {
      setSubmitting(false);
    }
  }

  const title = step === 'input' ? t('chat.transferKenTitle') : t('chat.transferKenConfirmTitle');

  const footer =
    step === 'input' ? (
      <DialogButton variant="green" onClick={goToConfirm}>
        {t('chat.transferKenOk')}
      </DialogButton>
    ) : (
      <>
        <DialogButton onClick={() => setStep('input')} disabled={submitting}>
          {t('chat.transferKenEdit')}
        </DialogButton>
        <DialogButton variant="green" onClick={() => void submitTransfer()} disabled={submitting}>
          {t('chat.transferKenOk')}
        </DialogButton>
      </>
    );

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={title}
      icon={<img src={kenIcon} alt="" className="h-6 w-6 object-contain" />}
      footer={footer}
    >
      {step === 'input' ? (
        <div className="flex flex-col gap-1 px-1 py-1">
          <div className="flex items-center justify-center gap-2 text-lg font-bold">
            <span className="text-black/54">{t('chat.transferKenBalance')}</span>
            <span className="text-black/87">
              {formatKen(balance)} {t('chat.transferKenUnit')}
            </span>
          </div>
          <div className="my-2 h-px bg-black/12" />
          <span className="text-base text-black/87">{t('chat.transferKenReceiver')}</span>
          <div className="mt-1 flex items-center gap-3 rounded border border-black/12 px-3 py-2">
            <Avatar name={receiver.name} color={receiver.color} src={receiver.avatar} size={32} />
            <div className="min-w-0">
              <p className="truncate text-base text-black/87">{receiver.name}</p>
              {receiver.fullName != null && receiver.fullName !== '' && (
                <p className="truncate text-xs text-black/54">{receiver.fullName}</p>
              )}
            </div>
          </div>
          <span className="mt-4 text-base text-black/87">{t('chat.transferKenAmountLabel')}</span>
          <input
            ref={amountInputRef}
            autoFocus
            inputMode="numeric"
            value={displayAmount}
            onChange={(event) => setAmountDigits(onlyDigits(event.target.value))}
            placeholder={t('chat.transferKenAmountPlaceholder')}
            className="mt-1 w-full rounded border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
          />
        </div>
      ) : (
        <div className="flex flex-col gap-1 px-1 py-1">
          <span className="text-base text-black/54">{t('chat.transferKenReceiver')}</span>
          <div className="mt-2 flex items-center gap-4">
            <Avatar name={receiver.name} color={receiver.color} src={receiver.avatar} size={48} />
            <div className="min-w-0">
              <p className="truncate text-base text-black/87">{receiver.name}</p>
              {receiver.fullName != null && receiver.fullName !== '' && (
                <p className="truncate text-xs text-black/54">{receiver.fullName}</p>
              )}
            </div>
          </div>
          <span className="mt-4 text-base text-black/54">
            {t('chat.transferKenConfirmAmountLabel')}
          </span>
          <p className="mt-2 text-lg font-bold text-black/87">
            {formatKen(amount)} {t('chat.transferKenUnit')}
          </p>
          <div className="mt-4 h-px bg-black/12" />
          <span className="mt-4 text-base text-black/87">{t('chat.transferKenPassword')}</span>
          <input
            type="password"
            autoFocus
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            onKeyDown={(event) => {
              if (event.key === 'Enter' && !submitting) void submitTransfer();
            }}
            placeholder={t('chat.transferKenPasswordPlaceholder')}
            className="mt-1 w-full rounded border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
          />
        </div>
      )}
    </Dialog>
  );
}
