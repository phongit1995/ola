import { useEffect, useState } from 'react';
import type { CSSProperties } from 'react';
import { useRoomChatStore } from '@/store/roomChatStore';
import { REACTION_IMAGE } from '@lib';
import type { ReactionType } from '@app-types';

interface Balloon {
  id: number;
  image: string;
  right: number;
  size: number;
  rise: number;
  sway: number;
  drift: number;
  delay: number;
  duration: number;
}

const MAX_BALLOONS = 12;

let nextBalloonId = 0;

function spawnBalloons(image: string): Balloon[] {
  const count = 2 + Math.round(Math.random());
  return Array.from({ length: count }, (_, index) => {
    nextBalloonId += 1;
    return {
      id: nextBalloonId,
      image,
      right: 16 + Math.random() * 72,
      size: 24 + Math.random() * 12,
      rise: Math.round(window.innerHeight * (0.38 + Math.random() * 0.22)),
      sway: Math.round((Math.random() * 2 - 1) * 40),
      drift: Math.round((Math.random() * 2 - 1) * 56),
      delay: Math.round(index * 150 + Math.random() * 120),
      duration: Math.round(2000 + Math.random() * 700),
    };
  });
}

export function RoomReactionBalloons() {
  const [balloons, setBalloons] = useState<Balloon[]>([]);

  useEffect(() => {
    return useRoomChatStore.subscribe((state, prevState) => {
      const notice = state.reactionNotice;
      if (notice == null || notice === prevState.reactionNotice) return;
      const image = REACTION_IMAGE[notice.type as ReactionType] ?? '';
      if (image === '') return;
      const spawned = spawnBalloons(image);
      setBalloons((current) => [...current, ...spawned].slice(-MAX_BALLOONS));
    });
  }, []);

  if (balloons.length === 0) return null;

  return (
    <div className="pointer-events-none absolute inset-0 z-10 overflow-hidden">
      {balloons.map((balloon) => (
        <img
          key={balloon.id}
          src={balloon.image}
          alt=""
          onAnimationEnd={() =>
            setBalloons((current) => current.filter((item) => item.id !== balloon.id))
          }
          className="animate-room-balloon absolute object-contain"
          style={
            {
              right: balloon.right,
              bottom: 84,
              width: balloon.size,
              height: balloon.size,
              animationDuration: `${balloon.duration}ms`,
              animationDelay: `${balloon.delay}ms`,
              '--balloon-rise': `${balloon.rise}px`,
              '--balloon-sway': `${balloon.sway}px`,
              '--balloon-drift': `${balloon.drift}px`,
            } as CSSProperties
          }
        />
      ))}
    </div>
  );
}
