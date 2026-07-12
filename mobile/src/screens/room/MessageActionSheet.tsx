import { useTranslation } from 'react-i18next';
import { Image, Modal, Platform, Pressable, Text, useWindowDimensions, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { ImageSourcePropType, ViewStyle } from 'react-native';
import type { ReactionType } from '@ola/shared/types';
import { useKeyboardHeight } from '../../hooks/useKeyboardHeight';
import { REACTION_IMAGE, REACTION_ORDER } from '../../lib/reactions';

export interface MessageSheetAction {
  key: string;
  label: string;
  icon?: ImageSourcePropType;
  destructive?: boolean;
  onSelect: () => void;
}

export interface AnchorRect {
  x: number;
  y: number;
  width: number;
  height: number;
}

interface MessageActionSheetProps {
  visible: boolean;
  actions: MessageSheetAction[];
  showReactions?: boolean;
  anchor?: AnchorRect | null;
  onReact: (type: ReactionType) => void;
  onClose: () => void;
}

const CARD_SHADOW = {
  shadowColor: '#000',
  shadowOpacity: 0.18,
  shadowRadius: 12,
  shadowOffset: { width: 0, height: 8 },
  elevation: 8,
} as const;

const REACTION_SIZE = 40;
const BAR_PADDING_H = 6;
const BAR_PADDING_V = 6;
const BAR_HEIGHT = REACTION_SIZE + BAR_PADDING_V * 2;
const BAR_WIDTH = REACTION_ORDER.length * REACTION_SIZE + BAR_PADDING_H * 2;
const MENU_ITEM_HEIGHT = 44;
const MENU_PADDING_V = 6;
const MENU_MIN_WIDTH = 168;
const POPUP_GAP = 8;
const POPUP_MARGIN = 12;

function ReactionRow({
  onReact,
  onClose,
}: Pick<MessageActionSheetProps, 'onReact' | 'onClose'>) {
  return (
    <View
      className="flex-row items-center rounded-full bg-white"
      style={[{ paddingHorizontal: BAR_PADDING_H, paddingVertical: BAR_PADDING_V }, CARD_SHADOW]}
    >
      {REACTION_ORDER.map((type) => (
        <Pressable
          key={type}
          onPress={() => {
            onReact(type);
            onClose();
          }}
          style={{ width: REACTION_SIZE, height: REACTION_SIZE }}
          className="items-center justify-center rounded-full active:bg-neutral-100"
        >
          {REACTION_IMAGE[type] != null && (
            <Image
              source={REACTION_IMAGE[type]!}
              style={{ width: 28, height: 28 }}
              resizeMode="contain"
            />
          )}
        </Pressable>
      ))}
    </View>
  );
}

function clamp(value: number, min: number, max: number): number {
  if (max < min) return min;
  return Math.min(Math.max(value, min), max);
}

function popupHeight(actionCount: number, showReactions: boolean): number {
  const menu = actionCount > 0 ? MENU_PADDING_V * 2 + actionCount * MENU_ITEM_HEIGHT : 0;
  if (!showReactions) return menu;
  if (menu === 0) return BAR_HEIGHT;
  return BAR_HEIGHT + POPUP_GAP + menu;
}

function AnchoredPopup({
  actions,
  showReactions = true,
  anchor,
  onReact,
  onClose,
}: MessageActionSheetProps & { anchor: AnchorRect }) {
  const { width: winW, height: winH } = useWindowDimensions();
  const insets = useSafeAreaInsets();
  const kbHeight = useKeyboardHeight();
  const refWidth = Math.min(BAR_WIDTH, winW - POPUP_MARGIN * 2);
  const height = popupHeight(actions.length, showReactions);
  const alignRight = anchor.x + anchor.width / 2 > winW / 2;

  const kbAdjust = Platform.OS === 'ios' ? kbHeight : 0;
  const usableBottom = winH - kbAdjust;
  const bottomInset = kbAdjust > 0 ? POPUP_MARGIN : Math.max(POPUP_MARGIN, insets.bottom);

  const spaceBelow = usableBottom - (anchor.y + anchor.height) - POPUP_MARGIN;
  const placeBelow = spaceBelow >= height + POPUP_GAP || spaceBelow >= anchor.y - POPUP_MARGIN;
  const rawTop = placeBelow ? anchor.y + anchor.height + POPUP_GAP : anchor.y - POPUP_GAP - height;
  const minTop = Math.max(POPUP_MARGIN, insets.top);
  const top = clamp(rawTop, minTop, usableBottom - bottomInset - height);

  const left = alignRight
    ? winW -
      clamp(winW - (anchor.x + anchor.width), POPUP_MARGIN, winW - POPUP_MARGIN - refWidth) -
      refWidth
    : clamp(anchor.x, POPUP_MARGIN, winW - POPUP_MARGIN - refWidth);

  const containerStyle: ViewStyle = {
    position: 'absolute',
    top,
    left,
    width: refWidth,
    alignItems: alignRight ? 'flex-end' : 'flex-start',
  };

  return (
    <Pressable className="flex-1" style={{ backgroundColor: 'rgba(0,0,0,0.15)' }} onPress={onClose}>
      <View style={containerStyle}>
        {showReactions && <ReactionRow onReact={onReact} onClose={onClose} />}
        {actions.length > 0 && (
          <View
            className="overflow-hidden rounded-xl bg-white"
            style={[
              { minWidth: MENU_MIN_WIDTH, marginTop: showReactions ? POPUP_GAP : 0 },
              CARD_SHADOW,
            ]}
          >
            {actions.map((action) => (
              <Pressable
                key={action.key}
                onPress={() => {
                  action.onSelect();
                  onClose();
                }}
                style={{ height: MENU_ITEM_HEIGHT }}
                className="flex-row items-center gap-2.5 px-4 active:bg-neutral-100"
              >
                {action.icon != null && (
                  <Image source={action.icon} style={{ width: 20, height: 20 }} resizeMode="contain" />
                )}
                <Text
                  className="text-base"
                  style={{ color: action.destructive ? '#e34545' : 'rgba(0,0,0,0.87)' }}
                >
                  {action.label}
                </Text>
              </Pressable>
            ))}
          </View>
        )}
      </View>
    </Pressable>
  );
}

function BottomSheet({
  actions,
  showReactions = true,
  onReact,
  onClose,
}: MessageActionSheetProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();

  return (
    <Pressable className="flex-1 justify-end bg-black/40" onPress={onClose}>
      <Pressable
        className="rounded-t-2xl bg-white"
        style={{ paddingBottom: Math.max(insets.bottom, 8) }}
        onPress={() => undefined}
      >
        {showReactions && (
          <View className="flex-row items-center justify-around px-2 py-3">
            <ReactionRow onReact={onReact} onClose={onClose} />
          </View>
        )}

        <View
          style={
            showReactions ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' } : undefined
          }
        >
          {actions.map((action) => (
            <Pressable
              key={action.key}
              onPress={() => {
                action.onSelect();
                onClose();
              }}
              className="flex-row items-center gap-3 px-5 py-3 active:bg-neutral-100"
            >
              {action.icon != null && (
                <Image source={action.icon} style={{ width: 20, height: 20 }} resizeMode="contain" />
              )}
              <Text
                className="text-base"
                style={{ color: action.destructive ? '#e34545' : 'rgba(0,0,0,0.87)' }}
              >
                {action.label}
              </Text>
            </Pressable>
          ))}
          <Pressable
            onPress={onClose}
            className="items-center justify-center px-5 py-3 active:bg-neutral-100"
          >
            <Text className="text-base font-medium" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {t('dialog.cancel')}
            </Text>
          </Pressable>
        </View>
      </Pressable>
    </Pressable>
  );
}

export function MessageActionSheet({ anchor, ...props }: MessageActionSheetProps) {
  return (
    <Modal
      visible={props.visible}
      transparent
      statusBarTranslucent
      animationType={anchor != null ? 'fade' : 'slide'}
      onRequestClose={props.onClose}
    >
      {anchor != null ? (
        <AnchoredPopup {...props} anchor={anchor} />
      ) : (
        <BottomSheet {...props} />
      )}
    </Modal>
  );
}
