import { useTranslation } from 'react-i18next';
import type { RoomChatStatus } from '@/store/roomChatStore';
import { ScreenHeader, FullScreenOverlay } from '@components';

interface RoomJoiningOverlayProps {
  name: string;
  status: RoomChatStatus;
  onClose: () => void;
}

export function RoomJoiningOverlay({ name, status, onClose }: RoomJoiningOverlayProps) {
  const { t } = useTranslation();
  const isError = status === 'error';

  return (
    <FullScreenOverlay position="absolute">
      <ScreenHeader title={name} onBack={onClose} align="center" />

      <div className="flex flex-1 flex-col items-center justify-center gap-3 px-6 text-center">
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
            <span className="h-9 w-9 animate-spin rounded-full border-[3px] border-ola-primary/30 border-t-ola-primary" />
            <p className="text-sm text-black/54">{t('room.joining')}</p>
          </>
        )}
      </div>
    </FullScreenOverlay>
  );
}
