function boundedScrollHeight(windowHeight: number, reservedHeight: number, maximumHeight: number): number {
  return Math.max(1, Math.min(maximumHeight, windowHeight - reservedHeight));
}

export function eggHistoryScrollHeight(windowHeight: number): number {
  return boundedScrollHeight(windowHeight, 180, 380);
}

export function eggGiftScrollHeight(windowHeight: number): number {
  return boundedScrollHeight(windowHeight, 114, 500);
}
