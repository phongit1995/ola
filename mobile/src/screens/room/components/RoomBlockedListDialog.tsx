import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { useThemeColors } from '@hooks/useThemeColors';
import { useRoomFilterStore } from '@ola/shared/stores/room/roomFilterStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { RoomBlockedUser } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { UserListDialog } from '@components/ui/UserListDialog';

export function RoomBlockedListDialog({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const push = useToastStore(s => s.push);
  const blockedUserIds = useRoomFilterStore(s => s.blockedUserIds);
  const blockedUsers = useRoomFilterStore(s => s.blockedUsers);
  const syncBlockedUsers = useRoomFilterStore(s => s.syncBlockedUsers);
  const unblockUser = useRoomFilterStore(s => s.unblockUser);
  const [loading, setLoading] = useState(true);
  const [busyId, setBusyId] = useState<string | null>(null);

  useEffect(() => {
    let active = true;
    syncBlockedUsers()
      .then(synced => {
        if (active && !synced) push('error', t('room.blockedListError'));
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [push, syncBlockedUsers, t]);

  const items = useMemo(
    () =>
      blockedUserIds.map(
        (id): RoomBlockedUser => blockedUsers[id] ?? { userId: id, username: '' },
      ),
    [blockedUserIds, blockedUsers],
  );

  function displayName(user: RoomBlockedUser): string {
    return user.fullName || user.username || t('room.blockedUnknownUser');
  }

  async function unblock(user: RoomBlockedUser) {
    setBusyId(user.userId);
    try {
      await unblockUser(user.userId);
      push('success', t('room.unblockSuccess', { name: displayName(user) }));
    } catch {
      push('error', t('common.error'));
    } finally {
      setBusyId(null);
    }
  }

  return (
    <UserListDialog
      visible
      title={t('room.blockedListTitle')}
      onClose={onClose}
      loading={loading}
      isEmpty={items.length === 0}
      empty={
        <Text className="py-2 text-center text-base text-ola-ink-soft">
          {t('room.blockedListEmpty')}
        </Text>
      }
      divided={false}
      listMaxHeight={320}
    >
      {items.map(user => {
        const name = displayName(user);
        const busy = busyId === user.userId;
        return (
          <View key={user.userId} className="flex-row items-center gap-3 py-2">
            <Avatar name={name} uri={user.avatar} size={40} />
            <Text numberOfLines={1} className="min-w-0 flex-1 text-base text-ola-ink">
              {name}
            </Text>
            <Pressable
              onPress={() => void unblock(user)}
              disabled={busy}
              className="rounded px-3 py-1.5"
              style={{ borderWidth: 1, borderColor: colors.primary, opacity: busy ? 0.5 : 1 }}
            >
              <Text className="text-sm font-medium" style={{ color: colors.primary }}>
                {t('room.unblock')}
              </Text>
            </Pressable>
          </View>
        );
      })}
    </UserListDialog>
  );
}
