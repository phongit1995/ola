import { useEffect, type CSSProperties } from 'react';
import { createPortal } from 'react-dom';
import { useTranslation } from 'react-i18next';
import { GIFT_ANIMATION_DURATION_MS } from '@constants';
import { portalRoot } from '@lib';
import { useGiftAnimationStore } from '@/store/giftAnimationStore';
import {
  GIFT_BUBBLES,
  GIFT_CONFETTI,
  GIFT_FIREWORK,
  GIFT_FLASH_BACKGROUND,
  GIFT_GLOW_BACKGROUND,
  GIFT_HEARTS,
  GIFT_PETALS,
  GIFT_RAINBOW_BACKGROUND,
  GIFT_RAINBOW_MASK,
  GIFT_RAYS_BACKGROUND,
  GIFT_RAYS_MASK,
  GIFT_RING_DELAYS,
  GIFT_SPARKS,
  GIFT_STARS,
  variantForAnimation,
  type GiftEffect,
} from '@ola/shared/lib/giftAnimationVariants';

const CENTERED = 'absolute top-1/2 left-1/2';

function LandingFlash() {
  return (
    <span
      aria-hidden="true"
      className={`${CENTERED} -mt-[160px] -ml-[160px] h-[320px] w-[320px] animate-gift-flash rounded-full`}
      style={{ background: GIFT_FLASH_BACKGROUND }}
    />
  );
}

function GiftEffectLayer({ effect }: { effect: GiftEffect }) {
  switch (effect) {
    case 'rays':
      return (
        <span
          aria-hidden="true"
          className={`${CENTERED} -mt-[190px] -ml-[190px] h-[380px] w-[380px] animate-gift-rays rounded-full`}
          style={{
            background: GIFT_RAYS_BACKGROUND,
            maskImage: GIFT_RAYS_MASK,
          }}
        />
      );
    case 'glow':
      return (
        <span
          aria-hidden="true"
          className={`${CENTERED} -mt-[170px] -ml-[170px] h-[340px] w-[340px] animate-gift-glow rounded-full`}
          style={{ background: GIFT_GLOW_BACKGROUND }}
        />
      );
    case 'ring':
      return (
        <>
          {GIFT_RING_DELAYS.map((delay) => (
            <span
              key={delay}
              aria-hidden="true"
              className={`${CENTERED} -mt-[120px] -ml-[120px] h-[240px] w-[240px] animate-gift-ring rounded-full border-4 border-[#ffd600] shadow-[0_0_16px_#ffd600]`}
              style={{ animationDelay: delay }}
            />
          ))}
        </>
      );
    case 'sparks':
      return (
        <>
          {GIFT_SPARKS.map((spark) => (
            <span
              key={`${spark.x}${spark.y}`}
              aria-hidden="true"
              className={`${CENTERED} h-3.5 w-3.5 animate-gift-sparkle rounded-full bg-[#ffd600] shadow-[0_0_10px_#ffd600]`}
              style={
                {
                  '--gift-spark-x': spark.x,
                  '--gift-spark-y': spark.y,
                  animationDelay: spark.delay,
                } as CSSProperties
              }
            />
          ))}
        </>
      );
    case 'confetti':
      return (
        <>
          {GIFT_CONFETTI.map((piece) => (
            <span
              key={`${piece.x}${piece.delay}`}
              aria-hidden="true"
              className={`${CENTERED} h-3.5 w-2 animate-gift-confetti rounded-[2px]`}
              style={
                {
                  backgroundColor: piece.color,
                  '--gift-confetti-x': piece.x,
                  '--gift-confetti-drift': piece.drift,
                  '--gift-confetti-spin': piece.spin,
                  animationDelay: piece.delay,
                } as CSSProperties
              }
            />
          ))}
        </>
      );
    case 'rainbow':
      return (
        <span
          aria-hidden="true"
          className={`${CENTERED} -mt-[175px] -ml-[175px] h-[350px] w-[350px] animate-gift-rainbow rounded-full blur-[1px]`}
          style={{
            background: GIFT_RAINBOW_BACKGROUND,
            maskImage: GIFT_RAINBOW_MASK,
          }}
        />
      );
    case 'stars':
      return (
        <>
          {GIFT_STARS.map((star) => (
            <span
              key={`${star.x}${star.y}`}
              aria-hidden="true"
              className={`${CENTERED} animate-gift-star leading-none`}
              style={
                {
                  color: star.color,
                  fontSize: star.size,
                  textShadow: `0 0 8px ${star.color}`,
                  '--gift-star-x': star.x,
                  '--gift-star-y': star.y,
                  animationDelay: star.delay,
                } as CSSProperties
              }
            >
              ✦
            </span>
          ))}
        </>
      );
    case 'bubbles':
      return (
        <>
          {GIFT_BUBBLES.map((bubble) => (
            <span
              key={`${bubble.x}${bubble.delay}`}
              aria-hidden="true"
              className={`${CENTERED} animate-gift-bubble rounded-full border border-white/80 bg-[radial-gradient(circle_at_30%_30%,rgba(255,255,255,0.95),rgba(64,196,255,0.25)_60%,rgba(64,196,255,0.1))] shadow-[0_0_6px_rgba(64,196,255,0.5)]`}
              style={
                {
                  width: bubble.size,
                  height: bubble.size,
                  '--gift-bubble-x': bubble.x,
                  '--gift-bubble-drift': bubble.drift,
                  animationDelay: bubble.delay,
                } as CSSProperties
              }
            />
          ))}
        </>
      );
    case 'firework':
      return (
        <>
          {GIFT_FIREWORK.map((dot) => (
            <span
              key={dot.key}
              aria-hidden="true"
              className={`${CENTERED} h-2 w-2 animate-gift-firework rounded-full`}
              style={
                {
                  backgroundColor: dot.color,
                  boxShadow: `0 0 8px ${dot.color}`,
                  '--gift-fw-from-x': dot.fromX,
                  '--gift-fw-from-y': dot.fromY,
                  '--gift-fw-to-x': dot.toX,
                  '--gift-fw-to-y': dot.toY,
                  animationDelay: dot.delay,
                } as CSSProperties
              }
            />
          ))}
        </>
      );
    case 'petals':
      return (
        <>
          {GIFT_PETALS.map((petal) => (
            <span
              key={`${petal.x}${petal.delay}`}
              aria-hidden="true"
              className={`${CENTERED} h-3 w-4 animate-gift-petal rounded-[100%_0] bg-linear-to-br from-[#ffc1e3] to-[#ff80ab] shadow-[0_1px_2px_rgba(0,0,0,0.15)]`}
              style={
                {
                  '--gift-petal-x': petal.x,
                  '--gift-petal-drift': petal.drift,
                  '--gift-petal-spin': petal.spin,
                  animationDelay: petal.delay,
                } as CSSProperties
              }
            />
          ))}
        </>
      );
    case 'hearts':
      return (
        <>
          {GIFT_HEARTS.map((heart) => (
            <span
              key={`${heart.x}${heart.delay}`}
              aria-hidden="true"
              className={`${CENTERED} animate-gift-heart leading-none drop-shadow-[0_2px_4px_rgba(0,0,0,0.2)]`}
              style={
                {
                  color: heart.color,
                  fontSize: heart.size,
                  '--gift-heart-x': heart.x,
                  '--gift-heart-drift': heart.drift,
                  animationDelay: heart.delay,
                } as CSSProperties
              }
            >
              ♥
            </span>
          ))}
        </>
      );
  }
}

