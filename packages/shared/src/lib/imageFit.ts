export interface BoxSize {
  width: number;
  height: number;
}

export function fitImageInBox(ratio: number | null, max: BoxSize, fallback: BoxSize): BoxSize {
  if (ratio == null || ratio <= 0) return fallback;
  let width = max.width;
  let height = width / ratio;
  if (height > max.height) {
    height = max.height;
    width = height * ratio;
  }
  return { width, height };
}
