import { useTranslation } from 'react-i18next';
import type { VipDayTransferForm } from '@ola/shared/stores/vip/useVipDayTransferForm';

export function VipDayTransferFields({ form }: { form: VipDayTransferForm }) {
  const { t } = useTranslation();
  const { config } = form;
  if (config == null) return null;

  return (
    <div className="flex flex-col gap-1">
      <p className="text-sm font-medium text-black/87">
        {t('vip.buy.transferDaysRate', { rate: config.rate })}
      </p>
      <label className="mt-2 text-xs text-black/54">
        {t('vip.buy.transferDaysLabel')}
      </label>
      <input
        inputMode="numeric"
        value={form.daysText}
        onChange={(event) =>
          form.setDaysText(event.target.value.replace(/\D/g, ''))
        }
        placeholder={t('vip.buy.transferDaysPlaceholder', {
          days: config.minSenderDays,
        })}
        className="w-full rounded border border-black/12 bg-white px-3 py-2 text-sm text-black/87 outline-none placeholder:text-black/38 focus:border-ola-primary"
      />
      {form.receiverDays > 0 && (
        <p className="mt-1 text-sm font-semibold text-ola-credit">
          {t('vip.buy.transferDaysReceive', { days: form.receiverDays })}
        </p>
      )}
      <p className="mt-1 text-xs text-black/54">
        {t('vip.buy.transferDaysMax', { days: form.maxSenderDays })}
      </p>
      <p className="text-xs text-black/54">
        {t('vip.buy.transferDaysMin', { days: config.minSenderDays })}
      </p>
    </div>
  );
}
