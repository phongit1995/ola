import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog } from '@components';
import { toast } from '@lib';
import { RoomChatView } from './components/RoomChatView';
import { RoomJoiningOverlay } from './components/RoomJoiningOverlay';
import { useRoomChatStore, type ActiveRoom } from '@/store/roomChatStore';
import { useRoomStore } from './roomStore';

export function RoomChatOverlay() {
  const { t } = useTranslation();
  const activeRoom = useRoomChatStore((state) => state.activeRoom);
  const joinStatus = useRoomChatStore((state) => state.status);
  const closeRoom = useRoomChatStore((state) => state.close);
  const fetchRooms = useRoomStore((state) => state.fetchRooms);
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
    <>
      {joinStatus === 'joined' ? (
        <RoomChatView onClose={() => setPendingQuit(activeRoom)} />
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
    </>
  );
}
