import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { toast, formatKen, formatVnd } from '@lib';
import { ScreenHeader, FullScreenOverlay } from '@components';
import { useAuthStore } from '@/store/authStore';
import { MIN_AMOUNT, STEP_AMOUNT, PRESET_AMOUNTS, QR_MODULES } from './constants';

function isFinderBit(localRow: number, localCol: number): boolean {
  const onOuterRing =
    localRow === 0 || localRow === 6 || localCol === 0 || localCol === 6;
  const onInnerBlock =
    localRow >= 2 && localRow <= 4 && localCol >= 2 && localCol <= 4;
  return onOuterRing || onInnerBlock;
}

function finderModule(row: number, col: number, size: number): boolean | null {
  const corners = [
    { r0: 0, c0: 0 },
    { r0: 0, c0: size - 7 },
    { r0: size - 7, c0: 0 },
  ];
  for (const { r0, c0 } of corners) {
    const inFinder = row >= r0 && row < r0 + 7 && col >= c0 && col < c0 + 7;
    if (inFinder) return isFinderBit(row - r0, col - c0);
    const sr0 = r0 === 0 ? 0 : r0 - 1;
    const sc0 = c0 === 0 ? 0 : c0 - 1;
    const inSeparator = row >= sr0 && row < sr0 + 8 && col >= sc0 && col < sc0 + 8;
    if (inSeparator) return false;
  }
  return null;
}

function dataModule(row: number, col: number, seed: number): boolean {
  let hash = ((row + 1) * 73856093) ^ ((col + 1) * 19349663) ^ ((seed + 1) * 83492791);
  hash ^= hash >>> 13;
  hash = (hash * 1274126177) | 0;
  hash ^= hash >>> 16;
  return (hash & 1) === 1;
}

function FakeQrCode({ seed }: { seed: number }) {
  const cells = useMemo(() => {
    const result: { row: number; col: number }[] = [];
    for (let row = 0; row < QR_MODULES; row += 1) {
      for (let col = 0; col < QR_MODULES; col += 1) {
        const fromFinder = finderModule(row, col, QR_MODULES);
        const filled = fromFinder != null ? fromFinder : dataModule(row, col, seed);
        if (filled) result.push({ row, col });
      }
    }
    return result;
  }, [seed]);

  const quiet = 2;
  const total = QR_MODULES + quiet * 2;

  return (
    <svg
      viewBox={`0 0 ${total} ${total}`}
      className="h-56 w-56"
      shapeRendering="crispEdges"
      role="img"
      aria-label="QR"
    >
      <rect x="0" y="0" width={total} height={total} fill="#ffffff" />
      {cells.map(({ row, col }) => (
        <rect key={`${row}-${col}`} x={col + quiet} y={row + quiet} width="1" height="1" fill="#000000" />
      ))}
    </svg>
  );
}

export function BuyKenPage({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);

  const [amount, setAmount] = useState(MIN_AMOUNT);
  const [customText, setCustomText] = useState('');

  const isValid = amount >= MIN_AMOUNT && amount % STEP_AMOUNT === 0;
  const kenAmount = amount;
  const balance = user?.ken ?? 0;

  function selectPreset(value: number) {
    setAmount(value);
    setCustomText('');
  }

  function changeCustom(raw: string) {
    const digits = raw.replace(/\D/g, '');
    setCustomText(digits);
    setAmount(digits === '' ? 0 : Number(digits));
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('ken.buy.title')} onBack={onClose} />

      <div className="flex-1 overflow-y-auto bg-[#ececec] pb-6">
        <div className="m-2 flex items-center rounded-sm border border-black/12 bg-white px-3 py-2.5">
          <span className="text-sm text-black/54">{t('ken.buy.balance')}</span>
          <span className="ml-2 flex-1 text-lg font-bold text-ola-primary">
            {formatKen(balance)} KEN
          </span>
        </div>

        <div className="mx-2 rounded-sm border border-black/12 bg-white p-3">
          <span className="text-xs text-black/54">{t('ken.buy.chooseAmount')}</span>
          <div className="mt-2 grid grid-cols-3 gap-2">
            {PRESET_AMOUNTS.map((value) => (
              <button
                key={value}
                type="button"
                onClick={() => selectPreset(value)}
                className={`rounded border px-2 py-2 text-sm font-medium transition-colors ${
                  amount === value && customText === ''
                    ? 'border-ola-primary bg-ola-primary/10 text-ola-primary'
                    : 'border-black/12 bg-white text-black/87'
                }`}
              >
                {formatVnd(value)}đ
              </button>
            ))}
          </div>

          <span className="mt-3 block text-xs text-black/54">{t('ken.buy.customLabel')}</span>
          <input
            type="text"
            inputMode="numeric"
            value={customText}
            onChange={(event) => changeCustom(event.target.value)}
            placeholder={t('ken.buy.customHint')}
            className="mt-1 w-full rounded border border-black/12 bg-white px-3 py-2 text-base text-black/87 outline-none placeholder:text-black/38 focus:border-ola-primary"
          />

          <div className="mt-3 flex items-center">
            <span className="text-sm text-black/54">{t('ken.buy.receive')}</span>
            <span className="ml-2 flex-1 text-lg font-bold text-ola-accent">
              {formatKen(isValid ? kenAmount : 0)} KEN
            </span>
          </div>
          {!isValid && <span className="mt-1 block text-xs text-[#e34545]">{t('ken.buy.invalid')}</span>}
        </div>

        {isValid && (
          <div className="mx-2 mt-2 rounded-sm border border-black/12 bg-white p-3">
            <span className="block text-center text-sm font-medium text-black/87">
              {t('ken.buy.qrTitle')}
            </span>
            <div className="mt-3 flex justify-center">
              <div className="rounded border border-black/12 p-2">
                <FakeQrCode seed={amount} />
              </div>
            </div>
            <div className="mt-3 text-center">
              <span className="block text-xs text-black/54">{t('ken.buy.amountLabel')}</span>
              <span className="block text-lg font-bold text-black/87">{formatVnd(amount)}đ</span>
            </div>
            <p className="mt-2 text-center text-xs text-black/54">
              {t('ken.buy.qrHint', { ken: formatKen(kenAmount) })}
            </p>
            <button
              type="button"
              onClick={() => toast.info(t('ken.buy.paidPending'))}
              className="mt-3 w-full rounded-sm border border-ola-primary-dark bg-[#9ccc65] py-2.5 text-sm font-medium text-white active:opacity-90"
            >
              {t('ken.buy.paid')}
            </button>
            <p className="mt-2 text-center text-[11px] text-black/38">{t('ken.buy.demoNote')}</p>
          </div>
        )}
      </div>
    </FullScreenOverlay>
  );
}
