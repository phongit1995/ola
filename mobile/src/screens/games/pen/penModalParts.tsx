import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Image,
  Pressable,
  Text,
  View,
  useWindowDimensions,
  type ImageSourcePropType,
} from 'react-native';
import { KeyboardView } from '../../../components/KeyboardView';
import { formatVnd } from '@ola/shared/lib';
import type { PenSide } from '@ola/shared/types';
import { penAssets } from './penAssets';
import { assetRatio, PenBg, PenPanel, penTextShadow, sizeByHeight, PEN_COLORS } from './penUi';

const DIRECTIONS: PenSide[] = ['left', 'right'];

export function penPanelWidth(windowWidth: number): number {
  return Math.min(380, windowWidth - 32);
}

export function penPickerWidth(windowWidth: number): number {
  return penPanelWidth(windowWidth) * 0.84 * 1.1;
}

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
  const { width: windowWidth } = useWindowDimensions();
  const panelW = penPanelWidth(windowWidth);
  const panelH = panelW / panelAspect;

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
      }}
    >
      <KeyboardView
        style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}
      >
        <Pressable onPress={() => {}} style={{ width: panelW, height: panelH }}>
          <PenPanel style={{ flex: 1 }}>
            <View
              style={{
                flex: 1,
                alignItems: 'center',
                paddingHorizontal: panelW * 0.08,
                paddingTop: panelW * 0.04,
                paddingBottom: panelW * 0.04,
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
                style={{
                  position: 'absolute',
                  right: panelW * 0.05,
                  top: panelH * 0.03,
                  width: 36,
                  height: 36,
                  alignItems: 'center',
                  justifyContent: 'center',
                }}
              >
                <PenBg source={closeBtn} />
                <Image source={closeIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
              </Pressable>

              {children}
            </View>
          </PenPanel>
        </Pressable>
      </KeyboardView>
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
        style={{
          width: 32,
          height: 32,
          alignItems: 'center',
          justifyContent: 'center',
        }}
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
  arrowTop: number;
  arrowWidth: number;
  arrowInset: number;
  centerTop: number;
  centerWidth: number;
  centerInset: number;
  markBottom: number;
  markWidth: number;
  tabAspect: number;
  tabWidth: number;
}

function fitByWidth(source: ImageSourcePropType, width: number): { width: number; height: number } {
  const ratio = assetRatio(source);
  return { width, height: ratio > 0 ? width / ratio : width };
}

interface PenDirectionPickerProps {
  value: PenSide | null;
  onSelect: (side: PenSide) => void;
  selected: PenDirSkin;
  unselected: PenDirSkin;
  center: { left: ImageSourcePropType; right: ImageSourcePropType };
  layout: PenDirLayout;
  width: number;
}

export function PenDirectionPicker({
  value,
  onSelect,
  selected,
  unselected,
  center,
  layout,
  width,
}: PenDirectionPickerProps) {
  const { t } = useTranslation();
  const btnW = (width - 8) / 2;
  const btnH = btnW / layout.buttonAspect;
  const tabW = btnW * layout.tabWidth;
  const tabH = tabW / layout.tabAspect;

  return (
    <View
      style={{
        marginTop: '3%',
        width,
        alignSelf: 'center',
        flexDirection: 'row',
        gap: 8,
      }}
    >
      {DIRECTIONS.map((dir) => {
        const active = value === dir;
        const skin = active ? selected : unselected;
        const left = dir === 'left';
        const label = left ? t('penGame.directionLeft') : t('penGame.directionRight');
        const arrow = fitByWidth(left ? skin.arrowLeft : skin.arrowRight, btnW * layout.arrowWidth);
        const centerImg = fitByWidth(left ? center.left : center.right, btnW * layout.centerWidth);
        const mark = skin.mark != null ? fitByWidth(skin.mark, btnW * layout.markWidth) : null;
        const inset = btnW * layout.arrowInset;
        const centerInset = btnW * layout.centerInset;
        return (
          <View key={dir} style={{ width: btnW, height: btnH }}>
            <Pressable
              accessibilityState={{ selected: active }}
              onPress={() => onSelect(dir)}
              style={{
                flex: 1,
              }}
            >
              <PenBg source={skin.bg} />
              <Image
                source={left ? skin.arrowLeft : skin.arrowRight}
                resizeMode="contain"
                style={{
                  position: 'absolute',
                  top: btnH * layout.arrowTop - arrow.height / 2,
                  ...(left ? { left: inset } : { right: inset }),
                  width: arrow.width,
                  height: arrow.height,
                }}
              />
              <Image
                source={left ? center.left : center.right}
                resizeMode="contain"
                style={{
                  position: 'absolute',
                  top: btnH * layout.centerTop - centerImg.height / 2,
                  ...(left ? { right: centerInset } : { left: centerInset }),
                  width: centerImg.width,
                  height: centerImg.height,
                }}
              />
              {mark != null && skin.mark != null && (
                <Image
                  source={skin.mark}
                  resizeMode="contain"
                  style={{
                    position: 'absolute',
                    bottom: btnH * layout.markBottom - mark.height / 2,
                    left: (btnW - mark.width) / 2,
                    width: mark.width,
                    height: mark.height,
                  }}
                />
              )}
              <View
                pointerEvents="none"
                style={{
                  position: 'absolute',
                  top: 0,
                  left: (btnW - tabW) / 2,
                  width: tabW,
                  height: tabH,
                  alignItems: 'center',
                  justifyContent: 'center',
                }}
              >
                <PenBg source={skin.tab} />
                <Text
                  numberOfLines={1}
                  style={[
                    { color: '#ffffff', fontSize: 14, fontWeight: '800', letterSpacing: 1 },
                    penTextShadow,
                  ]}
                >
                  {label}
                </Text>
              </View>
            </Pressable>
          </View>
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
        style={{
          flex: 2,
          height: 48,
          alignItems: 'center',
          justifyContent: 'center',
        }}
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
        style={{
          flex: 3,
          height: 48,
          alignItems: 'center',
          justifyContent: 'center',
          opacity: confirmDisabled ? 0.6 : 1,
        }}
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
