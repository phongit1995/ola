import { useState } from 'react';
import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';
import type { RoomInfo } from '../../../src/sdk';
import { useThirteen } from '../../store/useThirteen';

function KenPill() {
  const user = useThirteen((s) => s.user);
  if (!user) return null;
  return (
    <div className="tl-ken-pill">
      <span className="tl-avatar tl-avatar-sm">{user.username.charAt(0).toUpperCase()}</span>
      <span className="tl-ken-amount">{user.ken.toLocaleString('vi-VN')}</span>
      <span className="tl-ken-coin" />
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
  const [capacity, setCapacity] = useState(4);
  const [password, setPassword] = useState('');
  return (
    <div className="tl-modal-backdrop" onClick={(e) => e.target === e.currentTarget && onClose()}>
      <div className="tl-modal">
        <div className="tl-modal-title">Tạo bàn mới</div>
        <div className="tl-field-label">Số người chơi</div>
        <div className="tl-capacity-row">
          {[2, 3, 4].map((n) => (
            <button
              key={n}
              type="button"
              className={'tl-capacity-btn' + (capacity === n ? ' active' : '')}
              onClick={() => setCapacity(n)}
            >
              {n} người
            </button>
          ))}
        </div>
        <div className="tl-field-label">Mật khẩu (bỏ trống nếu công khai)</div>
        <input
          className="tl-input"
          value={password}
          maxLength={32}
          placeholder="Không đặt mật khẩu"
          onChange={(e) => setPassword(e.target.value)}
        />
        <div className="tl-modal-actions">
          <button type="button" className="tl-btn tl-btn-ghost" onClick={onClose}>
            Hủy
          </button>
          <button
            type="button"
            className="tl-btn tl-btn-gold"
            onClick={() => {
              createRoom(capacity, password.trim());
              onClose();
            }}
          >
            Tạo bàn
          </button>
        </div>
      </div>
    </div>
  );
}

function PasswordModal({ room, onClose }: { room: RoomInfo; onClose: () => void }) {
  const joinRoom = useThirteen((s) => s.joinRoom);
  const [password, setPassword] = useState('');
  return (
    <div className="tl-modal-backdrop" onClick={(e) => e.target === e.currentTarget && onClose()}>
      <div className="tl-modal">
        <div className="tl-modal-title">Bàn của {room.owner}</div>
        <div className="tl-field-label">Nhập mật khẩu bàn</div>
        <input
          className="tl-input"
          type="password"
          value={password}
          maxLength={32}
          autoFocus
          onChange={(e) => setPassword(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === 'Enter') {
              joinRoom(room, password);
              onClose();
            }
          }}
        />
        <div className="tl-modal-actions">
          <button type="button" className="tl-btn tl-btn-ghost" onClick={onClose}>
            Hủy
          </button>
          <button
            type="button"
            className="tl-btn tl-btn-gold"
            onClick={() => {
              joinRoom(room, password);
              onClose();
            }}
          >
            Vào bàn
          </button>
        </div>
      </div>
    </div>
  );
}

export function LobbyScreen({ assetsReady }: { assetsReady: boolean }) {
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
          ←
        </button>
        <KenPill />
      </div>

      <div className="tl-logo">
        <div className="tl-logo-main">TIẾN LÊN</div>
        <div className="tl-logo-sub">MIỀN NAM</div>
      </div>

      <div className="tl-lobby-actions">
        <button
          type="button"
          className={'tl-play-now' + (queueing ? ' waiting' : '')}
          disabled={!assetsReady}
          onClick={() => (queueing ? leaveQueue() : joinQueue())}
        >
          <span className="tl-play-now-label">{queueing ? 'ĐANG TÌM BÀN...' : 'CHƠI NGAY'}</span>
          <span className="tl-play-now-sub">
            {queueing ? 'Chạm để hủy tìm' : 'Tự động ghép bàn 4 người'}
          </span>
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
          ⟳
        </button>
      </div>

      <div className="tl-room-list">
        {rooms.length === 0 && <div className="tl-room-empty">Chưa có bàn nào — hãy tạo bàn đầu tiên!</div>}
        {rooms.map((room) => {
          const maxPlayers = room.maxPlayers ?? 4;
          const playing = room.status === 'playing';
          const full = room.players >= maxPlayers;
          return (
            <div key={room.id} className={'tl-room-row' + (full || playing ? ' muted' : '')}>
              <span className="tl-avatar">
                {(() => {
                  const vipId = parseVipTypeId(room.ownerVipType);
                  return vipId != null ? <img src={vipIconUrl(vipId)} alt="" className="tl-vip-icon" /> : null;
                })()}
                {room.owner.charAt(0).toUpperCase()}
              </span>
              <div className="tl-room-info">
                <span className="tl-room-name">
                  Bàn của {room.owner}
                  {room.locked && <span className="tl-lock">🔒</span>}
                  {playing && <span className="tl-playing-badge">Đang chơi</span>}
                </span>
                <span className="tl-room-meta">
                  <SeatDots players={room.players} maxPlayers={maxPlayers} />
                  <b>
                    {room.players}/{maxPlayers}
                  </b>
                </span>
              </div>
              <button
                type="button"
                className={'tl-btn ' + (full || playing ? 'tl-btn-disabled' : 'tl-btn-gold')}
                disabled={full || playing}
                onClick={() => (room.locked ? setPasswordRoom(room) : joinRoom(room))}
              >
                {playing ? 'Đang chơi' : full ? 'Đầy' : 'Vào bàn'}
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
