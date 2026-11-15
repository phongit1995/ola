import cardAirport from '../assets/art/card-airport.webp';
import cardBirthday from '../assets/art/card-birthday.webp';
import cardCashIn from '../assets/art/card-cash-in.webp';
import cardCashOut from '../assets/art/card-cash-out.webp';
import cardJailFree from '../assets/art/card-jail-free.webp';
import cardJail from '../assets/art/card-jail.webp';
import cardMove from '../assets/art/card-move.webp';
import cardRepair from '../assets/art/card-repair.webp';
import flag from '../assets/pixel/fx-flag.webp';
import lantern from '../assets/pixel/fx-lantern.webp';
import house0 from '../assets/art/house-0.webp';
import house1 from '../assets/art/house-1.webp';
import house2 from '../assets/art/house-2.webp';
import house3 from '../assets/art/house-3.webp';
import pawnNonLa from '../assets/art/pawn-non-la.webp';
import pawnTrau from '../assets/art/pawn-trau.webp';
import pawnXeMay from '../assets/art/pawn-xe-may.webp';
import pawnXichLo from '../assets/art/pawn-xich-lo.webp';
import type { CardData } from '../logic/board';

export const PAWN_ART = [pawnXichLo, pawnNonLa, pawnTrau, pawnXeMay] as const;
export const HOUSE_ART = [house1, house2, house3] as const;
export const PIXEL_ART = { flag, lantern } as const;

export function pawnArt(seat: number): string {
  return PAWN_ART[seat] ?? PAWN_ART[0];
}

export function houseArt(level: number): string | null {
  return level > 0 ? HOUSE_ART[Math.min(level, HOUSE_ART.length) - 1] : null;
}

export function levelArt(level: number): string {
  return houseArt(level) ?? house0;
}

export function cardArt(card: CardData | undefined): string {
  if (!card) return cardMove;
  switch (card.effect) {
    case 'cash':
      return (card.amount ?? 0) >= 0 ? cardCashIn : cardCashOut;
    case 'moveToNearest':
      return cardAirport;
    case 'goToJail':
      return cardJail;
    case 'jailCard':
      return cardJailFree;
    case 'repair':
      return cardRepair;
    case 'collectEach':
      return cardBirthday;
    default:
      return cardMove;
  }
}
