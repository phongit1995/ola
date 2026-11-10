import { useEffect, type CSSProperties } from 'react'
import { createPortal } from 'react-dom'
import { GIFT_ANIMATION_DURATION_MS } from '@ola/shared/constants'
import {
  GIFT_ANIMATION_VARIANTS,
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
  type GiftEffect,
} from '@ola/shared/lib/giftAnimationVariants'
import { GIFT_ANIMATION_LABEL } from './constants'
import type { GiftPreview } from './types'

const PREVIEW_Z_INDEX = 2000
const GIFT_IMAGE_SIZE = 'min(62vw, 240px)'

const CENTERED: CSSProperties = { position: 'absolute', top: '50%', left: '50%' }

const BACKDROP_STYLE: CSSProperties = {
  position: 'fixed',
  inset: 0,
  zIndex: PREVIEW_Z_INDEX,
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
  overflow: 'hidden',
  background: 'rgba(0, 0, 0, 0.55)',
}

const CAPTION_STYLE: CSSProperties = {
  position: 'absolute',
  bottom: 40,
  left: 0,
  right: 0,
  textAlign: 'center',
  color: '#fff',
  fontSize: 14,
  fontWeight: 600,
}

function centeredDisc(size: number): CSSProperties {
  return {
    ...CENTERED,
    width: size,
    height: size,
    marginTop: -size / 2,
    marginLeft: -size / 2,
    borderRadius: '50%',
  }
}

function particle(style: Record<string, string | number>): CSSProperties {
  return { ...CENTERED, ...style }
}

