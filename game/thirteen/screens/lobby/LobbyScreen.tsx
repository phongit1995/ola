import { useState } from 'react';
import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';
import type { RoomInfo } from '../../../src/sdk';
import backIcon from '../../assets/icons/ic-back.svg';
import cardsEmptyIcon from '../../assets/icons/ic-cards-empty.svg';
import checkIcon from '../../assets/icons/ic-check.svg';
import lockIcon from '../../assets/icons/ic-lock.svg';
import refreshIcon from '../../assets/icons/ic-refresh.svg';
import kenIcon from '../../assets/icons/ken.png';
import { BrandMark } from '../../components/BrandMark';
import { handleModalKeyDown } from '../../components/modalKeyboard';
import { avatarTone, userAvatarIconUrl } from '../../helpers/avatar';
import {
  formatBetInput,
  formatKen,
  parseBetInput,
  ROOM_PASSWORD_MAX_LENGTH,
  roomCreationError,
} from '../../helpers/room';
import { useThirteen } from '../../store/useThirteen';

function KenPill() {
  const user = useThirteen((s) => s.user);
  if (!user) return null;
  return (
    <div className="tl-ken-pill">
      <span className="tl-avatar tl-avatar-sm tl-user-avatar">
        <img src={userAvatarIconUrl(user.vipType)} alt={`VIP của ${user.username}`} />
      </span>
      <span className="tl-ken-amount">{formatKen(user.ken)}</span>
      <img className="tl-ken-coin" src={kenIcon} alt="Ken" />
    </div>
  );
}

function SeatDots({ players, maxPlayers }: { players: number; maxPlayers: number }) {
  return (
    <span className="tl-seat-dots">
      {Array.from({ length: maxPlayers }, (_, i) => (
        <i key={i} className={i < players ? 'filled' : ''} />
      ))}
    </span>
  );
}

function CreateRoomModal({ onClose }: { onClose: () => void }) {
  const createRoom = useThirteen((s) => s.createRoom);
  const user = useThirteen((s) => s.user);
  const [capacity, setCapacity] = useState(4);
  const [betInput, setBetInput] = useState('0');
  const [password, setPassword] = useState('');
  const bet = parseBetInput(betInput);
  const createError = roomCreationError(bet, password, user?.ken ?? null, user?.maxBet ?? null);
  const betHint =
    createError ??
    (bet === 0 ? '0 Ken = chơi không cược.' : `Mỗi người cần đủ ${formatKen(bet)} Ken để vào bàn.`);
  const submit = () => {
    if (createError) return;
    createRoom(capacity, password.trim(), bet);
    onClose();
  };
  return (
    <div
      className="tl-modal-backdrop tl-lobby-modal-backdrop"
      onClick={(e) => e.target === e.currentTarget && onClose()}
    >
      <form
        className="tl-modal tl-lobby-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby="tl-create-room-title"
        onSubmit={(event) => {
          event.preventDefault();
          submit();
        }}
        onKeyDown={(event) => handleModalKeyDown(event, onClose)}
      >
        <span className="tl-modal-accent" aria-hidden="true" />
        <div id="tl-create-room-title" className="tl-modal-title">
          Tạo bàn mới
        </div>
        <div className="tl-field-label">Số người chơi</div>
        <div className="tl-capacity-row">
          {[2, 3, 4].map((n) => (
            <button
              key={n}
              type="button"
              className={'tl-capacity-btn' + (capacity === n ? ' active' : '')}
              aria-pressed={capacity === n}
              onClick={() => setCapacity(n)}
            >
              <span>{n} người</span>
              {capacity === n && <img className="tl-capacity-check" src={checkIcon} alt="" />}
            </button>
          ))}
        </div>
        <label className="tl-field-label" htmlFor="tl-create-room-bet">
          Cược mỗi người
        </label>
        <div className={'tl-bet-input' + (createError ? ' invalid' : '')}>
          <img src={kenIcon} alt="" />
          <input
            id="tl-create-room-bet"
            type="text"
            inputMode="numeric"
            autoComplete="off"
            autoFocus
            maxLength={19}
            value={betInput}
            aria-invalid={createError != null}
            aria-describedby="tl-create-room-bet-hint"
            onFocus={(event) => event.currentTarget.select()}
            onChange={(event) => setBetInput(formatBetInput(event.target.value))}
          />
          <span>Ken</span>
        </div>
        <p
          id="tl-create-room-bet-hint"
          className={'tl-bet-hint' + (createError ? ' error' : '')}
          aria-live="polite"
        >
          {betHint}
        </p>
        <label className="tl-field-label" htmlFor="tl-create-room-password">
          Mật khẩu (bỏ trống nếu công khai)
        </label>
        <input
          id="tl-create-room-password"
          className="tl-input"
          type="password"
          value={password}
          maxLength={ROOM_PASSWORD_MAX_LENGTH}
          placeholder="Không đặt mật khẩu"
          onChange={(e) => setPassword(e.target.value)}
        />
        <div className="tl-modal-actions">
          <button type="button" className="tl-btn tl-btn-ghost" onClick={onClose}>
            Hủy
          </button>
          <button type="submit" className="tl-btn tl-btn-gold" disabled={createError != null}>
            Tạo bàn
          </button>
        </div>
      </form>
    </div>
  );
}

