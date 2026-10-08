import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, View } from 'react-native';
import { STORY_FONT_SIZE, STORY_LINE_HEIGHTS } from '@ola/shared/lib';
import { useStoryPrefsStore } from '@ola/shared/stores/story/storyPrefsStore';
import type { StoryIconName, StoryReaderFont } from '@ola/shared/types';
import { useThemeColors } from '@hooks/useThemeColors';
import {
  READER_FONTS,
  READER_PALETTES,
  READER_THEME_ICON,
  READER_THEME_ORDER,
} from '../constants';
import type { ReaderPalette } from '../interface';
import { useStoryTextSize } from '../typography';
import { ReaderSheet } from './ReaderSheet';
import { StoryIcon } from './StoryIcons';

const FONT_ORDER: StoryReaderFont[] = ['serif', 'sans'];
const SWATCH_SIZE = 36;
const SWATCH_RING = 2;
const SWATCH_GAP = 2;
const ROW_ICON_SIZE = 16;
const SWATCH_ICON_SIZE = 20;

interface SettingRowProps {
  icon: StoryIconName;
  label: string;
  palette: ReaderPalette;
  first?: boolean;
  children: ReactNode;
}

function SettingRow({ icon, label, palette, first = false, children }: SettingRowProps) {
  const textSize = useStoryTextSize();
  return (
    <View
      className="gap-2 py-3"
      style={first ? undefined : { borderTopWidth: 1, borderTopColor: palette.border }}
    >
      <View className="flex-row items-center gap-1.5">
        <StoryIcon name={icon} size={ROW_ICON_SIZE} color={palette.muted} />
        <Text style={[textSize(13, 18), { color: palette.muted }]}>{label}</Text>
      </View>
      {children}
    </View>
  );
}

interface SegmentProps {
  active: boolean;
  palette: ReaderPalette;
  onPress: () => void;
  children: string;
  fontFamily?: string;
}

function Segment({ active, palette, onPress, children, fontFamily }: SegmentProps) {
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityState={{ selected: active }}
      onPress={onPress}
      className="h-9 flex-1 items-center justify-center rounded-lg"
      style={{
        borderWidth: 1,
        borderColor: active ? colors.primary : palette.border,
        backgroundColor: palette.background,
      }}
    >
      <Text
        className={active ? 'font-semibold' : ''}
        style={[textSize(14, 20), { fontFamily, color: active ? colors.primaryInk : palette.text }]}
      >
        {children}
      </Text>
    </Pressable>
  );
}

interface StepButtonProps {
  label: string;
  accessibilityLabel: string;
  disabled: boolean;
  palette: ReaderPalette;
  onPress: () => void;
}

function StepButton({ label, accessibilityLabel, disabled, palette, onPress }: StepButtonProps) {
  const textSize = useStoryTextSize();
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={accessibilityLabel}
      disabled={disabled}
      onPress={onPress}
      className="h-9 w-12 items-center justify-center rounded-lg"
      style={{
        borderWidth: 1,
        borderColor: palette.border,
        backgroundColor: palette.background,
        opacity: disabled ? 0.4 : 1,
      }}
    >
      <Text style={[textSize(14, 20), { color: palette.text }]}>{label}</Text>
    </Pressable>
  );
}

interface ReaderSettingsSheetProps {
  palette: ReaderPalette;
  onClose: () => void;
}

export function ReaderSettingsSheet({ palette, onClose }: ReaderSettingsSheetProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const reader = useStoryPrefsStore((state) => state.reader);
  const setReader = useStoryPrefsStore((state) => state.setReader);

  return (
    <ReaderSheet title={t('story.displayOptions')} palette={palette} onClose={onClose}>
      <ScrollView contentContainerStyle={{ paddingHorizontal: 16, paddingBottom: 20 }}>
        <SettingRow icon="palette" label={t('story.theme')} palette={palette} first>
          <View className="flex-row gap-3">
            {READER_THEME_ORDER.map((theme) => {
              const swatch = READER_PALETTES[theme];
              const themeIcon = READER_THEME_ICON[theme];
              const active = reader.theme === theme;
              return (
                <Pressable
                  key={theme}
                  accessibilityRole="button"
                  accessibilityState={{ selected: active }}
                  onPress={() => setReader({ theme })}
                  className="items-center gap-1"
                >
                  <View
                    className="rounded-full"
                    style={{
                      padding: SWATCH_GAP,
                      borderWidth: SWATCH_RING,
                      borderColor: active ? colors.primary : 'transparent',
                    }}
                  >
                    <View
                      className="items-center justify-center"
                      style={{
                        width: SWATCH_SIZE,
                        height: SWATCH_SIZE,
                        borderRadius: SWATCH_SIZE / 2,
                        borderWidth: 1,
                        backgroundColor: swatch.background,
                        borderColor: swatch.border,
                      }}
                    >
                      {themeIcon && (
                        <StoryIcon name={themeIcon} size={SWATCH_ICON_SIZE} color={swatch.muted} />
                      )}
                    </View>
                  </View>
                  <Text style={[textSize(11, 16), { color: palette.text }]}>
                    {t(swatch.labelKey)}
                  </Text>
                </Pressable>
              );
            })}
          </View>
        </SettingRow>
        <SettingRow icon="textFields" label={t('story.font')} palette={palette}>
          <View className="flex-row gap-2">
            {FONT_ORDER.map((font) => (
              <Segment
                key={font}
                active={reader.font === font}
                palette={palette}
                fontFamily={READER_FONTS[font].family}
                onPress={() => setReader({ font })}
              >
                {t(READER_FONTS[font].labelKey)}
              </Segment>
            ))}
          </View>
        </SettingRow>
        <SettingRow icon="formatSize" label={t('story.fontSize')} palette={palette}>
          <View className="flex-row items-center gap-3">
            <StepButton
              label="A−"
              accessibilityLabel={t('story.decreaseFont')}
              disabled={reader.fontSize <= STORY_FONT_SIZE.min}
              palette={palette}
              onPress={() => setReader({ fontSize: reader.fontSize - STORY_FONT_SIZE.step })}
            />
            <Text
              className="flex-1 text-center font-semibold"
              style={[textSize(16, 24), { color: palette.text }]}
            >
              {reader.fontSize}
            </Text>
            <StepButton
              label="A+"
              accessibilityLabel={t('story.increaseFont')}
              disabled={reader.fontSize >= STORY_FONT_SIZE.max}
              palette={palette}
              onPress={() => setReader({ fontSize: reader.fontSize + STORY_FONT_SIZE.step })}
            />
          </View>
        </SettingRow>
        <SettingRow icon="formatLineSpacing" label={t('story.lineHeight')} palette={palette}>
          <View className="flex-row gap-2">
            {STORY_LINE_HEIGHTS.map((lineHeight) => (
              <Segment
                key={lineHeight}
                active={reader.lineHeight === lineHeight}
                palette={palette}
                onPress={() => setReader({ lineHeight })}
              >
                {lineHeight.toFixed(1)}
              </Segment>
            ))}
          </View>
        </SettingRow>
      </ScrollView>
    </ReaderSheet>
  );
}
