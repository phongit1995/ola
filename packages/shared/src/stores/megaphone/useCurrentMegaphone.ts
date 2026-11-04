import { useEffect, useMemo, useState } from 'react';
import { currentMegaphone } from '../../lib/megaphone';
import type { Megaphone } from '../../types/api/megaphone.type';
import { useRoomFilterStore } from '../room/roomFilterStore';
import { useMegaphoneStore } from './megaphoneStore';

const CHANGE_SLACK_MS = 30;

export function useVisibleMegaphones(items: readonly Megaphone[]): Megaphone[] {
  const blockedUserIds = useRoomFilterStore((s) => s.blockedUserIds);
  return useMemo(() => {
    if (blockedUserIds.length === 0) return [...items];
    const blocked = new Set(blockedUserIds);
    return items.filter((item) => !blocked.has(item.sender.id));
  }, [items, blockedUserIds]);
}

export function useCurrentMegaphone(): Megaphone | null {
  const items = useMegaphoneStore((s) => s.items);
  const clockOffset = useMegaphoneStore((s) => s.clockOffset);
  const visible = useVisibleMegaphones(items);
  const [now, setNow] = useState(() => Date.now() + clockOffset);
  const { current, nextChangeAt } = currentMegaphone(visible, now);

  useEffect(() => {
    if (nextChangeAt == null) return;
    const delay = Math.max(0, nextChangeAt - (Date.now() + clockOffset)) + CHANGE_SLACK_MS;
    const timer = setTimeout(() => setNow(Date.now() + clockOffset), delay);
    return () => clearTimeout(timer);
  }, [nextChangeAt, clockOffset]);

  return current;
}
