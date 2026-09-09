import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  toast,
  formatKen,
  formatVnd,
  formatVndCurrency,
  buildVietQrImageUrl,
  fillMemoTemplate,
  quoteTopupKen,
  topupBonusPercentFor,
} from '@lib';
import { ScreenHeader, FullScreenOverlay } from '@components';
import type { TopupBonusTier } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { useTopupConfigStore } from '@/store/topupConfigStore';
import { MIN_AMOUNT, STEP_AMOUNT, PRESET_AMOUNTS } from './constants';

const NO_BONUS_TIERS: TopupBonusTier[] = [];

function CopyRow({ label, value }: { label: string; value: string }) {
  const { t } = useTranslation();

  async function copyValue() {
    if (navigator.clipboard == null) return;
    await navigator.clipboard.writeText(value);
    toast.info(t('ken.buy.copied'));
  }

  return (
    <div className="flex items-center border-b border-black/8 py-2 last:border-b-0">
      <div className="min-w-0 flex-1">
        <span className="block text-xs text-black/54">{label}</span>
        <span className="block truncate text-sm font-medium text-black/87">
          {value}
        </span>
      </div>
      <button
        type="button"
        onClick={copyValue}
        className="ml-2 shrink-0 rounded border border-black/12 px-2 py-1 text-xs text-ola-primary-ink active:bg-black/5"
      >
        {t('common.copy')}
      </button>
    </div>
  );
}

