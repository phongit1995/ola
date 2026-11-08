import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, TextInput, View } from 'react-native';
import { avatarFrameErrorKey, formatKen } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { AvatarFrameShopState } from '@ola/shared/stores/avatar-frame/useAvatarFrameShop';
import type { AvatarFrameShopItem } from '@ola/shared/types';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { useThemeColors } from '@hooks/useThemeColors';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { FRAME_PREVIEW_SIZE } from '../constants';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';

type Step = 'detail' | 'confirm' | 'gift';

interface AvatarFrameShopDialogProps {
  item: AvatarFrameShopItem | null;
  vipActive: boolean;
  busy: boolean;
  buy: AvatarFrameShopState['buy'];
  gift: AvatarFrameShopState['gift'];
  onBuyVip: () => void;
  onClose: () => void;
}

export function AvatarFrameShopDialog({
  item,
  vipActive,
  busy,
  buy,
  gift,
  onBuyVip,
  onClose,
}: AvatarFrameShopDialogProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const push = useToastStore((s) => s.push);
  const username = useAuthStore((s) => s.user?.username ?? '');
  const avatar = useAuthStore((s) => s.user?.avatar ?? undefined);
  const [step, setStep] = useState<Step>('detail');
  const [receiver, setReceiver] = useState('');
  const [password, setPassword] = useState('');
  const [prevItemId, setPrevItemId] = useState<string | null>(null);

  const itemId = item?.id ?? null;
  if (itemId !== prevItemId) {
    setPrevItemId(itemId);
    setStep('detail');
    setReceiver('');
    setPassword('');
  }

  if (item == null) return null;

  const current = item;
  const label = avatarFrameLabel(current.frameId);
  const price = t('avatarFrame.price', { price: formatKen(current.kenPrice) });

  async function confirmBuy() {
    try {
      await buy(current);
      push('success', t('avatarFrame.toastBought'));
      onClose();
    } catch (error) {
      push('error', t(avatarFrameErrorKey(error)));
    }
  }

  async function confirmGift() {
    if (receiver.trim() === '' || password === '') {
      push('info', t(receiver.trim() === '' ? 'vip.buy.needReceiver' : 'vip.buy.needPassword'));
      return;
    }
    try {
      const result = await gift(current, receiver, password);
      push('success', t('avatarFrame.toastGifted', { name: result.receiverUsername }));
      onClose();
    } catch (error) {
      push('error', t(avatarFrameErrorKey(error)));
    }
  }

  const inputStyle = {
    borderWidth: 1,
    borderColor: DIVIDER,
    color: TEXT_PRIMARY,
    backgroundColor: '#ffffff',
  };

  const title =
    step === 'gift'
      ? t('avatarFrame.giftTitle')
      : step === 'confirm'
        ? t('avatarFrame.confirmBuyTitle')
        : label;

  const footer =
    step === 'detail' ? (
      <>
        <DialogButton
          variant="green"
          disabled={current.owned || busy}
          onPress={() => setStep('confirm')}
        >
          {current.owned ? t('avatarFrame.owned') : t('avatarFrame.actionBuy')}
        </DialogButton>
        <DialogButton disabled={busy} onPress={() => setStep('gift')}>
          {t('avatarFrame.actionGift')}
        </DialogButton>
      </>
    ) : (
      <>
        <DialogButton disabled={busy} onPress={() => setStep('detail')}>
          {t('avatarFrame.cancel')}
        </DialogButton>
        <DialogButton
          variant="green"
          disabled={busy}
          onPress={() => void (step === 'confirm' ? confirmBuy() : confirmGift())}
        >
          {step === 'confirm' ? t('avatarFrame.confirm') : t('avatarFrame.actionGift')}
        </DialogButton>
      </>
    );

  return (
    <Dialog
      visible
      onClose={onClose}
      title={title}
      showClose
      showToasts
      avoidKeyboard={step === 'gift'}
      footer={footer}
    >
      {step === 'detail' && (
        <View className="items-center py-2">
          <View style={{ paddingVertical: 12 }}>
            <AvatarWithFrame
              name={username}
              uri={avatar}
              size={FRAME_PREVIEW_SIZE}
              frameId={current.frameId}
            />
          </View>
          <Text className="mt-2 text-base font-semibold" style={{ color: TEXT_PRIMARY }}>
            {label}
          </Text>
          <Text className="mt-0.5 text-sm font-semibold" style={{ color: colors.primaryDarker }}>
            {price}
          </Text>
          {!vipActive && (
            <View className="mt-3 w-full flex-row items-center gap-2 rounded bg-black/5 px-3 py-2">
              <Text className="min-w-0 flex-1 text-xs" style={{ color: TEXT_SECONDARY }}>
                {t('avatarFrame.vipRequiredHint')}
              </Text>
              <Pressable onPress={onBuyVip} className="rounded bg-ola-button px-3 py-1 active:opacity-90">
                <Text className="text-xs font-medium text-white">{t('avatarFrame.buyVip')}</Text>
              </Pressable>
            </View>
          )}
        </View>
      )}

      {step === 'confirm' && (
        <Text className="py-3 text-sm" style={{ color: TEXT_PRIMARY }}>
          {t('avatarFrame.confirmBuy', { id: current.frameId, price: formatKen(current.kenPrice) })}
        </Text>
      )}

      {step === 'gift' && (
        <View className="gap-2 py-1">
          <Text className="text-sm" style={{ color: TEXT_PRIMARY }}>
            {label} · {price}
          </Text>
          <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
            {t('avatarFrame.giftReceiver')}
          </Text>
          <TextInput
            value={receiver}
            onChangeText={setReceiver}
            autoCapitalize="none"
            autoCorrect={false}
            placeholder={t('avatarFrame.giftReceiver')}
            placeholderTextColor="rgba(0,0,0,0.38)"
            className="rounded px-3 py-2 text-sm"
            style={inputStyle}
          />
          <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
            {t('avatarFrame.password')}
          </Text>
          <TextInput
            value={password}
            onChangeText={setPassword}
            secureTextEntry
            placeholder={t('avatarFrame.passwordHint')}
            placeholderTextColor="rgba(0,0,0,0.38)"
            className="rounded px-3 py-2 text-sm"
            style={inputStyle}
          />
        </View>
      )}
    </Dialog>
  );
}
