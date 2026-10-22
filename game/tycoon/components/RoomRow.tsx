import kenUrl from '../assets/lobby/ill-ken.webp';
import { formatKen } from '../helpers/format';
import { avatarIconUrl } from '../helpers/player';
import { roomAction, roomSeatsLabel, type TycoonRoom } from '../helpers/room';
import { RoomIcon } from './RoomIcon';

interface RoomRowProps {
  room: TycoonRoom;
  pendingId: string | null;
  onJoin: (room: TycoonRoom) => void;
  onWatch: (room: TycoonRoom) => void;
}

export function RoomRow({ room, pendingId, onJoin, onWatch }: RoomRowProps) {
  const action = roomAction(room);
  const busy = pendingId === room.id;
  const blocked = pendingId != null && !busy;
  const owner = `@${room.owner}`;

  return (
    <li className={action === 'full' ? 'ty-room-row ty-room-row-full' : 'ty-room-row'}>
      <span className="ty-room-owner">
        <img className="ty-room-avatar" src={avatarIconUrl(room.ownerVipType)} alt="" draggable={false} />
        <span className="ty-room-name">{owner}</span>
        {room.locked ? (
          <>
            <RoomIcon name="lock-gold" className="ty-room-lock" />
            <span className="ty-visually-hidden">, bàn khóa</span>
          </>
        ) : null}
      </span>
      <span className="ty-room-bet">
        {room.bet > 0 ? (
          <>
            <img src={kenUrl} alt="" draggable={false} />
            <b>{formatKen(room.bet)}</b>
            <span className="ty-visually-hidden"> KEN</span>
          </>
        ) : (
          <span className="ty-room-free">Giao lưu</span>
        )}
      </span>
      <span className={action === 'join' ? 'ty-room-seats' : 'ty-room-seats ty-room-seats-off'}>
        {roomSeatsLabel(room)}
        <span className="ty-visually-hidden"> chỗ</span>
      </span>
      <span className="ty-room-cell-act">
        {action === 'join' ? (
          <button
            type="button"
            className="ty-btn ty-btn-gold ty-room-act"
            aria-label={`Tham gia bàn của ${owner}`}
            disabled={blocked}
            aria-busy={busy || undefined}
            aria-disabled={busy || undefined}
            onClick={() => onJoin(room)}
          >
            Tham gia
          </button>
        ) : null}
        {action === 'full' ? (
          <button type="button" className="ty-btn ty-room-act ty-room-act-off" aria-label={`Bàn của ${owner} đã đủ người`} disabled>
            Tham gia
          </button>
        ) : null}
        {action === 'watch' ? (
          <button
            type="button"
            className="ty-btn ty-btn-paper ty-room-act"
            aria-label={`Xem bàn của ${owner}`}
            disabled={blocked}
            aria-busy={busy || undefined}
            aria-disabled={busy || undefined}
            onClick={() => onWatch(room)}
          >
            Xem
          </button>
        ) : null}
        {action === 'playing' ? <span className="ty-room-playing">Đang chơi</span> : null}
      </span>
    </li>
  );
}
