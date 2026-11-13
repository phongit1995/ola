import { useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, VipIcon } from '@components';
import { ApiError, vipName } from '@lib';
import { VipService } from '@services';
import { HTTP_STATUS } from '@constants';
import { useOffsetPage } from '@ola/shared/stores/useOffsetPage';

interface PeerVipStoreDialogProps {
  userId: string;
  name: string;
  onClose: () => void;
}

type LoadState = 'loading' | 'private' | 'error' | 'ready';

const PAGE_SIZE = 100;

export function PeerVipStoreDialog({
  userId,
  name,
  onClose,
}: PeerVipStoreDialogProps) {
  const { t } = useTranslation();
  const fetchPage = useCallback(
    (offset: number) => VipService.userStore(userId, { limit: PAGE_SIZE, offset }),
    [userId]
  );
  const { items, total, loading, loadingMore, error, loadMore } =
    useOffsetPage(fetchPage);
  const state: LoadState = loading
    ? 'loading'
    : error == null
      ? 'ready'
      : error instanceof ApiError && error.status === HTTP_STATUS.forbidden
        ? 'private'
        : 'error';

  function handleScroll(event: React.UIEvent<HTMLDivElement>) {
    const el = event.currentTarget;
    if (el.scrollHeight - el.scrollTop - el.clientHeight > 200) return;
    void loadMore();
  }

  return (
    <Dialog open onClose={onClose} showClose title={t('vip.storeOf', { name })}>
      <div
        className="max-h-[60vh] min-h-[120px] overflow-y-auto"
        onScroll={handleScroll}
      >
        {state === 'loading' ? (
          <div className="flex h-28 items-center justify-center text-sm text-black/54">
            {t('common.loading')}
          </div>
        ) : state === 'private' ? (
          <div className="flex h-28 items-center justify-center px-4 text-center text-sm text-black/54">
            {t('vip.storePrivate')}
          </div>
        ) : state === 'error' ? (
          <div className="flex h-28 items-center justify-center text-sm text-black/54">
            {t('common.error')}
          </div>
        ) : (
          <>
            <div className="mb-1 text-xs text-black/54">
              {t('vip.collection')} ({total})
            </div>
            {items.length === 0 ? (
              <div className="flex h-20 items-center justify-center text-sm text-black/54">
                {t('vip.empty')}
              </div>
            ) : (
              <div className="grid grid-cols-4 gap-2 pb-1">
                {items.map((icon) => (
                  <div
                    key={icon.instanceId}
                    className="flex flex-col items-center gap-1"
                  >
                    <div
                      className={
                        icon.isUsing
                          ? 'rounded-md p-0.5 ring-2 ring-ola-primary'
                          : 'p-0.5'
                      }
                    >
                      <VipIcon
                        typeId={icon.typeId}
                        size={48}
                        rounded
                        alt={vipName(icon.typeId)}
                      />
                    </div>
                    <span
                      className={`w-full truncate text-center text-[11px] ${
                        icon.isUsing
                          ? 'font-bold text-ola-primary-ink'
                          : 'text-black/54'
                      }`}
                    >
                      {vipName(icon.typeId)}
                    </span>
                  </div>
                ))}
              </div>
            )}
            {loadingMore && (
              <div className="flex h-10 items-center justify-center text-xs text-black/54">
                {t('common.loading')}
              </div>
            )}
          </>
        )}
      </div>
    </Dialog>
  );
}
