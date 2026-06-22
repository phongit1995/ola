import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ListOptionDialog, type ListOption } from '@components';
import { toast } from '@lib';
import type { RelationshipInfo } from '@app-types';
import type { ProfileActions } from '../types';
import addFriendIcon from '@/assets/icons/profile/ic_add_friend_black_disable.png';
import friendsActiveIcon from '@/assets/icons/profile/ic_state_friends.png';
import followIcon from '@/assets/icons/profile/ic_follow_black_disable.png';
import followingActiveIcon from '@/assets/icons/profile/ic_state_following.png';
import editIcon from '@/assets/icons/profile/ic_edit_profile_gray.png';
import postMeIcon from '@/assets/icons/profile/ic_post_me_gray.png';
import moreIcon from '@/assets/icons/profile/ic_more_horizon_black_disable.png';

interface RelationButtonsProps {
  nick: string;
  isSelf: boolean;
  onPostMe: () => void;
  onUpdateInfo: () => void;
  onChangeCover: () => void;
  relationship: RelationshipInfo;
  actions: ProfileActions;
}

function RelationButton({
  icon,
  label,
  active,
  onClick,
}: {
  icon: string;
  label: string;
  active?: boolean;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={`flex flex-1 flex-col items-center gap-1 py-1 text-xs ${
        active ? 'text-ola-primary' : 'text-black/26'
      }`}
    >
      <img src={icon} alt="" className="h-5 w-5 object-contain" />
      <span className="text-center leading-tight">{label}</span>
    </button>
  );
}

export function RelationButtons({
  nick,
  isSelf,
  onPostMe,
  onUpdateInfo,
  onChangeCover,
  relationship,
  actions,
}: RelationButtonsProps) {
  const { t } = useTranslation();
  const [menuOpen, setMenuOpen] = useState(false);

  const { status } = relationship;
  const isFriend = status === 'friend';
  const following = relationship.isFollowing;
  const blockedByMe = status === 'blocked_by_me';

  const comingSoon = () => toast.info(t('profile.comingSoon'));

  const friendLabel =
    status === 'friend'
      ? t('profile.alreadyFriend')
      : status === 'pending_outgoing'
        ? t('profile.requestSent')
        : status === 'pending_incoming'
          ? t('profile.acceptFriend')
          : t('profile.makeFriend');
  const friendActive = isFriend || status === 'pending_outgoing';
  const friendIcon = isFriend ? friendsActiveIcon : addFriendIcon;
  const followIconSrc = following ? followingActiveIcon : followIcon;

  const otherMenu: ListOption[] = [
    { key: 'block', label: t('profile.block'), danger: true, onSelect: actions.blockAction },
    { key: 'copy', label: t('profile.copyNick'), onSelect: () => navigator.clipboard?.writeText(nick) },
    { key: 'report', label: t('profile.report'), onSelect: comingSoon },
  ];

  const selfMenu: ListOption[] = [
    { key: 'avatar', label: t('profile.changeAvatar'), onSelect: comingSoon },
    { key: 'cover', label: t('profile.changeCover'), onSelect: onChangeCover },
    { key: 'privacy', label: t('profile.changePrivacy'), onSelect: comingSoon },
  ];

  if (blockedByMe) {
    return (
      <div className="px-2 py-2">
        <button
          type="button"
          onClick={actions.blockAction}
          className="w-full rounded bg-ola-error py-3 text-sm font-medium text-white"
        >
          {t('profile.unblock')}
        </button>
      </div>
    );
  }

  return (
    <>
      <div className="flex px-2 py-2">
        {isSelf ? (
          <RelationButton icon={editIcon} label={t('profile.updateInfo')} onClick={onUpdateInfo} />
        ) : (
          <>
            <RelationButton
              icon={friendIcon}
              label={friendLabel}
              active={friendActive}
              onClick={actions.friendAction}
            />
            <RelationButton
              icon={followIconSrc}
              label={following ? t('profile.following') : t('profile.follow')}
              active={following}
              onClick={actions.toggleFollow}
            />
          </>
        )}
        <RelationButton icon={postMeIcon} label={t('profile.postMe')} onClick={onPostMe} />
        <RelationButton icon={moreIcon} label={t('profile.more')} onClick={() => setMenuOpen(true)} />
      </div>

      <ListOptionDialog
        open={menuOpen}
        title={nick}
        options={isSelf ? selfMenu : otherMenu}
        onClose={() => setMenuOpen(false)}
      />
    </>
  );
}
