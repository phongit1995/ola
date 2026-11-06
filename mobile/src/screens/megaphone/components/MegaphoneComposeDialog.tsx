import { Image, Pressable, Text, TextInput, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { activeVipTypeId, formatKen } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useMegaphoneComposer, type MegaphoneComposer } from '@ola/shared/stores/megaphone/useMegaphoneComposer';
import type { SendMegaphoneResult } from '@ola/shared/types';
import { GIFT_ASSETS } from '@components/gift/giftAssets';
import { MEGAPHONE_IMAGE } from '@components/megaphone/megaphoneAssets';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { MegaphonePreview } from './MegaphonePreview';

const KEN_ICON_STYLE = { width: 16, height: 16 };
const INPUT_MIN_HEIGHT = 84;
const INPUT_COLOR = 'rgba(0,0,0,0.87)';
const INPUT_PLACEHOLDER_COLOR = 'rgba(0,0,0,0.38)';
const INPUT_BORDER = 'rgba(0,0,0,0.12)';
const ERROR_BORDER = '#e34545';

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
        {t('megaphone.confirmMessage', { ken: formatKen(composer.config.kenPrice) })}
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
    return t('megaphone.dailyLeft', { count: composer.dailyLeft });
  }

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
      <View>
        <TextInput
          value={composer.content}
          onChangeText={composer.changeContent}
          placeholder={t('megaphone.placeholder')}
          placeholderTextColor={INPUT_PLACEHOLDER_COLOR}
          multiline
          autoFocus
          textAlignVertical="top"
          className="rounded px-3 pt-2 pb-6 text-sm"
          style={{
            minHeight: INPUT_MIN_HEIGHT,
            color: INPUT_COLOR,
            borderWidth: 1,
            borderColor: composer.tooLong ? ERROR_BORDER : INPUT_BORDER,
          }}
        />
        <Text
          pointerEvents="none"
          className={`absolute right-2 bottom-2 text-xs ${
            composer.tooLong ? 'font-semibold text-ola-error' : 'text-ola-ink-faint'
          }`}
        >
          {t('megaphone.remaining', { count: composer.length, max: config.maxLength })}
        </Text>
      </View>
      <Text className="text-xs text-ola-ink-faint">{t('megaphone.rules')}</Text>
      <Text className="text-center text-sm font-medium text-ola-megaphone-ink">{statusLine()}</Text>
      <View className="flex-row items-center justify-between rounded-lg bg-ola-surface px-3 py-2">
        <View className="flex-row items-center gap-1">
          <Text className="text-sm text-ola-ink-soft">{t('megaphone.balance')}</Text>
          <KenValue ken={composer.balance} className="text-ola-ink" />
        </View>
        {composer.affordable ? (
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
