import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { cn, formatKen } from '@lib';
import { useMegaphoneComposer } from '@ola/shared/stores/megaphone/useMegaphoneComposer';
import megaphoneImage from '@/assets/images/announcement-megaphone.png';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { useAuthStore } from '@/store/authStore';
import { MegaphonePreview } from './MegaphonePreview';

interface MegaphoneComposeDialogProps {
  onClose: () => void;
  onSent?: () => void;
}

export function MegaphoneComposeDialog({ onClose, onSent }: MegaphoneComposeDialogProps) {
  const { t } = useTranslation();
  const composer = useMegaphoneComposer({ onClose, onSent });
  const openOverlay = useAppOverlayStore((s) => s.push);
  const user = useAuthStore((s) => s.user);
  const { config, loaded, loadError, step, submitting } = composer;
  const icon = <img src={megaphoneImage} alt="" className="h-7 w-7 object-contain" />;
  const priceText = config.kenPrice > 0 ? t('megaphone.kenAmount', { ken: formatKen(config.kenPrice) }) : t('megaphone.free');

  if (step === 'confirm') {
    return (
      <Dialog
        open
        onClose={onClose}
        title={t('megaphone.confirmTitle')}
        icon={icon}
        footer={
          <>
            <DialogButton onClick={composer.cancelConfirm} disabled={submitting}>
              {t('dialog.cancel')}
            </DialogButton>
            <DialogButton variant="green" onClick={composer.confirmSend} disabled={submitting}>
              {submitting ? t('megaphone.sending') : t('megaphone.send')}
            </DialogButton>
          </>
        }
      >
        <div className="flex flex-col gap-3 px-1 py-1">
          <MegaphonePreview
            name={user?.fullName || user?.username || ''}
            avatar={user?.avatar}
            content={composer.normalizedContent}
          />
          <p className="text-center text-base text-black/87">
            {t('megaphone.confirmMessage', { ken: formatKen(config.kenPrice) })}
          </p>
          {composer.waitMinutes > 0 && (
            <p className="text-center text-sm text-ola-megaphone-ink">
              {t('megaphone.queueWait', { minutes: composer.waitMinutes })}
            </p>
          )}
        </div>
      </Dialog>
    );
  }

  function statusLine() {
    if (!config.enabled) return t('megaphone.disabled');
    if (composer.dailyLeft === 0) return t('megaphone.dailyReached');
    if (composer.cooldownLeft > 0) return t('megaphone.cooldown', { seconds: composer.cooldownLeft });
    if (composer.waitMinutes > 0) return t('megaphone.queueWait', { minutes: composer.waitMinutes });
    return t('megaphone.dailyLeft', { count: composer.dailyLeft });
  }

  return (
    <Dialog
      open
      onClose={onClose}
      title={t('megaphone.composeTitle')}
      icon={icon}
      showClose
      footer={
        <DialogButton
          variant="green"
          className="flex-1"
          onClick={composer.requestSend}
          disabled={!composer.canSend}
        >
          {t('megaphone.send')}
        </DialogButton>
      }
    >
      {!loaded ? (
        <p className="py-8 text-center text-sm text-black/54">
          {loadError ? t('megaphone.loadFailed') : t('common.loading')}
        </p>
      ) : (
        <div className="flex flex-col gap-3 px-1 py-1">
          <p className="text-sm text-black/60">{t('megaphone.hint', { seconds: config.displaySeconds })}</p>
          <div className="relative">
            <textarea
              value={composer.content}
              rows={3}
              autoFocus
              onChange={(event) => composer.changeContent(event.target.value)}
              placeholder={t('megaphone.placeholder')}
              className={cn(
                'w-full resize-none rounded border px-3 py-2 pb-6 text-sm text-black/87 outline-none',
                composer.tooLong ? 'border-ola-error' : 'border-black/12 focus:border-ola-warning'
              )}
            />
            <span
              className={cn(
                'pointer-events-none absolute right-2 bottom-2 text-xs',
                composer.tooLong ? 'font-semibold text-ola-error' : 'text-black/40'
              )}
            >
              {t('megaphone.remaining', { count: composer.length, max: config.maxLength })}
            </span>
          </div>
          <p className="text-xs text-black/45">{t('megaphone.rules')}</p>
          <p className="text-center text-sm font-medium text-ola-megaphone-ink">{statusLine()}</p>
          <div className="flex items-center justify-between rounded-lg bg-ola-surface px-3 py-2 text-sm">
            <span className="text-black/54">
              {t('megaphone.balance')}{' '}
              <b className="text-black/87">{t('megaphone.kenAmount', { ken: formatKen(composer.balance) })}</b>
            </span>
            {composer.affordable ? (
              <span className="text-black/54">
                {t('megaphone.price')} <b className="text-ola-megaphone-ink">{priceText}</b>
              </span>
            ) : (
              <button
                type="button"
                onClick={() => openOverlay('kenBuy')}
                className="font-semibold text-ola-error underline"
              >
                {t('megaphone.notEnoughKen')} · {t('megaphone.topUp')}
              </button>
            )}
          </div>
        </div>
      )}
    </Dialog>
  );
}
