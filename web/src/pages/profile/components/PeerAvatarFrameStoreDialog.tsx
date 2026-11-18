import { useTranslation } from 'react-i18next';
import { Dialog, Spinner } from '@components';
import { cn, withoutExpiredItems } from '@lib';
import { useMinuteNow } from '@ola/shared/stores/useMinuteNow';
import { usePeerAvatarFrames } from '@ola/shared/stores/avatar-frame/usePeerAvatarFrames';
import { AvatarFrameThumb } from '../../avatar-frame/components/AvatarFrameThumb';
import { PEER_FRAME_THUMB_SIZE } from '../../avatar-frame/constants';
import { avatarFrameLabel, ownedAvatarFrameKey } from '@ola/shared/lib/avatarFrame';

interface PeerAvatarFrameStoreDialogProps {
  userId: string;
  name: string;
  onClose: () => void;
}

export function PeerAvatarFrameStoreDialog({
  userId,
  name,
  onClose,
}: PeerAvatarFrameStoreDialogProps) {
  const { t } = useTranslation();
  const { store, loading, loadingMore, hasMore, loadMore, isPrivate, failed } =
    usePeerAvatarFrames(userId, true);
  const now = useMinuteNow();

  function renderBody() {
    if (isPrivate) {
      return (
        <div className="flex h-28 items-center justify-center px-4 text-center text-sm text-black/54">
          {t('avatarFrame.storePrivate')}
        </div>
      );
    }
    if (failed) {
      return (
        <div className="flex h-28 items-center justify-center text-sm text-black/54">
          {t('common.error')}
        </div>
      );
    }
    if (loading || store == null) {
      return (
        <div className="flex h-28 items-center justify-center">
          <Spinner size={24} />
        </div>
      );
    }
    return (
      <>
        <div className="mb-1 text-xs text-black/54">
          {t('avatarFrame.count', { count: store.total })}
        </div>
        {store.items.length === 0 ? (
          <div className="flex h-20 items-center justify-center text-sm text-black/54">
            {t('avatarFrame.empty')}
          </div>
        ) : (
          <div className="grid grid-cols-4 gap-2 pb-1">
            {withoutExpiredItems(store.items, now).map((frame) => (
              <div
                key={ownedAvatarFrameKey(frame)}
                className="flex flex-col items-center gap-1"
              >
                <div
                  className={cn(
                    'relative rounded-md p-0.5',
                    frame.isEquipped && 'ring-2 ring-ola-primary'
                  )}
                >
                  <AvatarFrameThumb
                    frameId={frame.frameId}
                    size={PEER_FRAME_THUMB_SIZE}
                  />
                </div>
                <span
                  className={cn(
                    'w-full truncate text-center text-[11px]',
                    frame.isEquipped
                      ? 'font-bold text-ola-primary-ink'
                      : 'text-black/54'
                  )}
                >
                  {avatarFrameLabel(frame.frameId)}
                </span>
              </div>
            ))}
          </div>
        )}
        {hasMore && (
          <button
            type="button"
            disabled={loadingMore}
            onClick={() => void loadMore().catch(() => undefined)}
            className="mt-2 w-full py-2 text-sm font-medium text-ola-primary-ink disabled:opacity-50"
          >
            {loadingMore ? <Spinner size={16} /> : t('avatarFrame.history.loadMore')}
          </button>
        )}
      </>
    );
  }

  return (
    <Dialog
      open
      onClose={onClose}
      showClose
      title={t('avatarFrame.storeOf', { name })}
    >
      <div className="max-h-[60vh] min-h-[120px] overflow-y-auto">
        {renderBody()}
      </div>
    </Dialog>
  );
}
