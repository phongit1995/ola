import { useEffect, useRef, useState, type ComponentRef } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, ScrollView, Switch, Text, TextInput, View } from 'react-native';
import { formatKen, giftDisplayName, senderCharmGain } from '@ola/shared/lib';
import { useGiftPicker } from '@ola/shared/stores/gift/useGiftPicker';
import type { Gift, GiftSource, SendGiftResult } from '@ola/shared/types';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { CachedImage } from '@components/ui/CachedImage';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY, WARNING } from '@constants';
import {
  GIFT_ACCENT,
  GIFT_GRID_COLUMNS,
  GIFT_GRID_MAX_HEIGHT,
  GIFT_TILE_GAP,
} from './constants';
import { GIFT_ASSETS } from './giftAssets';
import { CharmIcon } from './CharmIcon';
import { GiftPill } from './GiftPill';

const KEN_ICON_LARGE = { width: 20, height: 20 };
const KEN_ICON_SMALL = { width: 12, height: 12 };
const SECTION_DIVIDER = { borderTopWidth: 1, borderTopColor: DIVIDER };

export interface GiftReceiver {
  id: string;
  name: string;
  username?: string;
  avatar?: string;
  avatarFrameId?: string | null;
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
  onActiveLayout,
}: {
  gift: Gift;
  active: boolean;
  language: string;
  onPress: () => void;
  onActiveLayout: (y: number) => void;
}) {
  return (
    <View
      style={{ width: `${100 / GIFT_GRID_COLUMNS}%`, padding: GIFT_TILE_GAP }}
      onLayout={active ? (event) => onActiveLayout(event.nativeEvent.layout.y) : undefined}
    >
      <Pressable
        onPress={onPress}
        accessibilityState={{ selected: active }}
        className="items-center rounded-lg px-1 pb-1 pt-1.5"
        style={{
          borderWidth: 1,
          borderColor: active ? GIFT_ACCENT : 'transparent',
          backgroundColor: '#ffffff',
        }}
      >
        <CachedImage uri={gift.imageUrl} style={{ width: 64, height: 64 }} resizeMode="contain" />
        <Text numberOfLines={1} className="mt-0.5 text-center text-xs" style={{ color: TEXT_PRIMARY }}>
          {giftDisplayName(gift, language)}
        </Text>
        <View className="flex-row items-center gap-0.5">
          <Image source={GIFT_ASSETS.ken} style={KEN_ICON_SMALL} resizeMode="contain" />
          <Text className="text-[11px] font-semibold" style={{ color: WARNING }}>
            {formatKen(gift.kenPrice)}
          </Text>
        </View>
      </Pressable>
    </View>
  );
}

function ReceiverIdentity({ receiver }: { receiver: GiftReceiver }) {
  return (
    <>
      <AvatarWithFrame name={receiver.name} uri={receiver.avatar} color={receiver.color} size={36} frameId={receiver.avatarFrameId} />
      <View className="min-w-0 flex-1">
        <Text numberOfLines={1} className="text-base" style={{ color: TEXT_PRIMARY }}>
          {receiver.name}
        </Text>
        {receiver.username != null && receiver.username !== '' && (
          <Text numberOfLines={1} className="text-xs" style={{ color: TEXT_SECONDARY }}>
            @{receiver.username}
          </Text>
        )}
      </View>
    </>
  );
}

