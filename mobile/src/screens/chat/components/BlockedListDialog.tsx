import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { RelationshipService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { Relationship } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { UserListDialog } from '@components/ui/UserListDialog';

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
    <UserListDialog
      visible
      title={t('chat.menuBlockList')}
      onClose={onClose}
      loading={loading}
      isEmpty={items.length === 0}
      empty={
        <Text className="py-2 text-center text-base text-ola-ink-soft">
          {t('chat.blockListEmpty')}
        </Text>
      }
      divided={false}
      listMaxHeight={320}
    >
      {items.map((item) => {
        const name = blockedName(item);
        return (
          <View key={item.id} className="flex-row items-center gap-3 py-2">
            <Avatar name={name} uri={item.addressee?.avatar ?? undefined} size={40} />
            <Text
              numberOfLines={1}
              className="min-w-0 flex-1 text-base text-ola-ink"
            >
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
      })}
    </UserListDialog>
  );
}
