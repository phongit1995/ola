import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ListOptionDialog, type ListOption } from '@components';
import addFriendIcon from '@/assets/icons/profile/ic_add_friend_black_disable.png';
import followIcon from '@/assets/icons/profile/ic_follow_black_disable.png';
import editIcon from '@/assets/icons/profile/ic_edit_profile_gray.png';
import postMeIcon from '@/assets/icons/profile/ic_post_me_gray.png';
import moreIcon from '@/assets/icons/profile/ic_more_horizon_black_disable.png';

interface RelationButtonsProps {
  nick: string;
  isSelf: boolean;
  onBlock: () => void;
  onPostMe: () => void;
  onUpdateInfo: () => void;
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
  onBlock,
  onPostMe,
  onUpdateInfo,
}: RelationButtonsProps) {
  const { t } = useTranslation();
  const [friended, setFriended] = useState(false);
  const [following, setFollowing] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);

  const otherMenu: ListOption[] = [
    { key: 'block', label: t('profile.block'), danger: true, onSelect: onBlock },
    { key: 'copy', label: t('profile.copyNick'), onSelect: () => navigator.clipboard?.writeText(nick) },
    { key: 'report', label: t('profile.report'), onSelect: () => {} },
  ];

  const selfMenu: ListOption[] = [
    { key: 'public', label: t('me.privacy_public'), onSelect: () => {} },
    { key: 'friend', label: t('me.privacy_friend'), onSelect: () => {} },
    { key: 'private', label: t('me.privacy_private'), onSelect: () => {} },
    { key: 'help', label: t('profile.privacyHelp'), onSelect: () => {} },
  ];

  return (
    <>
      <div className="flex px-2 py-2">
        {isSelf ? (
          <RelationButton icon={editIcon} label={t('profile.updateInfo')} onClick={onUpdateInfo} />
        ) : (
          <>
            <RelationButton
              icon={addFriendIcon}
              label={friended ? t('profile.alreadyFriend') : t('profile.makeFriend')}
              active={friended}
              onClick={() => setFriended((value) => !value)}
            />
            <RelationButton
              icon={followIcon}
              label={following ? t('profile.following') : t('profile.follow')}
              active={following}
              onClick={() => setFollowing((value) => !value)}
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
