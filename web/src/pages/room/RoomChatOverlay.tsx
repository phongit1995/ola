import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog } from '@components';
import { toast } from '@lib';
import { RoomChatView } from './components/RoomChatView';
import { RoomJoiningOverlay } from './components/RoomJoiningOverlay';
import { useRoomChatStore } from '@/store/roomChatStore';
import { useRoomListStore } from '@ola/shared/stores/roomListStore';
import type { ActiveRoom } from '@ola/shared/types';

export function RoomChatOverlay({ visible }: { visible: boolean }) {
  const { t } = useTranslation();
  const activeRoom = useRoomChatStore((state) => state.activeRoom);
  const joinStatus = useRoomChatStore((state) => state.status);
  const closeRoom = useRoomChatStore((state) => state.close);
  const fetchRooms = useRoomListStore((state) => state.fetchRooms);
  const [pendingQuit, setPendingQuit] = useState<ActiveRoom | null>(null);

  if (activeRoom == null) return null;

  function exitRoom() {
    closeRoom();
    fetchRooms();
  }

  function confirmQuit() {
    if (pendingQuit != null && activeRoom?.id === pendingQuit.id) {
      exitRoom();
      toast.success(t('room.quitSuccess'));
    }
    setPendingQuit(null);
  }

  return (
    <div className={visible ? '' : 'hidden'}>
      {joinStatus === 'joined' ? (
        <RoomChatView
          visible={visible}
          onClose={() => setPendingQuit(activeRoom)}
        />
      ) : (
        <RoomJoiningOverlay status={joinStatus} onClose={exitRoom} />
      )}

      <ConfirmDialog
        open={pendingQuit != null}
        danger
        title={t('room.quitTitle')}
        message={t('room.quitMessage', { name: pendingQuit?.name ?? '' })}
        confirmLabel={t('dialog.yes')}
        cancelLabel={t('dialog.no')}
        onConfirm={confirmQuit}
        onCancel={() => setPendingQuit(null)}
      />
    </div>
  );
}
