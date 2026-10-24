import { useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, ScrollView, StyleSheet, Text, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import {
  REEL_BACKGROUNDS,
  REEL_MAX_IMAGES,
  REEL_MAX_VIDEO_SECONDS,
  REEL_MIX_COLORS,
  REEL_MIX_ICON_COLORS,
  REEL_MIX_MAX_COLORS,
  type ReelBackgroundKey,
} from '@ola/shared/constants';
import {
  formatDuration,
  parseReelMix,
  readableTextColor,
  reelMixKey,
  toggleReelMixColor,
} from '@ola/shared/lib';
import type { ReelDraftSlide } from '@ola/shared/types';
import { ReelBackgroundFill } from './ReelCanvas';
import { ReelCloseIcon, ReelImageIcon, ReelPlusIcon, ReelVideoIcon } from './ReelIcons';

const BACKGROUND_KEYS = Object.keys(REEL_BACKGROUNDS) as ReelBackgroundKey[];
const SWATCH_SIZE = 36;
const SWATCH_ROW = { gap: 10, paddingHorizontal: 4, paddingVertical: 6 };
const MIX_ICON_GRADIENT = { start: { x: 0, y: 0 }, end: { x: 1, y: 1 } };
const SLIDE_THUMB = { width: 36, height: 64 };

function ModeCard({
  background,
  icon,
  title,
  hint,
  onPress,
}: {
  background: ReelBackgroundKey;
  icon: ReactNode;
  title: string;
  hint: string;
  onPress: () => void;
}) {
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={title}
      onPress={onPress}
      style={{ flex: 1, aspectRatio: 9 / 14, borderRadius: 16, overflow: 'hidden' }}
    >
      <ReelBackgroundFill background={background} />
      <View className="flex-1 items-center justify-center gap-2.5 px-2">
        <View
          className="h-12 w-12 items-center justify-center rounded-full"
          style={{ backgroundColor: 'rgba(255,255,255,0.25)' }}
        >
          {icon}
        </View>
        <Text className="text-center text-sm font-semibold" style={{ color: '#ffffff' }}>
          {title}
        </Text>
        <Text className="text-center" style={{ color: 'rgba(255,255,255,0.85)', fontSize: 11, lineHeight: 14 }}>
          {hint}
        </Text>
      </View>
    </Pressable>
  );
}

export function ReelModePicker({
  onPickText,
  onPickImage,
  onPickVideo,
}: {
  onPickText: () => void;
  onPickImage: () => void;
  onPickVideo: () => void;
}) {
  const { t } = useTranslation();
  return (
    <View className="flex-1 justify-center p-4">
      <View className="flex-row gap-3">
        <ModeCard
          background="sky"
          icon={<Text style={{ color: '#ffffff', fontSize: 20, fontWeight: '700' }}>Aa</Text>}
          title={t('reel.modeText')}
          hint={t('reel.modeTextHint')}
          onPress={onPickText}
        />
        <ModeCard
          background="sunset"
          icon={<ReelImageIcon size={24} />}
          title={t('reel.modeImage')}
          hint={t('reel.modeImageHint', { count: REEL_MAX_IMAGES })}
          onPress={onPickImage}
        />
        <ModeCard
          background="grape"
          icon={<ReelVideoIcon size={24} />}
          title={t('reel.modeVideo')}
          hint={t('reel.modeVideoHint', { count: REEL_MAX_VIDEO_SECONDS })}
          onPress={onPickVideo}
        />
      </View>
    </View>
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
        overflow: 'hidden',
        alignItems: 'center',
        justifyContent: 'center',
        transform: [{ scale: selected ? 1.1 : 1 }],
      }}
    >
      {children}
      <View
        pointerEvents="none"
        style={[
          StyleSheet.absoluteFill,
          {
            borderRadius: SWATCH_SIZE / 2,
            borderWidth: 2,
            borderColor: selected ? '#ffffff' : 'rgba(255,255,255,0.3)',
          },
        ]}
      />
    </Pressable>
  );
}

