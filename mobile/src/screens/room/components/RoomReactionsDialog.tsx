import { useTranslation } from 'react-i18next';
import { Image, ScrollView, Text, View } from 'react-native';
import type { RoomReactor } from '@ola/shared/types';
import { REACTION_IMAGE, REACTION_ORDER } from '@lib/reactions';
import { Dialog } from '@components/ui/Dialog';

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
    <Dialog visible={visible} title={t('room.reactionsTitle')} onClose={onClose}>
      {rows.length === 0 ? (
        <Text className="py-4 text-center text-sm text-ola-ink-soft">
          {t('room.reactionsEmpty')}
        </Text>
      ) : (
        <ScrollView style={{ maxHeight: 288 }}>
          {rows.map(({ type, reactor }, index) => (
            <View
              key={`${type}-${reactor.userId}`}
              className="flex-row items-center gap-3 py-2"
              style={index > 0 ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' } : null}
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
                className="flex-1 text-base text-ola-ink"
              >
                @{reactor.username}
              </Text>
            </View>
          ))}
        </ScrollView>
      )}
    </Dialog>
  );
}
