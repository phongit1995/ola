import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { ROUTES } from '@constants';
import { authTokens } from '@lib';
import { SocketService } from '@services';
import { requireAppConfig } from '@ola/shared/stores/appConfigStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { useAuthStore } from '@/store/authStore';
import nicknameIcon from '@/assets/icons/apps/nickname.png';
import { removeSavedAccount } from '../../personal/utils';
import { ChangeNicknameDialog } from './ChangeNicknameDialog';

export function NicknameField({ username }: { username: string }) {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const [dialogOpen, setDialogOpen] = useState(false);
  const [changeEnabled, setChangeEnabled] = useState(true);

  useEffect(() => {
    let cancelled = false;
    requireAppConfig('usernameChange')
      .then((config) => {
        if (!cancelled) setChangeEnabled(config.enabled);
      })
      .catch(() => {});
    return () => {
      cancelled = true;
    };
  }, []);

  function handleChanged() {
    setDialogOpen(false);
    removeSavedAccount(username);
    authTokens.clear();
    SocketService.disconnect();
    useAppOverlayStore.getState().reset();
    useAuthStore.getState().clearUser();
    navigate(ROUTES.login);
  }

  return (
    <>
      <div className="flex min-h-10 items-center gap-2 rounded-lg bg-black/5 py-1.5 pr-1.5 pl-3">
        <input
          disabled
          value={`@${username}`}
          aria-label={t('profileEdit.nicknameLabel')}
          className="min-w-0 flex-1 cursor-not-allowed truncate bg-transparent text-sm text-black/54"
        />
        {changeEnabled && (
          <button
            type="button"
            onClick={() => setDialogOpen(true)}
            className="flex shrink-0 items-center gap-1 rounded bg-ola-primary px-2.5 py-1 text-xs font-medium text-ola-on-primary"
          >
            <img src={nicknameIcon} alt="" className="h-4 w-4 object-contain" />
            {t('profileEdit.changeNickname')}
          </button>
        )}
      </div>
      <ChangeNicknameDialog
        open={dialogOpen}
        onClose={() => setDialogOpen(false)}
        onSuccess={handleChanged}
      />
    </>
  );
}
