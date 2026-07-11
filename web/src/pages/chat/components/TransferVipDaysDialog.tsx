import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, Spinner, UserRow } from '@components';
import { formatKen, toApiError, toast } from '@lib';
import { VipService } from '@services';
import type { VipPackageItem } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import vipIcon from '@/assets/icons/apps/vip.png';

interface TransferVipDaysReceiver {
  id: string;
  name: string;
  username?: string;
  avatar?: string;
  color: string;
}

interface TransferVipDaysDialogProps {
  open: boolean;
  onClose: () => void;
  receiver: TransferVipDaysReceiver;
}

function ReceiverRow({ receiver }: { receiver: TransferVipDaysReceiver }) {
  return (
    <div className="mt-1 rounded border border-black/12 px-3">
      <UserRow
        name={receiver.name}
        username={receiver.username}
        avatar={receiver.avatar}
        color={receiver.color}
      />
    </div>
  );
}

export function TransferVipDaysDialog({ open, onClose, receiver }: TransferVipDaysDialogProps) {
  const { t } = useTranslation();
  const balance = useAuthStore((s) => s.user?.ken ?? 0);
  const setUser = useAuthStore((s) => s.setUser);

  const [step, setStep] = useState<'select' | 'confirm'>('select');
  const [loading, setLoading] = useState(true);
  const [packages, setPackages] = useState<VipPackageItem[]>([]);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [password, setPassword] = useState('');
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    let active = true;
    VipService.listPackages()
      .then((res) => {
        if (active) setPackages(res.items);
      })
      .catch(() => undefined)
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, []);

  const selected = packages.find((item) => item.id === selectedId) ?? null;

  function goToConfirm() {
    if (selected == null) {
      toast.error(t('chat.transferVipDaysErrSelect'));
      return;
    }
    if (selected.kenPrice > balance) {
      toast.error(t('chat.transferVipDaysErrNotEnough'));
      return;
    }
    setStep('confirm');
  }

  async function submitGift() {
    if (selected == null || receiver.username == null || receiver.username === '') {
      toast.error(t('chat.actionError'));
      return;
    }
    if (password.trim() === '') {
      toast.error(t('chat.transferVipDaysErrPassword'));
      return;
    }
    setSubmitting(true);
    try {
      const result = await VipService.giftPackage(selected.id, receiver.username, password);
      const current = useAuthStore.getState().user;
      if (current != null) setUser({ ...current, ken: result.kenBalance });
      toast.success(
        t('chat.transferVipDaysSuccess', { days: result.days, name: receiver.name }),
      );
      onClose();
    } catch (error) {
      const apiError = toApiError(error);
      if (apiError.status === 0) {
        toast.error(t('chat.transferVipDaysError'));
      } else if (apiError.status === 401) {
        toast.error(t('chat.transferVipDaysErrWrongPassword'));
      } else if (apiError.status === 403) {
        toast.error(t('chat.transferKenErrBlocked'));
      } else {
        toast.error(apiError.message);
      }
    } finally {
      setSubmitting(false);
    }
  }

  const title =
    step === 'confirm' ? t('chat.transferVipDaysConfirmTitle') : t('chat.transferVipDaysTitle');

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
        <DialogButton variant="green" onClick={() => void submitGift()} disabled={submitting}>
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
            <span className="text-black/54">{t('chat.transferVipDaysBalance')}</span>
            <span className="text-black/87">
              {formatKen(balance)} {t('chat.transferKenUnit')}
            </span>
          </div>
          <div className="my-2 h-px bg-black/12" />
          <span className="text-base text-black/87">{t('chat.transferVipDaysReceiverLabel')}</span>
          <ReceiverRow receiver={receiver} />
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
            <div className="mt-1 max-h-56 overflow-y-auto rounded border border-black/12">
              <ul className="divide-y divide-black/8">
                {packages.map((item) => {
                  const active = item.id === selectedId;
                  return (
                    <li key={item.id}>
                      <button
                        type="button"
                        onClick={() => setSelectedId(item.id)}
                        className={`flex w-full items-center justify-between px-3 py-2.5 text-left ${
                          active ? 'bg-ola-primary/10' : 'bg-white'
                        }`}
                      >
                        <span className="min-w-0">
                          <span
                            className={`block truncate text-sm font-medium ${
                              active ? 'text-ola-primary' : 'text-black/87'
                            }`}
                          >
                            {item.name}
                          </span>
                          <span className="block text-xs text-black/54">
                            {t('chat.transferVipDaysDayUnit', { days: item.days })}
                          </span>
                        </span>
                        <span
                          className={`ml-2 shrink-0 text-sm font-bold ${
                            active ? 'text-ola-primary' : 'text-black/87'
                          }`}
                        >
                          {formatKen(item.kenPrice)} {t('chat.transferKenUnit')}
                        </span>
                      </button>
                    </li>
                  );
                })}
              </ul>
            </div>
          )}
        </div>
      ) : (
        <div className="flex flex-col gap-1 px-1 py-1">
          <span className="text-base text-black/54">{t('chat.transferVipDaysReceiverLabel')}</span>
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
