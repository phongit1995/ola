import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View, type StyleProp, type TextStyle } from 'react-native';
import { MOMENT_FONT_LABEL, MOMENT_FONTS, MOMENT_TEXT_COLORS } from '@ola/shared/constants';
import { momentFontSizeLabel, momentFontSizeOptions, resolveMomentTextFace } from '@ola/shared/lib';
import type { MomentOverlay } from '@ola/shared/types';
import { MOMENT_FONT_FACE } from '../constants';

export type MomentTextMenu = 'color' | 'size' | 'font';

const BAR_HEIGHT = 40;
const FONT_PILL_WIDTH = 112;
const COLOR_SWATCH = 28;
const MENU_SURFACE = 'rgba(0,0,0,0.8)';

function SelectPill({
  label,
  value,
  open,
  width,
  valueStyle,
  onPress,
}: {
  label: string;
  value: string;
  open: boolean;
  width?: number;
  valueStyle?: StyleProp<TextStyle>;
  onPress: () => void;
}) {
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={label}
      accessibilityState={{ expanded: open }}
      onPress={onPress}
      className="h-8 flex-row items-center gap-1.5 rounded-full pl-3 pr-2.5"
      style={{ width, backgroundColor: open ? 'rgba(255,255,255,0.3)' : 'rgba(255,255,255,0.1)' }}
    >
      <Text numberOfLines={1} style={[{ flex: width == null ? 0 : 1, fontSize: 14, color: '#ffffff' }, valueStyle]}>
        {value}
      </Text>
      <Text style={{ fontSize: 10, color: 'rgba(255,255,255,0.8)' }}>▾</Text>
    </Pressable>
  );
}

export function MomentTextQuickBar({
  overlay,
  menu,
  onToggleMenu,
}: {
  overlay: MomentOverlay;
  menu: MomentTextMenu | null;
  onToggleMenu: (menu: MomentTextMenu) => void;
}) {
  const { t } = useTranslation();
  const face = resolveMomentTextFace(overlay);
  return (
    <View
      className="flex-row items-center gap-1 rounded-full p-1"
      style={{ height: BAR_HEIGHT, backgroundColor: 'rgba(0,0,0,0.6)' }}
    >
      <SelectPill
        label={t('moment.fontSize')}
        value={momentFontSizeLabel(overlay.scale)}
        open={menu === 'size'}
        onPress={() => onToggleMenu('size')}
      />
      <SelectPill
        label={t('moment.font')}
        value={t(MOMENT_FONT_LABEL[face.font])}
        open={menu === 'font'}
        width={FONT_PILL_WIDTH}
        valueStyle={MOMENT_FONT_FACE[face.font].regular}
        onPress={() => onToggleMenu('font')}
      />
    </View>
  );
}

function OptionChip({
  label,
  selected,
  textStyle,
  onPress,
}: {
  label: string;
  selected: boolean;
  textStyle?: StyleProp<TextStyle>;
  onPress: () => void;
}) {
  return (
    <Pressable
      accessibilityRole="radio"
      accessibilityState={{ checked: selected }}
      onPress={onPress}
      className="h-8 justify-center rounded-full px-3"
      style={{ backgroundColor: selected ? '#ffffff' : 'rgba(255,255,255,0.1)' }}
    >
      <Text style={[{ fontSize: 14, color: selected ? '#000000' : '#ffffff' }, textStyle]}>{label}</Text>
    </Pressable>
  );
}

function MenuSurface({ label, children }: { label: string; children: ReactNode }) {
  return (
    <View
      accessibilityRole="radiogroup"
      accessibilityLabel={label}
      className="flex-row flex-wrap justify-center gap-1.5 rounded-3xl p-1.5"
      style={{ maxWidth: '100%', backgroundColor: MENU_SURFACE }}
    >
      {children}
    </View>
  );
}

export function MomentTextMenuOptions({
  menu,
  overlay,
  onSelect,
}: {
  menu: MomentTextMenu;
  overlay: MomentOverlay;
  onSelect: (patch: Partial<MomentOverlay>) => void;
}) {
  const { t } = useTranslation();
  const face = resolveMomentTextFace(overlay);

  if (menu === 'color') {
    return (
      <MenuSurface label={t('moment.textColor')}>
        {MOMENT_TEXT_COLORS.map((color) => {
          const selected = color === overlay.color;
          return (
            <Pressable
              key={color}
              accessibilityRole="radio"
              accessibilityState={{ checked: selected }}
              accessibilityLabel={color}
              onPress={() => onSelect({ color })}
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
      </MenuSurface>
    );
  }

  if (menu === 'size') {
    const current = Math.round(overlay.scale * 100) / 100;
    return (
      <MenuSurface label={t('moment.fontSize')}>
        {momentFontSizeOptions(overlay.scale).map((scale) => (
          <OptionChip
            key={scale}
            label={momentFontSizeLabel(scale)}
            selected={scale === current}
            onPress={() => onSelect({ scale })}
          />
        ))}
      </MenuSurface>
    );
  }

  return (
    <MenuSurface label={t('moment.font')}>
      {MOMENT_FONTS.map((font) => (
        <OptionChip
          key={font}
          label={t(MOMENT_FONT_LABEL[font])}
          selected={font === face.font}
          textStyle={MOMENT_FONT_FACE[font].regular}
          onPress={() => onSelect({ font })}
        />
      ))}
    </MenuSurface>
  );
}
