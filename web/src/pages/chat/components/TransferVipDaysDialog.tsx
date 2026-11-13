import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, Spinner, UserRow } from '@components';
import { formatKen } from '@lib';
import vipIcon from '@/assets/icons/apps/vip.png';
import { useTransferVipDays } from '@ola/shared/stores/vip/useTransferVipDays';
import type { TransferReceiver } from '../types';
import { TransferReceiverRow } from './TransferReceiverRow';

interface TransferVipDaysDialogProps {
  open: boolean;
  onClose: () => void;
  receiver: TransferReceiver;
}

export function TransferVipDaysDialog({
  open,
  onClose,
  receiver,
}: TransferVipDaysDialogProps) {
  const { t } = useTranslation();
  const {
    balance,
    step,
    setStep,
    loading,
    packages,
    selected,
    selectedId,
    setSelectedId,
    password,
    setPassword,
    submitting,
    goToConfirm,
    submitGift,
  } = useTransferVipDays({ receiver, enabled: true, onDone: onClose });

  const title =
    step === 'confirm'
      ? t('chat.transferVipDaysConfirmTitle')
      : t('chat.transferVipDaysTitle');

  const footer =
    step === 'select' ? (
      <DialogButton variant="green" onClick={goToConfirm}>
        {t('chat.transferVipDaysOk')}
      </DialogButton>
    ) : (
      <>
        <DialogButton onClick={() => setStep('select')} disabled={submitting}>
          {t('chat.transferVipDaysEdit')}
        </DialogButton>
        <DialogButton
          variant="green"
          onClick={() => void submitGift()}
          disabled={submitting}
        >
          {t('chat.transferVipDaysOk')}
        </DialogButton>
      </>
    );

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={title}
      icon={<img src={vipIcon} alt="" className="h-6 w-6 object-contain" />}
      footer={footer}
    >
      {step === 'select' ? (
        <div className="flex flex-col gap-1 px-1 py-1">
          <div className="flex items-center justify-center gap-2 text-lg font-bold">
            <span className="text-black/54">
              {t('chat.transferVipDaysBalance')}
            </span>
            <span className="text-black/87">
              {formatKen(balance)} {t('chat.transferKenUnit')}
            </span>
          </div>
          <div className="my-2 h-px bg-black/12" />
          <span className="text-base text-black/87">
            {t('chat.transferVipDaysReceiverLabel')}
          </span>
          <TransferReceiverRow receiver={receiver} className="mt-1" />
          <span className="mt-4 text-base text-black/87">
            {t('chat.transferVipDaysSelectLabel')}
          </span>
          {loading ? (
            <div className="flex justify-center py-4">
              <Spinner size={28} />
            </div>
          ) : packages.length === 0 ? (
            <p className="py-3 text-center text-sm text-black/54">
              {t('chat.transferVipDaysEmpty')}
            </p>
          ) : (
            <select
              value={selectedId ?? ''}
              onChange={(event) => setSelectedId(event.target.value)}
              className="mt-1 w-full cursor-pointer rounded border border-black/12 bg-white px-3 py-2.5 text-sm text-black/87 outline-none focus:border-ola-primary"
            >
              {packages.map((item) => (
                <option key={item.id} value={item.id}>
                  {item.name} ·{' '}
                  {t('chat.transferVipDaysDayUnit', { days: item.days })} ·{' '}
                  {formatKen(item.kenPrice)} {t('chat.transferKenUnit')}
                </option>
              ))}
            </select>
          )}
        </div>
      ) : (
        <div className="flex flex-col gap-1 px-1 py-1">
          <span className="text-base text-black/54">
            {t('chat.transferVipDaysReceiverLabel')}
          </span>
          <UserRow
            name={receiver.name}
            username={receiver.username}
            avatar={receiver.avatar}
            color={receiver.color}
          />
          <p className="mt-3 text-base text-black/87">
            {t('chat.transferVipDaysSummary', {
              name: selected?.name ?? '',
              days: selected?.days ?? 0,
              receiver: receiver.name,
              ken: formatKen(selected?.kenPrice ?? 0),
            })}
          </p>
          <p className="mt-3 rounded-lg border border-ola-error/30 bg-ola-error/5 px-3 py-2.5 text-center text-sm font-semibold text-ola-error/80">
            {t('chat.transferVipDaysWarning')}
          </p>
          <span className="mt-4 text-base text-black/87">
            {t('chat.transferVipDaysPasswordLabel')}
          </span>
          <input
            type="password"
            autoFocus
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            onKeyDown={(event) => {
              if (event.key === 'Enter' && !submitting) void submitGift();
            }}
            placeholder={t('chat.transferVipDaysPasswordPlaceholder')}
            className="mt-1 w-full rounded border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
          />
        </div>
      )}
    </Dialog>
  );
}
