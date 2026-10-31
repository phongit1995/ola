import { useLayoutEffect, type RefObject } from 'react';
import { flightKeyframes, type FlightOrigin } from '../../helpers/cardFlight';
import { trickRotation } from '../../helpers/cardLayout';
import type { ServerPlay } from '../../logic/server-types';
import { localBox, tableRoot } from './localBox';

const FLIGHT_MS = 420;
const FLIGHT_STAGGER_MS = 45;
const FRESH_PLAY_MS = 600;
const FLIGHT_EASING = 'cubic-bezier(0.22, 1, 0.36, 1)';

export function useCardFlight(
  trickRef: RefObject<HTMLDivElement | null>,
  table: ServerPlay | null,
  playedAt: number,
  cardHeight: number,
  originOf: (card: number, by: number) => FlightOrigin | null,
): void {
  useLayoutEffect(() => {
    const trick = trickRef.current;
    const root = tableRoot(trick);
    if (!trick || !root || !table || !playedAt || Date.now() - playedAt > FRESH_PLAY_MS) return;
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
    const box = localBox(trick, root);
    const cards = trick.querySelectorAll<HTMLElement>('.tl-trick-card');
    const animations = [...cards].map((element, i) => {
      const origin = originOf(table.cards[i], table.by);
      if (!origin) return null;
      const target = {
        x: box.left + element.offsetLeft + element.offsetWidth / 2,
        bottom: box.top + element.offsetTop + cardHeight,
        width: element.offsetWidth,
        height: cardHeight,
      };
      return element.animate(flightKeyframes(origin, target, trickRotation(i, cards.length)), {
        duration: FLIGHT_MS,
        delay: i * FLIGHT_STAGGER_MS,
        easing: FLIGHT_EASING,
        fill: 'backwards',
      });
    });
    return () => animations.forEach((animation) => animation?.cancel());
  }, [playedAt]);
}
