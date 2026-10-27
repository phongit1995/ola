import { useRef, useState } from 'react';
import type { MouseEvent } from 'react';
import { useTranslation } from 'react-i18next';
import {
  cn,
  createMomentReactionBurst,
  MOMENT_REACTION_LABEL_KEY,
  REACTION_IMAGE,
  REACTION_ORDER,
} from '@lib';
import type { MomentReactionBurst, ReactionType } from '@app-types';
import { MomentReactionFireworks } from './MomentReactionFireworks';

const MAX_BURSTS = 6;

interface MomentReactionBarProps {
  onReact: (type: ReactionType) => void;
}

export function MomentReactionBar({ onReact }: MomentReactionBarProps) {
  const { t } = useTranslation();
  const stageRef = useRef<HTMLDivElement>(null);
  const [bursts, setBursts] = useState<MomentReactionBurst[]>([]);
  const [pop, setPop] = useState<{ type: ReactionType | null; seq: number }>({
    type: null,
    seq: 0,
  });

  function react(type: ReactionType, event: MouseEvent<HTMLButtonElement>) {
    const stage = stageRef.current?.getBoundingClientRect();
    if (stage != null && stage.width > 0) {
      const origin = event.currentTarget.getBoundingClientRect();
      const burst = createMomentReactionBurst(type, stage, {
        x: origin.left + origin.width / 2 - stage.left,
        y: origin.top + origin.height / 2 - stage.top,
      });
      setBursts((current) => [...current, burst].slice(-MAX_BURSTS));
    }
    setPop((value) => ({ type, seq: value.seq + 1 }));
    onReact(type);
  }

  function finishBurst(id: number) {
    setBursts((current) => current.filter((burst) => burst.id !== id));
  }

  return (
    <>
      <div className="absolute inset-x-0 bottom-0 h-28 bg-gradient-to-t from-black/55 to-transparent" />
      <div
        ref={stageRef}
        className="pointer-events-none absolute inset-0 z-10 overflow-hidden motion-reduce:hidden"
      >
        <MomentReactionFireworks bursts={bursts} onDone={finishBurst} />
      </div>
      <div
        role="group"
        aria-label={t('moment.reactions')}
        className="absolute inset-x-0 bottom-3 flex justify-center gap-1.5 px-3"
      >
        {REACTION_ORDER.map((type) => {
          const popped = pop.type === type;
          return (
            <button
              key={type}
              type="button"
              aria-label={t(MOMENT_REACTION_LABEL_KEY[type])}
              onClick={(event) => react(type, event)}
              className="pointer-events-auto rounded-full p-1 transition-transform hover:scale-110 active:scale-90"
            >
              <img
                key={popped ? pop.seq : 0}
                src={REACTION_IMAGE[type]}
                alt=""
                draggable={false}
                className={cn(
                  'h-9 w-9 object-contain',
                  popped && 'animate-ola-pop'
                )}
              />
            </button>
          );
        })}
      </div>
    </>
  );
}
