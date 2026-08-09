import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import autoJoinIcon from '@/assets/icons/room/ic_action_auto_join_room.png';
import type { RoomListItem } from '../types';
import { RoomRow } from './RoomRow';

interface RoomListProps {
  rooms: RoomListItem[];
  joinedRoomId: string | null;
  onEnter: (room: RoomListItem) => void;
  onAroundYou: () => void;
  onQuickJoin: () => void;
  showQuickJoin: boolean;
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
  showQuickJoin,
}: RoomListProps) {
  const { t } = useTranslation();
  return (
    <ul>
      {/* Banner VIP tạm ẩn theo yêu cầu — bật lại: bỏ comment + thêm lại prop onBuyVip
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
      */}
      {/* "Xung quanh bạn" tạm ẩn theo yêu cầu — bật lại: bỏ comment + thêm lại prop onAroundYou vào destructure
      <SpecialRow
        icon="📍"
        title={t('room.aroundYou')}
        subtitle={t('room.aroundYouDesc')}
        onClick={onAroundYou}
      />
      */}
      {showQuickJoin && (
        <SpecialRow
          icon={
            <img
              src={autoJoinIcon}
              alt=""
              className="h-12 w-12 object-contain"
            />
          }
          title={t('room.quickJoin')}
          subtitle={t('room.quickJoinDesc')}
          onClick={onQuickJoin}
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
