import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Text, TextInput, View } from 'react-native';
import { GIFT_CODE_MAX_LENGTH, GIFT_CODE_REWARD_TYPE } from '@ola/shared/constants';
import { giftCodeRewardText, withAlpha } from '@ola/shared/lib';
import { useGiftCodeRedeem } from '@ola/shared/stores/gift-code/useGiftCodeRedeem';
import type { GiftCodeReward } from '@ola/shared/types';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { VipIcon } from '@components/ui/VipIcon';
import { DIVIDER, ERROR, TEXT_FAINT, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';

const giftCodeIcon = require('@assets/icons/apps/gift-code.webp');
const vipCrownIcon = require('@assets/icons/apps/vip-crown.webp');

interface GiftCodeDialogProps {
  visible: boolean;
  onClose: () => void;
}

function RewardChip({ reward }: { reward: GiftCodeReward }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const text = giftCodeRewardText(t, reward);
  if (text == null) return null;
  const isIcon = reward.type === GIFT_CODE_REWARD_TYPE.vipIcon && reward.vipIconId != null;
  return (
    <View
      className="flex-row items-center gap-1.5 rounded-full py-1 pl-1.5 pr-3"
      style={{ backgroundColor: withAlpha(colors.primary, 0.12) }}
    >
      {isIcon ? (
        <VipIcon typeId={reward.vipIconId} size={24} />
      ) : (
        <Image source={vipCrownIcon} style={{ width: 24, height: 20 }} resizeMode="contain" />
      )}
      <Text className="text-sm font-semibold" style={{ color: TEXT_PRIMARY }}>
        {text}
      </Text>
    </View>
  );
}

export function GiftCodeDialog({ visible, onClose }: GiftCodeDialogProps) {
  const { t } = useTranslation();
  const redeem = useGiftCodeRedeem();

  function close() {
    redeem.reset();
    onClose();
  }

  if (redeem.result != null) {
    return (
      <Dialog
        visible={visible}
        onClose={close}
        avoidKeyboard={false}
        footer={
          <DialogButton variant="green" onPress={close}>
            {t('giftCode.successButton')}
          </DialogButton>
        }
      >
        <View className="items-center px-2 pb-1 pt-3">
          <Image source={giftCodeIcon} style={{ width: 80, height: 80 }} resizeMode="contain" />
          <Text className="mt-2 text-lg font-bold" style={{ color: TEXT_PRIMARY }}>
            {t('giftCode.successTitle')}
          </Text>
          <Text className="mt-1 text-center text-sm" style={{ color: 'rgba(0,0,0,0.7)' }}>
            {redeem.result.message}
          </Text>
          <View className="mt-3 flex-row flex-wrap justify-center gap-2">
            {redeem.result.rewards.map((reward, index) => (
              <RewardChip key={`${reward.type}-${index}`} reward={reward} />
            ))}
          </View>
        </View>
      </Dialog>
    );
  }

  return (
    <Dialog
      visible={visible}
      onClose={close}
      dismissOnBackdrop={!redeem.submitting}
      title={t('giftCode.title')}
      icon={giftCodeIcon}
      footer={
        <>
          <DialogButton onPress={close} disabled={redeem.submitting}>
            {t('giftCode.cancel')}
          </DialogButton>
          <DialogButton
            variant="green"
            onPress={() => void redeem.submit()}
            disabled={!redeem.canSubmit}
          >
            {redeem.submitting ? <ActivityIndicator size="small" color="#ffffff" /> : t('giftCode.submit')}
          </DialogButton>
        </>
      }
    >
      <View className="gap-2 px-1 py-1">
        <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
          {t('giftCode.hint')}
        </Text>
        <TextInput
          autoFocus
          value={redeem.code}
          maxLength={GIFT_CODE_MAX_LENGTH}
          autoCapitalize="characters"
          autoCorrect={false}
          autoComplete="off"
          spellCheck={false}
          returnKeyType="done"
          onChangeText={redeem.setCode}
          onSubmitEditing={() => void redeem.submit()}
          placeholder={t('giftCode.placeholder')}
          placeholderTextColor={TEXT_FAINT}
          className="w-full rounded px-3 py-2.5 text-center text-lg font-bold"
          style={{
            borderWidth: 1,
            borderColor: redeem.error != null ? ERROR : DIVIDER,
            color: TEXT_PRIMARY,
            letterSpacing: redeem.code === '' ? 0 : 2,
          }}
        />
        {redeem.error != null && (
          <Text className="text-sm" style={{ color: ERROR }}>
            {redeem.error}
          </Text>
        )}
        {redeem.needsEmailVerify && (
          <>
            <Text className="text-sm" style={{ color: ERROR }}>
              {t('giftCode.errors.emailNotVerified')}
            </Text>
            <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.7)' }}>
              {t('giftCode.verifyGuide')}
            </Text>
          </>
        )}
      </View>
    </Dialog>
  );
}
