import { useTranslation } from 'react-i18next';
import { Image, Modal, Pressable, ScrollView, Text, View } from 'react-native';
import type { RoomReactor } from '@ola/shared/types';
import { REACTION_IMAGE, REACTION_ORDER } from '../../lib/reactions';

interface RoomReactionsDialogProps {
  visible: boolean;
  reactions?: Record<string, RoomReactor[]>;
  onClose: () => void;
}

export function RoomReactionsDialog({ visible, reactions, onClose }: RoomReactionsDialogProps) {
  const { t } = useTranslation();
  const rows = REACTION_ORDER.flatMap((type) =>
    (reactions?.[type] ?? []).map((reactor) => ({ type, reactor }))
  );

  return (
    <Modal visible={visible} transparent animationType="fade" onRequestClose={onClose}>
      <Pressable className="flex-1 items-center justify-center bg-black/40 px-8" onPress={onClose}>
        <Pressable className="w-full max-w-md rounded-2xl bg-white p-4" onPress={() => undefined}>
          <Text className="mb-2 text-base font-semibold" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {t('room.reactionsTitle')}
          </Text>
          {rows.length === 0 ? (
            <Text className="py-4 text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {t('room.reactionsEmpty')}
            </Text>
          ) : (
            <ScrollView style={{ maxHeight: 288 }}>
              {rows.map(({ type, reactor }) => (
                <View
                  key={`${type}-${reactor.userId}`}
                  className="flex-row items-center gap-3 py-2"
                  style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.08)' }}
                >
                  {REACTION_IMAGE[type] != null && (
                    <Image
                      source={REACTION_IMAGE[type]!}
                      style={{ width: 24, height: 24 }}
                      resizeMode="contain"
                    />
                  )}
                  <Text
                    numberOfLines={1}
                    className="flex-1 text-base"
                    style={{ color: 'rgba(0,0,0,0.87)' }}
                  >
                    @{reactor.username}
                  </Text>
                </View>
              ))}
            </ScrollView>
          )}
        </Pressable>
      </Pressable>
    </Modal>
  );
}
