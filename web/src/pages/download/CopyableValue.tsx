import { useTranslation } from 'react-i18next';
import { toast } from '@lib';
import { CopyIcon } from './platformIcons';
import { copyToClipboard } from './copyToClipboard';

interface CopyableValueProps {
  label: string;
  value: string;
  hint?: string;
  emphasize?: boolean;
}

export function CopyableValue({
  label,
  value,
  hint,
  emphasize = false,
}: CopyableValueProps) {
  const { t } = useTranslation();

  async function handleCopy() {
    const copied = await copyToClipboard(value);
    if (copied) toast.success(t('download.copiedToClipboard'));
    else toast.error(t('common.error'));
  }

  return (
    <div className="mt-2.5 rounded-xl bg-black/3 px-3 py-2.5">
      <div className="flex items-center justify-between gap-2">
        <p className="min-w-0 flex-1 text-[11px] font-semibold text-black/55">
          {label}
        </p>
        <button
          type="button"
          onClick={handleCopy}
          className="flex h-7 shrink-0 items-center gap-1 rounded-lg border border-black/10 bg-white px-2 text-[11px] font-semibold text-ola-primary-dark"
        >
          <CopyIcon className="h-3.5 w-3.5" />
          {t('common.copy')}
        </button>
      </div>
      <p
        className={
          emphasize
            ? 'mt-1.5 font-mono text-base font-bold tracking-[0.18em] text-ola-primary-dark'
            : 'mt-1 font-mono text-[11px] leading-snug break-all text-black/60'
        }
      >
        {value}
      </p>
      {hint != null && (
        <p className="mt-1 text-[11px] leading-relaxed text-black/45">{hint}</p>
      )}
    </div>
  );
}
