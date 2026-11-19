import { Image, Pressable, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { activeVipTypeId, formatKen } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useMegaphoneComposer, type MegaphoneComposer } from '@ola/shared/stores/megaphone/useMegaphoneComposer';
import type { SendMegaphoneResult } from '@ola/shared/types';
import { GIFT_ASSETS } from '@components/gift/giftAssets';
import { MEGAPHONE_IMAGE, MEGAPHONE_LINE, MEGAPHONE_TICKET_IMAGE } from '@components/megaphone/megaphoneAssets';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { MegaphoneContentInput } from './MegaphoneContentInput';
import { MegaphonePreview } from './MegaphonePreview';

const KEN_ICON_STYLE = { width: 16, height: 16 };
const TICKET_ICON_STYLE = { width: 20, height: 20 };
const CHECKBOX_SIZE = 18;

function TicketToggle({ composer }: { composer: MegaphoneComposer }) {
  const { t } = useTranslation();
  const checked = composer.useTicket;
  return (
    <Pressable
      onPress={composer.toggleUseTicket}
      accessibilityRole="checkbox"
      accessibilityState={{ checked }}
      className={`flex-row items-center gap-2 rounded-lg px-3 py-2 active:opacity-80 ${checked ? 'bg-ola-megaphone-soft' : ''}`}
      style={{ borderWidth: 1, borderColor: checked ? MEGAPHONE_LINE : 'rgba(0,0,0,0.12)' }}
    >
      <View
        className={`items-center justify-center rounded ${checked ? 'bg-ola-warning' : ''}`}
        style={{
          width: CHECKBOX_SIZE,
          height: CHECKBOX_SIZE,
          borderWidth: checked ? 0 : 2,
          borderColor: 'rgba(0,0,0,0.38)',
        }}
      >
        {checked && <Text className="text-xs font-bold text-white">✓</Text>}
      </View>
      <Image source={MEGAPHONE_TICKET_IMAGE} style={TICKET_ICON_STYLE} resizeMode="contain" />
      <Text className={`flex-1 text-sm font-medium ${checked ? 'text-ola-megaphone-ink' : 'text-ola-ink'}`}>
        {t('megaphone.ticket.useLabel', { count: composer.ticketCount })}
      </Text>
    </Pressable>
  );
}

interface MegaphoneComposeDialogProps {
  onClose: () => void;
  onSent?: (result: SendMegaphoneResult) => void;
  onTopUp: () => void;
}

function KenValue({ ken, className }: { ken: number; className: string }) {
  return (
    <View className="flex-row items-center gap-1">
      <Text className={`text-sm font-bold ${className}`}>{formatKen(ken)}</Text>
      <Image source={GIFT_ASSETS.ken} style={KEN_ICON_STYLE} resizeMode="contain" />
    </View>
  );
}

function ConfirmStep({ composer }: { composer: MegaphoneComposer }) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  return (
    <View className="gap-3 p-4">
      <MegaphonePreview
        username={user?.username ?? ''}
        vipTypeId={activeVipTypeId(user?.vipUsed, user?.vipEndTime)}
        content={composer.normalizedContent}
      />
      <Text className="text-center text-base text-ola-ink">
        {composer.payingWithTicket
          ? t('megaphone.confirmPlain')
          : t('megaphone.confirmMessage', { ken: formatKen(composer.config.kenPrice) })}
      </Text>
      {composer.waitMinutes > 0 && (
        <Text className="text-center text-sm text-ola-megaphone-ink">
          {t('megaphone.queueWait', { minutes: composer.waitMinutes })}
        </Text>
      )}
    </View>
  );
}

