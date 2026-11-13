import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, UserRow } from '@components';
import { toast } from '@lib';
import { useVipDayTransferForm } from '@ola/shared/stores/vip/useVipDayTransferForm';
import { VipDayTransferFields } from '@/pages/vip/components/VipDayTransferFields';
import { VipDayTransferSummary } from '@/pages/vip/components/VipDayTransferSummary';
import vipIcon from '@/assets/icons/apps/vip.png';
import type { TransferReceiver } from '../types';

interface VipDayTransferDialogProps {
  open: boolean;
  onClose: () => void;
  receiver: TransferReceiver;
}

export function VipDayTransferDialog({
  open,
  onClose,
  receiver,
}: VipDayTransferDialogProps) {
  const { t } = useTranslation();
  const form = useVipDayTransferForm(t);
  const [step, setStep] = useState<'input' | 'confirm'>('input');
  const [password, setPassword] = useState('');

  function goToConfirm() {
    const inputError = form.inputError();
    if (inputError != null) {
      toast.error(inputError);
      return;
    }
    setStep('confirm');
  }

  async function submit() {
    if (receiver.username == null || receiver.username === '') {
      toast.error(t('chat.actionError'));
      return;
    }
    if (password.trim() === '') {
      toast.error(t('vip.buy.needPassword'));
      return;
    }
    if (await form.submit(receiver.username, password)) onClose();
  }

  const receiverRow = (
    <UserRow
      name={receiver.name}
      username={receiver.username}
      avatar={receiver.avatar}
      color={receiver.color}
    />
  );

  const footer =
    step === 'input' ? (
      <DialogButton variant="green" onClick={goToConfirm}>
        {t('chat.transferVipDaysOk')}
      </DialogButton>
    ) : (
      <>
        <DialogButton
          onClick={() => setStep('input')}
          disabled={form.submitting}
        >
          {t('chat.transferVipDaysEdit')}
        </DialogButton>
        <DialogButton
          variant="green"
          onClick={() => void submit()}
          disabled={form.submitting}
        >
          {t('vip.buy.actionTransferDays')}
        </DialogButton>
      </>
    );

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('vip.buy.titleTransferDays')}
      icon={<img src={vipIcon} alt="" className="h-6 w-6 object-contain" />}
      footer={footer}
    >
      {step === 'input' ? (
        <div className="flex flex-col gap-2 px-1 py-1">
          <span className="text-base text-black/87">
            {t('chat.transferVipDaysReceiverLabel')}
          </span>
          <div className="rounded border border-black/12 px-3">
            {receiverRow}
          </div>
          <div className="mt-2">
            <VipDayTransferFields form={form} />
          </div>
        </div>
      ) : (
        <div className="flex flex-col gap-1 px-1 py-1">
          <span className="text-base text-black/54">
            {t('chat.transferVipDaysReceiverLabel')}
          </span>
          {receiverRow}
          <p className="mt-3">
            <VipDayTransferSummary
              senderDays={form.senderDays}
              receiverDays={form.receiverDays}
              receiver={receiver.username ?? receiver.name}
            />
          </p>
          <p className="mt-3 rounded-lg border border-ola-error/30 bg-ola-error/5 px-3 py-2.5 text-center text-sm font-semibold text-ola-error/80">
            {t('vip.buy.transferDaysWarning')}
          </p>
          <span className="mt-4 text-base text-black/87">
            {t('vip.buy.passwordLabel')}
          </span>
          <input
            type="password"
            autoFocus
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            onKeyDown={(event) => {
              if (event.key === 'Enter' && !form.submitting) void submit();
            }}
            placeholder={t('vip.buy.passwordPlaceholder')}
            className="mt-1 w-full rounded border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
          />
        </div>
      )}
    </Dialog>
  );
}
