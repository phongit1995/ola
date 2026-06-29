import { useRef } from 'react';
import { Avatar, PresenceBadge, UserName, VipBadge } from '@components';
import type { Contact } from '../types';
import birthdayIcon from '@/assets/icons/chat/ic_buddy_birthday.png';
import { DEVICE_ICONS } from '../constants';

interface BuddyRowProps {
  contact: Contact;
  highlight: boolean;
  onSelect: () => void;
  onOpenProfile: () => void;
  onLongPress: () => void;
  onPreviewImage?: (url: string) => void;
}

export function BuddyRow({
  contact,
  highlight,
  onSelect,
  onOpenProfile,
  onLongPress,
  onPreviewImage,
}: BuddyRowProps) {
  const timer = useRef<number | undefined>(undefined);
  const longPressed = useRef(false);
  const showVip = contact.online && contact.vip;
  const badge =
    contact.group === 'birthday'
      ? birthdayIcon
      : contact.online
        ? DEVICE_ICONS[contact.deviceType]
        : null;

  function startPress() {
    longPressed.current = false;
    timer.current = window.setTimeout(() => {
      longPressed.current = true;
      onLongPress();
    }, 450);
  }

  function cancelPress() {
    window.clearTimeout(timer.current);
  }

  function handleClick() {
    if (longPressed.current) {
      longPressed.current = false;
      return;
    }
    onSelect();
  }

  function openProfile(event: { stopPropagation: () => void }) {
    event.stopPropagation();
    if (longPressed.current) {
      longPressed.current = false;
      return;
    }
    onOpenProfile();
  }

  return (
    <li>
      <div
        onClick={handleClick}
        onPointerDown={startPress}
        onPointerUp={cancelPress}
        onPointerLeave={cancelPress}
        onContextMenu={(event) => {
          event.preventDefault();
          onLongPress();
        }}
        className={`flex w-full cursor-pointer items-center border-b border-black/12 px-4 py-3 text-left ${
          highlight ? 'bg-[#f1f8e9]' : 'bg-white/80'
        }`}
      >
        <button
          type="button"
          onClick={openProfile}
          aria-label={contact.name}
          className="relative h-10 w-10 shrink-0"
        >
          <span className="block h-10 w-10 overflow-hidden rounded">
            <Avatar name={contact.name} color={contact.color} src={contact.avatar} rounded={false} />
          </span>
          {badge != null && <PresenceBadge icon={badge} className="absolute right-0 bottom-0" />}
        </button>
        <span className="ml-4 min-w-0 flex-1">
          <button type="button" onClick={openProfile} className="flex items-center gap-1 text-left">
            {showVip && <VipBadge typeId={contact.vipTypeId} />}
            <UserName name={contact.name} fullName={contact.fullName} />
          </button>
          {contact.status != null && contact.status !== '' && (
            <span className="block truncate text-xs text-black/54">{contact.status}</span>
          )}
        </span>
        {!contact.online && contact.lastActive != null && contact.lastActive !== '' && (
          <span className="ml-2 shrink-0 text-xs text-black/54">{contact.lastActive}</span>
        )}
        {contact.statusImage != null && contact.statusImage !== '' && (
          <img
            src={contact.statusImage}
            alt=""
            onClick={(event) => {
              event.stopPropagation();
              onPreviewImage?.(contact.statusImage!);
            }}
            className="ml-2 h-10 w-10 shrink-0 cursor-pointer rounded border border-black/12 object-cover"
          />
        )}
      </div>
    </li>
  );
}
