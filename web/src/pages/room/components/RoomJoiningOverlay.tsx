import { useTranslation } from 'react-i18next';
import type { RoomChatStatus } from '@/store/roomChatStore';
import { Spinner } from '@components';

interface RoomJoiningOverlayProps {
  status: RoomChatStatus;
  onClose: () => void;
}

export function RoomJoiningOverlay({
  status,
  onClose,
}: RoomJoiningOverlayProps) {
  const { t } = useTranslation();
  const isError = status === 'error';

  return (
    <div className="absolute inset-0 z-40 flex items-center justify-center bg-black/25 px-6">
      <div className="flex flex-col items-center gap-3 rounded-lg bg-white px-8 py-6 text-center shadow-xl">
        {isError ? (
          <>
            <p className="text-base text-black/70">{t('room.joinError')}</p>
            <button
              type="button"
              onClick={onClose}
              className="rounded-full bg-ola-primary px-6 py-2 text-sm font-medium text-white"
            >
              {t('chat.back')}
            </button>
          </>
        ) : (
          <>
            <Spinner size={36} thickness={3} />
            <p className="text-sm text-black/54">{t('room.joining')}</p>
          </>
        )}
      </div>
    </div>
  );
}
