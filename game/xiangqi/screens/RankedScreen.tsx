import { useEffect, useId, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import type { RoomInfo } from '../../src/sdk';
import { ModalHeading } from '../components/ModalHeading';
import { XqIcon } from '../components/XqIcon';
import { formatKen } from '../helpers/format';
import { useXiangqi } from '../store/useXiangqi';

const PAGE_SIZE = 9;
const BET_CHIPS = [0, 100, 500, 1000, 5000];

function CreateRoomModal({ onClose }: { onClose: () => void }) {
  const { userInfo, ken, createRoom, roomActionPending, showToast } = useXiangqi(
    useShallow((s) => ({
      userInfo: s.userInfo,
      ken: s.ken,
      createRoom: s.createRoom,
      roomActionPending: s.roomActionPending,
      showToast: s.showToast,
    })),
  );
  const [bet, setBet] = useState('0');
  const [password, setPassword] = useState('');
  const titleId = useId();

  const submit = () => {
    const value = Number(bet);
    if (!Number.isInteger(value) || value < 0 || (userInfo?.maxBet != null && value > userInfo.maxBet)) {
      showToast('Số Ken cược không hợp lệ');
      return;
    }
    if (value > ken) {
      showToast('Bạn không đủ Ken để tạo bàn');
      return;
    }
    if (password.length > 64) {
      showToast('Mật khẩu tối đa 64 ký tự');
      return;
    }
    createRoom(value, password);
  };

  return (
    <div className="xq-backdrop" onClick={onClose}>
      <div
        className="xq-modal xq-modal-form"
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        onClick={(event) => event.stopPropagation()}
      >
        <ModalHeading eyebrow="Mở phòng cờ" title="Tạo bàn" icon="owner" titleId={titleId} />
        <label className="xq-field">
          <span>Ken cược</span>
          <input
            inputMode="numeric"
            value={bet}
            onChange={(event) => setBet(event.target.value.replace(/[^0-9]/g, ''))}
            aria-label="Ken cược"
          />
        </label>
        <div className="xq-chip-row">
          {BET_CHIPS.map((chip) => (
            <button
              key={chip}
              type="button"
              className={`xq-chip-btn ${Number(bet) === chip ? 'xq-chip-btn-active' : ''}`}
              onClick={() => setBet(String(chip))}
              aria-pressed={Number(bet) === chip}
            >
              {chip === 0 ? 'Giao hữu' : formatKen(chip)}
            </button>
          ))}
        </div>
        <label className="xq-field">
          <span>Mật khẩu (tùy chọn)</span>
          <input value={password} onChange={(event) => setPassword(event.target.value)} maxLength={64} aria-label="Mật khẩu" />
        </label>
        <div className="xq-modal-actions">
          <button type="button" className="xq-btn xq-btn-paper" onClick={onClose}>
            Hủy
          </button>
          <button
            type="button"
            className="xq-btn xq-btn-gold"
            onClick={submit}
            disabled={roomActionPending === 'creating'}
            aria-busy={roomActionPending === 'creating'}
          >
            {roomActionPending === 'creating' ? 'Đang tạo...' : 'Tạo bàn'}
          </button>
        </div>
      </div>
    </div>
  );
}

function JoinLockedModal({ room, onClose }: { room: RoomInfo; onClose: () => void }) {
  const { joinRoom, roomActionPending } = useXiangqi(
    useShallow((s) => ({ joinRoom: s.joinRoom, roomActionPending: s.roomActionPending })),
  );
  const [password, setPassword] = useState('');
  const titleId = useId();
  return (
    <div className="xq-backdrop" onClick={onClose}>
      <div
        className="xq-modal xq-modal-form xq-modal-locked"
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        onClick={(event) => event.stopPropagation()}
      >
        <ModalHeading eyebrow="Bàn có mật khẩu" title={`Bàn của @${room.owner}`} icon="lock" titleId={titleId} />
        <label className="xq-field">
          <span>Mật khẩu</span>
          <input
            type="password"
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            maxLength={64}
            aria-label="Mật khẩu"
          />
        </label>
        <div className="xq-modal-actions">
          <button type="button" className="xq-btn xq-btn-paper" onClick={onClose}>
            Hủy
          </button>
          <button
            type="button"
            className="xq-btn xq-btn-gold"
            onClick={() => joinRoom(room.id, password)}
            disabled={roomActionPending === 'joining'}
            aria-busy={roomActionPending === 'joining'}
          >
            {roomActionPending === 'joining' ? 'Đang vào...' : 'Vào bàn'}
          </button>
        </div>
      </div>
    </div>
  );
}

export function RankedScreen() {
  const { rooms, closeRanked, refreshRooms, joinRoom, roomActionPending } = useXiangqi(
    useShallow((s) => ({
      rooms: s.rooms,
      closeRanked: s.closeRanked,
      refreshRooms: s.refreshRooms,
      joinRoom: s.joinRoom,
      roomActionPending: s.roomActionPending,
    })),
  );
  const [page, setPage] = useState(0);
  const [createOpen, setCreateOpen] = useState(false);
  const [lockedRoom, setLockedRoom] = useState<RoomInfo | null>(null);

  useEffect(() => {
    const timer = setInterval(() => refreshRooms(), 90_000 + Math.random() * 30_000);
    return () => clearInterval(timer);
  }, [refreshRooms]);

  const pageCount = Math.max(1, Math.ceil(rooms.length / PAGE_SIZE));
  const currentPage = Math.min(page, pageCount - 1);
  const visible = rooms.slice(currentPage * PAGE_SIZE, currentPage * PAGE_SIZE + PAGE_SIZE);

  return (
    <div className="xq-screen xq-ranked">
      <div className="xq-screen-header">
        <button type="button" className="xq-icon-btn" onClick={closeRanked} aria-label="Quay lại">
          <XqIcon name="arrow-left" size={22} />
        </button>
        <h1>Bàn cờ tướng</h1>
        <button type="button" className="xq-icon-btn" onClick={refreshRooms} aria-label="Làm mới">
          <XqIcon name="refresh" size={22} />
        </button>
      </div>

      <div className="xq-room-head">
        <span>Chủ bàn</span>
        <span>Ken cược</span>
        <span>Tham gia</span>
      </div>

      <div className="xq-room-list">
        {visible.length === 0 ? <div className="xq-empty">Chưa có bàn nào — tạo bàn mới nhé!</div> : null}
        {visible.map((room) => {
          const full = room.full || room.players >= (room.maxPlayers ?? 2);
          return (
            <div key={room.id} className="xq-room-row">
              <div className="xq-room-owner">
                <div className="xq-pod-avatar xq-pod-avatar-red">{room.owner.slice(0, 1).toUpperCase()}</div>
                <span className="xq-room-owner-name">@{room.owner}</span>
                {room.locked ? (
                  <span className="xq-room-lock" aria-label="Có mật khẩu">
                    <XqIcon name="lock" size={16} />
                  </span>
                ) : null}
              </div>
              <div className="xq-room-bet">
                {room.bet > 0 ? (
                  <>
                    <span>{formatKen(room.bet)}</span>
                    <XqIcon name="ken" size={15} />
                  </>
                ) : (
                  'Giao hữu'
                )}
              </div>
              <div className="xq-room-join">
                <span className={`xq-chip ${full ? '' : 'xq-chip-jade'}`}>{room.players}/{room.maxPlayers ?? 2}</span>
                <button
                  type="button"
                  className="xq-btn xq-btn-gold xq-btn-small"
                  disabled={full || roomActionPending != null}
                  onClick={() => (room.locked ? setLockedRoom(room) : joinRoom(room.id, ''))}
                >
                  Tham gia
                </button>
              </div>
            </div>
          );
        })}
      </div>

      <div className="xq-ranked-footer">
        <button type="button" className="xq-icon-btn" disabled={currentPage === 0} onClick={() => setPage(currentPage - 1)} aria-label="Trang trước">
          <XqIcon name="chevron-left" size={22} />
        </button>
        <button type="button" className="xq-btn xq-btn-gold" onClick={() => setCreateOpen(true)}>
          Tạo bàn
        </button>
        <button
          type="button"
          className="xq-icon-btn"
          disabled={currentPage >= pageCount - 1}
          onClick={() => setPage(currentPage + 1)}
          aria-label="Trang sau"
        >
          <XqIcon name="chevron-right" size={22} />
        </button>
      </div>

      {createOpen ? <CreateRoomModal onClose={() => setCreateOpen(false)} /> : null}
      {lockedRoom ? <JoinLockedModal room={lockedRoom} onClose={() => setLockedRoom(null)} /> : null}
    </div>
  );
}
