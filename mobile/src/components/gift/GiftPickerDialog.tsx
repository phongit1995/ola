import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import { formatKen, giftDisplayName, senderCharmGain, withAlpha } from '@ola/shared/lib';
import { useGiftPicker } from '@ola/shared/stores/gift/useGiftPicker';
import type { Gift, GiftSource, SendGiftResult } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { CachedImage } from '@components/ui/CachedImage';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { ERROR, TEXT_PRIMARY, TEXT_SECONDARY, WARNING } from '@constants';
import {
  GIFT_ACCENT,
  GIFT_ACCENT_DARK,
  GIFT_GRID_COLUMNS,
  GIFT_GRID_MAX_HEIGHT,
  GIFT_TILE_GAP,
} from './constants';
import { GIFT_ASSETS } from './giftAssets';
import { CharmIcon } from './CharmIcon';

export interface GiftReceiver {
  id: string;
  name: string;
  avatar?: string;
  color?: string;
}

interface GiftPickerDialogProps {
  receiver: GiftReceiver;
  source: GiftSource;
  onClose: () => void;
  onSent?: (result: SendGiftResult) => void;
}

function GiftTile({
  gift,
  active,
  language,
  onPress,
}: {
  gift: Gift;
  active: boolean;
  language: string;
  onPress: () => void;
}) {
  return (
    <View style={{ width: `${100 / GIFT_GRID_COLUMNS}%`, padding: GIFT_TILE_GAP }}>
      <Pressable
        onPress={onPress}
        accessibilityState={{ selected: active }}
        className="items-center rounded-lg px-1 pb-1 pt-1.5"
        style={{
          borderWidth: active ? 2 : 1,
          borderColor: active ? GIFT_ACCENT : 'rgba(0,0,0,0.08)',
          backgroundColor: active ? withAlpha(GIFT_ACCENT, 0.08) : '#ffffff',
        }}
      >
        <CachedImage uri={gift.imageUrl} style={{ width: 48, height: 48 }} resizeMode="contain" />
        <Text numberOfLines={1} className="mt-0.5 text-xs" style={{ color: TEXT_PRIMARY }}>
          {giftDisplayName(gift, language)}
        </Text>
        <View className="flex-row items-center gap-0.5">
          <Image source={GIFT_ASSETS.ken} style={{ width: 12, height: 12 }} resizeMode="contain" />
          <Text className="text-[11px] font-semibold" style={{ color: WARNING }}>
            {formatKen(gift.kenPrice)}
          </Text>
        </View>
      </Pressable>
    </View>
  );
}

