import type { CSSProperties } from 'react';
import { REACTION_IMAGE } from '@lib';
import type { MomentReactionBurst, MomentReactionSpark } from '@app-types';

const ROCKET_SIZE = 40;
const FLASH_SIZE = 128;

function sparkStyle(spark: MomentReactionSpark): CSSProperties {
  return {
    width: spark.size,
    height: spark.size,
    marginLeft: -spark.size / 2,
    marginTop: -spark.size / 2,
    backgroundColor: spark.color ?? undefined,
    '--spark-x': `${spark.x}px`,
    '--spark-y': `${spark.y}px`,
    '--spark-rotate': `${spark.rotate}deg`,
  } as CSSProperties;
}

function ReactionFirework({
  burst,
  onDone,
}: {
  burst: MomentReactionBurst;
  onDone: (id: number) => void;
}) {
  const image = REACTION_IMAGE[burst.type];
  return (
    <>
      <span
        className="animate-moment-launch-x absolute"
        style={
          {
            left: burst.fromX - ROCKET_SIZE / 2,
            top: burst.fromY - ROCKET_SIZE / 2,
            '--launch-x': `${burst.toX - burst.fromX}px`,
          } as CSSProperties
        }
      >
        <img
          src={image}
          alt=""
          className="animate-moment-launch-y block max-w-none object-contain drop-shadow-[0_0_8px_rgba(255,255,255,0.85)]"
          style={
            {
              width: ROCKET_SIZE,
              height: ROCKET_SIZE,
              '--launch-y': `${burst.toY - burst.fromY}px`,
            } as CSSProperties
          }
        />
      </span>
      <span className="absolute" style={{ left: burst.toX, top: burst.toY }}>
        <span
          className="animate-moment-flash absolute rounded-full bg-[radial-gradient(circle,rgba(255,255,255,0.9)_0%,rgba(255,226,140,0.45)_35%,transparent_70%)]"
          style={{
            width: FLASH_SIZE,
            height: FLASH_SIZE,
            marginLeft: -FLASH_SIZE / 2,
            marginTop: -FLASH_SIZE / 2,
          }}
        />
        {burst.sparks.map((spark, index) =>
          spark.color == null ? (
            <img
              key={index}
              src={image}
              alt=""
              onAnimationEnd={index === 0 ? () => onDone(burst.id) : undefined}
              className="animate-moment-spark absolute max-w-none object-contain"
              style={sparkStyle(spark)}
            />
          ) : (
            <span
              key={index}
              className="animate-moment-spark absolute rounded-full shadow-[0_0_6px_currentColor]"
              style={{ ...sparkStyle(spark), color: spark.color }}
            />
          )
        )}
      </span>
    </>
  );
}

interface MomentReactionFireworksProps {
  bursts: MomentReactionBurst[];
  onDone: (id: number) => void;
}

export function MomentReactionFireworks({
  bursts,
  onDone,
}: MomentReactionFireworksProps) {
  return bursts.map((burst) => (
    <ReactionFirework key={burst.id} burst={burst} onDone={onDone} />
  ));
}
