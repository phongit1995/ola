import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog } from '@components';
import { HomeHeader } from '@components/HomeHeader';
import { ChatConversationView } from '../chat/components/ChatConversationView';
import { RoomList } from './components/RoomList';
import { RoomFilterDialog } from './components/RoomFilterDialog';
import { RoomReturnFab } from './components/RoomReturnFab';
import { DEFAULT_ROOM_FILTERS, ROOMS } from './data';
import type { Room, RoomFilters } from './types';
import filterIcon from '@/assets/icons/room/ic_filter_unselected.png';

export function RoomPanel() {
  const { t } = useTranslation();
  const [filters, setFilters] = useState<RoomFilters>(DEFAULT_ROOM_FILTERS);
  const [filterOpen, setFilterOpen] = useState(false);
  const [refreshing, setRefreshing] = useState(false);
  const [joinedRoom, setJoinedRoom] = useState<Room | null>(null);
  const [activeRoom, setActiveRoom] = useState<Room | null>(null);
  const [pendingQuit, setPendingQuit] = useState<Room | null>(null);
  const [unread, setUnread] = useState(0);

  function enterRoom(room: Room) {
    setJoinedRoom(room);
    setUnread(0);
    setActiveRoom(room);
  }

  function closeActiveRoom() {
    setActiveRoom(null);
    setUnread(Math.floor(Math.random() * 5) + 1);
  }

  function reopenJoinedRoom() {
    if (joinedRoom == null) return;
    setUnread(0);
    setActiveRoom(joinedRoom);
  }

  function confirmQuit() {
    if (pendingQuit != null) {
      if (activeRoom?.id === pendingQuit.id) setActiveRoom(null);
      if (joinedRoom?.id === pendingQuit.id) setJoinedRoom(null);
      setUnread(0);
    }
    setPendingQuit(null);
  }

  function refresh() {
    setRefreshing(true);
    window.setTimeout(() => setRefreshing(false), 800);
  }

  function quickJoin() {
    const available = [...ROOMS]
      .filter((room) => room.members < 200)
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
        <button
          type="button"
          aria-label={t('room.filterTitle')}
          onClick={() => setFilterOpen(true)}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <img src={filterIcon} alt="" className="h-5 w-5 object-contain" />
        </button>
      </HomeHeader>

      <main className="relative flex-1 overflow-y-auto bg-[#f3f3f3]">
        {refreshing && (
          <div className="py-2 text-center text-sm text-ola-primary">
            {t('room.refreshing')}
          </div>
        )}
        <RoomList
          rooms={ROOMS}
          joinedRoomId={joinedRoom?.id ?? null}
          onEnter={enterRoom}
          onQuit={setPendingQuit}
          onAroundYou={aroundYou}
          onQuickJoin={quickJoin}
          onBuyVip={() => {}}
        />
        {joinedRoom != null && activeRoom == null && (
          <RoomReturnFab
            label={joinedRoom.title}
            unread={unread}
            onClick={reopenJoinedRoom}
          />
        )}
      </main>

      {activeRoom != null && (
        <ChatConversationView
          name={activeRoom.title}
          color={activeRoom.color}
          seedMessage={activeRoom.subtitle}
          onClose={closeActiveRoom}
        />
      )}

      <RoomFilterDialog
        key={filterOpen ? 'open' : 'closed'}
        open={filterOpen}
        value={filters}
        onApply={(value) => {
          setFilters(value);
          setFilterOpen(false);
        }}
        onClose={() => setFilterOpen(false)}
      />
      <ConfirmDialog
        open={pendingQuit != null}
        danger
        title={t('room.quitTitle')}
        message={t('room.quitMessage', { name: pendingQuit?.title ?? '' })}
        confirmLabel={t('room.quit')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={confirmQuit}
        onCancel={() => setPendingQuit(null)}
      />
    </>
  );
}
