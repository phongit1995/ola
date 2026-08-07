import { useTranslation } from 'react-i18next';
import { Avatar, UserName, VipIcon } from '@components';
import { GENDER } from '@constants';
import { activeVipTypeId, daysSince, monthsSince, yearsSince } from '@lib';
import checkedIcon from '@/assets/icons/profile/ic_checked.png';
import maleIcon from '@/assets/icons/profile/ic_indicate_male.png';
import femaleIcon from '@/assets/icons/profile/ic_indicate_female.png';
import type { PublicProfile } from '@app-types';

interface PeerProfileCardProps {
  profile: PublicProfile;
  name: string;
  color: string;
  avatar?: string;
  onHide: () => void;
  onBlock: () => void;
  friendLabel: string;
  onFriendAction: () => void;
  onShowAvatar?: () => void;
}

export function PeerProfileCard({
  profile,
  name,
  color,
  avatar,
  onHide,
  onBlock,
  friendLabel,
  onFriendAction,
  onShowAvatar,
}: PeerProfileCardProps) {
  const { t } = useTranslation();
  const vipTypeId = activeVipTypeId(profile.vipUsed, profile.vipEndTime);
  const cover = profile.coverPhoto ?? '';
  const years = yearsSince(profile.createdAt);
  const months = monthsSince(profile.createdAt);
  const days = daysSince(profile.createdAt);
  const joinedText =
    years >= 1
      ? t('chat.joinedOlaYears', { n: years })
      : months >= 1
      ? t('chat.joinedOlaMonths', { n: months })
      : days >= 1
      ? t('chat.joinedOlaDays', { n: days })
      : t('chat.joinedOlaToday');
  const genderIcon =
    profile.gender === GENDER.female ? femaleIcon : maleIcon;
  const avatarUrl = profile.avatar ?? avatar ?? '';

  const avatarEl = (
    <Avatar
      name={name}
      color={color}
      src={avatarUrl}
      size={56}
      rounded={false}
    />
  );

  return (
    <div className="-mx-2 mt-2 border-y border-black/12 bg-white">
      <div
        className="bg-ola-primary-light bg-cover bg-center"
        style={cover !== '' ? { backgroundImage: `url(${cover})` } : undefined}
      >
        <div className="flex min-h-32 items-end gap-2 bg-white/60 p-2">
          {avatarUrl !== '' && onShowAvatar != null ? (
            <button
              type="button"
              onClick={onShowAvatar}
              className="leading-none"
            >
              {avatarEl}
            </button>
          ) : (
            avatarEl
          )}
          <div className="min-w-0 flex-1">
            <div className="flex items-center gap-1">
              <VipIcon typeId={vipTypeId} className="h-6 w-6" />
              <UserName
                name={name}
                fullName={profile.fullName}
                className="min-w-0 truncate text-base text-black/87"
                fullNameClassName="text-black/54"
              />
              {profile.verified && (
                <img
                  src={checkedIcon}
                  alt=""
                  className="h-3 w-3 object-contain"
                />
              )}
            </div>
            <div className="mt-1 flex items-center gap-1 text-xs text-black/54">
              <img
                src={genderIcon}
                alt=""
                className="h-3.5 w-3.5 shrink-0 object-contain"
              />
              <span className="truncate">{joinedText}</span>
            </div>
            <p className="mt-1 truncate text-xs text-black/54">
              {t('chat.fanCount', { n: profile.followerCount })}
            </p>
            <p className="mt-1 truncate text-xs text-black/54">
              {t('chat.antiCount', { n: profile.antiCount ?? 0 })}
            </p>
            {profile.bio != null && profile.bio !== '' && (
              <p className="mt-2 line-clamp-3 text-sm text-black/87">
                {profile.bio}
              </p>
            )}
          </div>
        </div>
      </div>

      <div className="flex items-center gap-4 p-2">
        <button
          type="button"
          onClick={onHide}
          className="rounded-sm border border-black/12 bg-white px-3 py-1 text-sm uppercase text-black/54"
        >
          {t('chat.hide')}
        </button>
        <button
          type="button"
          onClick={onBlock}
          className="rounded-sm border border-black/12 bg-white px-3 py-1 text-sm uppercase text-black/54"
        >
          {t('chat.block')}
        </button>
        <div className="flex-1" />
        <button
          type="button"
          onClick={onFriendAction}
          className="rounded-sm border border-ola-primary-dark bg-ola-button px-3 py-1 text-sm text-white"
        >
          {friendLabel}
        </button>
      </div>
    </div>
  );
}
