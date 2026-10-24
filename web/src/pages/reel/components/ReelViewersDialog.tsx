import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { UserListDialog, UserRow } from '@components';
import { appendReelViewers, colorForName, toast } from '@lib';
import { ReelService } from '@services';
import type { ReelViewer } from '@app-types';

interface ReelViewersDialogProps {
  open: boolean;
  reelId: string;
  onClose: () => void;
}

interface ViewerList {
  reelId: string;
  items: ReelViewer[];
  total: number;
  nextOffset: number | null;
}

export function ReelViewersDialog({ open, reelId, onClose }: ReelViewersDialogProps) {
  const { t } = useTranslation();
  const [list, setList] = useState<ViewerList | null>(null);
  const [loadingMore, setLoadingMore] = useState(false);

  useEffect(() => {
    if (!open) return;
    let cancelled = false;
    ReelService.visibleViewers(reelId)
      .then((page) => {
        if (!cancelled) {
          setList({ reelId, items: page.items, total: page.total, nextOffset: page.nextOffset });
        }
      })
      .catch(() => {
        if (!cancelled) setList({ reelId, items: [], total: 0, nextOffset: null });
      });
    return () => {
      cancelled = true;
    };
  }, [open, reelId]);

  const current = list?.reelId === reelId ? list : null;
  const items = current?.items ?? [];
  const nextOffset = current?.nextOffset ?? null;

  async function loadMore() {
    if (nextOffset == null || loadingMore) return;
    setLoadingMore(true);
    try {
      const page = await ReelService.visibleViewers(reelId, nextOffset);
      setList((value) =>
        value?.reelId === reelId
          ? {
              reelId,
              items: appendReelViewers(value.items, page.items),
              total: page.total,
              nextOffset: page.nextOffset,
            }
          : value
      );
    } catch {
      toast.error(t('reel.viewersFailed'));
    } finally {
      setLoadingMore(false);
    }
  }

  return (
    <UserListDialog
      open={open}
      title={current ? t('reel.viewerCount', { count: current.total }) : t('reel.viewers')}
      onClose={onClose}
      loading={current == null}
      isEmpty={items.length === 0}
      empty={t('reel.viewersEmpty')}
    >
      {items.map(({ user }) => (
        <li key={user.id}>
          <UserRow
            name={user.username}
            fullName={user.fullName}
            avatar={user.avatar ?? undefined}
            color={colorForName(user.username)}
          />
        </li>
      ))}
      {nextOffset != null && (
        <li>
          <button
            type="button"
            disabled={loadingMore}
            onClick={() => void loadMore()}
            className="w-full py-2.5 text-sm font-semibold text-ola-primary hover:bg-black/5 disabled:opacity-50"
          >
            {t('reel.viewersMore')}
          </button>
        </li>
      )}
    </UserListDialog>
  );
}
