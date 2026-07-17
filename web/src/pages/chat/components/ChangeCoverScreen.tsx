import { useTranslation } from 'react-i18next';
import { COVER_ASPECT } from '@constants';
import { useAuthStore } from '@/store/authStore';
import { ChangeUserImageDialog } from './ChangeUserImageDialog';

interface ChangeCoverScreenProps {
  open: boolean;
  onClose: () => void;
}

export function ChangeCoverScreen({ open, onClose }: ChangeCoverScreenProps) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);

  if (!open || !user) return null;

  return (
    <ChangeUserImageDialog
      onClose={onClose}
      aspect={COVER_ASPECT}
      currentUrl={user.coverPhoto ?? ''}
      buildUpdate={(url) => ({ coverPhoto: url })}
      texts={{
        title: t('cover.title'),
        tooSmall: t('cover.tooSmall'),
        error: t('cover.error'),
        success: t('cover.success'),
        saving: t('cover.saving'),
        save: t('cover.save'),
        cancel: t('cover.cancel'),
        changeHint: t('cover.changeHint'),
        postToMe: t('cover.postToMe'),
        postContent: t('cover.postContent'),
      }}
      renderPicker={({ shown, saving, openPicker }) => (
        <button
          type="button"
          onClick={openPicker}
          disabled={saving}
          style={{ aspectRatio: String(COVER_ASPECT) }}
          className="relative w-full overflow-hidden rounded-lg bg-black/5 disabled:opacity-60"
          aria-label={t('cover.title')}
        >
          {shown ? (
            <img src={shown} alt="" className="h-full w-full object-cover" />
          ) : (
            <span className="flex h-full w-full items-center justify-center px-4 text-center text-sm text-black/40">
              {t('cover.changeHint')}
            </span>
          )}
        </button>
      )}
    />
  );
}
