import { useRef, useState } from 'react';
import { useDebouncedCallback } from 'use-debounce';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, UserRow } from '@components';
import { colorForName, formatKen, toApiError, toast } from '@lib';
import { KenService, UserService } from '@services';
import type { UserSearchResult } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import kenIcon from '@/assets/icons/apps/ken.png';

const KEN_TRANSFER_MIN = 1000;
const KEN_TRANSFER_MAX = 10_000_000;

interface TransferKenReceiver {
  id: string;
  name: string;
  username?: string;
  avatar?: string;
  color: string;
}

interface TransferKenDialogProps {
  open: boolean;
  onClose: () => void;
  receiver?: TransferKenReceiver;
}

type Step = 'recipient' | 'input' | 'confirm';

function onlyDigits(value: string): string {
  return value.replace(/\D/g, '').slice(0, 12);
}

function toReceiver(user: UserSearchResult): TransferKenReceiver {
  return {
    id: user.id,
    name: user.fullName || user.username,
    username: user.username,
    avatar: user.avatar,
    color: colorForName(user.username),
  };
}

export function TransferKenDialog({ open, onClose, receiver }: TransferKenDialogProps) {
  const { t } = useTranslation();
  const myId = useAuthStore((s) => s.user?.id ?? '');
  const balance = useAuthStore((s) => s.user?.ken ?? 0);
  const setUser = useAuthStore((s) => s.setUser);

  const [step, setStep] = useState<Step>(receiver != null ? 'input' : 'recipient');
  const [pickedReceiver, setPickedReceiver] = useState<TransferKenReceiver | null>(null);
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<UserSearchResult[]>([]);
  const [searching, setSearching] = useState(false);
  const [amountDigits, setAmountDigits] = useState('');
  const [password, setPassword] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const amountInputRef = useRef<HTMLInputElement>(null);

  const runSearch = useDebouncedCallback((value: string) => {
    if (value === '') {
      setResults([]);
      setSearching(false);
      return;
    }
    setSearching(true);
    UserService.search(value, 30)
      .then((res) => setResults(res.users))
      .catch(() => setResults([]))
      .finally(() => setSearching(false));
  }, 300);

  const activeReceiver = receiver ?? pickedReceiver;
  const amount = amountDigits === '' ? 0 : Number(amountDigits);
  const displayAmount = amountDigits === '' ? '' : formatKen(amount);

  function handleQueryChange(value: string) {
    setQuery(value);
    runSearch(value.trim());
  }

  function pickReceiver(user: UserSearchResult) {
    runSearch.cancel();
    setPickedReceiver(toReceiver(user));
    setQuery('');
    setResults([]);
    setStep('input');
  }

  function changeReceiver() {
    setPickedReceiver(null);
    setAmountDigits('');
    setStep('recipient');
  }

  function goToConfirm() {
    if (activeReceiver == null) return;
    if (amount <= 0) {
      toast.error(t('chat.transferKenErrEmpty'));
      return;
    }
    if (activeReceiver.id === myId) {
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
    if (activeReceiver == null) return;
    if (password.trim() === '') {
      toast.error(t('chat.transferKenErrPasswordEmpty'));
      return;
    }
    setSubmitting(true);
    try {
      const result = await KenService.transfer({ toUserId: activeReceiver.id, amount, password });
      const current = useAuthStore.getState().user;
      if (current != null) setUser({ ...current, ken: result.kenBalance });
      toast.success(t('chat.transferKenSuccess', { name: activeReceiver.name }));
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

  const title = step === 'confirm' ? t('chat.transferKenConfirmTitle') : t('chat.transferKenTitle');

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
      {step === 'recipient' ? (
        <div className="flex flex-col gap-1 px-1 py-1">
          <span className="text-base text-black/87">{t('chat.transferKenReceiver')}</span>
          <input
            autoFocus
            type="text"
            value={query}
            onChange={(event) => handleQueryChange(event.target.value)}
            placeholder={t('chat.transferKenReceiverHint')}
            className="mt-1 w-full rounded border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
          />
          {query.trim() !== '' && (
            <div className="mt-2 max-h-56 overflow-y-auto rounded border border-black/12">
              {searching ? (
                <p className="py-3 text-center text-sm text-black/54">{t('common.loading')}</p>
              ) : results.length === 0 ? (
                <p className="py-3 text-center text-sm text-black/54">{t('chat.composeSearchEmpty')}</p>
              ) : (
                <ul className="divide-y divide-black/8 px-2">
                  {results.map((item) => (
                    <li key={item.id}>
                      <UserRow
                        name={item.fullName || item.username}
                        username={item.username}
                        avatar={item.avatar}
                        color={colorForName(item.username)}
                        online={item.isOnline}
                        onClick={() => pickReceiver(item)}
                      />
                    </li>
                  ))}
                </ul>
              )}
            </div>
          )}
        </div>
      ) : step === 'input' ? (
        <div className="flex flex-col gap-1 px-1 py-1">
          <div className="flex items-center justify-center gap-2 text-lg font-bold">
            <span className="text-black/54">{t('chat.transferKenBalance')}</span>
            <span className="text-black/87">
              {formatKen(balance)} {t('chat.transferKenUnit')}
            </span>
          </div>
          <div className="my-2 h-px bg-black/12" />
          <div className="flex items-center justify-between">
            <span className="text-base text-black/87">{t('chat.transferKenReceiver')}</span>
            {receiver == null && (
              <button
                type="button"
                onClick={changeReceiver}
                className="text-sm font-medium text-ola-primary active:opacity-70"
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
          <UserRow
            name={activeReceiver?.name ?? ''}
            username={activeReceiver?.username}
            avatar={activeReceiver?.avatar}
            color={activeReceiver?.color ?? '#999'}
          />
          <span className="mt-4 text-base text-black/54">{t('chat.transferKenConfirmAmountLabel')}</span>
          <p className="mt-2 text-lg font-bold text-black/87">
            {formatKen(amount)} {t('chat.transferKenUnit')}
          </p>
          <p className="mt-3 rounded-lg border border-ola-error/30 bg-ola-error/5 px-3 py-2.5 text-center text-sm font-semibold text-ola-error/80">
            {t('chat.transferKenWarning')}
          </p>
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