function PasswordModal({ room, onClose }: { room: RoomInfo; onClose: () => void }) {
  const joinRoom = useThirteen((s) => s.joinRoom);
  const [password, setPassword] = useState('');
  const submit = () => {
    joinRoom(room, password);
    onClose();
  };
  return (
    <div
      className="tl-modal-backdrop tl-lobby-modal-backdrop"
      onClick={(e) => e.target === e.currentTarget && onClose()}
    >
      <form
        className="tl-modal tl-lobby-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby="tl-password-room-title"
        onSubmit={(event) => {
          event.preventDefault();
          submit();
        }}
        onKeyDown={(event) => handleModalKeyDown(event, onClose)}
      >
        <span className="tl-modal-accent" aria-hidden="true" />
        <div id="tl-password-room-title" className="tl-modal-title">
          Bàn của {room.owner}
        </div>
        <div className="tl-field-label">Nhập mật khẩu bàn</div>
        <input
          className="tl-input"
          type="password"
          value={password}
          maxLength={32}
          autoFocus
          onChange={(e) => setPassword(e.target.value)}
        />
        <div className="tl-modal-actions">
          <button type="button" className="tl-btn tl-btn-ghost" onClick={onClose}>
            Hủy
          </button>
          <button type="submit" className="tl-btn tl-btn-gold">
            Vào bàn
          </button>
        </div>
      </form>
    </div>
  );
}

