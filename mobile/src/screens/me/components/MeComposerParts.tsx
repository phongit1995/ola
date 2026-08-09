import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Pressable,
  ScrollView,
  Text,
  View,
  type ImageSourcePropType,
} from 'react-native';
import type { PostVisibility } from '@ola/shared/types';
import { KUL_IMAGES, stickerImageForCode } from '@lib/kul';
import { imageSizeForHeight } from '@lib/chatSmiley';
import { CachedImage } from '@components/ui/CachedImage';
import { CloseIcon } from '@components/ui/CloseIcon';
import { DIVIDER, ERROR, TEXT_SECONDARY } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import type { ComposedCheckIn } from './MeComposerCheckInPanel';
import { COMPOSER_MAX_IMAGES } from '../constants';
import type { PickedPhoto } from '../interface';
import type { ComposerAttachKey, ComposerPanel } from '../types';

const checkInCardIcon = require('@assets/icons/me/ic_check_in.png');
const kulTabIcon = require('@assets/icons/chat/ic_tab_kul.png');

function privacyKey(option: PostVisibility): 'me.privacy_public' {
  return `me.privacy_${option}` as 'me.privacy_public';
}

interface ComposerHeaderProps {
  paddingTop: number;
  titleText: string;
  actionText: string;
  canPost: boolean;
  posting: boolean;
  onClose: () => void;
  onSubmit: () => void;
}

export function ComposerHeader({
  paddingTop,
  titleText,
  actionText,
  canPost,
  posting,
  onClose,
  onSubmit,
}: ComposerHeaderProps) {
  return (
    <View
      className="flex-row items-center justify-between bg-ola-primary px-2 pb-2"
      style={{ paddingTop }}
    >
      <Pressable
        onPress={onClose}
        className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
      >
        <CloseIcon />
      </Pressable>
      <Text className="text-lg font-medium text-white">{titleText}</Text>
      <Pressable
        onPress={onSubmit}
        disabled={!canPost}
        className="h-9 items-center justify-center rounded-full px-4"
        style={{ opacity: canPost ? 1 : 0.4 }}
      >
        {posting ? (
          <ActivityIndicator color="#ffffff" />
        ) : (
          <Text className="text-sm font-semibold text-white">{actionText}</Text>
        )}
      </Pressable>
    </View>
  );
}

interface PrivacyRowProps {
  options: PostVisibility[];
  privacy: PostVisibility;
  onChange: (option: PostVisibility) => void;
}

export function PrivacyRow({ options, privacy, onChange }: PrivacyRowProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <View className="flex-row items-center gap-2 px-4 pt-3">
      <Text className="text-sm text-ola-ink-soft">{t('me.privacyTo')}</Text>
      {options.map(option => {
        const active = option === privacy;
        return (
          <Pressable
            key={option}
            onPress={() => onChange(option)}
            className="rounded-full px-3 py-1"
            style={{
              borderWidth: 1,
              borderColor: active ? colors.primary : DIVIDER,
              backgroundColor: active ? colors.primaryLight : 'transparent',
            }}
          >
            <Text
              className="text-xs"
              style={{ color: active ? colors.primary : TEXT_SECONDARY }}
            >
              {t(privacyKey(option))}
            </Text>
          </Pressable>
        );
      })}
    </View>
  );
}

export function StickerPreview({
  sticker,
  onRemove,
}: {
  sticker: string;
  onRemove: () => void;
}) {
  const { t } = useTranslation();
  const stickerImg = stickerImageForCode(sticker);
  return (
    <View
      className="mx-4 mt-2 flex-row items-center rounded-md p-2"
      style={{ borderWidth: 1, borderColor: DIVIDER }}
    >
      {stickerImg != null ? (
        <Image
          source={stickerImg}
          style={imageSizeForHeight(stickerImg, 64)}
          resizeMode="contain"
        />
      ) : (
        <Text className="text-sm text-ola-ink-soft">{sticker}</Text>
      )}
      <Pressable onPress={onRemove} className="ml-auto px-2">
        <Text className="text-xs" style={{ color: ERROR }}>
          {t('me.removeSticker')}
        </Text>
      </Pressable>
    </View>
  );
}

