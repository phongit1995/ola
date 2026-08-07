import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, Spinner, UserRow, VipIcon } from '@components';
import { toApiError, toast, vipName } from '@lib';
import { VipService } from '@services';
import type { VipIconInstance } from '@app-types';

interface TradingVipReceiver {
  id: string;
  name: string;
  username?: string;
  avatar?: string;
  color: string;
}

interface TradingVipDialogProps {
  open: boolean;
  onClose: () => void;
  receiver: TradingVipReceiver;
}

function ReceiverRow({ receiver }: { receiver: TradingVipReceiver }) {
  return (
    <div className="mt-2 rounded border border-black/12 px-3">
      <UserRow
        name={receiver.name}
        username={receiver.username}
        avatar={receiver.avatar}
        color={receiver.color}
      />
    </div>
  );
}

const VIP_STORE_LIMIT = 100;

export function TradingVipDialog({
  open,
  onClose,
  receiver,
}: TradingVipDialogProps) {
  const { t } = useTranslation();
  const [step, setStep] = useState<'select' | 'confirm'>('select');
  const [loading, setLoading] = useState(true);
  const [vips, setVips] = useState<VipIconInstance[]>([]);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [password, setPassword] = useState('');
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    let active = true;
    VipService.store({ limit: VIP_STORE_LIMIT })
      .then((res) => {
        if (active)
          setVips(res.items.filter((item) => !item.isUsing && !item.isLocked));
      })
      .catch(() => undefined)
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, []);

  const selected = vips.find((item) => item.instanceId === selectedId) ?? null;

  function pickVip(instanceId: string) {
    setSelectedId(instanceId);
    setStep('confirm');
  }

  async function submitTransfer() {
    if (selected == null) {
      toast.error(t('chat.tradingVipErrSelect'));
      return;
    }
    if (password.trim() === '') {
      toast.error(t('chat.tradingVipErrPassword'));
      return;
    }
    if (receiver.id === '') {
      toast.error(t('chat.actionError'));
      return;
    }
    setSubmitting(true);
    try {
      await VipService.transferIcon(selected.instanceId, {
        toUserId: receiver.id,
        password,
      });
      toast.success(t('chat.tradingVipSuccess', { name: receiver.name }));
      onClose();
    } catch (error) {
      const apiError = toApiError(error);
      if (apiError.status === 401) {
        toast.error(t('chat.tradingVipErrWrongPassword'));
      } else if (apiError.status === 403) {
        toast.error(t('chat.tradingVipErrNotAllowed'));
      } else if (apiError.status === 0) {
        toast.error(t('chat.tradingVipError'));
      } else {
        toast.error(apiError.message);
      }
    } finally {
      setSubmitting(false);
    }
  }

  const footer =
    step === 'confirm' ? (
      <>
        <DialogButton onClick={() => setStep('select')} disabled={submitting}>
          {t('chat.transferKenEdit')}
        </DialogButton>
        <DialogButton
          variant="green"
          onClick={() => void submitTransfer()}
          disabled={submitting}
        >
          {t('chat.tradingVipOk')}
        </DialogButton>
      </>
    ) : null;

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('chat.tradingVipTitle')}
      footer={footer}
    >
      {step === 'select' ? (
        <div className="flex flex-col gap-1 px-1 py-1">
          <span className="text-base text-black/54">
            {t('chat.tradingVipReceiverLabel')}
          </span>
          <ReceiverRow receiver={receiver} />

          <span className="mt-4 text-base text-black/87">
            {t('chat.tradingVipSelectLabel')}
          </span>
          {loading ? (
            <div className="flex justify-center py-6">
              <Spinner size={24} tone="muted" />
            </div>
          ) : vips.length === 0 ? (
            <p className="mt-2 text-sm text-black/54">
              {t('chat.tradingVipEmpty')}
            </p>
          ) : (
            <div className="mt-2 grid max-h-56 grid-cols-4 gap-2 overflow-y-auto">
              {vips.map((vip) => (
                <button
                  key={vip.instanceId}
                  type="button"
                  onClick={() => pickVip(vip.instanceId)}
                  className="flex flex-col items-center gap-1 rounded border border-black/12 p-2 active:scale-95 hover:bg-gray-50"
                >
                  <VipIcon typeId={vip.typeId} className="h-10 w-10" />
                  <span className="w-full truncate text-center text-[10px] text-black/54">
                    {vipName(vip.typeId)}
                  </span>
                </button>
              ))}
            </div>
          )}
        </div>
      ) : (
        <div className="flex flex-col gap-1 px-1 py-1">
          <span className="text-base text-black/54">
            {t('chat.tradingVipReceiverLabel')}
          </span>
          <ReceiverRow receiver={receiver} />

          <span className="mt-4 text-base text-black/54">
            {t('chat.tradingVipSelectLabel')}
          </span>
          {selected != null && (
            <div className="mt-2 flex items-center gap-2">
              <VipIcon typeId={selected.typeId} className="h-10 w-10" />
              <span className="text-sm font-semibold text-black/87">
                {vipName(selected.typeId)}
              </span>
            </div>
          )}

          <span className="mt-4 text-base text-black/87">
            {t('chat.tradingVipPasswordLabel')}
          </span>
          <input
            type="password"
            autoFocus
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            onKeyDown={(event) => {
              if (event.key === 'Enter' && !submitting) void submitTransfer();
            }}
            placeholder={t('chat.tradingVipPasswordPlaceholder')}
            className="mt-1 w-full rounded border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
          />
        </div>
      )}
    </Dialog>
  );
}
