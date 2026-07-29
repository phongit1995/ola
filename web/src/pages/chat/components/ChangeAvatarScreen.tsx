import { useTranslation } from 'react-i18next';
import { Avatar } from '@components';
import { colorForName } from '@lib';
import { AVATAR_ASPECT } from '@constants';
import { useAuthStore } from '@/store/authStore';
import { ChangeUserImageDialog } from './ChangeUserImageDialog';
import { CameraIcon } from './Icons';

interface ChangeAvatarScreenProps {
  open: boolean;
  onClose: () => void;
}

export function ChangeAvatarScreen({ open, onClose }: ChangeAvatarScreenProps) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);

  if (!open || !user) return null;

  const nick = user.fullName || user.username;

  return (
    <ChangeUserImageDialog
      onClose={onClose}
      aspect={AVATAR_ASPECT}
      currentUrl={user.avatar ?? ''}
      buildUpdate={(url) => ({ avatar: url })}
      texts={{
        title: t('avatar.title'),
        tooSmall: t('avatar.tooSmall'),
        error: t('avatar.error'),
        success: t('avatar.success'),
        saving: t('avatar.saving'),
        save: t('avatar.save'),
        cancel: t('avatar.cancel'),
        changeHint: t('avatar.changeHint'),
        postToMe: t('avatar.postToMe'),
        postContent: t('avatar.postContent'),
      }}
      renderPicker={({ shown, saving, openPicker }) => (
        <button
          type="button"
          onClick={openPicker}
          disabled={saving}
          className="relative disabled:opacity-60"
          aria-label={t('avatar.title')}
        >
          {shown ? (
            <img
              src={shown}
              alt=""
              className="h-28 w-28 rounded-full object-cover"
            />
          ) : (
            <Avatar name={nick} color={colorForName(nick)} size={112} />
          )}
          <span className="absolute bottom-0 right-0 flex h-8 w-8 items-center justify-center rounded-full border-2 border-white bg-ola-primary text-white">
            <CameraIcon />
          </span>
        </button>
      )}
    />
  );
}
