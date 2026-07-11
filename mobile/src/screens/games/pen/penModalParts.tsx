import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Image,
  KeyboardAvoidingView,
  Platform,
  Pressable,
  Text,
  View,
  type DimensionValue,
  type ImageSourcePropType,
} from 'react-native';
import { formatVnd } from '@ola/shared/lib';
import type { PenSide } from '@ola/shared/types';
import { penAssets } from './penAssets';
import { assetRatio, PenBg, PenPanel, penTextShadow, sizeByHeight, PEN_COLORS } from './penUi';

const DIRECTIONS: PenSide[] = ['left', 'right'];

interface PenModalShellProps {
  panelAspect: number;
  titleIcon: ImageSourcePropType;
  titleIconHeight?: number;
  title: string;
  closeBtn: ImageSourcePropType;
  closeIcon: ImageSourcePropType;
  onClose: () => void;
  children: ReactNode;
}

export function PenModalShell({
  panelAspect,
  titleIcon,
  titleIconHeight = 36,
  title,
  closeBtn,
  closeIcon,
  onClose,
  children,
}: PenModalShellProps) {
  const { t } = useTranslation();
  return (
    <Pressable
      onPress={onClose}
      style={{
        position: 'absolute',
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        zIndex: 40,
        backgroundColor: 'rgba(0,0,0,0.55)',
        paddingHorizontal: 16,
      }}
    >
      <KeyboardAvoidingView
        behavior={Platform.OS === 'ios' ? 'padding' : undefined}
        style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}
      >
        <Pressable
          onPress={() => {}}
          style={{ width: '100%', maxWidth: 380, aspectRatio: panelAspect }}
        >
          <PenPanel style={{ flex: 1 }}>
            <View
              style={{
                flex: 1,
                alignItems: 'center',
                paddingHorizontal: '8%',
                paddingTop: '4%',
                paddingBottom: '4%',
              }}
            >
              <View style={{ flexDirection: 'row', alignItems: 'center', gap: 8 }}>
                <Image
                  source={titleIcon}
                  style={sizeByHeight(titleIcon, titleIconHeight)}
                  resizeMode="contain"
                />
                <Text
                  style={[
                    {
                      color: '#ffffff',
                      fontSize: 30,
                      fontWeight: '800',
                      fontStyle: 'italic',
                      letterSpacing: 1,
                    },
                    penTextShadow,
                  ]}
                >
                  {title}
                </Text>
              </View>

              <Pressable
                accessibilityLabel={t('penGame.close')}
                onPress={onClose}
                style={({ pressed }) => ({
                  position: 'absolute',
                  right: '5%',
                  top: '3%',
                  width: 36,
                  height: 36,
                  alignItems: 'center',
                  justifyContent: 'center',
                  transform: [{ scale: pressed ? 0.95 : 1 }],
                })}
              >
                <PenBg source={closeBtn} />
                <Image source={closeIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
              </Pressable>

              {children}
            </View>
          </PenPanel>
        </Pressable>
      </KeyboardAvoidingView>
    </Pressable>
  );
}

interface PenKenRowProps {
  ken: number;
  onTopUp: () => void;
}

