export interface PenShot {
  id: string;
  code: string;
  shooter: string;
  bet: number;
  minutesAgo: number;
}

export const PEN_START_KEN = 12_345;

export const PEN_SHOTS: PenShot[] = [
  { id: 'p321', code: 'PEN321', shooter: 'abcxyz', bet: 1000, minutesAgo: 2 },
  { id: 'p322', code: 'PEN322', shooter: 'sweetgirl', bet: 2000, minutesAgo: 5 },
  { id: 'p323', code: 'PEN323', shooter: 'boycool', bet: 500, minutesAgo: 7 },
  { id: 'p324', code: 'PEN324', shooter: 'sunshine', bet: 1500, minutesAgo: 9 },
  { id: 'p325', code: 'PEN325', shooter: 'vip.top1', bet: 3000, minutesAgo: 11 },
  { id: 'p326', code: 'PEN326', shooter: 'kicker99', bet: 800, minutesAgo: 13 },
  { id: 'p327', code: 'PEN327', shooter: 'goalie88', bet: 2500, minutesAgo: 15 },
  { id: 'p328', code: 'PEN328', shooter: 'player10', bet: 1000, minutesAgo: 17 },
  { id: 'p329', code: 'PEN329', shooter: 'striker07', bet: 600, minutesAgo: 19 },
  { id: 'p330', code: 'PEN330', shooter: 'footyking', bet: 2200, minutesAgo: 21 },
];
