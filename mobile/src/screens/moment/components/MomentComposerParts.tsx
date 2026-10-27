import { useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, StyleSheet, Text, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import {
  MOMENT_BACKGROUNDS,
  MOMENT_MAX_SLIDES,
  MOMENT_MAX_VIDEO_SECONDS,
  MOMENT_MIX_COLORS,
  MOMENT_MIX_ICON_COLORS,
  MOMENT_MIX_MAX_COLORS,
  MOMENT_VISIBILITY,
  MOMENT_VISIBILITY_LABEL,
  type MomentBackgroundKey,
} from '@ola/shared/constants';
import {
  formatDuration,
  parseMomentMix,
  readableTextColor,
  momentMixKey,
  toggleMomentMixColor,
} from '@ola/shared/lib';
import type { MomentDraftSlide, MomentVisibility } from '@ola/shared/types';
import { Dialog } from '@components/ui/Dialog';
import { useThemeColors } from '@hooks/useThemeColors';
import { MomentBackgroundFill } from './MomentCanvas';
import {
  MomentCheckIcon,
  MomentChevronIcon,
  MomentCloseIcon,
  MomentImageIcon,
  MomentPlusIcon,
  MomentVideoIcon,
} from './MomentIcons';

const BACKGROUND_KEYS = Object.keys(MOMENT_BACKGROUNDS) as MomentBackgroundKey[];
const MODE_ICON = {
  width: 40,
  height: 40,
  borderRadius: 20,
  overflow: 'hidden',
  alignItems: 'center',
  justifyContent: 'center',
} as const;
const VIP_BADGE = { borderRadius: 999, paddingHorizontal: 6, backgroundColor: '#fbbf24' } as const;
const VIP_BADGE_TEXT = { color: '#ffffff', fontSize: 10, fontWeight: '700' } as const;
const INK = 'rgba(0,0,0,0.7)';
const CHIP = {
  backgroundColor: '#ffffff',
  borderWidth: 1,
  borderColor: 'rgba(0,0,0,0.06)',
  shadowColor: '#000',
  shadowOpacity: 0.08,
  shadowRadius: 2,
  shadowOffset: { width: 0, height: 1 },
  elevation: 1,
} as const;
const SWATCH_SIZE = 36;
const SWATCH_GRID = { gap: 10, paddingHorizontal: 4, paddingVertical: 6 };
const MIX_ICON_GRADIENT = { start: { x: 0, y: 0 }, end: { x: 1, y: 1 } };
const SLIDE_THUMB = { width: 30, height: 54 };
const CHOICE_BUTTON = {
  height: 48,
  width: '100%',
  maxWidth: 240,
  borderRadius: 24,
  backgroundColor: '#ffffff',
  flexDirection: 'row',
  alignItems: 'center',
  justifyContent: 'center',
  gap: 8,
  shadowColor: '#000',
  shadowOpacity: 0.15,
  shadowRadius: 4,
  shadowOffset: { width: 0, height: 2 },
  elevation: 2,
} as const;
const CHOICE_MIX_DOT = { width: 20, height: 20, borderRadius: 10 };
const MENU = {
  position: 'absolute',
  minWidth: 168,
  paddingVertical: 4,
  borderRadius: 12,
  backgroundColor: '#ffffff',
  shadowColor: '#000',
  shadowOpacity: 0.18,
  shadowRadius: 12,
  shadowOffset: { width: 0, height: 4 },
  elevation: 8,
} as const;

function ModeRow({
  background,
  icon,
  title,
  hint,
  badge,
  divided,
  onPress,
}: {
  background: MomentBackgroundKey;
  icon: ReactNode;
  title: string;
  hint: string;
  badge?: string;
  divided: boolean;
  onPress: () => void;
}) {
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={title}
      onPress={onPress}
      className="flex-row items-center gap-3 px-3 py-3 active:bg-black/5"
      style={divided ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' } : null}
    >
      <View style={MODE_ICON}>
        <MomentBackgroundFill background={background} />
        {icon}
      </View>
      <View className="min-w-0 flex-1 gap-0.5">
        <View className="flex-row items-center gap-1.5">
          <Text className="text-base font-medium" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {title}
          </Text>
          {badge != null && (
            <View style={VIP_BADGE}>
              <Text style={VIP_BADGE_TEXT}>{badge}</Text>
            </View>
          )}
        </View>
        <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
          {hint}
        </Text>
      </View>
      <MomentChevronIcon direction="right" size={20} color="rgba(0,0,0,0.3)" />
    </Pressable>
  );
}

export function MomentModePicker({
  visible,
  error,
  videoLocked,
  vipPrompt,
  onClose,
  onDismiss,
  onPickSlides,
  onPickVideo,
  onBuyVip,
}: {
  visible: boolean;
  error: string | null;
  videoLocked: boolean;
  vipPrompt: boolean;
  onClose: () => void;
  onDismiss: () => void;
  onPickSlides: () => void;
  onPickVideo: () => void;
  onBuyVip: () => void;
}) {
  const { t } = useTranslation();
  return (
    <Dialog
      visible={visible}
      onClose={onClose}
      onDismiss={onDismiss}
      title={t('moment.createTitle')}
      showClose
      avoidKeyboard={false}
    >
      <View style={{ marginHorizontal: -8, marginVertical: -4 }}>
        <ModeRow
          background="sunset"
          icon={<MomentImageIcon size={20} />}
          title={t('moment.modeSlides')}
          hint={t('moment.modeSlidesHint', { count: MOMENT_MAX_SLIDES })}
          divided={false}
          onPress={onPickSlides}
        />
        <ModeRow
          background="grape"
          icon={<MomentVideoIcon size={20} />}
          title={t('moment.modeVideo')}
          hint={t('moment.modeVideoHint', { count: MOMENT_MAX_VIDEO_SECONDS })}
          badge={videoLocked ? t('moment.videoVipBadge') : undefined}
          divided
          onPress={onPickVideo}
        />
      </View>
      {error != null && (
        <Text className="px-1 pt-3 text-sm text-ola-error">{error}</Text>
      )}
      {vipPrompt && (
        <View className="items-center gap-3 px-1 pt-3">
          <Text className="text-center text-sm" style={{ color: INK }}>
            {t('moment.videoVipRequired')}
          </Text>
          <Pressable
            accessibilityRole="button"
            onPress={onBuyVip}
            className="rounded-full bg-ola-button px-6 py-2 active:opacity-90"
          >
            <Text className="text-sm font-medium text-white">{t('moment.buyVip')}</Text>
          </Pressable>
        </View>
      )}
    </Dialog>
  );
}

function Swatch({
  role,
  label,
  selected,
  onPress,
  children,
}: {
  role: 'radio' | 'checkbox' | 'button';
  label: string;
  selected: boolean;
  onPress: () => void;
  children: ReactNode;
}) {
  const colors = useThemeColors();
  return (
    <Pressable
      accessibilityRole={role}
      accessibilityState={{ checked: selected }}
      accessibilityLabel={label}
      onPress={onPress}
      style={{
        width: SWATCH_SIZE,
        height: SWATCH_SIZE,
        borderRadius: SWATCH_SIZE / 2,
        borderWidth: selected ? 2 : 1,
        borderColor: selected ? colors.primary : 'rgba(0,0,0,0.12)',
        backgroundColor: '#ffffff',
        padding: 2,
        transform: [{ scale: selected ? 1.1 : 1 }],
      }}
    >
      <View
        style={{
          flex: 1,
          borderRadius: SWATCH_SIZE / 2,
          overflow: 'hidden',
          alignItems: 'center',
          justifyContent: 'center',
        }}
      >
        {children}
      </View>
    </Pressable>
  );
}

function MomentMixPalette({
  value,
  onChange,
  onDone,
}: {
  value: string;
  onChange: (key: string) => void;
  onDone: () => void;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const selected = parseMomentMix(value) ?? [];
  return (
    <View className="items-center gap-1">
      <Text className="text-center text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
        {t('moment.mixHint', { count: MOMENT_MIX_MAX_COLORS })}
      </Text>
      <View className="flex-row flex-wrap justify-center" style={SWATCH_GRID}>
        {MOMENT_MIX_COLORS.map((color) => {
          const order = selected.indexOf(color);
          return (
            <Swatch
              key={color}
              role="checkbox"
              label={color}
              selected={order >= 0}
              onPress={() => onChange(momentMixKey(toggleMomentMixColor(selected, color)))}
            >
              <View style={[StyleSheet.absoluteFill, { backgroundColor: color }]} />
              {order >= 0 && (
                <Text className="text-sm font-bold" style={{ color: readableTextColor(color) }}>
                  {order + 1}
                </Text>
              )}
            </Swatch>
          );
        })}
      </View>
      <Pressable
        accessibilityRole="button"
        onPress={onDone}
        className="rounded-full px-4 py-1.5"
        style={{ backgroundColor: colors.primary }}
      >
        <Text className="text-sm font-semibold" style={{ color: colors.onPrimary }}>
          {t('moment.done')}
        </Text>
      </Pressable>
    </View>
  );
}

export function MomentBackgroundPicker({
  value,
  onChange,
}: {
  value: string;
  onChange: (key: string) => void;
}) {
  const { t } = useTranslation();
  const [mixing, setMixing] = useState(false);
  const mixed = parseMomentMix(value) != null;

  if (mixing) {
    return <MomentMixPalette value={value} onChange={onChange} onDone={() => setMixing(false)} />;
  }

  return (
    <View
      accessibilityRole="radiogroup"
      accessibilityLabel={t('moment.background')}
      className="flex-row flex-wrap justify-center"
      style={SWATCH_GRID}
    >
      <Swatch role="button" label={t('moment.mixBackground')} selected={mixed} onPress={() => setMixing(true)}>
        {mixed ? (
          <MomentBackgroundFill background={value} />
        ) : (
          <LinearGradient
            colors={[...MOMENT_MIX_ICON_COLORS]}
            start={MIX_ICON_GRADIENT.start}
            end={MIX_ICON_GRADIENT.end}
            style={StyleSheet.absoluteFill}
          />
        )}
        <MomentPlusIcon size={16} />
      </Swatch>
      {BACKGROUND_KEYS.map((key, index) => (
        <Swatch
          key={key}
          role="radio"
          label={`${t('moment.background')} ${index + 1}`}
          selected={key === value}
          onPress={() => onChange(key)}
        >
          <MomentBackgroundFill background={key} />
        </Swatch>
      ))}
    </View>
  );
}

interface MomentSlideStripProps {
  slides: MomentDraftSlide[];
  activeIndex: number;
  onSelect: (index: number) => void;
  onRemove: (id: string) => void;
  onAdd: () => void;
}

export function MomentSlideStrip({ slides, activeIndex, onSelect, onRemove, onAdd }: MomentSlideStripProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <View className="flex-row items-center justify-center gap-3 py-1.5">
      {slides.map((slide, index) => (
        <View key={slide.id}>
          <Pressable
            accessibilityRole="button"
            onPress={() => onSelect(index)}
            style={{
              ...SLIDE_THUMB,
              borderRadius: 6,
              overflow: 'hidden',
              borderWidth: 2,
              borderColor: index === activeIndex ? colors.primary : 'transparent',
              opacity: index === activeIndex ? 1 : 0.6,
            }}
          >
            {slide.blank ? (
              <View className="flex-1" style={{ backgroundColor: 'rgba(0,0,0,0.08)' }} />
            ) : slide.media ? (
              <Image source={{ uri: slide.media.url }} resizeMode="cover" style={{ width: '100%', height: '100%' }} />
            ) : (
              <MomentBackgroundFill background={slide.background} />
            )}
          </Pressable>
          {slides.length > 1 && (
            <Pressable
              accessibilityRole="button"
              accessibilityLabel={t('moment.removeSlide')}
              hitSlop={6}
              onPress={() => onRemove(slide.id)}
              style={{
                position: 'absolute',
                top: -8,
                right: -8,
                width: 20,
                height: 20,
                borderRadius: 10,
                alignItems: 'center',
                justifyContent: 'center',
                backgroundColor: 'rgba(0,0,0,0.7)',
                borderWidth: 2,
                borderColor: '#ffffff',
              }}
            >
              <MomentCloseIcon size={12} />
            </Pressable>
          )}
        </View>
      ))}
      {slides.length < MOMENT_MAX_SLIDES && (
        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('moment.addSlide')}
          onPress={onAdd}
          style={{
            ...SLIDE_THUMB,
            borderRadius: 6,
            borderWidth: 2,
            borderStyle: 'dashed',
            borderColor: 'rgba(0,0,0,0.2)',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          <MomentPlusIcon size={16} color="rgba(0,0,0,0.45)" />
        </Pressable>
      )}
    </View>
  );
}

export function MomentVideoBar({ duration, onChange }: { duration?: number; onChange: () => void }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <View className="flex-row items-center justify-center gap-3 py-1.5">
      <View className="flex-row items-center gap-1.5 rounded-full px-3 py-1.5" style={CHIP}>
        <MomentVideoIcon size={16} color={INK} />
        <Text className="text-sm" style={{ color: INK }}>
          {duration == null ? t('moment.videoNoPreviewShort') : formatDuration(Math.round(duration))}
        </Text>
      </View>
      <Pressable
        accessibilityRole="button"
        onPress={onChange}
        className="rounded-full px-3 py-1.5 active:opacity-70"
        style={CHIP}
      >
        <Text className="text-sm font-medium" style={{ color: colors.primaryInk }}>
          {t('moment.changeVideo')}
        </Text>
      </Pressable>
    </View>
  );
}

export interface MomentMenuAnchor {
  top: number;
  right: number;
}

interface MomentVisibilityMenuProps {
  anchor: MomentMenuAnchor;
  value: MomentVisibility;
  onSelect: (value: MomentVisibility) => void;
  onClose: () => void;
}

export function MomentVisibilityMenu({ anchor, value, onSelect, onClose }: MomentVisibilityMenuProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <>
      <Pressable style={StyleSheet.absoluteFill} onPress={onClose} />
      <View accessibilityRole="menu" style={[MENU, anchor]}>
        {Object.values(MOMENT_VISIBILITY).map((option) => {
          const active = option === value;
          return (
            <Pressable
              key={option}
              accessibilityRole="menuitem"
              accessibilityState={{ selected: active }}
              onPress={() => onSelect(option)}
              className="flex-row items-center gap-3 px-4 py-3 active:bg-black/5"
            >
              <Text
                className={`flex-1 text-sm ${active ? 'font-semibold' : ''}`}
                style={{ color: active ? colors.primaryInk : INK }}
              >
                {t(MOMENT_VISIBILITY_LABEL[option])}
              </Text>
              {active && <MomentCheckIcon size={18} color={colors.primaryInk} />}
            </Pressable>
          );
        })}
      </View>
    </>
  );
}