function ComposeStep({ composer, onTopUp }: { composer: MegaphoneComposer; onTopUp: () => void }) {
  const { t } = useTranslation();
  const { config } = composer;

  function statusLine() {
    if (!config.enabled) return t('megaphone.disabled');
    if (composer.dailyLeft === 0) return t('megaphone.dailyReached');
    if (composer.cooldownLeft > 0) return t('megaphone.cooldown', { seconds: composer.cooldownLeft });
    if (composer.waitMinutes > 0) return t('megaphone.queueWait', { minutes: composer.waitMinutes });
    return null;
  }

  const status = statusLine();

  if (!composer.loaded) {
    return (
      <Text className="py-8 text-center text-sm text-ola-ink-soft">
        {composer.loadError ? t('megaphone.loadFailed') : t('common.loading')}
      </Text>
    );
  }

  return (
    <View className="gap-3 p-4">
      <Text className="text-sm text-ola-ink-soft">{t('megaphone.hint', { minutes: config.liveMinutes })}</Text>
      <MegaphoneContentInput
        value={composer.content}
        tooLong={composer.tooLong}
        counter={t('megaphone.remaining', { count: composer.length, max: config.maxLength })}
        onChange={composer.changeContent}
      />
      <Text className="text-xs text-ola-ink-faint">
        {t(composer.payingWithTicket ? 'megaphone.rulesTicket' : 'megaphone.rules')}
      </Text>
      {status != null && (
        <Text className="text-center text-sm font-medium text-ola-megaphone-ink">{status}</Text>
      )}
      {composer.canUseTicket && <TicketToggle composer={composer} />}
      <View className="flex-row items-center justify-between rounded-lg bg-ola-surface px-3 py-2">
        <View className="flex-row items-center gap-1">
          <Text className="text-sm text-ola-ink-soft">{t('megaphone.balance')}</Text>
          <KenValue ken={composer.balance} className="text-ola-ink" />
        </View>
        {composer.payingWithTicket ? (
          <View className="flex-row items-center gap-1">
            <Text className="text-sm text-ola-ink-soft">{t('megaphone.price')}</Text>
            <Text className="text-sm font-bold text-ola-megaphone-ink">{t('megaphone.ticket.price')}</Text>
          </View>
        ) : composer.affordable ? (
          <View className="flex-row items-center gap-1">
            <Text className="text-sm text-ola-ink-soft">{t('megaphone.price')}</Text>
            {config.kenPrice > 0 ? (
              <KenValue ken={config.kenPrice} className="text-ola-megaphone-ink" />
            ) : (
              <Text className="text-sm font-bold text-ola-megaphone-ink">{t('megaphone.free')}</Text>
            )}
          </View>
        ) : (
          <Pressable onPress={onTopUp} className="active:opacity-70">
            <Text className="text-sm font-semibold text-ola-error underline">
              {t('megaphone.notEnoughKen')} · {t('megaphone.topUp')}
            </Text>
          </Pressable>
        )}
      </View>
    </View>
  );
}

export function MegaphoneComposeDialog({ onClose, onSent, onTopUp }: MegaphoneComposeDialogProps) {
  const { t } = useTranslation();
  const composer = useMegaphoneComposer({ onClose, onSent });
  const confirming = composer.step === 'confirm';

  return (
    <Dialog
      visible
      onClose={onClose}
      title={t(confirming ? 'megaphone.confirmTitle' : 'megaphone.composeTitle')}
      icon={MEGAPHONE_IMAGE}
      showClose={!confirming}
      showToasts
      footer={
        confirming ? (
          <>
            <DialogButton onPress={composer.cancelConfirm} disabled={composer.submitting}>
              {t('dialog.cancel')}
            </DialogButton>
            <DialogButton variant="green" onPress={composer.confirmSend} disabled={composer.submitting}>
              {composer.submitting ? t('megaphone.sending') : t('megaphone.send')}
            </DialogButton>
          </>
        ) : (
          <DialogButton variant="green" onPress={composer.requestSend} disabled={!composer.canSend}>
            {t('megaphone.send')}
          </DialogButton>
        )
      }
    >
      {confirming ? <ConfirmStep composer={composer} /> : <ComposeStep composer={composer} onTopUp={onTopUp} />}
    </Dialog>
  );
}
