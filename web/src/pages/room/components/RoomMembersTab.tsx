import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import maleIcon from '@/assets/icons/chat/ic_indicate_male.png';
import femaleIcon from '@/assets/icons/chat/ic_indicate_female.png';
import androidIcon from '@/assets/icons/me/ic_indicate_android.png';
import type { RoomMember } from '@app-types';
import { Avatar } from '@components';
import { colorForName, vipIconUrl } from '@lib';
import { MediaViewer } from '../../me/components/MediaViewer';

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

function DeviceBadge() {
  return (
    <span className="absolute -bottom-0.5 -right-0.5 flex h-4 w-4 items-center justify-center rounded-full border border-white bg-white">
      <img src={androidIcon} alt="" className="h-3 w-3 object-contain" />
    </span>
  );
}

export function RoomMembersTab({ members, active, onOpenProfile }: RoomMembersTabProps) {
  const { t } = useTranslation();
  const [previewImage, setPreviewImage] = useState<string | null>(null);

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
                    {member.avatar ? (
                      <img
                        src={member.avatar}
                        alt=""
                        className="h-10 w-10 rounded-full object-cover"
                      />
                    ) : (
                      <Avatar name={member.username} color={color} />
                    )}
                    <DeviceBadge />
                  </span>
                  <div className="flex min-w-0 flex-1 flex-col">
                    <span className="flex min-w-0 items-center gap-1 text-base">
                      {member.vipTypeId != null && (
                        <img
                          src={vipIconUrl(member.vipTypeId)}
                          alt=""
                          className="h-4 w-4 shrink-0 object-contain"
                        />
                      )}
                      <span className="min-w-0 truncate">
                        <span className="text-black/87">{member.username}</span>
                        {subName ? <span className="text-black/54"> · {subName}</span> : null}
                      </span>
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
                        setPreviewImage(member.bioImage!);
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
      {previewImage != null && (
        <MediaViewer photos={[previewImage]} index={0} onClose={() => setPreviewImage(null)} />
      )}
    </div>
  );
}
