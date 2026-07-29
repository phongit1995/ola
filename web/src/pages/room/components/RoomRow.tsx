import membersIcon from '@/assets/icons/room/ic_indicate_privacy_friends.png';
import type { RoomListItem } from '../types';

function MembersBadge({ members }: { members: number }) {
  const display = members >= 200 ? '200+' : String(members);
  const color =
    members >= 200
      ? 'text-ola-accent'
      : members >= 100
      ? 'text-black/54'
      : 'text-black/26';
  return (
    <span className={`flex shrink-0 items-center gap-1 text-sm ${color}`}>
      <img src={membersIcon} alt="" className="h-4 w-4 object-contain" />
      {display}
    </span>
  );
}

interface RoomRowProps {
  room: RoomListItem;
  joined: boolean;
  onEnter: (room: RoomListItem) => void;
}

export function RoomRow({ room, joined, onEnter }: RoomRowProps) {
  return (
    <li
      className={`flex items-center gap-2 border-b border-black/12 px-4 py-3 ${
        joined ? 'bg-ola-primary-light' : 'bg-white/80'
      }`}
    >
      <button
        type="button"
        onClick={() => onEnter(room)}
        className="flex min-w-0 flex-1 items-center gap-2 text-left"
      >
        {room.imageUrl ? (
          <img
            src={room.imageUrl}
            alt=""
            className="h-16 w-16 shrink-0 rounded object-cover shadow"
          />
        ) : (
          <span
            className="flex h-16 w-16 shrink-0 items-center justify-center rounded text-2xl font-medium text-white shadow"
            style={{ backgroundColor: room.color }}
          >
            {room.title.charAt(0).toUpperCase()}
          </span>
        )}
        <span className="min-w-0 flex-1 pl-2">
          <span className="block truncate text-base text-black/87">
            {room.title}
          </span>
          <span className="mt-1 block truncate text-sm text-black/54">
            {room.subtitle}
          </span>
        </span>
      </button>
      <MembersBadge members={room.members} />
    </li>
  );
}
