import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import autoJoinIcon from '@/assets/icons/room/ic_action_auto_join_room.png';
import membersIcon from '@/assets/icons/room/ic_indicate_privacy_friends.png';
import type { Room } from '../types';

interface RoomListProps {
  rooms: Room[];
  joinedRoomId: string | null;
  onEnter: (room: Room) => void;
  onQuit: (room: Room) => void;
  onAroundYou: () => void;
  onQuickJoin: () => void;
  onBuyVip: () => void;
}

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

function SectionHeader({ label }: { label: string }) {
  return (
    <li className="bg-[#f3f3f3] px-4 py-1.5 text-xs font-medium tracking-wide text-black/54 uppercase">
      {label}
    </li>
  );
}

function SpecialRow({
  icon,
  title,
  subtitle,
  onClick,
}: {
  icon: ReactNode;
  title: string;
  subtitle: string;
  onClick: () => void;
}) {
  return (
    <li>
      <button
        type="button"
        onClick={onClick}
        className="flex w-full items-center gap-2 border-b border-black/12 bg-white/80 px-4 py-3 text-left"
      >
        <span className="flex h-16 w-16 shrink-0 items-center justify-center rounded bg-ola-primary-light text-3xl">
          {icon}
        </span>
        <span className="min-w-0 flex-1 pl-2">
          <span className="block truncate text-base text-black/87">{title}</span>
          <span className="mt-1 block truncate text-sm text-black/54">{subtitle}</span>
        </span>
      </button>
    </li>
  );
}

export function RoomList({
  rooms,
  joinedRoomId,
  onEnter,
  onQuit,
  onAroundYou,
  onQuickJoin,
  onBuyVip,
}: RoomListProps) {
  const { t } = useTranslation();
  return (
    <ul>
      <li className="flex items-center justify-between gap-3 border-b border-black/12 bg-[#fff8e1] px-4 py-3">
        <span className="min-w-0">
          <span className="block text-sm font-medium text-black/87">
            {t('room.warningVipTitle')}
          </span>
          <span className="block text-xs text-black/54">
            {t('room.warningVipBody')}
          </span>
        </span>
        <button
          type="button"
          onClick={onBuyVip}
          className="shrink-0 rounded-sm bg-amber-400 px-3 py-1.5 text-sm font-medium text-white"
        >
          {t('room.buyVip')}
        </button>
      </li>

      <SpecialRow
        icon="📍"
        title={t('room.aroundYou')}
        subtitle={t('room.aroundYouDesc')}
        onClick={onAroundYou}
      />
      <SpecialRow
        icon={<img src={autoJoinIcon} alt="" className="h-12 w-12 object-contain" />}
        title={t('room.quickJoin')}
        subtitle={t('room.quickJoinDesc')}
        onClick={onQuickJoin}
      />

      <SectionHeader label={t('room.sectionPublic')} />

      {rooms.map((room) => {
        const joined = room.id === joinedRoomId;
        return (
          <li
            key={room.id}
            className={`group flex items-center gap-2 border-b border-black/12 px-4 py-3 ${
              joined ? 'bg-ola-primary-light' : 'bg-white/80'
            }`}
          >
            <button
              type="button"
              onClick={() => onEnter(room)}
              className="flex min-w-0 flex-1 items-center gap-2 text-left"
            >
              <span
                className="flex h-16 w-16 shrink-0 items-center justify-center rounded text-2xl font-medium text-white shadow"
                style={{ backgroundColor: room.color }}
              >
                {room.title.charAt(0).toUpperCase()}
              </span>
              <span className="min-w-0 flex-1 pl-2">
                <span className="block truncate text-base text-black/87">{room.title}</span>
                <span className="mt-1 block truncate text-sm text-black/54">{room.subtitle}</span>
              </span>
            </button>
            {joined ? (
              <button
                type="button"
                onClick={() => onQuit(room)}
                className="shrink-0 rounded-sm border border-black/12 px-2 py-1 text-xs text-[#dd4b39] opacity-0 transition group-hover:opacity-100 focus:opacity-100"
              >
                {t('room.quit')}
              </button>
            ) : (
              <MembersBadge members={room.members} />
            )}
          </li>
        );
      })}
    </ul>
  );
}
