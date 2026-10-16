import { useTranslation } from 'react-i18next';
import type { RoomChatStatus } from '@ola/shared/types';
import { Spinner } from '@components';

const PRIMARY_BUTTON_CLASS =
  'rounded-full bg-ola-primary px-6 py-2 text-sm font-medium text-ola-on-primary';

interface RoomJoiningOverlayProps {
  status: RoomChatStatus;
  joiningText?: string;
  errorText?: string;
  vipRequiredText?: string;
  onClose: () => void;
  onBuyVip: () => void;
}

export function RoomJoiningOverlay({
  status,
  joiningText,
  errorText,
  vipRequiredText,
  onClose,
  onBuyVip,
}: RoomJoiningOverlayProps) {
  const { t } = useTranslation();
  const vipRequired = status === 'vipRequired';
  const isError = status === 'error' || vipRequired;

  return (
    <div className="absolute inset-0 z-40 flex items-center justify-center bg-black/25 px-6">
      <div className="flex flex-col items-center gap-3 rounded-lg bg-white px-8 py-6 text-center shadow-xl">
        {isError ? (
          <>
            <p className="text-base text-black/70">
              {vipRequired
                ? (vipRequiredText ?? t('room.vipRequired'))
                : (errorText ?? t('room.joinError'))}
            </p>
            {vipRequired && (
              <button
                type="button"
                onClick={onBuyVip}
                className={PRIMARY_BUTTON_CLASS}
              >
                {t('room.buyVip')}
              </button>
            )}
            <button
              type="button"
              onClick={onClose}
              className={
                vipRequired
                  ? 'px-6 py-1 text-sm font-medium text-black/54'
                  : PRIMARY_BUTTON_CLASS
              }
            >
              {t('chat.back')}
            </button>
          </>
        ) : (
          <>
            <Spinner size={36} thickness={3} />
            <p className="text-sm text-black/54">
              {joiningText ?? t('room.joining')}
            </p>
          </>
        )}
      </div>
    </div>
  );
}
