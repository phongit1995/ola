import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { TFunction } from 'i18next';
import { ApiError, formatKen, toast } from '@lib';
import { SettingsService, UserService } from '@services';
import { Dialog, DialogButton } from '@components';
import { useAuthStore } from '@/store/authStore';
import type {
  CheckUsernameResult,
  UsernameChangeTier,
} from '@ola/shared/types';
import kenIcon from '@/assets/icons/apps/ken.png';

const USERNAME_MIN = 2;
const USERNAME_MAX = 20;
const USERNAME_PATTERN = /^[a-z0-9][a-z0-9._-]*[a-z0-9]$/;
const CHECK_DEBOUNCE_MS = 400;

function normalizeNickname(value: string): string {
  return value.trim().toLowerCase().replace(/^@/, '');
}

function isValidNickname(nickname: string): boolean {
  return (
    nickname.length >= USERNAME_MIN &&
    nickname.length <= USERNAME_MAX &&
    USERNAME_PATTERN.test(nickname)
  );
}

function isDisabledError(err: unknown): boolean {
  return err instanceof ApiError && /disabled/i.test(err.message);
}

function tierLabel(
  tier: UsernameChangeTier,
  next: UsernameChangeTier | undefined,
  t: TFunction
): string {
  if (!next) return t('changeNickname.tierLabelPlus', { n: tier.minLength });
  const upper = next.minLength - 1;
  if (upper === tier.minLength) {
    return t('changeNickname.tierLabel', { n: tier.minLength });
  }
  return t('changeNickname.tierRange', { from: tier.minLength, to: upper });
}

