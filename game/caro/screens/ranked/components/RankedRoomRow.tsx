import type { RoomInfo } from '../../../../src/sdk';
import { assetSrc } from '../../../assets';
import { formatKen } from '../../../helpers/format';
import { avatarIconSrc } from '../../../helpers/player';

interface RankedRoomRowProps {
  room: RoomInfo;
  top: number;
  height: number;
  onJoin: (room: RoomInfo) => void;
}

export function RankedRoomRow({ room, top, height, onJoin }: RankedRoomRowProps) {
  return (
    <div
      className={'ranked-row' + (room.full ? ' full' : '')}
      style={{ top: `${top}%`, height: `${height}%` }}
      onClick={room.full ? undefined : () => onJoin(room)}
    >
      <span className="rr-owner">
        <img src={avatarIconSrc(room.ownerVipType)} alt="" className="rr-vip" />
        <span className="rr-owner-name">@{room.owner}</span>
      </span>
      <span className="rr-bet">{formatKen(room.bet)}</span>
      <span className="rr-join">
        {room.locked && <img src={assetSrc('rankedLock')} alt="" className="rr-lock" />}
        <span
          className="rr-badge"
          style={{ backgroundImage: `url('${assetSrc(room.full ? 'rankedSlotFull' : 'rankedSlotOpen')}')` }}
        >
          {room.players}/2
        </span>
      </span>
    </div>
  );
}