export function GiftAnimationOverlay() {
  const { t } = useTranslation();
  const current = useGiftAnimationStore((s) => s.queue[0]);
  const next = useGiftAnimationStore((s) => s.next);

  useEffect(() => {
    if (current == null) return;
    const timer = window.setTimeout(next, GIFT_ANIMATION_DURATION_MS);
    return () => window.clearTimeout(timer);
  }, [current, next]);

  if (current == null) return null;

  const { key, variant } = variantForAnimation(current.animation);

  return createPortal(
    <div
      key={current.id}
      aria-live="polite"
      aria-label={current.caption ?? current.name}
      data-gift-animation={key}
      className="pointer-events-none fixed inset-0 z-[130] flex items-center justify-center overflow-hidden"
    >
      <div className="relative flex items-center justify-center">
        {variant.effects.map((effect) => (
          <GiftEffectLayer key={effect} effect={effect} />
        ))}
        <LandingFlash />
        <div className={`relative ${variant.giftClass}`}>
          <img
            src={current.imageUrl}
            alt=""
            className="h-[min(62vw,240px)] w-[min(62vw,240px)] object-contain drop-shadow-[0_10px_22px_rgba(0,0,0,0.35)]"
          />
          {current.quantity > 1 && (
            <span className="absolute right-0 bottom-3 rounded-full bg-ola-accent px-3 py-0.5 text-2xl font-bold text-white shadow-lg">
              {t('gift.quantityTimes', { count: current.quantity })}
            </span>
          )}
        </div>
      </div>
    </div>,
    portalRoot()
  );
}
