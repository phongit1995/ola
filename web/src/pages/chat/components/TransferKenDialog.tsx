import { useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, UserRow, UserSearchPicker } from '@components';
import { colorForName, formatKen } from '@lib';
import type { UserSearchResult } from '@app-types';
import kenIcon from '@/assets/icons/apps/ken.png';
import { useTransferKen } from '@ola/shared/stores/ken/useTransferKen';
import type { TransferReceiver } from '../types';

interface TransferKenDialogProps {
  open: boolean;
  onClose: () => void;
  receiver?: TransferReceiver;
}

function toReceiver(user: UserSearchResult): TransferReceiver {
  return {
    id: user.id,
    name: user.fullName || user.username,
    username: user.username,
    avatar: user.avatar,
    color: colorForName(user.username),
  };
}

export function TransferKenDialog({
  open,
  onClose,
  receiver,
}: TransferKenDialogProps) {
  const { t } = useTranslation();
  const {
    balance,
    step,
    setStep,
    activeReceiver,
    amount,
    displayAmount,
    changeAmount,
    password,
    setPassword,
    submitting,
    pickReceiver,
    changeReceiver,
    goToConfirm,
    submitTransfer,
  } = useTransferKen({ receiver, toReceiver, onDone: onClose });
  const amountInputRef = useRef<HTMLInputElement>(null);

  const title =
    step === 'confirm'
      ? t('chat.transferKenConfirmTitle')
      : t('chat.transferKenTitle');

  const footer =
    step === 'recipient' ? undefined : step === 'input' ? (
      <DialogButton variant="green" onClick={goToConfirm}>
        {t('chat.transferKenOk')}
      </DialogButton>
    ) : (
      <>
        <DialogButton onClick={() => setStep('input')} disabled={submitting}>
          {t('chat.transferKenEdit')}
        </DialogButton>
        <DialogButton
          variant="green"
          onClick={() => void submitTransfer()}
          disabled={submitting}
        >
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
      {step === 'recipient' ? (
        <UserSearchPicker
          label={t('chat.transferKenReceiver')}
          placeholder={t('chat.transferKenReceiverHint')}
          onPick={pickReceiver}
        />
      ) : step === 'input' ? (
        <div className="flex flex-col gap-1 px-1 py-1">
          <div className="flex items-center justify-center gap-2 text-lg font-bold">
            <span className="text-black/54">
              {t('chat.transferKenBalance')}
            </span>
            <span className="text-black/87">
              {formatKen(balance)} {t('chat.transferKenUnit')}
            </span>
          </div>
          <div className="my-2 h-px bg-black/12" />
          <div className="flex items-center justify-between">
            <span className="text-base text-black/87">
              {t('chat.transferKenReceiver')}
            </span>
            {receiver == null && (
              <button
                type="button"
                onClick={changeReceiver}
                className="text-sm font-medium text-ola-primary-ink active:opacity-70"
              >
                {t('chat.transferKenChangeReceiver')}
              </button>
            )}
          </div>
          <div className="mt-1 rounded border border-black/12 px-3">
            <UserRow
              name={activeReceiver?.name ?? ''}
              username={activeReceiver?.username}
              avatar={activeReceiver?.avatar}
              color={activeReceiver?.color ?? '#999'}
            />
          </div>
          <span className="mt-4 text-base text-black/87">
            {t('chat.transferKenAmountLabel')}
          </span>
          <input
            ref={amountInputRef}
            autoFocus
            inputMode="numeric"
            value={displayAmount}
            onChange={(event) =>
              changeAmount(event.target.value)
            }
            placeholder={t('chat.transferKenAmountPlaceholder')}
            className="mt-1 w-full rounded border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
          />
        </div>
      ) : (
        <div className="flex flex-col gap-1 px-1 py-1">
          <span className="text-base text-black/54">
            {t('chat.transferKenReceiver')}
          </span>
          <UserRow
            name={activeReceiver?.name ?? ''}
            username={activeReceiver?.username}
            avatar={activeReceiver?.avatar}
            color={activeReceiver?.color ?? '#999'}
          />
          <span className="mt-4 text-base text-black/54">
            {t('chat.transferKenConfirmAmountLabel')}
          </span>
          <p className="mt-2 text-lg font-bold text-black/87">
            {formatKen(amount)} {t('chat.transferKenUnit')}
          </p>
          <p className="mt-3 rounded-lg border border-ola-error/30 bg-ola-error/5 px-3 py-2.5 text-center text-sm font-semibold text-ola-error/80">
            {t('chat.transferKenWarning')}
          </p>
          <span className="mt-4 text-base text-black/87">
            {t('chat.transferKenPassword')}
          </span>
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
