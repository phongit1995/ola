import { useEffect, useState } from 'react';
import { appendMomentUsers } from '../../lib/moment';
import { toast } from '../../lib/toast';
import type { MomentAuthor, MomentUserPage } from '../../types/api/moment.type';

interface MomentUserList<T> {
  momentId: string;
  items: T[];
  total: number;
  nextOffset: number | null;
}

interface MomentUserPagesOptions<T> {
  open: boolean;
  momentId: string;
  load: (momentId: string, offset?: number) => Promise<MomentUserPage<T>>;
  failedMessage: string;
}

export function useMomentUserPages<T extends { user: MomentAuthor }>({
  open,
  momentId,
  load,
  failedMessage,
}: MomentUserPagesOptions<T>) {
  const [list, setList] = useState<MomentUserList<T> | null>(null);
  const [loadingMore, setLoadingMore] = useState(false);

  useEffect(() => {
    if (!open) return;
    let cancelled = false;
    load(momentId)
      .then((page) => {
        if (!cancelled) {
          setList({ momentId, items: page.items, total: page.total, nextOffset: page.nextOffset });
        }
      })
      .catch(() => {
        if (!cancelled) setList({ momentId, items: [], total: 0, nextOffset: null });
      });
    return () => {
      cancelled = true;
    };
  }, [open, momentId, load]);

  const current = list?.momentId === momentId ? list : null;
  const nextOffset = current?.nextOffset ?? null;

  async function loadMore() {
    if (nextOffset == null || loadingMore) return;
    setLoadingMore(true);
    try {
      const page = await load(momentId, nextOffset);
      setList((value) =>
        value?.momentId === momentId
          ? {
              momentId,
              items: appendMomentUsers(value.items, page.items),
              total: page.total,
              nextOffset: page.nextOffset,
            }
          : value
      );
    } catch {
      toast.error(failedMessage);
    } finally {
      setLoadingMore(false);
    }
  }

  return { list: current, nextOffset, loadingMore, loadMore };
}