export function PenKenRow({ ken, onTopUp }: PenKenRowProps) {
  const { t } = useTranslation();
  return (
    <View
      style={{
        marginTop: '3%',
        flexDirection: 'row',
        alignItems: 'center',
        gap: 8,
        borderRadius: 12,
        backgroundColor: 'rgba(0,0,0,0.3)',
        paddingHorizontal: 12,
        paddingVertical: 6,
      }}
    >
      <Image source={penAssets.kenIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
      <Text
        style={{
          minWidth: 68,
          textAlign: 'center',
          fontSize: 20,
          fontWeight: '700',
          color: '#ffffff',
        }}
      >
        {formatVnd(ken)}
      </Text>
      <Pressable
        accessibilityLabel={t('penGame.topUp')}
        onPress={onTopUp}
        style={({ pressed }) => ({
          width: 32,
          height: 32,
          alignItems: 'center',
          justifyContent: 'center',
          transform: [{ scale: pressed ? 0.95 : 1 }],
        })}
      >
        <PenBg source={penAssets.plusBtn} />
        <Image source={penAssets.plusIcon} style={{ width: 14, height: 14 }} resizeMode="contain" />
      </Pressable>
    </View>
  );
}

export interface PenDirSkin {
  bg: ImageSourcePropType;
  tab: ImageSourcePropType;
  arrowLeft: ImageSourcePropType;
  arrowRight: ImageSourcePropType;
  mark?: ImageSourcePropType;
}

export interface PenDirLayout {
  buttonAspect: number;
  arrowTop: DimensionValue;
  arrowWidth: DimensionValue;
  arrowInset: DimensionValue;
  centerTop: DimensionValue;
  centerWidth: DimensionValue;
  centerInset: DimensionValue;
  markBottom: DimensionValue;
  markWidth: DimensionValue;
  tabAspect: number;
  tabWidth: DimensionValue;
}

function OverlayImage({
  source,
  top,
  bottom,
  left,
  right,
  width,
  centered = false,
}: {
  source: ImageSourcePropType;
  top?: DimensionValue;
  bottom?: DimensionValue;
  left?: DimensionValue;
  right?: DimensionValue;
  width: DimensionValue;
  centered?: boolean;
}) {
  return (
    <View
      pointerEvents="none"
      style={{
        position: 'absolute',
        top,
        bottom,
        left: centered ? 0 : left,
        right: centered ? 0 : right,
        width: centered ? undefined : width,
        height: 0,
        justifyContent: 'center',
        alignItems: centered ? 'center' : 'stretch',
      }}
    >
      <View style={{ width: centered ? width : '100%', aspectRatio: assetRatio(source) }}>
        <Image source={source} style={{ width: '100%', height: '100%' }} resizeMode="contain" />
      </View>
    </View>
  );
}

interface PenDirectionPickerProps {
  value: PenSide | null;
  onSelect: (side: PenSide) => void;
  selected: PenDirSkin;
  unselected: PenDirSkin;
  center: { left: ImageSourcePropType; right: ImageSourcePropType };
  layout: PenDirLayout;
}

export function PenDirectionPicker({
  value,
  onSelect,
  selected,
  unselected,
  center,
  layout,
}: PenDirectionPickerProps) {
  const { t } = useTranslation();
  return (
    <View style={{ marginTop: '3%', width: '110%', flexDirection: 'row', gap: 8 }}>
      {DIRECTIONS.map((dir) => {
        const active = value === dir;
        const skin = active ? selected : unselected;
        const left = dir === 'left';
        const label = left ? t('penGame.directionLeft') : t('penGame.directionRight');
        return (
          <Pressable
            key={dir}
            accessibilityState={{ selected: active }}
            onPress={() => onSelect(dir)}
            style={({ pressed }) => ({
              flex: 1,
              aspectRatio: layout.buttonAspect,
              transform: [{ scale: pressed ? 0.95 : 1 }],
            })}
          >
            <PenBg source={skin.bg} />
            <OverlayImage
              source={left ? skin.arrowLeft : skin.arrowRight}
              top={layout.arrowTop}
              left={left ? layout.arrowInset : undefined}
              right={left ? undefined : layout.arrowInset}
              width={layout.arrowWidth}
            />
            <OverlayImage
              source={left ? center.left : center.right}
              top={layout.centerTop}
              left={left ? undefined : layout.centerInset}
              right={left ? layout.centerInset : undefined}
              width={layout.centerWidth}
            />
            {skin.mark != null && (
              <OverlayImage
                source={skin.mark}
                bottom={layout.markBottom}
                width={layout.markWidth}
                centered
              />
            )}
            <View
              pointerEvents="none"
              style={{ position: 'absolute', top: 0, left: 0, right: 0, alignItems: 'center' }}
            >
              <View
                style={{
                  width: layout.tabWidth,
                  aspectRatio: layout.tabAspect,
                  alignItems: 'center',
                  justifyContent: 'center',
                }}
              >
                <PenBg source={skin.tab} />
                <Text
                  style={[
                    { color: '#ffffff', fontSize: 14, fontWeight: '800', letterSpacing: 1 },
                    penTextShadow,
                  ]}
                >
                  {label}
                </Text>
              </View>
            </View>
          </Pressable>
        );
      })}
    </View>
  );
}

interface PenModalActionsProps {
  style?: { marginTop?: number | 'auto' | `${number}%`; paddingTop?: number | `${number}%` };
  cancelBg: ImageSourcePropType;
  confirmBg: ImageSourcePropType;
  onCancel: () => void;
  onConfirm: () => void;
  confirmDisabled?: boolean;
}

export function PenModalActions({
  style,
  cancelBg,
  confirmBg,
  onCancel,
  onConfirm,
  confirmDisabled = false,
}: PenModalActionsProps) {
  const { t } = useTranslation();
  return (
    <View style={[{ flexDirection: 'row', alignItems: 'center', gap: 12, width: '100%' }, style]}>
      <Pressable
        onPress={onCancel}
        style={({ pressed }) => ({
          flex: 2,
          height: 48,
          alignItems: 'center',
          justifyContent: 'center',
          transform: [{ scale: pressed ? 0.95 : 1 }],
        })}
      >
        <PenBg source={cancelBg} />
        <Text
          style={[
            { color: PEN_COLORS.red, fontSize: 18, fontWeight: '800', letterSpacing: 0.5 },
            penTextShadow,
          ]}
        >
          {t('penGame.cancel')}
        </Text>
      </Pressable>
      <Pressable
        onPress={onConfirm}
        disabled={confirmDisabled}
        style={({ pressed }) => ({
          flex: 3,
          height: 48,
          alignItems: 'center',
          justifyContent: 'center',
          opacity: confirmDisabled ? 0.6 : 1,
          transform: [{ scale: pressed ? 0.95 : 1 }],
        })}
      >
        <PenBg source={confirmBg} />
        <Text
          style={[
            { color: '#ffffff', fontSize: 18, fontWeight: '800', letterSpacing: 0.5 },
            penTextShadow,
          ]}
        >
          {t('penGame.confirm')}
        </Text>
      </Pressable>
    </View>
  );
}
