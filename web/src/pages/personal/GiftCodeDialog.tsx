import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, Spinner, VipIcon } from '@components';
import { GIFT_CODE_MAX_LENGTH, GIFT_CODE_REWARD_TYPE } from '@constants';
import { giftCodeRewardText } from '@lib';
import { avatarFrameById } from '@ola/shared/lib/avatarFrame';
import { useGiftCodeRedeem } from '@ola/shared/stores/gift-code/useGiftCodeRedeem';
import type { GiftCodeReward } from '@app-types';
import giftCodeIcon from '@/assets/icons/apps/gift-code.webp';
import vipCrownIcon from '@/assets/icons/apps/vip-crown.webp';

interface GiftCodeDialogProps {
  open: boolean;
  onClose: () => void;
}

function RewardChip({ reward }: { reward: GiftCodeReward }) {
  const { t } = useTranslation();
  const text = giftCodeRewardText(t, reward);
  if (text == null) return null;
  const isIcon =
    reward.type === GIFT_CODE_REWARD_TYPE.vipIcon && reward.vipIconId != null;
  const frameUrl =
    reward.type === GIFT_CODE_REWARD_TYPE.avatarFrame
      ? avatarFrameById(reward.frameId)?.url
      : undefined;
  return (
    <span className="inline-flex items-center gap-1.5 rounded-full bg-ola-primary/10 py-1 pl-1.5 pr-3 text-sm font-semibold text-black/87">
      {frameUrl != null ? (
        <img src={frameUrl} alt="" className="h-6 w-6 object-contain" />
      ) : isIcon ? (
        <VipIcon typeId={reward.vipIconId} className="h-6 w-6" />
      ) : (
        <img src={vipCrownIcon} alt="" className="h-5 w-6 object-contain" />
      )}
      {text}
    </span>
  );
}

export function GiftCodeDialog({ open, onClose }: GiftCodeDialogProps) {
  const { t } = useTranslation();
  const redeem = useGiftCodeRedeem();

  function close() {
    redeem.reset();
    onClose();
  }

  if (redeem.result != null) {
    return (
      <Dialog
        open={open}
        onClose={close}
        footer={
          <DialogButton variant="green" onClick={close}>
            {t('giftCode.successButton')}
          </DialogButton>
        }
      >
        <div className="flex flex-col items-center px-2 pb-1 pt-3 text-center">
          <img src={giftCodeIcon} alt="" className="h-20 w-20 object-contain" />
          <p className="mt-2 text-lg font-bold text-black/87">
            {t('giftCode.successTitle')}
          </p>
          <p className="mt-1 text-sm text-black/70">{redeem.result.message}</p>
          <div className="mt-3 flex flex-wrap justify-center gap-2">
            {redeem.result.rewards.map((reward, index) => (
              <RewardChip key={`${reward.type}-${index}`} reward={reward} />
            ))}
          </div>
        </div>
      </Dialog>
    );
  }

  const titleIcon = (
    <img src={giftCodeIcon} alt="" className="h-7 w-7 object-contain" />
  );

  return (
    <Dialog
      open={open}
      onClose={close}
      dismissOnBackdrop={!redeem.submitting}
      title={t('giftCode.title')}
      icon={titleIcon}
      footer={
        <>
          <DialogButton onClick={close} disabled={redeem.submitting}>
            {t('giftCode.cancel')}
          </DialogButton>
          <DialogButton
            variant="green"
            onClick={() => void redeem.submit()}
            disabled={!redeem.canSubmit}
          >
            {redeem.submitting ? (
              <Spinner size={16} tone="light" />
            ) : (
              t('giftCode.submit')
            )}
          </DialogButton>
        </>
      }
    >
      <div className="flex flex-col gap-2 px-1 py-1">
        <p className="text-sm text-black/54">{t('giftCode.hint')}</p>
        <input
          autoFocus
          value={redeem.code}
          maxLength={GIFT_CODE_MAX_LENGTH}
          autoComplete="off"
          autoCapitalize="characters"
          spellCheck={false}
          onChange={(event) => redeem.setCode(event.target.value)}
          onKeyDown={(event) => {
            if (event.key === 'Enter') void redeem.submit();
          }}
          placeholder={t('giftCode.placeholder')}
          className={`w-full rounded border px-3 py-2.5 text-center font-mono text-lg font-bold tracking-[0.15em] text-black/87 outline-none placeholder:font-sans placeholder:text-base placeholder:font-normal placeholder:tracking-normal ${
            redeem.error != null
              ? 'border-ola-error'
              : 'border-black/12 focus:border-ola-primary'
          }`}
        />
        {redeem.error != null && (
          <p className="text-sm text-ola-error">{redeem.error}</p>
        )}
        {redeem.needsEmailVerify && (
          <>
            <p className="text-sm text-ola-error">
              {t('giftCode.errors.emailNotVerified')}
            </p>
            <p className="text-sm text-black/70">{t('giftCode.verifyGuide')}</p>
          </>
        )}
      </div>
    </Dialog>
  );
}
