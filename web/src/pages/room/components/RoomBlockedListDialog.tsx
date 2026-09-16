import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActionButton, UserListDialog, UserRow } from '@components';
import { colorForName, toast } from '@lib';
import { useRoomFilterStore } from '@ola/shared/stores/room/roomFilterStore';
import type { RoomBlockedUser } from '@app-types';

interface RoomBlockedListDialogProps {
  open: boolean;
  onClose: () => void;
}

export function RoomBlockedListDialog({
  open,
  onClose,
}: RoomBlockedListDialogProps) {
  const { t } = useTranslation();
  const blockedUserIds = useRoomFilterStore((state) => state.blockedUserIds);
  const blockedUsers = useRoomFilterStore((state) => state.blockedUsers);
  const syncBlockedUsers = useRoomFilterStore(
    (state) => state.syncBlockedUsers
  );
  const unblockUser = useRoomFilterStore((state) => state.unblockUser);
  const [loading, setLoading] = useState(true);
  const [busyId, setBusyId] = useState<string | null>(null);

  useEffect(() => {
    let active = true;
    syncBlockedUsers()
      .then((synced) => {
        if (active && !synced) toast.error(t('room.blockedListError'));
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [syncBlockedUsers, t]);

  const items = useMemo(
    () =>
      blockedUserIds.map(
        (id): RoomBlockedUser => blockedUsers[id] ?? { userId: id, username: '' }
      ),
    [blockedUserIds, blockedUsers]
  );

  function displayName(user: RoomBlockedUser): string {
    return user.fullName || user.username || t('room.blockedUnknownUser');
  }

  async function unblock(user: RoomBlockedUser) {
    setBusyId(user.userId);
    try {
      await unblockUser(user.userId);
      toast.success(t('room.unblockSuccess', { name: displayName(user) }));
    } catch {
      toast.error(t('common.error'));
    } finally {
      setBusyId(null);
    }
  }

  return (
    <UserListDialog
      open={open}
      onClose={onClose}
      title={t('room.blockedListTitle')}
      loading={loading}
      isEmpty={items.length === 0}
      empty={
        <p className="py-2 text-center text-black/54">
          {t('room.blockedListEmpty')}
        </p>
      }
      divided={false}
      listMaxHeightClass="max-h-80"
    >
      {items.map((user) => {
        const name = displayName(user);
        return (
          <li key={user.userId}>
            <UserRow
              name={name}
              color={colorForName(name)}
              avatar={user.avatar}
              layout="inline"
              trailing={
                <ActionButton
                  variant="outline"
                  disabled={busyId === user.userId}
                  onClick={() => void unblock(user)}
                >
                  {t('room.unblock')}
                </ActionButton>
              }
            />
          </li>
        );
      })}
    </UserListDialog>
  );
}
