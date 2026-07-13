import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, VipIcon } from '@components';
import { ApiError, vipName } from '@lib';
import { VipService } from '@services';
import type { VipIconInstance } from '@app-types';

interface PeerVipStoreDialogProps {
  userId: string;
  name: string;
  onClose: () => void;
}

type LoadState = 'loading' | 'private' | 'error' | 'ready';

export function PeerVipStoreDialog({ userId, name, onClose }: PeerVipStoreDialogProps) {
  const { t } = useTranslation();
  const [items, setItems] = useState<VipIconInstance[]>([]);
  const [state, setState] = useState<LoadState>('loading');

  useEffect(() => {
    let active = true;
    VipService.userStore(userId, { limit: 100 })
      .then((res) => {
        if (!active) return;
        setItems(res.items);
        setState('ready');
      })
      .catch((err) => {
        if (!active) return;
        setState(err instanceof ApiError && err.status === 403 ? 'private' : 'error');
      });
    return () => {
      active = false;
    };
  }, [userId]);

  return (
    <Dialog
      open
      onClose={onClose}
      showClose
      title={t('vip.storeOf', { name })}
    >
      <div className="max-h-[60vh] min-h-[120px] overflow-y-auto">
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
              {t('vip.collection')} ({items.length})
            </div>
            {items.length === 0 ? (
              <div className="flex h-20 items-center justify-center text-sm text-black/54">
                {t('vip.empty')}
              </div>
            ) : (
              <div className="grid grid-cols-4 gap-2 pb-1">
                {items.map((icon) => (
                  <div key={icon.instanceId} className="flex flex-col items-center gap-1">
                    <div
                      className={
                        icon.isUsing
                          ? 'rounded-md p-0.5 ring-2 ring-ola-primary'
                          : 'p-0.5'
                      }
                    >
                      <VipIcon typeId={icon.typeId} size={48} rounded alt={vipName(icon.typeId)} />
                    </div>
                    <span
                      className={`w-full truncate text-center text-[11px] ${
                        icon.isUsing ? 'font-bold text-ola-primary' : 'text-black/54'
                      }`}
                    >
                      {vipName(icon.typeId)}
                    </span>
                  </div>
                ))}
              </div>
            )}
          </>
        )}
      </div>
    </Dialog>
  );
}