export function ChangeNicknameDialog({
  open,
  onClose,
  onSuccess,
}: {
  open: boolean;
  onClose: () => void;
  onSuccess: () => void;
}) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const [tiers, setTiers] = useState<UsernameChangeTier[]>([]);
  const [featureDisabled, setFeatureDisabled] = useState(false);
  const [value, setValue] = useState('');
  const [lastCheck, setLastCheck] = useState<CheckUsernameResult | null>(null);
  const [checkFailedFor, setCheckFailedFor] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  const ken = user?.ken ?? 0;
  const nickname = normalizeNickname(value);
  const localError =
    nickname === ''
      ? null
      : !isValidNickname(nickname)
        ? 'format'
        : nickname === user?.username
          ? 'same'
          : null;
  const needsCheck = nickname !== '' && localError == null;
  const checked =
    needsCheck && lastCheck?.username === nickname ? lastCheck : null;
  const checkFailed = needsCheck && checkFailedFor === nickname;
  const cost = checked?.cost;
  const canSubmit =
    !submitting &&
    !featureDisabled &&
    checked != null &&
    checked.available &&
    cost != null &&
    ken >= cost;

  useEffect(() => {
    if (!open) return;
    let cancelled = false;
    SettingsService.usernameChangeConfig()
      .then((config) => {
        if (cancelled) return;
        setFeatureDisabled(!config.enabled);
        setTiers([...config.tiers].sort((a, b) => a.minLength - b.minLength));
      })
      .catch(() => {
        if (!cancelled) toast.error(t('changeNickname.checkError'));
      });
    return () => {
      cancelled = true;
    };
  }, [open, t]);

  useEffect(() => {
    if (!open || !needsCheck || featureDisabled) return;
    let cancelled = false;
    const timer = setTimeout(() => {
      UserService.checkUsername(nickname)
        .then((result) => {
          if (cancelled) return;
          setLastCheck(result);
          setCheckFailedFor(null);
        })
        .catch((err) => {
          if (cancelled) return;
          if (isDisabledError(err)) {
            setFeatureDisabled(true);
            return;
          }
          setCheckFailedFor(nickname);
        });
    }, CHECK_DEBOUNCE_MS);
    return () => {
      cancelled = true;
      clearTimeout(timer);
    };
  }, [open, needsCheck, nickname, featureDisabled]);

  function close() {
    if (submitting) return;
    setValue('');
    setLastCheck(null);
    setCheckFailedFor(null);
    onClose();
  }

  function statusLine() {
    if (localError != null) {
      return (
        <p className="text-xs text-ola-error">
          {localError === 'same'
            ? t('changeNickname.same')
            : t('changeNickname.invalid')}
        </p>
      );
    }
    if (checkFailed) {
      return (
        <p className="text-xs text-ola-error">{t('changeNickname.checkError')}</p>
      );
    }
    if (needsCheck && checked == null) {
      return (
        <p className="text-xs text-black/50">{t('changeNickname.checking')}</p>
      );
    }
    if (checked != null) {
      if (!checked.available) {
        return (
          <p className="text-xs text-ola-error">{t('changeNickname.taken')}</p>
        );
      }
      if (cost != null && ken < cost) {
        return (
          <p className="text-xs text-ola-error">
            {t('changeNickname.insufficient')}
          </p>
        );
      }
      return (
        <p className="text-xs text-ola-primary-dark">
          {t('changeNickname.available')}
        </p>
      );
    }
    return null;
  }

  async function submit() {
    if (!canSubmit || checked == null || cost == null) return;
    setSubmitting(true);
    try {
      await UserService.changeUsername(checked.username, cost);
      toast.success(t('changeNickname.success'));
      onSuccess();
    } catch (err) {
      if (err instanceof ApiError && /failed to revoke/i.test(err.message)) {
        toast.success(t('changeNickname.success'));
        onSuccess();
        return;
      }
      let message = t('changeNickname.error');
      if (err instanceof ApiError) {
        if (isDisabledError(err)) {
          setFeatureDisabled(true);
          message = t('changeNickname.disabledNotice');
        } else if (/cost has changed/i.test(err.message)) {
          setLastCheck(null);
          message = t('changeNickname.costChanged');
        } else if (/already exists/i.test(err.message)) {
          message = t('changeNickname.taken');
        } else if (/insufficient ken/i.test(err.message)) {
          message = t('changeNickname.insufficient');
        }
      }
      toast.error(message);
      setSubmitting(false);
    }
  }

  return (
    <Dialog
      open={open}
      onClose={close}
      title={t('changeNickname.title')}
      dismissOnBackdrop={!submitting}
      footer={
        <>
          <DialogButton type="button" onClick={close} disabled={submitting}>
            {t('changeNickname.cancel')}
          </DialogButton>
          {!featureDisabled && (
            <DialogButton
              type="button"
              variant="green"
              disabled={!canSubmit}
              onClick={() => void submit()}
            >
              {cost != null
                ? t('changeNickname.confirm', { ken: formatKen(cost) })
                : t('changeNickname.title')}
            </DialogButton>
          )}
        </>
      }
    >
      {featureDisabled ? (
        <p className="py-2 text-sm text-black/60">
          {t('changeNickname.disabledNotice')}
        </p>
      ) : (
        <div className="flex flex-col gap-3">
          <div className="rounded border border-black/10 bg-black/4">
            <p className="border-b border-black/10 px-3 py-2 text-xs font-semibold text-black/60">
              {t('changeNickname.priceTitle')}
            </p>
            <ul>
              {tiers.map((tier, index) => (
                <li
                  key={tier.minLength}
                  className="flex items-center justify-between px-3 py-1.5 text-sm text-black/80"
                >
                  <span>{tierLabel(tier, tiers[index + 1], t)}</span>
                  <span className="flex items-center gap-1 font-semibold">
                    {formatKen(tier.cost)}
                    <img
                      src={kenIcon}
                      alt=""
                      className="h-4 w-4 object-contain"
                    />
                  </span>
                </li>
              ))}
            </ul>
          </div>
          <p className="flex items-center gap-1 text-xs text-black/60">
            <img src={kenIcon} alt="" className="h-3.5 w-3.5 object-contain" />
            {t('changeNickname.balance', { ken: formatKen(ken) })}
          </p>
          <div>
            <input
              type="text"
              autoComplete="off"
              autoCapitalize="none"
              placeholder={t('changeNickname.inputPlaceholder')}
              value={value}
              onChange={(e) => setValue(e.target.value)}
              disabled={submitting}
              className="w-full rounded border border-black/15 bg-white px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary"
            />
            <div className="mt-1 min-h-4">{statusLine()}</div>
          </div>
          <p className="text-xs text-black/50">{t('changeNickname.note')}</p>
        </div>
      )}
    </Dialog>
  );
}
