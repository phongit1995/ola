import { useTranslation } from 'react-i18next';
import { Image, Modal, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { ImageSourcePropType } from 'react-native';
import type { ReactionType } from '@ola/shared/types';
import { REACTION_IMAGE, REACTION_ORDER } from '../../lib/reactions';

export interface MessageSheetAction {
  key: string;
  label: string;
  icon?: ImageSourcePropType;
  destructive?: boolean;
  onSelect: () => void;
}

interface MessageActionSheetProps {
  visible: boolean;
  actions: MessageSheetAction[];
  showReactions?: boolean;
  onReact: (type: ReactionType) => void;
  onClose: () => void;
}

export function MessageActionSheet({
  visible,
  actions,
  showReactions = true,
  onReact,
  onClose,
}: MessageActionSheetProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();

  return (
    <Modal visible={visible} transparent animationType="slide" onRequestClose={onClose}>
      <Pressable className="flex-1 justify-end bg-black/40" onPress={onClose}>
        <Pressable
          className="rounded-t-2xl bg-white"
          style={{ paddingBottom: Math.max(insets.bottom, 8) }}
          onPress={() => undefined}
        >
          {showReactions && (
            <View className="flex-row items-center justify-around px-2 py-3">
              {REACTION_ORDER.map((type) => (
                <Pressable
                  key={type}
                  onPress={() => {
                    onReact(type);
                    onClose();
                  }}
                  className="h-10 w-10 items-center justify-center rounded-full active:bg-neutral-100"
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
    </Modal>
  );
}