export function GiftPickerDialog({ receiver, source, onClose, onSent }: GiftPickerDialogProps) {
  const { t, i18n } = useTranslation();
  const picker = useGiftPicker({ receiverId: receiver.id, source, onClose, onSent });
  const {
    gifts,
    settings,
    loaded,
    loadError,
    ready,
    balance,
    selected,
    selectedName,
    quantity,
    note,
    total,
    affordable,
    step,
    submitting,
  } = picker;

  if (step === 'confirm' && selected != null) {
    const senderGain = senderCharmGain(selected, quantity);
    return (
      <Dialog
        visible
        onClose={onClose}
        title={t('gift.confirmTitle')}
        icon={GIFT_ASSETS.icon}
        avoidKeyboard={false}
        showToasts
        footer={
          <>
            <DialogButton onPress={picker.cancelConfirm} disabled={submitting}>
              {t('dialog.cancel')}
            </DialogButton>
            <DialogButton variant="green" onPress={picker.confirmSend} disabled={submitting}>
              {submitting ? t('gift.sending') : t('gift.send')}
            </DialogButton>
          </>
        }
      >
        <View className="items-center gap-2 px-2 py-2">
          <CachedImage uri={selected.imageUrl} style={{ width: 96, height: 96 }} resizeMode="contain" />
          <Text className="text-center text-base" style={{ color: TEXT_PRIMARY }}>
            {t('gift.confirmMessage', {
              quantity,
              name: selectedName,
              receiver: receiver.name,
              ken: formatKen(total),
            })}
          </Text>
          <View className="flex-row items-center justify-center" style={{ gap: 4 }}>
            <CharmIcon />
            <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('gift.receiverCharmGain', {
                name: receiver.name,
                value: formatKen(selected.charmPoints * quantity),
              })}
            </Text>
          </View>
          {senderGain > 0 && (
            <View className="flex-row items-center justify-center" style={{ gap: 4 }}>
              <CharmIcon />
              <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
                {t('gift.senderCharmGain', { value: formatKen(senderGain) })}
              </Text>
            </View>
          )}
        </View>
      </Dialog>
    );
  }

  return (
    <Dialog
      visible
      onClose={onClose}
      title={t('gift.title')}
      icon={GIFT_ASSETS.icon}
      showClose
      showToasts
      footer={
        <DialogButton variant="green" onPress={picker.requestSend} disabled={!picker.canSend}>
          {submitting ? t('gift.sending') : t('gift.send')}
        </DialogButton>
      }
    >
      <View className="gap-3 px-1 py-1">
        <View className="flex-row items-center gap-2">
          <Avatar name={receiver.name} uri={receiver.avatar} color={receiver.color} size={32} />
          <Text numberOfLines={1} className="min-w-0 flex-1 text-base font-medium" style={{ color: TEXT_PRIMARY }}>
            {t('gift.toReceiver', { name: receiver.name })}
          </Text>
        </View>

        {!loaded ? (
          <View className="items-center py-8">
            {loadError ? (
              <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
                {t('gift.loadFailed')}
              </Text>
            ) : (
              <ActivityIndicator color={GIFT_ACCENT} />
            )}
          </View>
        ) : !settings.enabled ? (
          <Text className="py-6 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
            {t('gift.disabledHint')}
          </Text>
        ) : gifts.length === 0 ? (
          <Text className="py-6 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
            {t('gift.empty')}
          </Text>
        ) : (
          <ScrollView
            style={{ maxHeight: GIFT_GRID_MAX_HEIGHT }}
            contentContainerStyle={{ flexDirection: 'row', flexWrap: 'wrap' }}
          >
            {gifts.map((gift) => (
              <GiftTile
                key={gift.id}
                gift={gift}
                active={gift.id === selected?.id}
                language={i18n.language}
                onPress={() => picker.selectGift(gift.id)}
              />
            ))}
          </ScrollView>
        )}

        {ready && (
          <>
            <View className="flex-row items-center gap-2">
              <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
                {t('gift.quantity')}
              </Text>
              <View className="flex-1 flex-row flex-wrap gap-1.5">
                {settings.quantityOptions.map((option) => {
                  const active = option === quantity;
                  return (
                    <Pressable
                      key={option}
                      onPress={() => picker.selectQuantity(option)}
                      accessibilityState={{ selected: active }}
                      className="min-w-10 items-center rounded-full px-2.5 py-0.5"
                      style={{
                        borderWidth: 1,
                        borderColor: active ? GIFT_ACCENT : 'rgba(0,0,0,0.12)',
                        backgroundColor: active ? GIFT_ACCENT : '#ffffff',
                      }}
                    >
                      <Text className="text-sm font-medium" style={{ color: active ? '#ffffff' : 'rgba(0,0,0,0.7)' }}>
                        {t('gift.quantityTimes', { count: option })}
                      </Text>
                    </Pressable>
                  );
                })}
              </View>
            </View>

            {settings.noteMaxLength > 0 && (
              <TextInput
                value={note}
                maxLength={settings.noteMaxLength}
                onChangeText={picker.changeNote}
                placeholder={t('gift.notePlaceholder')}
                placeholderTextColor="rgba(0,0,0,0.38)"
                className="rounded px-3 py-2 text-sm"
                style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)', color: TEXT_PRIMARY }}
              />
            )}

            <View className="flex-row items-center justify-between gap-2 rounded-lg bg-ola-surface px-3 py-2">
              <Text className="flex-shrink text-sm" style={{ color: TEXT_SECONDARY }}>
                {t('gift.balance')}{' '}
                <Text className="font-bold" style={{ color: TEXT_PRIMARY }}>
                  {t('gift.kenAmount', { ken: formatKen(balance) })}
                </Text>
              </Text>
              {affordable ? (
                <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
                  {t('gift.total')}{' '}
                  <Text className="font-bold" style={{ color: GIFT_ACCENT_DARK }}>
                    {t('gift.kenAmount', { ken: formatKen(total) })}
                  </Text>
                </Text>
              ) : (
                <Text className="text-sm font-semibold" style={{ color: ERROR }}>
                  {t('gift.notEnoughKen')}
                </Text>
              )}
            </View>
          </>
        )}
      </View>
    </Dialog>
  );
}
