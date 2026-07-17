import { useTranslation } from 'react-i18next';
import maleIcon from '@/assets/icons/chat/ic_indicate_male.png';
import femaleIcon from '@/assets/icons/chat/ic_indicate_female.png';
import type { RoomMember } from '@app-types';
import { DEVICE_ICONS, normalizeDevice } from '@constants';
import { PresenceBadge, UserName, VipAvatar } from '@components';
import { colorForName } from '@lib';
import { useMediaViewerStore } from '@/store/mediaViewerStore';

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
  const openViewer = useMediaViewerStore((s) => s.openViewer);

  return (
    <div className={`relative flex-1 overflow-y-auto bg-white ${active ? '' : 'hidden'}`}>
      {members.length === 0 ? (
        <p className="px-4 py-6 text-center text-sm text-black/54">{t('room.noMembers')}</p>
      ) : (
        <ul>
          {members.map((member) => {
            const color = colorForName(member.username);
            const subName =
              member.fullName && member.fullName !== '' && member.fullName !== member.username
                ? member.fullName
                : null;
            return (
              <li key={member.userId} className="border-b border-black/12">
                <button
                  type="button"
                  onClick={() => onOpenProfile?.(member.username, color)}
                  className="flex w-full items-center gap-2 px-4 py-3 text-left hover:bg-black/[0.03]"
                >
                  <GenderIcon gender={member.gender} />
                  <span className="relative h-10 w-10 shrink-0">
                    <VipAvatar typeId={member.vipTypeId} className="h-10 w-10" />
                    <PresenceBadge
                      icon={DEVICE_ICONS[normalizeDevice(member.deviceType)]}
                      className="absolute -right-0.5 -bottom-0.5"
                    />
                  </span>
                  <div className="flex min-w-0 flex-1 flex-col">
                    <span className="flex min-w-0 items-center gap-1 text-base">
                      <UserName
                        name={member.username}
                        fullName={subName ?? undefined}
                        className="min-w-0 truncate text-black/87"
                        fullNameClassName="text-black/54"
                      />
                    </span>
                    {member.bio ? (
                      <span className="truncate text-xs text-black/54">{member.bio}</span>
                    ) : null}
                  </div>
                  {member.bioImage != null && member.bioImage !== '' && (
                    <img
                      src={member.bioImage}
                      alt=""
                      onClick={(event) => {
                        event.stopPropagation();
                        openViewer([member.bioImage!]);
                      }}
                      className="ml-1 h-10 w-10 shrink-0 cursor-pointer rounded border border-black/12 object-cover"
                    />
                  )}
                </button>
              </li>
            );
          })}
        </ul>
      )}
    </div>
  );
}
