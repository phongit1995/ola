export interface FlightOrigin {
  x: number;
  y: number;
  width: number;
}

export interface FlightTarget {
  x: number;
  bottom: number;
  width: number;
  height: number;
}

export const SEAT_FLIGHT_SCALE = 0.42;
const SEAT_FLIGHT_SPIN = 30;

export function flightKeyframes(origin: FlightOrigin, target: FlightTarget, rotate: number): Keyframe[] {
  const fromSeat = origin.width <= 0;
  const scale = fromSeat ? SEAT_FLIGHT_SCALE : origin.width / target.width;
  const dx = origin.x - target.x;
  const dy = origin.y + (scale * target.height) / 2 - target.bottom;
  return [
    {
      transform: `translate(${dx}px, ${dy}px) scale(${scale}) rotate(${fromSeat ? rotate - SEAT_FLIGHT_SPIN : 0}deg)`,
      opacity: fromSeat ? 0 : 1,
    },
    { opacity: 1, offset: 0.2 },
    { transform: `translate(0px, 0px) scale(1) rotate(${rotate}deg)`, opacity: 1 },
  ];
}
