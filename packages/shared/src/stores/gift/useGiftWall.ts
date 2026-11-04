import { useEffect, useState } from 'react';
import { GiftService } from '../../services/gift.service';
import type { GiftWall } from '../../types/api/gift.type';

export function useGiftWall(userId: string, refreshKey: number): GiftWall | null {
  const [wall, setWall] = useState<GiftWall | null>(null);

  useEffect(() => {
    if (userId === '') return;
    let cancelled = false;
    GiftService.wall(userId)
      .then((result) => {
        if (!cancelled) setWall(result);
      })
      .catch(() => {
        if (!cancelled) setWall(null);
      });
    return () => {
      cancelled = true;
    };
  }, [userId, refreshKey]);

  return wall;
}
