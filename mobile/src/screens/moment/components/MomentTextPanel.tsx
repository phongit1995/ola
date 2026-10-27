import { useEffect, useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Platform,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  View,
  type ScrollViewInstance,
  type TextInputInstance,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import {
  MOMENT_FONT_CAPS,
  MOMENT_MAX_OVERLAY_CHARS,
  MOMENT_OVERLAY_STYLE,
  MOMENT_TEXT_ALIGN,
} from '@ola/shared/constants';
import { nextMomentOption, resolveMomentTextFace } from '@ola/shared/lib';
import type { MomentOverlay } from '@ola/shared/types';
import { KeyboardView } from '@components/KeyboardView';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { overlayBubbleStyle, overlayTextStyle } from '../utils';
import { MomentAlignIcon, MomentTextStyleIcon, MomentTrashIcon } from './MomentIcons';
import { MomentTextMenuOptions, MomentTextQuickBar, type MomentTextMenu } from './MomentTextTools';

const OVERLAY_STYLES = Object.values(MOMENT_OVERLAY_STYLE);
const TEXT_ALIGNS = Object.values(MOMENT_TEXT_ALIGN);
const COLOR_BUTTON = 32;
const ITALIC_ICON_FAMILY = Platform.select({ ios: 'Georgia', default: 'serif' });

function ToolButton({
  label,
  active = false,
  disabled = false,
  onPress,
  children,
}: {
  label: string;
  active?: boolean;
  disabled?: boolean;
  onPress: () => void;
  children: ReactNode;
}) {
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={label}
      accessibilityState={{ selected: active, disabled }}
      disabled={disabled}
      onPress={onPress}
      className="h-9 min-w-9 items-center justify-center rounded-full px-2.5"
      style={{ backgroundColor: active ? '#ffffff' : 'rgba(0,0,0,0.4)', opacity: disabled ? 0.35 : 1 }}
    >
      {children}
    </Pressable>
  );
}

interface MomentTextPanelProps {
  overlay: MomentOverlay;
  canvasWidth: number;
  onChange: (patch: Partial<MomentOverlay>) => void;
  onDone: () => void;
  onDelete: () => void;
}