interface MomentSlideChoiceProps {
  width: number;
  height: number;
  onPickPhoto: () => void;
  onPickColor: () => void;
}

export function MomentSlideChoice({ width, height, onPickPhoto, onPickColor }: MomentSlideChoiceProps) {
  const { t } = useTranslation();
  return (
    <View
      className="items-center justify-center gap-3 px-8"
      style={{ width, height, borderRadius: 12, overflow: 'hidden' }}
    >
      <MomentBackgroundFill background="ink" />
      <Text className="mb-1 text-center text-base font-medium" style={{ color: 'rgba(255,255,255,0.85)' }}>
        {t('moment.chooseHint')}
      </Text>
      <Pressable accessibilityRole="button" onPress={onPickPhoto} className="active:opacity-80" style={CHOICE_BUTTON}>
        <MomentImageIcon size={20} color={INK} />
        <Text className="text-base font-semibold" style={{ color: INK }}>
          {t('moment.choosePhoto')}
        </Text>
      </Pressable>
      <Pressable accessibilityRole="button" onPress={onPickColor} className="active:opacity-80" style={CHOICE_BUTTON}>
        <LinearGradient
          colors={[...MOMENT_MIX_ICON_COLORS]}
          start={MIX_ICON_GRADIENT.start}
          end={MIX_ICON_GRADIENT.end}
          style={CHOICE_MIX_DOT}
        />
        <Text className="text-base font-semibold" style={{ color: INK }}>
          {t('moment.chooseColor')}
        </Text>
      </Pressable>
    </View>
  );
}

export function MomentPhotoBar({ onChange }: { onChange: () => void }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <View className="flex-row items-center justify-center py-1.5">
      <Pressable
        accessibilityRole="button"
        onPress={onChange}
        className="flex-row items-center gap-1.5 rounded-full px-3 py-1.5 active:opacity-70"
        style={CHIP}
      >
        <MomentImageIcon size={16} color={colors.primaryInk} />
        <Text className="text-sm font-medium" style={{ color: colors.primaryInk }}>
          {t('moment.changePhoto')}
        </Text>
      </Pressable>
    </View>
  );
}
