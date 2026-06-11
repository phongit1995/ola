import { useTranslation } from 'react-i18next';
import type { RoomMember } from '@app-types';
import { Avatar } from '../../chat/components/Avatar';
import { colorForName } from '../avatarColor';

interface RoomMembersTabProps {
  members: RoomMember[];
  active: boolean;
}

export function RoomMembersTab({ members, active }: RoomMembersTabProps) {
  const { t } = useTranslation();

  return (
    <div className={`relative flex-1 overflow-y-auto bg-white ${active ? '' : 'hidden'}`}>
      {members.length === 0 ? (
        <p className="px-4 py-6 text-center text-sm text-black/54">{t('room.noMembers')}</p>
      ) : (
        <ul>
          {members.map((member) => {
            const name = member.fullName ?? member.username;
            return (
              <li
                key={member.userId}
                className="flex items-center gap-2 border-b border-black/12 px-4 py-3"
              >
                {member.avatar ? (
                  <img
                    src={member.avatar}
                    alt=""
                    className="h-10 w-10 shrink-0 rounded-full object-cover"
                  />
                ) : (
                  <Avatar name={name} color={colorForName(name)} />
                )}
                <span className="min-w-0 flex-1 truncate text-base text-black/87">{name}</span>
                <span className="shrink-0 text-xs text-ola-primary">{t('chat.online')}</span>
              </li>
            );
          })}
        </ul>
      )}
    </div>
  );
}
