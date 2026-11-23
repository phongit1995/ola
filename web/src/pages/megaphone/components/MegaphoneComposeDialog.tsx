import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { activeVipTypeId, cn, formatKen } from '@lib';
import { useMegaphoneComposer } from '@ola/shared/stores/megaphone/useMegaphoneComposer';
import type { SendMegaphoneResult } from '@app-types';
import { MEGAPHONE_TICKET_ICON } from '@constants';
import kenIcon from '@/assets/icons/apps/ken.png';
import megaphoneImage from '@/assets/images/member-megaphone.webp';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { MegaphoneContentInput } from './MegaphoneContentInput';
import { MegaphonePreview } from './MegaphonePreview';

interface MegaphoneComposeDialogProps {
  onClose: () => void;
  onSent?: (result: SendMegaphoneResult) => void;
}

function KenValue({ ken, className }: { ken: number; className: string }) {
  return (
    <b className={cn('inline-flex items-center gap-1', className)}>
      {formatKen(ken)}
      <img src={kenIcon} alt="KEN" className="h-4 w-4 object-contain" />
    </b>
  );
}

export function MegaphoneComposeDialog({ onClose, onSent }: MegaphoneComposeDialogProps) {
  const { t } = useTranslation();
  const composer = useMegaphoneComposer({ onClose, onSent });
  const openOverlay = useAppOverlayStore((s) => s.push);
  const user = useAuthStore((s) => s.user);
  const { config, loaded, loadError, step, submitting } = composer;
  const icon = <img src={megaphoneImage} alt="" className="h-7 w-7 object-contain" />;

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
            username={user?.username ?? ''}
            vipTypeId={activeVipTypeId(user?.vipUsed, user?.vipEndTime)}
            content={composer.normalizedContent}
          />
          <p className="text-center text-base text-black/87">
            {composer.payingWithTicket
              ? t('megaphone.confirmPlain')
              : t('megaphone.confirmMessage', { ken: formatKen(config.kenPrice) })}
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
    return null;
  }

  const status = statusLine();

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
          <p className="text-sm text-black/60">{t('megaphone.hint', { minutes: config.liveMinutes })}</p>
          <MegaphoneContentInput
            value={composer.content}
            tooLong={composer.tooLong}
            counter={t('megaphone.remaining', { count: composer.length, max: config.maxLength })}
            onChange={composer.changeContent}
          />
          <p className="text-xs text-black/45">{t(composer.payingWithTicket ? 'megaphone.rulesTicket' : 'megaphone.rules')}</p>
          {status != null && <p className="text-center text-sm font-medium text-ola-megaphone-ink">{status}</p>}
          {composer.canUseTicket && (
            <label
              className={cn(
                'flex cursor-pointer items-center gap-2 rounded-lg border px-3 py-2 text-sm',
                composer.useTicket
                  ? 'border-ola-megaphone-line bg-ola-megaphone-soft text-ola-megaphone-ink'
                  : 'border-black/12 text-black/70'
              )}
            >
              <input
                type="checkbox"
                checked={composer.useTicket}
                onChange={composer.toggleUseTicket}
                className="h-4 w-4 accent-ola-warning"
              />
              <img src={MEGAPHONE_TICKET_ICON} alt="" className="h-5 w-5 object-contain" draggable={false} />
              <span className="font-medium">{t('megaphone.ticket.useLabel', { count: composer.ticketCount })}</span>
            </label>
          )}
          <div className="flex items-center justify-between rounded-lg bg-ola-surface px-3 py-2 text-sm">
            <span className="inline-flex items-center gap-1 text-black/54">
              {t('megaphone.balance')}
              <KenValue ken={composer.balance} className="text-black/87" />
            </span>
            {composer.payingWithTicket ? (
              <span className="inline-flex items-center gap-1 text-black/54">
                {t('megaphone.price')}
                <b className="text-ola-megaphone-ink">{t('megaphone.ticket.price')}</b>
              </span>
            ) : composer.affordable ? (
              <span className="inline-flex items-center gap-1 text-black/54">
                {t('megaphone.price')}
                {config.kenPrice > 0 ? (
                  <KenValue ken={config.kenPrice} className="text-ola-megaphone-ink" />
                ) : (
                  <b className="text-ola-megaphone-ink">{t('megaphone.free')}</b>
                )}
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
