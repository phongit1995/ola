import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog } from '@components';
import { toast } from '@lib';
import { HomeHeader } from '@components/HomeHeader';
import { RoomChatView } from './components/RoomChatView';
import { RoomJoiningOverlay } from './components/RoomJoiningOverlay';
import { RoomList } from './components/RoomList';
import type { RoomListItem } from './types';
import { useRoomStore } from '@/store/roomStore';
import { useRoomChatStore, type ActiveRoom } from '@/store/roomChatStore';
import { ROOM_CAPACITY, ROOM_COLORS } from './constants';

export function RoomPanel() {
  const { t } = useTranslation();
  const apiRooms = useRoomStore((state) => state.rooms);
  const loadingRooms = useRoomStore((state) => state.loading);
  const roomsLoaded = useRoomStore((state) => state.loaded);
  const fetchRooms = useRoomStore((state) => state.fetchRooms);
  const activeRoom = useRoomChatStore((state) => state.activeRoom);
  const joinStatus = useRoomChatStore((state) => state.status);
  const openRoom = useRoomChatStore((state) => state.open);
  const closeRoom = useRoomChatStore((state) => state.close);
  const [pendingQuit, setPendingQuit] = useState<ActiveRoom | null>(null);
  const [fullRoom, setFullRoom] = useState<RoomListItem | null>(null);

  useEffect(() => {
    fetchRooms();
  }, [fetchRooms]);

  const rooms = useMemo<RoomListItem[]>(
    () =>
      apiRooms.map((room, index) => ({
        id: room.id,
        title: room.name,
        subtitle: room.description ?? '',
        members: room.memberCount,
        color: ROOM_COLORS[index % ROOM_COLORS.length]!,
        imageUrl: room.imageUrl,
      })),
    [apiRooms]
  );

  function enterRoom(room: RoomListItem) {
    if (room.members >= ROOM_CAPACITY) {
      setFullRoom(room);
      return;
    }
    openRoom({ id: room.id, name: room.title });
  }

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

  function refresh() {
    fetchRooms();
  }

  function quickJoin() {
    const available = [...rooms]
      .filter((room) => room.members < ROOM_CAPACITY)
      .sort((a, b) => a.members - b.members)[0];
    if (available != null) enterRoom(available);
  }

  function aroundYou() {
    enterRoom({
      id: 'around-you',
      title: t('room.aroundYou'),
      subtitle: t('room.aroundYouDesc'),
      members: 12,
      color: '#26c6da',
    });
  }

  return (
    <>
      <HomeHeader>
        <span className="w-9" />
        <span className="flex-1 text-center text-base font-medium">
          {t('home.tabRoom')}
        </span>
        <button
          type="button"
          aria-label={t('room.refresh')}
          onClick={refresh}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <svg viewBox="0 0 24 24" className="h-5 w-5" fill="currentColor" aria-hidden="true">
            <path d="M17.65 6.35A8 8 0 1 0 19.73 14h-2.08A6 6 0 1 1 12 6c1.66 0 3.14.69 4.22 1.78L13 11h7V4l-2.35 2.35z" />
          </svg>
        </button>
      </HomeHeader>

      <main className="relative flex-1 overflow-y-auto bg-[#f3f3f3]">
        {loadingRooms && (
          <div className="py-2 text-center text-sm text-ola-primary">
            {t('room.refreshing')}
          </div>
        )}
        <RoomList
          rooms={rooms}
          joinedRoomId={activeRoom?.id ?? null}
          onEnter={enterRoom}
          onQuit={(room) => setPendingQuit({ id: room.id, name: room.title })}
          onAroundYou={aroundYou}
          onQuickJoin={quickJoin}
          showQuickJoin={roomsLoaded}
        />
      </main>

      {activeRoom != null && joinStatus === 'joined' && (
        <RoomChatView onClose={() => setPendingQuit(activeRoom)} />
      )}
      {activeRoom != null && joinStatus !== 'joined' && (
        <RoomJoiningOverlay name={activeRoom.name} status={joinStatus} onClose={exitRoom} />
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
      <ConfirmDialog
        open={fullRoom != null}
        title={fullRoom?.title ?? ''}
        message={t('room.roomFull')}
        confirmLabel={t('room.buyVip')}
        cancelLabel={t('dialog.close')}
        onConfirm={() => setFullRoom(null)}
        onCancel={() => setFullRoom(null)}
      />
    </>
  );
}
