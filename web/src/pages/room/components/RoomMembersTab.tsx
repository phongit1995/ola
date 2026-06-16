import { useTranslation } from 'react-i18next';
import maleIcon from '@/assets/icons/chat/ic_indicate_male.png';
import femaleIcon from '@/assets/icons/chat/ic_indicate_female.png';
import type { RoomMember } from '@app-types';
import { Avatar } from '@components';
import { colorForName } from '@lib';

interface RoomMembersTabProps {
  members: RoomMember[];
  active: boolean;
  onOpenProfile?: (nick: string, color: string) => void;
}

function GenderIcon({ gender }: { gender: RoomMember['gender'] }) {
  if (gender == null) return null;
  return (
    <img
      src={gender === 'female' ? femaleIcon : maleIcon}
      alt=""
      className="h-4 w-4 shrink-0 object-contain"
    />
  );
}

export function RoomMembersTab({ members, active, onOpenProfile }: RoomMembersTabProps) {
  const { t } = useTranslation();

  return (
    <div className={`relative flex-1 overflow-y-auto bg-white ${active ? '' : 'hidden'}`}>
      {members.length === 0 ? (
        <p className="px-4 py-6 text-center text-sm text-black/54">{t('room.noMembers')}</p>
      ) : (
        <ul>
          {members.map((member) => {
            const name = member.username;
            const color = colorForName(name);
            return (
              <li key={member.userId} className="border-b border-black/12">
                <button
                  type="button"
                  onClick={() => onOpenProfile?.(name, color)}
                  className="flex w-full items-center gap-2 px-4 py-3 text-left hover:bg-black/[0.03]"
                >
                  {member.avatar ? (
                    <img
                      src={member.avatar}
                      alt=""
                      className="h-10 w-10 shrink-0 rounded-full object-cover"
                    />
                  ) : (
                    <Avatar name={name} color={color} />
                  )}
                  <div className="flex min-w-0 flex-1 flex-col">
                    <span className="flex items-center gap-1 text-base text-black/87">
                      <span className="truncate">{name}</span>
                      <GenderIcon gender={member.gender} />
                    </span>
                    {member.bio ? (
                      <span className="truncate text-xs text-black/54">{member.bio}</span>
                    ) : null}
                  </div>
                  <span className="shrink-0 text-xs text-ola-primary">{t('chat.online')}</span>
                </button>
              </li>
            );
          })}
        </ul>
      )}
    </div>
  );
}