function GiftEffectLayer({ effect }: { effect: GiftEffect }) {
  switch (effect) {
    case 'rays':
      return (
        <span
          className="animate-gift-rays"
          style={{
            ...centeredDisc(380),
            background: GIFT_RAYS_BACKGROUND,
            maskImage: GIFT_RAYS_MASK,
          }}
        />
      )
    case 'glow':
      return (
        <span
          className="animate-gift-glow"
          style={{ ...centeredDisc(340), background: GIFT_GLOW_BACKGROUND }}
        />
      )
    case 'ring':
      return GIFT_RING_DELAYS.map((delay) => (
        <span
          key={delay}
          className="animate-gift-ring"
          style={{
            ...centeredDisc(240),
            border: '4px solid #ffd600',
            boxShadow: '0 0 16px #ffd600',
            animationDelay: delay,
          }}
        />
      ))
    case 'sparks':
      return GIFT_SPARKS.map((spark) => (
        <span
          key={`${spark.x}${spark.y}`}
          className="animate-gift-sparkle"
          style={particle({
            width: 14,
            height: 14,
            borderRadius: '50%',
            background: '#ffd600',
            boxShadow: '0 0 10px #ffd600',
            '--gift-spark-x': spark.x,
            '--gift-spark-y': spark.y,
            animationDelay: spark.delay,
          })}
        />
      ))
    case 'confetti':
      return GIFT_CONFETTI.map((piece) => (
        <span
          key={`${piece.x}${piece.delay}`}
          className="animate-gift-confetti"
          style={particle({
            width: 8,
            height: 14,
            borderRadius: 2,
            backgroundColor: piece.color,
            '--gift-confetti-x': piece.x,
            '--gift-confetti-drift': piece.drift,
            '--gift-confetti-spin': piece.spin,
            animationDelay: piece.delay,
          })}
        />
      ))
    case 'rainbow':
      return (
        <span
          className="animate-gift-rainbow"
          style={{
            ...centeredDisc(350),
            filter: 'blur(1px)',
            background: GIFT_RAINBOW_BACKGROUND,
            maskImage: GIFT_RAINBOW_MASK,
          }}
        />
      )
    case 'stars':
      return GIFT_STARS.map((star) => (
        <span
          key={`${star.x}${star.y}`}
          className="animate-gift-star"
          style={particle({
            lineHeight: 1,
            color: star.color,
            fontSize: star.size,
            textShadow: `0 0 8px ${star.color}`,
            '--gift-star-x': star.x,
            '--gift-star-y': star.y,
            animationDelay: star.delay,
          })}
        >
          ✦
        </span>
      ))
    case 'bubbles':
      return GIFT_BUBBLES.map((bubble) => (
        <span
          key={`${bubble.x}${bubble.delay}`}
          className="animate-gift-bubble"
          style={particle({
            width: bubble.size,
            height: bubble.size,
            borderRadius: '50%',
            border: '1px solid rgba(255, 255, 255, 0.8)',
            background:
              'radial-gradient(circle at 30% 30%, rgba(255,255,255,0.95), rgba(64,196,255,0.25) 60%, rgba(64,196,255,0.1))',
            boxShadow: '0 0 6px rgba(64, 196, 255, 0.5)',
            '--gift-bubble-x': bubble.x,
            '--gift-bubble-drift': bubble.drift,
            animationDelay: bubble.delay,
          })}
        />
      ))
    case 'firework':
      return GIFT_FIREWORK.map((dot) => (
        <span
          key={dot.key}
          className="animate-gift-firework"
          style={particle({
            width: 8,
            height: 8,
            borderRadius: '50%',
            backgroundColor: dot.color,
            boxShadow: `0 0 8px ${dot.color}`,
            '--gift-fw-from-x': dot.fromX,
            '--gift-fw-from-y': dot.fromY,
            '--gift-fw-to-x': dot.toX,
            '--gift-fw-to-y': dot.toY,
            animationDelay: dot.delay,
          })}
        />
      ))
    case 'petals':
      return GIFT_PETALS.map((petal) => (
        <span
          key={`${petal.x}${petal.delay}`}
          className="animate-gift-petal"
          style={particle({
            width: 16,
            height: 12,
            borderRadius: '100% 0',
            background: 'linear-gradient(to bottom right, #ffc1e3, #ff80ab)',
            boxShadow: '0 1px 2px rgba(0, 0, 0, 0.15)',
            '--gift-petal-x': petal.x,
            '--gift-petal-drift': petal.drift,
            '--gift-petal-spin': petal.spin,
            animationDelay: petal.delay,
          })}
        />
      ))
    case 'hearts':
      return GIFT_HEARTS.map((heart) => (
        <span
          key={`${heart.x}${heart.delay}`}
          className="animate-gift-heart"
          style={particle({
            lineHeight: 1,
            color: heart.color,
            fontSize: heart.size,
            filter: 'drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2))',
            '--gift-heart-x': heart.x,
            '--gift-heart-drift': heart.drift,
            animationDelay: heart.delay,
          })}
        >
          ♥
        </span>
      ))
  }
}

export function GiftAnimationPreview({
  preview,
  onClose,
}: {
  preview: GiftPreview
  onClose: () => void
}) {
  useEffect(() => {
    const timer = window.setTimeout(onClose, GIFT_ANIMATION_DURATION_MS)
    return () => window.clearTimeout(timer)
  }, [onClose])

  const variant = GIFT_ANIMATION_VARIANTS[preview.animation]

  return createPortal(
    <div style={BACKDROP_STYLE} onClick={onClose}>
      <div
        style={{
          position: 'relative',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
        }}
      >
        {variant.effects.map((effect) => (
          <GiftEffectLayer key={effect} effect={effect} />
        ))}
        <span
          className="animate-gift-flash"
          style={{ ...centeredDisc(320), background: GIFT_FLASH_BACKGROUND }}
        />
        <div className={variant.giftClass} style={{ position: 'relative' }}>
          <img
            src={preview.imageUrl}
            alt=""
            style={{
              display: 'block',
              width: GIFT_IMAGE_SIZE,
              height: GIFT_IMAGE_SIZE,
              objectFit: 'contain',
              filter: 'drop-shadow(0 10px 22px rgba(0, 0, 0, 0.35))',
            }}
          />
        </div>
      </div>
      <div style={CAPTION_STYLE}>
        {preview.name} · {GIFT_ANIMATION_LABEL[preview.animation]}
      </div>
    </div>,
    document.body,
  )
}
