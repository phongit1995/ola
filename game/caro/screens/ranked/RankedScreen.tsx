import { useEffect } from 'react';
import { useShallow } from 'zustand/react/shallow';
import type { RoomInfo } from '../../../src/sdk';
import { assetBg, assetSrc, preloadCreateModalAssets } from '../../assets';
import { useCaro } from '../../store/useCaro';
import { CreateRoomModal } from './components/CreateRoomModal';
import { JoinRoomModal } from './components/JoinRoomModal';
import { RankedRoomRow } from './components/RankedRoomRow';
import { useRanked } from './useRanked';

const PAGE_SIZE = 9;
const HEAD_BOTTOM = 10.5;
const ROW_HEIGHT = 8.85;
const ROOM_RESYNC_MIN_MS = 90_000;
const ROOM_RESYNC_JITTER_MS = 30_000;

export function RankedScreen() {
  const visible = useCaro((s) => s.rankedVisible);
  const rooms = useCaro((s) => s.rooms);
  const availableKen = useCaro((s) => s.userInfo?.ken ?? 0);
  const maxBet = useCaro((s) => s.userInfo?.maxBet ?? null);
  const toast = useCaro((s) => s.toast);
  const onExit = useCaro((s) => s.toLobby);
  const createRoom = useCaro((s) => s.createRoom);
  const joinRoom = useCaro((s) => s.joinRoom);
  const refreshRooms = useCaro((s) => s.refreshRooms);

  const { page, createOpen, passRoom, setPage, openCreate, closeCreate, openPass, closePass } = useRanked(
    useShallow((state) => ({
      page: state.page,
      createOpen: state.createOpen,
      passRoom: state.passRoom,
      setPage: state.setPage,
      openCreate: state.openCreate,
      closeCreate: state.closeCreate,
      openPass: state.openPass,
      closePass: state.closePass,
    })),
  );

  const pageCount = Math.max(1, Math.ceil(rooms.length / PAGE_SIZE));
  const visibleRooms = rooms.slice(page * PAGE_SIZE, page * PAGE_SIZE + PAGE_SIZE);

  useEffect(() => {
    if (!visible) return;
    let timer: number;
    const schedule = (): void => {
      const delay = ROOM_RESYNC_MIN_MS + Math.random() * ROOM_RESYNC_JITTER_MS;
      timer = window.setTimeout(() => {
        refreshRooms();
        schedule();
      }, delay);
    };
    schedule();
    return () => window.clearTimeout(timer);
  }, [visible, refreshRooms]);

  useEffect(() => {
    setPage((p) => Math.min(p, Math.max(0, Math.ceil(rooms.length / PAGE_SIZE) - 1)));
  }, [rooms.length, setPage]);

  const attemptJoin = (room: RoomInfo): void => {
    if (room.locked) {
      preloadCreateModalAssets();
      openPass(room);
      return;
    }
    joinRoom(room.id);
  };

  const submitPass = (roomId: string, password: string): void => {
    joinRoom(roomId, password);
    closePass();
  };

  const onCreateOk = (amount: number, password?: string): void => {
    closeCreate();
    createRoom(amount, password);
  };

  const openCreateModal = (): void => {
    preloadCreateModalAssets();
    openCreate();
  };

  return (
    <div id="ranked" className={visible ? '' : 'hidden'}>
      <div id="ranked-inner" style={assetBg('rankedBg')}>
        <div className="ranked-title" style={assetBg('rankedTitleFrame')}>
          <span>Chơi xếp hạng</span>
          <img src={assetSrc('rankedCup')} alt="" />
        </div>
        <div className="ranked-table-wrap">
          <div className="ranked-table" style={assetBg('rankedTable')}>
            <div className="ranked-head">
              <span>Chủ bàn</span>
              <span>Ken cược</span>
              <span>Tham gia</span>
            </div>
            <div id="ranked-rows">
              {visibleRooms.map((room, index) => (
                <RankedRoomRow
                  key={room.id}
                  room={room}
                  top={HEAD_BOTTOM + index * ROW_HEIGHT}
                  height={ROW_HEIGHT}
                  onJoin={attemptJoin}
                />
              ))}
            </div>
            <div id="ranked-empty" className={rooms.length > 0 ? 'hidden' : ''}>
              Chưa có bàn nào,
              <br />
              tạo bàn mới nhé!
            </div>
          </div>
        </div>
        <div className="ranked-pager">
          <button type="button" id="ranked-prev" style={assetBg('rankedPageBtn')} disabled={page === 0} onClick={() => setPage((p) => Math.max(0, p - 1))}>
            &lt;
          </button>
          <span id="ranked-page" style={assetBg('rankedPageBtn')}>
            {page + 1}
          </span>
          <button type="button" id="ranked-next" style={assetBg('rankedPageBtn')} disabled={page >= pageCount - 1} onClick={() => setPage((p) => Math.min(pageCount - 1, p + 1))}>
            &gt;
          </button>
        </div>
        <div className="ranked-menu">
          <button
            type="button"
            id="ranked-create"
            style={assetBg('rankedMenuBtn')}
            onPointerEnter={preloadCreateModalAssets}
            onFocus={preloadCreateModalAssets}
            onClick={openCreateModal}
          >
            Tạo bàn
          </button>
          <button type="button" id="ranked-refresh" style={assetBg('rankedMenuBtn')} onClick={() => refreshRooms()}>
            Làm mới
          </button>
          <button type="button" id="ranked-exit" style={assetBg('rankedMenuBtn')} onClick={onExit}>
            Thoát
          </button>
        </div>
        <div id="ranked-toast" className={toast ? 'show' : 'hidden'}>
          {toast}
        </div>
      </div>

      <CreateRoomModal
        open={createOpen}
        availableKen={availableKen}
        maxBet={maxBet}
        onClose={closeCreate}
        onSubmit={onCreateOk}
      />
      <JoinRoomModal room={passRoom} onClose={closePass} onSubmit={submitPass} />
    </div>
  );
}