export function MomentTextPanel({ overlay, canvasWidth, onChange, onDone, onDelete }: MomentTextPanelProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const bottomInset = useBottomBarInset();
  const face = resolveMomentTextFace(overlay);
  const caps = MOMENT_FONT_CAPS[face.font];
  const inputRef = useRef<TextInputInstance>(null);
  const scrollRef = useRef<ScrollViewInstance>(null);
  const [menu, setMenu] = useState<MomentTextMenu | null>(null);
  const [deleteOpen, setDeleteOpen] = useState(false);
  const [deletePending, setDeletePending] = useState(false);

  useEffect(() => {
    const frame = requestAnimationFrame(() => inputRef.current?.focus());
    return () => cancelAnimationFrame(frame);
  }, []);

  useEffect(() => {
    if (menu == null) return;
    const frame = requestAnimationFrame(() => scrollRef.current?.scrollToEnd({ animated: true }));
    return () => cancelAnimationFrame(frame);
  }, [menu]);

  function toggleMenu(next: MomentTextMenu) {
    setMenu((current) => (current === next ? null : next));
  }

  function confirmDelete() {
    setDeleteOpen(false);
    setDeletePending(true);
    if (Platform.OS !== 'ios') requestAnimationFrame(onDelete);
  }

  return (
    <View style={[StyleSheet.absoluteFill, { backgroundColor: 'rgba(0,0,0,0.55)' }]}>
      <KeyboardView className="flex-1" style={{ paddingTop: insets.top, paddingBottom: bottomInset }}>
        <View className="flex-row justify-end p-3">
          <Pressable
            accessibilityRole="button"
            onPress={onDone}
            className="rounded-full px-4 py-1.5"
            style={{ backgroundColor: '#ffffff' }}
          >
            <Text className="text-sm font-semibold" style={{ color: '#000000' }}>
              {t('moment.done')}
            </Text>
          </Pressable>
        </View>

        <ScrollView
          ref={scrollRef}
          style={{ flex: 1 }}
          contentContainerStyle={{ flexGrow: 1 }}
          keyboardShouldPersistTaps="handled"
          showsVerticalScrollIndicator={false}
        >
          <Pressable className="flex-1 items-center justify-center px-3 pb-3" onPress={onDone}>
            <View style={[overlayBubbleStyle(overlay, canvasWidth), { width: overlay.w * canvasWidth }]}>
              <TextInput
                ref={inputRef}
                value={overlay.text}
                multiline
                scrollEnabled={false}
                maxLength={MOMENT_MAX_OVERLAY_CHARS}
                placeholder={t('moment.textPlaceholder')}
                placeholderTextColor="rgba(255,255,255,0.6)"
                onChangeText={(text) => onChange({ text })}
                style={[overlayTextStyle(overlay, canvasWidth), { padding: 0, margin: 0 }]}
              />
            </View>

            <View
              className="mt-1.5 items-center gap-2"
              style={{ maxWidth: '100%' }}
              onStartShouldSetResponder={() => true}
            >
              <View className="flex-row items-center gap-1.5">
                <ToolButton
                  label={t('moment.bold')}
                  active={face.bold}
                  disabled={!caps.bold}
                  onPress={() => onChange({ font: face.font, bold: !face.bold })}
                >
                  <Text style={{ color: face.bold ? '#000000' : '#ffffff', fontSize: 16, fontWeight: '800' }}>B</Text>
                </ToolButton>
                <ToolButton
                  label={t('moment.italic')}
                  active={face.italic}
                  disabled={!caps.italic}
                  onPress={() => onChange({ font: face.font, italic: !face.italic })}
                >
                  <Text
                    style={{
                      color: face.italic ? '#000000' : '#ffffff',
                      fontSize: 16,
                      fontStyle: 'italic',
                      fontFamily: ITALIC_ICON_FAMILY,
                    }}
                  >
                    I
                  </Text>
                </ToolButton>
                <ToolButton
                  label={t('moment.textStyle')}
                  onPress={() => onChange({ style: nextMomentOption(OVERLAY_STYLES, overlay.style) })}
                >
                  <MomentTextStyleIcon />
                </ToolButton>
                <ToolButton
                  label={t('moment.align')}
                  onPress={() => onChange({ align: nextMomentOption(TEXT_ALIGNS, overlay.align) })}
                >
                  <MomentAlignIcon align={overlay.align} />
                </ToolButton>
                <Pressable
                  accessibilityRole="button"
                  accessibilityLabel={t('moment.textColor')}
                  accessibilityState={{ expanded: menu === 'color' }}
                  onPress={() => toggleMenu('color')}
                  style={{
                    width: COLOR_BUTTON,
                    height: COLOR_BUTTON,
                    borderRadius: COLOR_BUTTON / 2,
                    backgroundColor: overlay.color,
                    borderWidth: 2,
                    borderColor: menu === 'color' ? '#ffffff' : 'rgba(255,255,255,0.8)',
                    transform: [{ scale: menu === 'color' ? 1.1 : 1 }],
                  }}
                />
              </View>

              <View className="flex-row items-center gap-1.5">
                <MomentTextQuickBar overlay={overlay} menu={menu} onToggleMenu={toggleMenu} />
                <ToolButton label={t('moment.deleteText')} onPress={() => setDeleteOpen(true)}>
                  <MomentTrashIcon size={20} />
                </ToolButton>
              </View>

              {menu != null && (
                <MomentTextMenuOptions
                  menu={menu}
                  overlay={overlay}
                  onSelect={(patch) => {
                    onChange(patch);
                    setMenu(null);
                  }}
                />
              )}
            </View>
          </Pressable>
        </ScrollView>
      </KeyboardView>

      <ConfirmDialog
        visible={deleteOpen}
        danger
        title={t('moment.deleteTextTitle')}
        message={t('moment.deleteTextMessage')}
        confirmLabel={t('common.delete')}
        cancelLabel={t('common.cancel')}
        onConfirm={confirmDelete}
        onCancel={() => setDeleteOpen(false)}
        onDismiss={() => {
          if (deletePending) onDelete();
        }}
      />
    </View>
  );
}
