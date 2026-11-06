export function normalizeQuantityOptions(values: Array<number | string>): number[] {
  const numbers = values
    .map((value) => Number(value))
    .filter((value) => Number.isInteger(value) && value > 0)
  return [...new Set(numbers)].sort((a, b) => a - b)
}
