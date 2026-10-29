import { useRef, useState } from 'react';
import type { MouseEvent, ReactNode } from 'react';
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
const ENTER_DELAY_MS = 120;
const ENTER_STAGGER_MS = 45;

interface MomentReactionBarProps {
  onReact: (type: ReactionType) => void;
  leading?: ReactNode;
}

export function MomentReactionBar({
  onReact,
  leading,
}: MomentReactionBarProps) {
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
      <div className="pointer-events-auto absolute inset-x-0 bottom-1 touch-pan-x overflow-x-auto overscroll-x-contain [scrollbar-width:none] [&::-webkit-scrollbar]:hidden">
        <div className="flex w-max min-w-full items-center justify-center gap-2 px-3 pt-4 pb-2">
          {leading != null && (
            <div className="w-50 shrink-0 grow">{leading}</div>
          )}
          <div
            role="group"
            aria-label={t('moment.reactions')}
            className="flex shrink-0 gap-1"
          >
            {REACTION_ORDER.map((type, index) => {
              const popped = pop.type === type;
              return (
                <button
                  key={type}
                  type="button"
                  aria-label={t(MOMENT_REACTION_LABEL_KEY[type])}
                  onClick={(event) => react(type, event)}
                  style={{
                    animationDelay: `${ENTER_DELAY_MS + index * ENTER_STAGGER_MS}ms`,
                  }}
                  className="shrink-0 origin-bottom rounded-full p-1 transition-[translate,scale] duration-200 ease-[cubic-bezier(0.34,1.56,0.64,1)] hover:-translate-y-1.5 hover:scale-125 active:scale-90 motion-safe:animate-moment-react-in motion-reduce:transition-none"
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
        </div>
      </div>
    </>
  );
}
