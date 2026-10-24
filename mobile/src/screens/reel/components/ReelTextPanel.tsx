import { useEffect, useRef, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, StyleSheet, Text, TextInput, View, type TextInputInstance } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import {
  REEL_FONT_LABEL,
  REEL_FONTS,
  REEL_MAX_OVERLAY_CHARS,
  REEL_OVERLAY_STYLE,
  REEL_TEXT_ALIGN,
  REEL_TEXT_COLORS,
} from '@ola/shared/constants';
import { nextReelOption, resolveReelFont } from '@ola/shared/lib';
import type { ReelOverlay } from '@ola/shared/types';
import { KeyboardView } from '@components/KeyboardView';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { overlayBubbleStyle, overlayTextStyle } from '../utils';
import { ReelAlignIcon, ReelTextStyleIcon } from './ReelIcons';

const OVERLAY_STYLES = Object.values(REEL_OVERLAY_STYLE);
const TEXT_ALIGNS = Object.values(REEL_TEXT_ALIGN);
const COLOR_SWATCH = 28;

function ToolButton({ label, onPress, children }: { label: string; onPress: () => void; children: ReactNode }) {
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={label}
      onPress={onPress}
      className="h-9 min-w-9 items-center justify-center rounded-full px-2.5"
      style={{ backgroundColor: 'rgba(0,0,0,0.4)' }}
    >
      {children}
    </Pressable>
  );
}

interface ReelTextPanelProps {
  overlay: ReelOverlay;
  canvasWidth: number;
  onChange: (patch: Partial<ReelOverlay>) => void;
  onDone: () => void;
}

export function ReelTextPanel({ overlay, canvasWidth, onChange, onDone }: ReelTextPanelProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const bottomInset = useBottomBarInset();
  const font = resolveReelFont(overlay.font);
  const inputRef = useRef<TextInputInstance>(null);

  useEffect(() => {
    const frame = requestAnimationFrame(() => inputRef.current?.focus());
    return () => cancelAnimationFrame(frame);
  }, []);

  return (
    <View style={[StyleSheet.absoluteFill, { backgroundColor: 'rgba(0,0,0,0.55)' }]}>
      <KeyboardView className="flex-1" style={{ paddingTop: insets.top, paddingBottom: bottomInset }}>
        <View className="flex-row items-center gap-1.5 p-3">
          <ToolButton
            label={t('reel.font')}
            onPress={() => onChange({ font: nextReelOption(REEL_FONTS, font) })}
          >
            <Text className="text-sm font-semibold" style={{ color: '#ffffff' }}>
              {t(REEL_FONT_LABEL[font])}
            </Text>
          </ToolButton>
          <ToolButton
            label={t('reel.textStyle')}
            onPress={() => onChange({ style: nextReelOption(OVERLAY_STYLES, overlay.style) })}
          >
            <ReelTextStyleIcon />
          </ToolButton>
          <ToolButton
            label={t('reel.align')}
            onPress={() => onChange({ align: nextReelOption(TEXT_ALIGNS, overlay.align) })}
          >
            <ReelAlignIcon align={overlay.align} />
          </ToolButton>
          <View className="flex-1" />
          <Pressable
            accessibilityRole="button"
            onPress={onDone}
            className="rounded-full px-4 py-1.5"
            style={{ backgroundColor: '#ffffff' }}
          >
            <Text className="text-sm font-semibold" style={{ color: '#000000' }}>
              {t('reel.done')}
            </Text>
          </Pressable>
        </View>

        <Pressable className="flex-1 items-center justify-center" onPress={onDone}>
          <View style={[overlayBubbleStyle(overlay, canvasWidth), { width: overlay.w * canvasWidth }]}>
            <TextInput
              ref={inputRef}
              value={overlay.text}
              multiline
              maxLength={REEL_MAX_OVERLAY_CHARS}
              placeholder={t('reel.textPlaceholder')}
              placeholderTextColor="rgba(255,255,255,0.6)"
              onChangeText={(text) => onChange({ text })}
              style={[overlayTextStyle(overlay, canvasWidth), { padding: 0, margin: 0 }]}
            />
          </View>
        </Pressable>

        <ScrollView
          horizontal
          style={{ flexGrow: 0 }}
          keyboardShouldPersistTaps="always"
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={{ gap: 8, padding: 12 }}
        >
          {REEL_TEXT_COLORS.map((color) => {
            const selected = color === overlay.color;
            return (
              <Pressable
                key={color}
                accessibilityRole="radio"
                accessibilityState={{ checked: selected }}
                accessibilityLabel={color}
                onPress={() => onChange({ color })}
                style={{
                  width: COLOR_SWATCH,
                  height: COLOR_SWATCH,
                  borderRadius: COLOR_SWATCH / 2,
                  backgroundColor: color,
                  borderWidth: 2,
                  borderColor: selected ? '#ffffff' : 'rgba(255,255,255,0.4)',
                  transform: [{ scale: selected ? 1.1 : 1 }],
                }}
              />
            );
          })}
        </ScrollView>
      </KeyboardView>
    </View>
  );
}
