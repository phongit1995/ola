const FACE_TURN: Record<number, [number, number]> = {
  1: [0, 0],
  2: [-90, 0],
  3: [0, -90],
  4: [0, 90],
  5: [90, 0],
  6: [0, 180],
};

export const DIE_FACES = [
  { value: 1, transform: 'rotateY(0deg)' },
  { value: 6, transform: 'rotateY(180deg)' },
  { value: 3, transform: 'rotateY(90deg)' },
  { value: 4, transform: 'rotateY(-90deg)' },
  { value: 2, transform: 'rotateX(90deg)' },
  { value: 5, transform: 'rotateX(-90deg)' },
] as const;

export function cubeTransform(value: number, index: number, spinX = 0, spinY = 0): string {
  const [x, y] = FACE_TURN[value] ?? FACE_TURN[1];
  const side = index ? -1 : 1;
  return `rotateX(${x + spinX * 360}deg) rotateY(${y + spinY * 360 * side}deg)`;
}
