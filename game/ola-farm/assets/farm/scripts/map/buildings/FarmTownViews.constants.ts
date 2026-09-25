export const YARD_PREFABS: Record<string, string> = {
  layer: 'yard-coop',
  'dairy-cow': 'yard-cowshed',
  pig: 'yard-pigpen',
  sheep: 'yard-sheepfold',
};

export const HERD_STYLE: Record<string, { scale: number; slots: ReadonlyArray<readonly [number, number]> }> = {
  // Keep the first three places; the added pair stands farther back, inside the same front fences.
  layer: {
    scale: 0.53,
    slots: [
      [-43, 14],
      [0, -4],
      [43, 14],
      [-24, 20],
      [24, 20],
    ],
  },
  'dairy-cow': {
    scale: 0.78,
    slots: [
      [-55, 12],
      [0, -6],
      [55, 12],
      [-29, 18],
      [29, 18],
    ],
  },
  pig: {
    scale: 0.73,
    slots: [
      [-50, 12],
      [0, -5],
      [50, 12],
      [-26, 19],
      [26, 19],
    ],
  },
  sheep: {
    scale: 0.68,
    slots: [
      [-52, 13],
      [0, -5],
      [52, 13],
      [-28, 19],
      [28, 19],
    ],
  },
};
