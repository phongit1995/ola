import { useEffect, type CSSProperties } from 'react';
import { createPortal } from 'react-dom';
import { useTranslation } from 'react-i18next';
import { GIFT_ANIMATION_DURATION_MS } from '@constants';
import { formatKen, portalRoot } from '@lib';
import { useGiftAnimationStore } from '@/store/giftAnimationStore';

const SPARKS = [
  { x: '-120px', y: '-90px', delay: '0.35s' },
  { x: '110px', y: '-110px', delay: '0.45s' },
  { x: '-140px', y: '30px', delay: '0.5s' },
  { x: '130px', y: '50px', delay: '0.4s' },
  { x: '-60px', y: '-140px', delay: '0.6s' },
  { x: '70px', y: '120px', delay: '0.55s' },
  { x: '-90px', y: '110px', delay: '0.65s' },
  { x: '20px', y: '-150px', delay: '0.5s' },
];

const RAYS_BACKGROUND =
  'repeating-conic-gradient(from 0deg, rgba(255,214,0,0.55) 0deg 10deg, transparent 10deg 30deg)';

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

  return createPortal(
    <div
      key={current.id}
      aria-live="polite"
      className="pointer-events-none fixed inset-0 z-[130] flex items-center justify-center"
    >
      <div className="relative flex flex-col items-center">
        <span
          aria-hidden="true"
          className="absolute top-1/2 left-1/2 -mt-[130px] -ml-[130px] h-[260px] w-[260px] animate-gift-rays rounded-full"
          style={{
            background: RAYS_BACKGROUND,
            maskImage: 'radial-gradient(circle, black 30%, transparent 70%)',
          }}
        />
        {SPARKS.map((spark) => (
          <span
            key={`${spark.x}${spark.y}`}
            aria-hidden="true"
            className="absolute top-1/2 left-1/2 h-3 w-3 animate-gift-sparkle rounded-full bg-[#ffd600] shadow-[0_0_8px_#ffd600]"
            style={
              {
                '--gift-spark-x': spark.x,
                '--gift-spark-y': spark.y,
                animationDelay: spark.delay,
              } as CSSProperties
            }
          />
        ))}
        <div className="relative animate-gift-fly">
          <img
            src={current.imageUrl}
            alt=""
            className="h-40 w-40 object-contain drop-shadow-[0_8px_18px_rgba(0,0,0,0.35)]"
          />
          {current.quantity > 1 && (
            <span className="absolute -right-3 bottom-2 rounded-full bg-ola-accent px-2.5 py-0.5 text-xl font-bold text-white shadow-lg">
              {t('gift.quantityTimes', { count: current.quantity })}
            </span>
          )}
        </div>
        <div className="mt-3 animate-gift-caption rounded-full bg-black/60 px-4 py-1.5 text-center text-white shadow-lg">
          <p className="text-sm font-semibold">
            {current.caption ?? current.name}
          </p>
          {current.charmPoints > 0 && (
            <p className="text-xs text-[#ffd600]">
              {t('gift.charmGain', { value: formatKen(current.charmPoints) })}
            </p>
          )}
        </div>
      </div>
    </div>,
    portalRoot()
  );
}