export function BuyKenPage({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
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
  const bonusTiers = config?.bonusTiers ?? NO_BONUS_TIERS;
  const bank = config?.bank;

  const amount =
    customText == null
      ? selectedPreset ?? presetAmounts[0] ?? minAmount
      : customText === ''
      ? 0
      : Number(customText);
  const isValid = amount >= minAmount && amount % stepAmount === 0;
  const quote = quoteTopupKen(amount, bonusTiers);
  const kenAmount = quote.total;
  const balance = user?.ken ?? 0;

  const memo = useMemo(
    () =>
      fillMemoTemplate(
        bank?.memoTemplate || '@{username}',
        user?.username ?? ''
      ),
    [bank?.memoTemplate, user?.username]
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

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('ken.buy.title')} onBack={onClose} />

      <div className="flex-1 overflow-y-auto bg-[#ececec] pb-6">
        <div className="m-2 flex items-center rounded-sm border border-black/12 bg-white px-3 py-2.5">
          <span className="text-sm text-black/54">{t('ken.buy.balance')}</span>
          <span className="ml-2 flex-1 text-lg font-bold text-ola-primary-ink">
            {formatKen(balance)} KEN
          </span>
        </div>

        {config == null ? (
          <div className="mx-2 rounded-sm border border-black/12 bg-white p-4 text-center text-sm text-black/54">
            {t('common.loading')}
          </div>
        ) : !config.enabled ? (
          <div className="mx-2 rounded-sm border border-black/12 bg-white p-4 text-center text-sm text-black/54">
            {t('ken.buy.disabled')}
          </div>
        ) : (
          <>
            <div className="mx-2 rounded-sm border border-black/12 bg-white p-3">
              <span className="text-xs text-black/54">
                {t('ken.buy.chooseAmount')}
              </span>
              <div className="mt-2 grid grid-cols-3 gap-2">
                {presetAmounts.map((value) => {
                  const bonusPercent = topupBonusPercentFor(value, bonusTiers);
                  return (
                    <button
                      key={value}
                      type="button"
                      onClick={() => selectPreset(value)}
                      className={`relative rounded border px-2 py-2 text-sm font-medium transition-colors ${
                        amount === value && customText == null
                          ? 'border-ola-primary bg-ola-primary/10 text-ola-primary-ink'
                          : 'border-black/12 bg-white text-black/87'
                      }`}
                    >
                      {formatVndCurrency(value)}
                      {bonusPercent > 0 && (
                        <span className="absolute -top-1.5 right-1 rounded-full bg-ola-accent px-1.5 text-[10px] font-semibold leading-4 text-white">
                          {t('ken.buy.bonusBadge', { percent: bonusPercent })}
                        </span>
                      )}
                    </button>
                  );
                })}
              </div>

              <span className="mt-3 block text-xs text-black/54">
                {t('ken.buy.customLabel')}
              </span>
              <input
                type="text"
                inputMode="numeric"
                value={customText ?? ''}
                onChange={(event) => changeCustom(event.target.value)}
                placeholder={t('ken.buy.customHint', {
                  min: formatVnd(minAmount),
                  step: formatVnd(stepAmount),
                })}
                className="mt-1 w-full rounded border border-black/12 bg-white px-3 py-2 text-base text-black/87 outline-none placeholder:text-black/38 focus:border-ola-primary"
              />

              <div className="mt-3 flex items-center">
                <span className="text-sm text-black/54">
                  {t('ken.buy.receive')}
                </span>
                <span className="ml-2 flex-1 text-lg font-bold text-ola-accent">
                  {formatKen(isValid ? kenAmount : 0)} KEN
                </span>
              </div>
              {isValid && quote.bonus > 0 && (
                <span className="mt-1 block text-xs text-ola-accent">
                  {t('ken.buy.bonusLine', {
                    bonus: formatKen(quote.bonus),
                    percent: quote.bonusPercent,
                  })}
                </span>
              )}
              {!isValid && (
                <span className="mt-1 block text-xs text-ola-error">
                  {t('ken.buy.invalid', {
                    min: formatVnd(minAmount),
                    step: formatVnd(stepAmount),
                  })}
                </span>
              )}
            </div>

            {isValid && (
              <div className="mx-2 mt-2 rounded-sm border border-black/12 bg-white p-3">
                {bank == null ? (
                  <p className="py-4 text-center text-sm text-black/54">
                    {t('ken.buy.notConfigured')}
                  </p>
                ) : (
                  <>
                    <span className="block text-center text-sm font-medium text-black/87">
                      {t('ken.buy.qrTitle')}
                    </span>
                    {qrImageUrl != null && (
                      <div className="mt-3 flex justify-center">
                        <div className="rounded border border-black/12 bg-white p-2">
                          <img
                            src={qrImageUrl}
                            alt="VietQR"
                            className="h-56 w-56 object-contain"
                          />
                        </div>
                      </div>
                    )}
                    <div className="mt-3">
                      {bank.bankName !== '' && (
                        <div className="border-b border-black/8 py-2">
                          <span className="block text-xs text-black/54">
                            {t('ken.buy.bankLabel')}
                          </span>
                          <span className="block text-sm font-medium text-black/87">
                            {bank.bankName}
                          </span>
                        </div>
                      )}
                      <CopyRow
                        label={t('ken.buy.accountNumberLabel')}
                        value={bank.accountNumber}
                      />
                      {bank.accountName !== '' && (
                        <div className="border-b border-black/8 py-2">
                          <span className="block text-xs text-black/54">
                            {t('ken.buy.accountNameLabel')}
                          </span>
                          <span className="block text-sm font-medium text-black/87">
                            {bank.accountName}
                          </span>
                        </div>
                      )}
                      {memo !== '' && (
                        <CopyRow label={t('ken.buy.memoLabel')} value={memo} />
                      )}
                    </div>
                    <div className="mt-3 text-center">
                      <span className="block text-xs text-black/54">
                        {t('ken.buy.amountLabel')}
                      </span>
                      <span className="block text-lg font-bold text-black/87">
                        {formatVndCurrency(amount)}
                      </span>
                    </div>
                    <p className="mt-2 text-center text-xs text-black/54">
                      {t('ken.buy.qrHint', { ken: formatKen(kenAmount) })}
                    </p>
                    <button
                      type="button"
                      onClick={() => toast.info(t('ken.buy.paidPending'))}
                      className="mt-3 w-full rounded-sm border border-ola-primary-dark bg-ola-button py-2.5 text-sm font-medium text-ola-on-primary active:opacity-90"
                    >
                      {t('ken.buy.paid')}
                    </button>
                    <p className="mt-2 text-center text-[11px] text-black/38">
                      {t('ken.buy.memoHint')}
                    </p>
                  </>
                )}
              </div>
            )}
          </>
        )}
      </div>
    </FullScreenOverlay>
  );
}