export function CheckInPreview({
  checkIn,
  onRemove,
}: {
  checkIn: ComposedCheckIn;
  onRemove: () => void;
}) {
  const { t } = useTranslation();
  return (
    <View
      className="mx-4 mt-2 flex-row items-center gap-2 rounded-md p-2"
      style={{ borderWidth: 1, borderColor: DIVIDER }}
    >
      <Image
        source={checkInCardIcon}
        style={{ width: 28, height: 28 }}
        resizeMode="contain"
      />
      <View className="min-w-0 flex-1">
        {(checkIn.action ?? '') !== '' && (
          <Text numberOfLines={1} className="text-sm text-ola-ink">
            {checkIn.actionIcon} {checkIn.action}
          </Text>
        )}
        <Text
          numberOfLines={1}
          className="text-xs"
          style={{ color: 'rgba(0,0,0,0.4)' }}
        >
          {checkIn.name}
        </Text>
      </View>
      <Pressable onPress={onRemove} className="px-2">
        <Text className="text-xs" style={{ color: ERROR }}>
          {t('me.removeCheckIn')}
        </Text>
      </Pressable>
    </View>
  );
}

export function PhotoStrip({
  photos,
  onRemove,
}: {
  photos: PickedPhoto[];
  onRemove: (id: string) => void;
}) {
  const { t } = useTranslation();
  if (photos.length === 0) return null;
  return (
    <>
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        className="mt-3"
        contentContainerClassName="gap-2 px-4"
      >
        {photos.map(photo => (
          <View key={photo.id} className="relative">
            <CachedImage
              uri={photo.uri}
              style={{
                width: 80,
                height: 80,
                borderRadius: 6,
                borderWidth: 1,
                borderColor: DIVIDER,
              }}
              resizeMode="cover"
            />
            <Pressable
              onPress={() => onRemove(photo.id)}
              className="absolute h-5 w-5 items-center justify-center rounded-full"
              style={{ top: 4, right: 4, backgroundColor: 'rgba(0,0,0,0.6)' }}
            >
              <Text className="text-sm leading-none text-white">×</Text>
            </Pressable>
          </View>
        ))}
      </ScrollView>
      {photos.length >= COMPOSER_MAX_IMAGES && (
        <Text className="mx-4 mt-1 text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
          {t('me.maxImages')}
        </Text>
      )}
    </>
  );
}

export function StickerPanel({ onPick }: { onPick: (code: string) => void }) {
  return (
    <View
      className="mx-4 mt-2"
      style={{ borderWidth: 1, borderColor: DIVIDER, borderRadius: 6 }}
    >
      <ScrollView style={{ maxHeight: 176 }} keyboardShouldPersistTaps="handled">
        <View className="flex-row flex-wrap p-2">
          {KUL_IMAGES.map((image, index) => (
            <Pressable
              key={index}
              onPress={() => onPick(`kul:${index + 1}`)}
              className="items-center justify-center"
              style={{ width: `${100 / 6}%`, height: 48 }}
            >
              <Image
                source={image}
                style={{ width: 40, height: 40 }}
                resizeMode="contain"
              />
            </Pressable>
          ))}
        </View>
      </ScrollView>
    </View>
  );
}

interface AttachButton {
  key: ComposerAttachKey;
  glyph?: string;
  icon?: ImageSourcePropType;
  label: string;
}

export function AttachBar({
  panel,
  paddingBottom,
  onPress,
}: {
  panel: ComposerPanel;
  paddingBottom: number;
  onPress: (key: ComposerAttachKey) => void;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const buttons: AttachButton[] = [
    { key: 'local', glyph: '📷', label: t('me.attachLocal') },
    { key: 'smiley', glyph: '😀', label: t('me.attachSmiley') },
    { key: 'tag', glyph: '🏷️', label: t('me.attachTag') },
    { key: 'checkin', glyph: '📍', label: t('me.attachCheckIn') },
    { key: 'sticker', icon: kulTabIcon, label: t('me.attachSticker') },
  ];
  return (
    <View
      className="flex-row justify-around px-2 pt-2"
      style={{ borderTopWidth: 1, borderTopColor: DIVIDER, paddingBottom }}
    >
      {buttons.map(button => (
        <Pressable
          key={button.key}
          onPress={() => onPress(button.key)}
          className="items-center gap-0.5 px-2 py-1"
        >
          {button.icon != null ? (
            <Image
              source={button.icon}
              style={{ width: 24, height: 24 }}
              resizeMode="contain"
            />
          ) : (
            <Text style={{ fontSize: 24, lineHeight: 24 }}>{button.glyph}</Text>
          )}
          <Text
            className="text-xs"
            style={{ color: panel === button.key ? colors.primary : TEXT_SECONDARY }}
          >
            {button.label}
          </Text>
        </Pressable>
      ))}
    </View>
  );
}
