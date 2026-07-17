import { useEffect, useMemo, useState } from 'react';
import { buildVietQrImageUrl, fillMemoTemplate } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useTopupConfigStore } from '@ola/shared/stores/topupConfigStore';
import { MIN_AMOUNT, PRESET_AMOUNTS, STEP_AMOUNT } from './constants';

export function useBuyKen() {
  const user = useAuthStore((s) => s.user);
  const config = useTopupConfigStore((s) => s.config);
  const loadConfig = useTopupConfigStore((s) => s.load);
  const [selectedPreset, setSelectedPreset] = useState<number | null>(null);
  const [customText, setCustomText] = useState<string | null>(null);

  useEffect(() => {
    void loadConfig();
  }, [loadConfig]);

  const minAmount = config?.minAmount ?? MIN_AMOUNT;
  const stepAmount = config?.stepAmount ?? STEP_AMOUNT;
  const presetAmounts = config?.presetAmounts ?? PRESET_AMOUNTS;
  const kenPerVnd = config?.kenPerVnd ?? 1;
  const bank = config?.bank;

  const amount =
    customText == null
      ? (selectedPreset ?? presetAmounts[0] ?? minAmount)
      : customText === ''
        ? 0
        : Number(customText);
  const isValid = amount >= minAmount && amount % stepAmount === 0;
  const kenAmount = amount * kenPerVnd;
  const balance = user?.ken ?? 0;

  const memo = useMemo(
    () => fillMemoTemplate(bank?.memoTemplate || '@{username}', user?.username ?? ''),
    [bank?.memoTemplate, user?.username],
  );

  const qrImageUrl = useMemo(() => {
    if (!bank?.bankBin || !bank.accountNumber || !isValid) return null;
    return buildVietQrImageUrl({
      bankBin: bank.bankBin,
      accountNumber: bank.accountNumber,
      amount,
      memo,
      accountName: bank.accountName,
    });
  }, [bank, isValid, amount, memo]);

  function selectPreset(value: number) {
    setSelectedPreset(value);
    setCustomText(null);
  }

  function changeCustom(raw: string) {
    setCustomText(raw.replace(/\D/g, ''));
  }

  return {
    config,
    bank,
    minAmount,
    stepAmount,
    presetAmounts,
    amount,
    isValid,
    kenAmount,
    balance,
    memo,
    qrImageUrl,
    customText,
    selectPreset,
    changeCustom,
  };
}
