import { useCallback, useEffect, useRef, type ReactNode } from 'react';
import { OlaModal } from '@components/ui/OlaModal';
import { useTranslation } from 'react-i18next';
import {
  Animated,
  Image,

  Platform,
  Pressable,
  StatusBar,
  StyleSheet,
  Text,
  useWindowDimensions,
  View,
} from 'react-native';
import { BlurView } from '@react-native-community/blur';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { ImageSourcePropType, ViewStyle } from 'react-native';
import type { ReactionType } from '@ola/shared/types';
import { useKeyboardHeight } from '@hooks/useKeyboardHeight';
import { hapticImpact } from '@lib/haptics';
import { REACTION_IMAGE, REACTION_ORDER } from '@lib/reactions';

export interface MessageSheetAction {
  key: string;
  label: string;
  icon?: ImageSourcePropType;
  iconTint?: string;
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
  preview?: ReactNode;
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

function ActionMenu({
  actions,
  onClose,
  style,
}: {
  actions: MessageSheetAction[];
  onClose: () => void;
  style?: ViewStyle;
}) {
  return (
    <View
      className="overflow-hidden rounded-xl bg-white"
      style={[{ minWidth: MENU_MIN_WIDTH }, CARD_SHADOW, style]}
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
            <Image
              source={action.icon}
              style={{ width: 20, height: 20, tintColor: action.iconTint }}
              resizeMode="contain"
            />
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
  );
}

function clamp(value: number, min: number, max: number): number {
  if (max < min) return min;
  return Math.min(Math.max(value, min), max);
}

const ANCHOR_TOP_OFFSET =
  Platform.OS === 'android' ? StatusBar.currentHeight ?? 0 : 0;

function popupHeight(actionCount: number, showReactions: boolean): number {
  const menu = actionCount > 0 ? MENU_PADDING_V * 2 + actionCount * MENU_ITEM_HEIGHT : 0;
  if (!showReactions) return menu;
  if (menu === 0) return BAR_HEIGHT;
  return BAR_HEIGHT + POPUP_GAP + menu;
}

function useSheetTransition(onClose: () => void): {
  progress: Animated.Value;
  requestClose: () => void;
} {
  const progress = useRef(new Animated.Value(0)).current;
  const closingRef = useRef(false);
  const onCloseRef = useRef(onClose);
  onCloseRef.current = onClose;
  useEffect(() => {
    Animated.spring(progress, {
      toValue: 1,
      tension: 220,
      friction: 16,
      useNativeDriver: true,
    }).start();
  }, [progress]);
  const requestClose = useCallback(() => {
    if (closingRef.current) return;
    closingRef.current = true;
    Animated.timing(progress, {
      toValue: 0,
      duration: 140,
      useNativeDriver: true,
    }).start(() => onCloseRef.current());
  }, [progress]);
  return { progress, requestClose };
}

function popStyle(progress: Animated.Value) {
  return {
    opacity: progress,
    transform: [
      {
        scale: progress.interpolate({ inputRange: [0, 1], outputRange: [0.75, 1] }),
      },
    ],
  };
}

function MessengerPopup({
  actions,
  showReactions = true,
  anchor,
  preview,
  onReact,
  onClose,
}: MessageActionSheetProps & { anchor: AnchorRect; preview: ReactNode }) {
  const { width: winW, height: winH } = useWindowDimensions();
  const insets = useSafeAreaInsets();
  const kbHeight = useKeyboardHeight();
  const { progress, requestClose } = useSheetTransition(onClose);

  const menuH = actions.length > 0 ? MENU_PADDING_V * 2 + actions.length * MENU_ITEM_HEIGHT : 0;
  const barH = showReactions ? BAR_HEIGHT : 0;
  const topNeed = barH > 0 ? barH + POPUP_GAP : 0;
  const bottomNeed = menuH > 0 ? menuH + POPUP_GAP : 0;

  const kbAdjust = Platform.OS === 'ios' ? kbHeight : 0;
  const usableBottom = winH - kbAdjust;
  const bottomInset = kbAdjust > 0 ? POPUP_MARGIN : Math.max(POPUP_MARGIN, insets.bottom);

  const anchorY = anchor.y + ANCHOR_TOP_OFFSET;
  const minBubbleTop = Math.max(POPUP_MARGIN, insets.top) + topNeed;
  const maxBubbleTop = usableBottom - bottomInset - anchor.height - bottomNeed;
  const bubbleTop = clamp(anchorY, minBubbleTop, maxBubbleTop);

  const alignRight = anchor.x + anchor.width / 2 > winW / 2;
  const barWidth = Math.min(BAR_WIDTH, winW - POPUP_MARGIN * 2);
  const anchorRight = winW - (anchor.x + anchor.width);
  const sideRight = clamp(anchorRight, POPUP_MARGIN, winW - POPUP_MARGIN - barWidth);
  const sideLeft = clamp(anchor.x, POPUP_MARGIN, winW - POPUP_MARGIN - barWidth);

  const barPos: ViewStyle = alignRight ? { right: sideRight } : { left: sideLeft };
  const menuPos: ViewStyle = alignRight
    ? { right: clamp(anchorRight, POPUP_MARGIN, winW - POPUP_MARGIN - MENU_MIN_WIDTH) }
    : { left: clamp(anchor.x, POPUP_MARGIN, winW - POPUP_MARGIN - MENU_MIN_WIDTH) };

  return (
    <Pressable className="flex-1" onPress={requestClose}>
      <Animated.View
        pointerEvents="none"
        style={[StyleSheet.absoluteFill, { opacity: progress }]}
      >
        {Platform.OS === 'ios' ? (
          <>
            <BlurView
              style={StyleSheet.absoluteFill}
              blurType="regular"
              blurAmount={25}
              reducedTransparencyFallbackColor="rgba(235,235,235,0.6)"
            />
          </>
        ) : (
          <View style={[StyleSheet.absoluteFill, { backgroundColor: 'rgba(255,255,255,0.45)' }]} />
        )}
      </Animated.View>
      <Animated.View
        pointerEvents="box-none"
        style={{
          position: 'absolute',
          top: bubbleTop,
          left: anchor.x,
          width: anchor.width,
          opacity: progress,
        }}
      >
        {preview}
      </Animated.View>
      {showReactions && (
        <Animated.View
          style={[
            { position: 'absolute', top: bubbleTop - POPUP_GAP - BAR_HEIGHT, ...barPos },
            popStyle(progress),
          ]}
        >
          <ReactionRow onReact={onReact} onClose={requestClose} />
        </Animated.View>
      )}
      {actions.length > 0 && (
        <Animated.View
          style={[
            { position: 'absolute', top: bubbleTop + anchor.height + POPUP_GAP, ...menuPos },
            popStyle(progress),
          ]}
        >
          <ActionMenu actions={actions} onClose={requestClose} />
        </Animated.View>
      )}
    </Pressable>
  );
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
  const { progress, requestClose } = useSheetTransition(onClose);
  const refWidth = Math.min(BAR_WIDTH, winW - POPUP_MARGIN * 2);
  const height = popupHeight(actions.length, showReactions);
  const alignRight = anchor.x + anchor.width / 2 > winW / 2;

  const kbAdjust = Platform.OS === 'ios' ? kbHeight : 0;
  const usableBottom = winH - kbAdjust;
  const bottomInset = kbAdjust > 0 ? POPUP_MARGIN : Math.max(POPUP_MARGIN, insets.bottom);

  const anchorY = anchor.y + ANCHOR_TOP_OFFSET;
  const spaceBelow = usableBottom - (anchorY + anchor.height) - POPUP_MARGIN;
  const placeBelow = spaceBelow >= height + POPUP_GAP || spaceBelow >= anchorY - POPUP_MARGIN;
  const rawTop = placeBelow ? anchorY + anchor.height + POPUP_GAP : anchorY - POPUP_GAP - height;
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
    <Pressable className="flex-1" onPress={requestClose}>
      <Animated.View
        pointerEvents="none"
        style={[StyleSheet.absoluteFill, { backgroundColor: 'rgba(0,0,0,0.15)', opacity: progress }]}
      />
      <Animated.View style={[containerStyle, popStyle(progress)]}>
        {showReactions && <ReactionRow onReact={onReact} onClose={requestClose} />}
        {actions.length > 0 && (
          <ActionMenu
            actions={actions}
            onClose={requestClose}
            style={{ marginTop: showReactions ? POPUP_GAP : 0 }}
          />
        )}
      </Animated.View>
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
                <Image
                  source={action.icon}
                  style={{ width: 20, height: 20, tintColor: action.iconTint }}
                  resizeMode="contain"
                />
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
            <Text className="text-base font-medium text-ola-ink-soft">
              {t('dialog.cancel')}
            </Text>
          </Pressable>
        </View>
      </Pressable>
    </Pressable>
  );
}

export function MessageActionSheet({ anchor, preview, ...props }: MessageActionSheetProps) {
  const hasAnchor = anchor != null;
  useEffect(() => {
    if (props.visible && hasAnchor) hapticImpact();
  }, [props.visible, hasAnchor]);

  return (
    <OlaModal
      visible={props.visible}
      transparent
      statusBarTranslucent
      animationType={anchor == null && props.visible ? 'slide' : 'none'}
      onRequestClose={props.onClose}
    >
      {!props.visible ? null : anchor != null ? (
        preview != null ? (
          <MessengerPopup {...props} anchor={anchor} preview={preview} />
        ) : (
          <AnchoredPopup {...props} anchor={anchor} />
        )
      ) : (
        <BottomSheet {...props} />
      )}
    </OlaModal>
  );
}
