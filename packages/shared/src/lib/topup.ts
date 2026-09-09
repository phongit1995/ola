import type { TopupBonusTier } from '../types/api/settings.type';

export interface TopupKenQuote {
  base: number;
  bonusPercent: number;
  bonus: number;
  total: number;
}

export function topupBonusPercentFor(amountVnd: number, tiers: TopupBonusTier[]): number {
  let percent = 0;
  let bestMin = -1;
  for (const tier of tiers) {
    if (amountVnd >= tier.minAmount && tier.minAmount > bestMin) {
      bestMin = tier.minAmount;
      percent = tier.percent;
    }
  }
  return percent;
}

export function quoteTopupKen(amountVnd: number, tiers: TopupBonusTier[] = []): TopupKenQuote {
  const bonusPercent = topupBonusPercentFor(amountVnd, tiers);
  const bonus = Math.floor((amountVnd * bonusPercent) / 100);
  return { base: amountVnd, bonusPercent, bonus, total: amountVnd + bonus };
}
