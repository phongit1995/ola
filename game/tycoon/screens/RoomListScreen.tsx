import { useEffect, type CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import bgUrl from '../assets/lobby/bg-board-pixel.webp';
import { CreateRoomModal } from '../components/CreateRoomModal';
import { JoinLockedModal } from '../components/JoinLockedModal';
import { RoomIcon } from '../components/RoomIcon';
import { RoomRow } from '../components/RoomRow';
import { TyIcon } from '../components/TyIcon';
import { ROOM_PAGE_SIZE, ROOM_RESYNC_JITTER_MS, ROOM_RESYNC_MIN_MS, pageCount } from '../helpers/room';
import { useRoomList } from '../store/useRoomList';
import { useTycoon } from '../store/useTycoon';

const SKELETON_ROWS = Array.from({ length: ROOM_PAGE_SIZE }, (_, index) => index);

function RoomListBody() {
  const { status, rooms, page, pendingId, load, join, spectate } = useRoomList(
    useShallow((s) => ({
      status: s.status,
      rooms: s.rooms,
      page: s.page,
      pendingId: s.pendingId,
      load: s.load,
      join: s.join,
      spectate: s.spectate,
    })),
  );

  if (status === 'loading') {
    return (
      <ul className="ty-rooms-rows" aria-hidden="true">
        {SKELETON_ROWS.map((index) => (
          <li key={index} className="ty-room-row ty-room-skel">
            <span className="ty-room-owner">
              <i className="ty-room-skel-avatar" />
              <i className="ty-room-skel-bar" />
            </span>
            <i className="ty-room-skel-bar ty-room-skel-short" />
            <i className="ty-room-skel-pill" />
            <i className="ty-room-skel-pill ty-room-skel-wide" />
          </li>
        ))}
      </ul>
    );
  }

  if (status === 'error') {
    return (
      <div className="ty-rooms-state" role="alert">
        <TyIcon name="wifi-off" size={32} />
        <p className="ty-rooms-state-title">Chưa tải được danh sách bàn</p>
        <button type="button" className="ty-btn ty-btn-paper ty-btn-small" onClick={() => void load()}>
          Thử lại
        </button>
      </div>
    );
  }

  if (rooms.length === 0) {
    return (
      <div className="ty-rooms-state">
        <p className="ty-rooms-state-title">Chưa có bàn nào</p>
        <p className="ty-rooms-state-hint">Tạo bàn để mời bạn bè cùng chơi</p>
      </div>
    );
  }

  return (
    <ul className="ty-rooms-rows">
      {rooms.slice(page * ROOM_PAGE_SIZE, (page + 1) * ROOM_PAGE_SIZE).map((room) => (
        <RoomRow key={room.id} room={room} pendingId={pendingId} onJoin={(item) => void join(item)} onWatch={(item) => void spectate(item)} />
      ))}
    </ul>
  );
}

export function RoomListScreen() {
  const setRoomsOpen = useTycoon((s) => s.setRoomsOpen);
  const { status, total, page, refreshing, busy, createOpen, lockedRoom, load, leave, refresh, setPage, openCreate } = useRoomList(
    useShallow((s) => ({
      status: s.status,
      total: s.rooms.length,
      page: s.page,
      refreshing: s.refreshing,
      busy: s.pendingId != null,
      createOpen: s.createOpen,
      lockedRoom: s.lockedRoom,
      load: s.load,
      leave: s.leave,
      refresh: s.refresh,
      setPage: s.setPage,
      openCreate: s.openCreate,
    })),
  );
  const pages = pageCount(total);
  const ready = status === 'ready';
  const atFirst = !ready || page === 0;
  const atLast = !ready || page >= pages - 1;

  useEffect(() => {
    void load();
    return leave;
  }, [load, leave]);

  useEffect(() => {
    if (!ready) return;
    let timer = 0;
    const schedule = () => {
      timer = window.setTimeout(() => {
        void refresh();
        schedule();
      }, ROOM_RESYNC_MIN_MS + Math.random() * ROOM_RESYNC_JITTER_MS);
    };
    schedule();
    return () => window.clearTimeout(timer);
  }, [ready, refresh]);

  return (
    <div className="ty-lobby ty-rooms" style={{ '--ty-lb-bg': `url(${bgUrl})` } as CSSProperties}>
      <header className="ty-rooms-top">
        <button type="button" className="ty-rooms-round" aria-label="Quay lại" onClick={() => setRoomsOpen(false)}>
          <RoomIcon name="chevron-left" />
        </button>
        <h1 className="ty-rooms-title">Bàn tỷ phú</h1>
        <button
          type="button"
          className={refreshing ? 'ty-rooms-round ty-rooms-refresh ty-rooms-refreshing' : 'ty-rooms-round ty-rooms-refresh'}
          aria-label="Làm mới danh sách bàn"
          aria-busy={refreshing || status === 'loading' || undefined}
          disabled={status === 'loading'}
          onClick={() => void refresh()}
        >
          <RoomIcon name="refresh-blue" />
        </button>
      </header>

      <section className="ty-rooms-table" aria-label="Danh sách bàn" aria-busy={status === 'loading' || undefined}>
        <div className="ty-rooms-head" aria-hidden="true">
          <span>Chủ bàn</span>
          <span>KEN</span>
          <span>Chỗ</span>
          <span>
            Tham gia
            <br />/ Xem
          </span>
        </div>
        <RoomListBody />
      </section>

      <footer className="ty-rooms-footer">
        <div className="ty-rooms-nav">
          <button type="button" className="ty-rooms-round ty-rooms-page-btn" aria-label="Trang trước" disabled={atFirst} onClick={() => setPage(page - 1)}>
            <RoomIcon name={atFirst ? 'chevron-left-disabled' : 'chevron-left'} />
          </button>
          <button type="button" className="ty-rooms-create" disabled={busy} onClick={openCreate}>
            <RoomIcon name="plus-gold" />
            <span>Tạo bàn</span>
          </button>
          <button type="button" className="ty-rooms-round ty-rooms-page-btn" aria-label="Trang sau" disabled={atLast} onClick={() => setPage(page + 1)}>
            <RoomIcon name={atLast ? 'chevron-right-disabled' : 'chevron-right'} />
          </button>
        </div>
        <p className="ty-rooms-page" aria-live="polite">
          <span className="ty-visually-hidden">Trang </span>
          {page + 1} / {pages}
        </p>
      </footer>

      {createOpen ? <CreateRoomModal /> : null}
      {lockedRoom ? <JoinLockedModal key={lockedRoom.id} room={lockedRoom} /> : null}
    </div>
  );
}
