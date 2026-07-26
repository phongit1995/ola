import { useEffect, useState, type CSSProperties } from 'react';
import { reactionOption } from '../../../helpers/reaction';
import { useCaro } from '../../../store/useCaro';

interface ReactionBalloon {
  id: number;
  src: string;
  mine: boolean;
  start: number;
  size: number;
  rise30: number;
  rise62: number;
  riseEnd: number;
  sway: number;
  returnSway: number;
  drift: number;
  delay: number;
  duration: number;
}

const MAX_BALLOONS = 12;
const BALLOONS_PER_REACTION = 3;
let nextBalloonID = 0;

function spawnBalloons(src: string, mine: boolean): ReactionBalloon[] {
  return Array.from({ length: BALLOONS_PER_REACTION }, (_, index) => {
    nextBalloonID += 1;
    const rise = Math.round(window.innerHeight * (0.38 + Math.random() * 0.14));
    const sway = Math.round((Math.random() * 2 - 1) * 36);
    return {
      id: nextBalloonID,
      src,
      mine,
      start: (mine ? 68 : 14) + Math.random() * 18,
      size: 34 + Math.random() * 14,
      rise30: -Math.round(rise * 0.3),
      rise62: -Math.round(rise * 0.62),
      riseEnd: -rise,
      sway,
      returnSway: -Math.round(sway * 0.45),
      drift: Math.round((Math.random() * 2 - 1) * 48),
      delay: Math.round(index * 130 + Math.random() * 90),
      duration: Math.round(1900 + Math.random() * 600),
    };
  });
}

export function ReactionBalloons() {
  const [balloons, setBalloons] = useState<ReactionBalloon[]>([]);

  useEffect(
    () =>
      useCaro.subscribe((state, previousState) => {
        const notice = state.reactionNotice;
        if (notice === previousState.reactionNotice) return;
        if (notice == null) {
          setBalloons([]);
          return;
        }
        const reaction = reactionOption(notice.type);
        if (reaction == null) return;
        const spawned = spawnBalloons(reaction.src, notice.mine);
        setBalloons((current) => [...current, ...spawned].slice(-MAX_BALLOONS));
      }),
    [],
  );

  if (balloons.length === 0) return null;

  return (
    <div className="caro-reaction-balloons" aria-hidden="true">
      {balloons.map((balloon) => (
        <img
          key={balloon.id}
          className={balloon.mine ? 'mine' : 'opponent'}
          src={balloon.src}
          alt=""
          onAnimationEnd={() =>
            setBalloons((current) => current.filter((candidate) => candidate.id !== balloon.id))
          }
          style={
            {
              left: `${balloon.start}%`,
              bottom: `max(92px, 15dvh)`,
              width: `${balloon.size}px`,
              height: `${balloon.size}px`,
              animationDelay: `${balloon.delay}ms`,
              animationDuration: `${balloon.duration}ms`,
              '--reaction-rise-30': `${balloon.rise30}px`,
              '--reaction-rise-62': `${balloon.rise62}px`,
              '--reaction-rise-end': `${balloon.riseEnd}px`,
              '--reaction-sway': `${balloon.sway}px`,
              '--reaction-return-sway': `${balloon.returnSway}px`,
              '--reaction-drift': `${balloon.drift}px`,
            } as CSSProperties
          }
        />
      ))}
    </div>
  );
}
