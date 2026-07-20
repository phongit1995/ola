import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, PullToRefresh } from '@components';
import { HomeHeader } from '@components/HomeHeader';
import { RoomList } from './components/RoomList';
import type { RoomListItem } from './types';
import { useRoomListStore } from '@ola/shared/stores/roomListStore';
import { useRoomChatStore } from '@/store/roomChatStore';
import { ROOM_CAPACITY, ROOM_COLORS } from './constants';

export function RoomPanel() {
  const { t } = useTranslation();
  const apiRooms = useRoomListStore((state) => state.rooms);
  const loadingRooms = useRoomListStore((state) => state.loading);
  const roomsLoaded = useRoomListStore((state) => state.loaded);
  const fetchRooms = useRoomListStore((state) => state.fetchRooms);
  const activeRoom = useRoomChatStore((state) => state.activeRoom);
  const openRoom = useRoomChatStore((state) => state.open);
  const [fullRoom, setFullRoom] = useState<RoomListItem | null>(null);

  useEffect(() => {
    void fetchRooms(undefined, { silent: useRoomListStore.getState().loaded });
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

  function refresh() {
    return fetchRooms();
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
        <span className="flex-1 text-center text-lg font-medium">
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

      <PullToRefresh
        onRefresh={refresh}
        className="relative flex-1 overflow-y-auto bg-[#f3f3f3]"
      >
        {loadingRooms && (
          <div className="py-2 text-center text-sm text-ola-primary">
            {t('room.refreshing')}
          </div>
        )}
        <RoomList
          rooms={rooms}
          joinedRoomId={activeRoom?.id ?? null}
          onEnter={enterRoom}
          onAroundYou={aroundYou}
          onQuickJoin={quickJoin}
          showQuickJoin={roomsLoaded}
        />
      </PullToRefresh>

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