function AnnounceSwitch({
  value,
  onValueChange,
}: {
  value: boolean;
  onValueChange?: (value: boolean) => void;
}) {
  const { t } = useTranslation();
  return (
    <View className="flex-row items-center justify-between gap-2">
      <Text className="flex-1 text-sm" style={{ color: TEXT_SECONDARY }}>
        {t('gift.announceLabel')}
      </Text>
      <Switch
        value={value}
        onValueChange={onValueChange}
        disabled={onValueChange == null}
        trackColor={{ true: GIFT_ACCENT }}
      />
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
  const gridRef = useRef<ComponentRef<typeof ScrollView>>(null);
  const [activeTileY, setActiveTileY] = useState<number | null>(null);

  useEffect(() => {
    if (step === 'pick' && activeTileY != null) {
      gridRef.current?.scrollTo({ y: activeTileY, animated: false });
    }
  }, [activeTileY, step]);

  if (step === 'confirm' && selected != null) {
    const senderGain = senderCharmGain(selected, quantity);
    const trimmedNote = note.trim();
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
              {t('gift.edit')}
            </DialogButton>
            <DialogButton variant="green" onPress={picker.confirmSend} disabled={submitting}>
              {submitting ? t('gift.sending') : t('gift.send')}
            </DialogButton>
          </>
        }
      >
        <View className="px-1">
          <View className="gap-1.5 pb-3">
            <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('gift.receiverLabel')}
            </Text>
            <View className="flex-row items-center gap-3">
              <ReceiverIdentity receiver={receiver} />
            </View>
          </View>
          <View className="gap-1.5 py-3" style={SECTION_DIVIDER}>
            <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('gift.giftLabel')}
            </Text>
            <View className="flex-row items-center gap-3">
              <CachedImage uri={selected.imageUrl} style={{ width: 64, height: 64 }} resizeMode="contain" />
              <View className="min-w-0 flex-1 gap-1">
                <Text numberOfLines={1} className="text-lg font-bold" style={{ color: TEXT_PRIMARY }}>
                  {selectedName}{' '}
                  <Text style={{ color: GIFT_ACCENT }}>{t('gift.quantityTimes', { count: quantity })}</Text>
                </Text>
                <GiftPill
                  tone="charm"
                  text={t('gift.receiverCharmGain', {
                    name: receiver.name,
                    value: formatKen(selected.charmPoints * quantity),
                  })}
                  trailing={<CharmIcon />}
                />
                {senderGain > 0 && (
                  <GiftPill
                    tone="ken"
                    text={t('gift.senderCharmGain', { value: formatKen(senderGain) })}
                    trailing={<CharmIcon />}
                  />
                )}
              </View>
            </View>
            {trimmedNote !== '' && (
              <Text
                className="mt-1 rounded-lg px-3 py-2 text-sm italic"
                style={{ backgroundColor: 'rgba(0,0,0,0.04)', color: 'rgba(0,0,0,0.7)' }}
              >
                “{trimmedNote}”
              </Text>
            )}
          </View>
          {picker.canAnnounce && (
            <View className="py-3" style={SECTION_DIVIDER}>
              <AnnounceSwitch value={picker.announce} />
            </View>
          )}
          <View className="flex-row items-center justify-between pt-3" style={SECTION_DIVIDER}>
            <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('gift.total')}
            </Text>
            <View className="flex-row items-center gap-1">
              <Image source={GIFT_ASSETS.ken} style={KEN_ICON_LARGE} resizeMode="contain" />
              <Text className="text-lg font-bold" style={{ color: WARNING }}>
                {formatKen(total)} {t('chat.transferKenUnit')}
              </Text>
            </View>
          </View>
        </View>
      </Dialog>
    );
  }

  const sendLabel = submitting
    ? t('gift.sending')
    : !affordable && selected != null
      ? t('gift.notEnoughKen')
      : t('gift.sendWithTotal', { ken: formatKen(total) });

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
          {sendLabel}
        </DialogButton>
      }
    >
      <View className="gap-2.5 px-1 py-1">
        <View
          className="flex-row items-center gap-3 rounded px-3 py-2"
          style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
        >
          <ReceiverIdentity receiver={receiver} />
          <View className="flex-row items-center gap-1">
            <Image source={GIFT_ASSETS.ken} style={KEN_ICON_LARGE} resizeMode="contain" />
            <Text className="text-base font-bold" style={{ color: TEXT_PRIMARY }}>
              {formatKen(balance)}
            </Text>
          </View>
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
            ref={gridRef}
            className="rounded"
            style={{ maxHeight: GIFT_GRID_MAX_HEIGHT, borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
            contentContainerStyle={{ flexDirection: 'row', flexWrap: 'wrap', padding: 1 }}
          >
            {gifts.map((gift) => (
              <GiftTile
                key={gift.id}
                gift={gift}
                active={gift.id === selected?.id}
                language={i18n.language}
                onPress={() => picker.selectGift(gift.id)}
                onActiveLayout={setActiveTileY}
              />
            ))}
          </ScrollView>
        )}

        {ready && (
          <>
            <View className="flex-row items-center gap-2">
              <Text className="text-sm" style={{ color: TEXT_PRIMARY }}>
                {t('gift.quantity')}
              </Text>
              <View className="flex-1 flex-row gap-1.5">
                {settings.quantityOptions.map((option) => {
                  const active = option === quantity;
                  return (
                    <Pressable
                      key={option}
                      onPress={() => picker.selectQuantity(option)}
                      accessibilityState={{ selected: active }}
                      className="flex-1 items-center rounded py-1"
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
                className="rounded px-3 py-1.5 text-sm"
                style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)', color: TEXT_PRIMARY }}
              />
            )}

            {picker.canAnnounce && (
              <AnnounceSwitch value={picker.announce} onValueChange={picker.setAnnounce} />
            )}
          </>
        )}
      </View>
    </Dialog>
  );
}
