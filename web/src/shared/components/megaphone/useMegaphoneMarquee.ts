import { useEffect, useLayoutEffect, useRef } from 'react';
import { useMegaphoneStore } from '@ola/shared/stores/megaphone/megaphoneStore';
import type { Megaphone } from '@app-types';

const REDUCED_MOTION_QUERY = '(prefers-reduced-motion: reduce)';
const MS_PER_SECOND = 1000;
const TRACK_OFFSCREEN = 'translateX(100vw)';
const PILL_EXPAND_MS = 1100;
const MARQUEE_MIN_MS = 1000;
const IMAGE_WAIT_MAX_MS = 1000;

function prefersReducedMotion(): boolean {
  return window.matchMedia(REDUCED_MOTION_QUERY).matches;
}

async function waitForImages(element: HTMLElement): Promise<void> {
  const images = Array.from(element.querySelectorAll('img'));
  const timeout = new Promise((resolve) => window.setTimeout(resolve, IMAGE_WAIT_MAX_MS));
  await Promise.race([Promise.allSettled(images.map((image) => image.decode())), timeout]);
}

export function useMegaphoneMarquee({ id, displaySeconds }: Pick<Megaphone, 'id' | 'displaySeconds'>) {
  const markSeen = useMegaphoneStore((s) => s.markSeen);
  const clipRef = useRef<HTMLDivElement>(null);
  const trackRef = useRef<HTMLSpanElement>(null);
  const animationRef = useRef<Animation | null>(null);
  const durationMs = displaySeconds * MS_PER_SECOND;

  useLayoutEffect(() => {
    const track = trackRef.current;
    if (track != null) track.style.transform = prefersReducedMotion() ? 'none' : TRACK_OFFSCREEN;
  }, []);

  useEffect(() => {
    if (!prefersReducedMotion()) return;
    const timer = window.setTimeout(() => markSeen(id), durationMs);
    return () => window.clearTimeout(timer);
  }, [id, durationMs, markSeen]);

  useEffect(() => () => animationRef.current?.cancel(), []);

  async function startMarquee() {
    const clip = clipRef.current;
    const track = trackRef.current;
    if (clip == null || track == null || prefersReducedMotion()) return;
    await waitForImages(track);
    if (trackRef.current !== track) return;
    const animation = track.animate(
      [
        { transform: `translateX(${clip.clientWidth}px)` },
        { transform: `translateX(${-track.scrollWidth}px)` },
      ],
      { duration: Math.max(MARQUEE_MIN_MS, durationMs - PILL_EXPAND_MS), easing: 'linear', fill: 'forwards' }
    );
    animation.onfinish = () => markSeen(id);
    animationRef.current = animation;
  }

  return { clipRef, trackRef, startMarquee };
}
