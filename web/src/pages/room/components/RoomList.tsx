import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import autoJoinIcon from '@/assets/icons/room/ic_action_auto_join_room.png';
import { WordChainRoomIcon } from '../word-chain/components/WordChainRoomIcon';
import type { RoomListItem } from '../types';
import { RoomRow } from './RoomRow';

interface RoomListProps {
  rooms: RoomListItem[];
  joinedRoomId: string | null;
  onEnter: (room: RoomListItem) => void;
  onAroundYou: () => void;
  onQuickJoin: () => void;
  onWordChain: () => void;
  showQuickJoin: boolean;
  showWordChain: boolean;
}

function SectionHeader({ label }: { label: string }) {
  return (
    <li className="bg-ola-surface/80 px-4 py-1.5 text-xs font-medium tracking-wide text-black/54 uppercase">
      {label}
    </li>
  );
}

function SpecialRow({
  icon,
  title,
  subtitle,
  onClick,
  bareIcon = false,
}: {
  icon: ReactNode;
  title: string;
  subtitle: string;
  onClick: () => void;
  bareIcon?: boolean;
}) {
  return (
    <li>
      <button
        type="button"
        onClick={onClick}
        className="flex w-full items-center gap-2 border-b border-black/12 bg-white/80 px-4 py-3 text-left"
      >
        <span
          className={`flex h-16 w-16 shrink-0 items-center justify-center text-3xl ${
            bareIcon ? '' : 'rounded bg-ola-primary-light'
          }`}
        >
          {icon}
        </span>
        <span className="min-w-0 flex-1 pl-2">
          <span className="block truncate text-base text-black/87">
            {title}
          </span>
          <span className="mt-1 block truncate text-sm text-black/54">
            {subtitle}
          </span>
        </span>
      </button>
    </li>
  );
}

export function RoomList({
  rooms,
  joinedRoomId,
  onEnter,
  onQuickJoin,
  onWordChain,
  showQuickJoin,
  showWordChain,
}: RoomListProps) {
  const { t } = useTranslation();
  return (
    <ul>
      {showQuickJoin && (
        <SpecialRow
          icon={
            <img
              src={autoJoinIcon}
              alt=""
              className="h-14 w-14 object-contain"
            />
          }
          title={t('room.quickJoin')}
          subtitle={t('room.quickJoinDesc')}
          onClick={onQuickJoin}
        />
      )}
      {showWordChain && (
        <SpecialRow
          icon={<WordChainRoomIcon className="h-16 w-16" />}
          bareIcon
          title={t('wordChain.entryTitle')}
          subtitle={t('wordChain.entryDesc')}
          onClick={onWordChain}
        />
      )}

      <SectionHeader label={t('room.sectionPublic')} />

      {rooms.map((room) => (
        <RoomRow
          key={room.id}
          room={room}
          joined={room.id === joinedRoomId}
          onEnter={onEnter}
        />
      ))}
    </ul>
  );
}
