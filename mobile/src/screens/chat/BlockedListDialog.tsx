import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, FlatList, Modal, Pressable, Text, View } from 'react-native';
import { RelationshipService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { Relationship } from '@ola/shared/types';
import { Avatar } from '../../components/Avatar';

function blockedName(relationship: Relationship): string {
  return relationship.addressee?.fullName || relationship.addressee?.username || '';
}

export function BlockedListDialog({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [items, setItems] = useState<Relationship[]>([]);
  const [loading, setLoading] = useState(true);
  const [busyId, setBusyId] = useState<string | null>(null);

  useEffect(() => {
    let active = true;
    RelationshipService.blocked({ limit: 100 })
      .then((result) => {
        if (active) setItems(result.relationships);
      })
      .catch(() => {
        if (active) push('error', t('chat.blockListError'));
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [push, t]);

  async function unblock(relationship: Relationship) {
    setBusyId(relationship.id);
    try {
      await RelationshipService.unblock(relationship.id);
      setItems((list) => list.filter((item) => item.id !== relationship.id));
      push('success', t('chat.unblockDone', { name: blockedName(relationship) }));
    } catch {
      push('error', t('chat.actionError'));
    } finally {
      setBusyId(null);
    }
  }

  return (
    <Modal visible transparent animationType="fade" onRequestClose={onClose}>
      <Pressable className="flex-1 items-center justify-center bg-black/40 px-6" onPress={onClose}>
        <Pressable className="w-full max-w-md rounded-2xl bg-white p-4" onPress={() => undefined}>
          <Text className="mb-3 text-base font-semibold" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {t('chat.menuBlockList')}
          </Text>
          {loading ? (
            <ActivityIndicator className="py-6" color="#7cb342" />
          ) : items.length === 0 ? (
            <Text className="py-2 text-center text-base" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {t('chat.blockListEmpty')}
            </Text>
          ) : (
            <FlatList
              style={{ maxHeight: 320 }}
              data={items}
              keyExtractor={(item) => item.id}
              renderItem={({ item }) => {
                const name = blockedName(item);
                return (
                  <View className="flex-row items-center gap-3 py-2">
                    <Avatar name={name} uri={item.addressee?.avatar ?? undefined} size={40} />
                    <Text numberOfLines={1} className="min-w-0 flex-1 text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
                      {name}
                    </Text>
                    <Pressable
                      onPress={() => void unblock(item)}
                      disabled={busyId === item.id}
                      className="rounded px-3 py-1.5"
                      style={{ borderWidth: 1, borderColor: '#7cb342', opacity: busyId === item.id ? 0.5 : 1 }}
                    >
                      <Text className="text-sm font-medium" style={{ color: '#7cb342' }}>
                        {t('chat.unblock')}
                      </Text>
                    </Pressable>
                  </View>
                );
              }}
            />
          )}
        </Pressable>
      </Pressable>
    </Modal>
  );
}