export function LobbyScreen({ assetsReady }: { assetsReady: boolean }) {
  const user = useThirteen((s) => s.user);
  const rooms = useThirteen((s) => s.rooms);
  const queueing = useThirteen((s) => s.queueing);
  const joinQueue = useThirteen((s) => s.joinQueue);
  const leaveQueue = useThirteen((s) => s.leaveQueue);
  const refreshRooms = useThirteen((s) => s.refreshRooms);
  const joinRoom = useThirteen((s) => s.joinRoom);
  const requestExit = useThirteen((s) => s.requestExit);
  const [createOpen, setCreateOpen] = useState(false);
  const [passwordRoom, setPasswordRoom] = useState<RoomInfo | null>(null);

  return (
    <div className="tl-screen tl-lobby">
      <div className="tl-topbar">
        <button type="button" className="tl-icon-btn" onClick={requestExit} aria-label="Thoát">
          <img src={backIcon} alt="" />
        </button>
        <KenPill />
      </div>

      <BrandMark />

      <div className="tl-lobby-actions">
        <button
          type="button"
          className={'tl-play-now' + (queueing ? ' waiting' : '')}
          disabled={!assetsReady}
          onClick={() => (queueing ? leaveQueue() : joinQueue())}
        >
          <span className="tl-play-now-label">{queueing ? 'ĐANG TÌM BÀN...' : 'CHƠI NGAY'}</span>
          <span className="tl-play-now-sub">{queueing ? 'Chạm để hủy tìm' : 'Tự động ghép bàn 4 người'}</span>
        </button>
        <button type="button" className="tl-secondary-btn" onClick={() => setCreateOpen(true)}>
          + Tạo bàn riêng
        </button>
      </div>

      <div className="tl-room-list-header">
        <span>
          Danh sách bàn <b>({rooms.length})</b>
        </span>
        <button type="button" className="tl-icon-btn" onClick={refreshRooms} aria-label="Tải lại">
          <img src={refreshIcon} alt="" />
        </button>
      </div>

      <div className="tl-room-list">
        {rooms.length === 0 && (
          <div className="tl-room-empty">
            <img src={cardsEmptyIcon} alt="" />
            <span>Chưa có bàn nào — hãy tạo bàn đầu tiên!</span>
          </div>
        )}
        {rooms.map((room) => {
          const maxPlayers = room.maxPlayers ?? 4;
          const playing = room.status === 'playing';
          const full = room.players >= maxPlayers;
          const bet = Number.isFinite(room.bet) ? Math.max(0, Math.trunc(room.bet)) : 0;
          const insufficientKen = !playing && !full && bet > (user?.ken ?? 0);
          const unavailable = full || playing || insufficientKen;
          return (
            <div
              key={room.id}
              className={
                'tl-room-row' +
                (full || playing ? ' muted' : '') +
                (playing ? ' is-playing' : '') +
                (full ? ' is-full' : '') +
                (insufficientKen ? ' is-insufficient' : '')
              }
            >
              <span className={`tl-avatar tl-avatar-${avatarTone(room.owner)}`}>
                {(() => {
                  const vipId = parseVipTypeId(room.ownerVipType);
                  return vipId != null ? <img src={vipIconUrl(vipId)} alt="" className="tl-vip-icon" /> : null;
                })()}
                {room.owner.charAt(0).toUpperCase()}
              </span>
              <div className="tl-room-info">
                <span className="tl-room-name">
                  <span className="tl-room-name-text">Bàn của {room.owner}</span>
                  {room.locked && <img className="tl-lock" src={lockIcon} alt="Có mật khẩu" />}
                  {playing && <span className="tl-playing-badge">Đang chơi</span>}
                </span>
                <span className="tl-room-meta">
                  <span className="tl-room-occupancy">
                    <SeatDots players={room.players} maxPlayers={maxPlayers} />
                    <b>
                      {room.players}/{maxPlayers}
                    </b>
                  </span>
                  <span className="tl-room-bet" aria-label={`Cược ${formatKen(bet)} Ken mỗi người`}>
                    <img src={kenIcon} alt="" />
                    <b>{formatKen(bet)}</b>
                  </span>
                </span>
              </div>
              <button
                type="button"
                className={
                  'tl-btn ' +
                  (insufficientKen ? 'tl-btn-insufficient' : unavailable ? 'tl-btn-disabled' : 'tl-btn-gold')
                }
                disabled={unavailable}
                onClick={() => (room.locked ? setPasswordRoom(room) : joinRoom(room))}
              >
                {playing ? 'Đang chơi' : full ? 'Đầy' : insufficientKen ? 'Thiếu Ken' : 'Vào bàn'}
              </button>
            </div>
          );
        })}
      </div>

      {createOpen && <CreateRoomModal onClose={() => setCreateOpen(false)} />}
      {passwordRoom && <PasswordModal room={passwordRoom} onClose={() => setPasswordRoom(null)} />}
    </div>
  );
}
