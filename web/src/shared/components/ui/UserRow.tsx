import type { ReactNode } from 'react';
import { Avatar } from './Avatar';
import { PresenceBadge } from './PresenceBadge';
import { UserName } from './UserName';

interface UserRowProps {
  name: string;
  username?: string;
  fullName?: string;
  avatar?: string;
  color: string;
  online?: boolean;
  deviceIcon?: string;
  layout?: 'stacked' | 'inline';
  rounded?: boolean;
  onClick?: () => void;
  trailing?: ReactNode;
}

export function UserRow({
  name,
  username,
  fullName,
  avatar,
  color,
  online = false,
  deviceIcon,
  layout = 'stacked',
  rounded = true,
  onClick,
  trailing,
}: UserRowProps) {
  const content = (
    <>
      <span className="relative shrink-0">
        <Avatar name={name} color={color} src={avatar} size={40} rounded={rounded} />
        {online && <PresenceBadge icon={deviceIcon} className="absolute right-0 bottom-0" />}
      </span>
      {layout === 'inline' ? (
        <span className="min-w-0 flex-1">
          <UserName name={name} fullName={fullName} fullNameClassName="text-black/54" />
        </span>
      ) : (
        <span className="min-w-0 flex-1">
          <span className="block truncate text-base text-black/87">{name}</span>
          {username != null && username !== '' && (
            <span className="block truncate text-xs text-black/54">@{username}</span>
          )}
        </span>
      )}
    </>
  );

  return (
    <div className="flex items-center gap-3 py-2">
      {onClick != null ? (
        <button
          type="button"
          onClick={onClick}
          className="flex min-w-0 flex-1 items-center gap-3 text-left"
        >
          {content}
        </button>
      ) : (
        <div className="flex min-w-0 flex-1 items-center gap-3">{content}</div>
      )}
      {trailing}
    </div>
  );
}