function ReelMixPalette({
  value,
  onChange,
  onDone,
}: {
  value: string;
  onChange: (key: string) => void;
  onDone: () => void;
}) {
  const { t } = useTranslation();
  const selected = parseReelMix(value) ?? [];
  return (
    <View className="gap-1">
      <Text className="text-center text-xs" style={{ color: 'rgba(255,255,255,0.8)' }}>
        {t('reel.mixHint', { count: REEL_MIX_MAX_COLORS })}
      </Text>
      <View className="flex-row items-center gap-2">
        <Pressable
          accessibilityRole="button"
          onPress={onDone}
          className="rounded-full px-3 py-1.5"
          style={{ backgroundColor: '#ffffff' }}
        >
          <Text className="text-sm font-semibold" style={{ color: '#000000' }}>
            {t('reel.done')}
          </Text>
        </Pressable>
        <ScrollView
          horizontal
          style={{ flex: 1 }}
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={SWATCH_ROW}
        >
          {REEL_MIX_COLORS.map((color) => {
            const order = selected.indexOf(color);
            return (
              <Swatch
                key={color}
                role="checkbox"
                label={color}
                selected={order >= 0}
                onPress={() => onChange(reelMixKey(toggleReelMixColor(selected, color)))}
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
        </ScrollView>
      </View>
    </View>
  );
}

export function ReelBackgroundPicker({
  value,
  onChange,
}: {
  value: string;
  onChange: (key: string) => void;
}) {
  const { t } = useTranslation();
  const [mixing, setMixing] = useState(false);
  const mixed = parseReelMix(value) != null;

  if (mixing) {
    return <ReelMixPalette value={value} onChange={onChange} onDone={() => setMixing(false)} />;
  }

  return (
    <ScrollView
      horizontal
      style={{ flexGrow: 0 }}
      showsHorizontalScrollIndicator={false}
      contentContainerStyle={SWATCH_ROW}
    >
      <Swatch role="button" label={t('reel.mixBackground')} selected={mixed} onPress={() => setMixing(true)}>
        {mixed ? (
          <ReelBackgroundFill background={value} />
        ) : (
          <LinearGradient
            colors={[...REEL_MIX_ICON_COLORS]}
            start={MIX_ICON_GRADIENT.start}
            end={MIX_ICON_GRADIENT.end}
            style={StyleSheet.absoluteFill}
          />
        )}
        <ReelPlusIcon size={16} />
      </Swatch>
      {BACKGROUND_KEYS.map((key, index) => (
        <Swatch
          key={key}
          role="radio"
          label={`${t('reel.background')} ${index + 1}`}
          selected={key === value}
          onPress={() => onChange(key)}
        >
          <ReelBackgroundFill background={key} />
        </Swatch>
      ))}
    </ScrollView>
  );
}

interface ReelSlideStripProps {
  slides: ReelDraftSlide[];
  activeIndex: number;
  onSelect: (index: number) => void;
  onRemove: (id: string) => void;
  onAdd: () => void;
}

export function ReelSlideStrip({ slides, activeIndex, onSelect, onRemove, onAdd }: ReelSlideStripProps) {
  const { t } = useTranslation();
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
              borderColor: index === activeIndex ? '#ffffff' : 'transparent',
              opacity: index === activeIndex ? 1 : 0.6,
            }}
          >
            {slide.media && (
              <Image source={{ uri: slide.media.url }} resizeMode="cover" style={{ width: '100%', height: '100%' }} />
            )}
          </Pressable>
          {slides.length > 1 && (
            <Pressable
              accessibilityRole="button"
              accessibilityLabel={t('reel.removeImage')}
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
                backgroundColor: '#000000',
                borderWidth: 1,
                borderColor: 'rgba(255,255,255,0.5)',
              }}
            >
              <ReelCloseIcon size={12} />
            </Pressable>
          )}
        </View>
      ))}
      {slides.length < REEL_MAX_IMAGES && (
        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('reel.addImage')}
          onPress={onAdd}
          style={{
            ...SLIDE_THUMB,
            borderRadius: 6,
            borderWidth: 2,
            borderStyle: 'dashed',
            borderColor: 'rgba(255,255,255,0.4)',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          <ReelPlusIcon size={16} color="rgba(255,255,255,0.8)" />
        </Pressable>
      )}
    </View>
  );
}

export function ReelVideoBar({ duration, onChange }: { duration?: number; onChange: () => void }) {
  const { t } = useTranslation();
  return (
    <View className="flex-row items-center justify-center gap-3 py-1.5">
      <View
        className="flex-row items-center gap-1.5 rounded-full px-3 py-1.5"
        style={{ backgroundColor: 'rgba(255,255,255,0.1)' }}
      >
        <ReelVideoIcon size={16} />
        <Text className="text-sm" style={{ color: '#ffffff' }}>
          {duration == null ? t('reel.videoNoPreviewShort') : formatDuration(Math.round(duration))}
        </Text>
      </View>
      <Pressable
        accessibilityRole="button"
        onPress={onChange}
        className="rounded-full px-3 py-1.5"
        style={{ backgroundColor: 'rgba(255,255,255,0.1)' }}
      >
        <Text className="text-sm" style={{ color: '#ffffff' }}>
          {t('reel.changeVideo')}
        </Text>
      </Pressable>
    </View>
  );
}
