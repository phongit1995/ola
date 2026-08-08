import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';

interface ActionLinkProps {
  href: string;
  label: string;
  icon?: ReactNode;
  tone?: 'primary' | 'outline';
}

export function ActionLink({
  href,
  label,
  icon,
  tone = 'primary',
}: ActionLinkProps) {
  const toneClass =
    tone === 'primary'
      ? 'bg-ola-primary text-ola-on-primary hover:bg-ola-primary-dark'
      : 'border border-black/15 text-black/75 hover:border-ola-primary hover:text-ola-primary-ink';

  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      className={`flex h-11 items-center justify-center gap-2 rounded-xl px-4 text-sm font-semibold transition-colors ${toneClass}`}
    >
      {icon}
      {label}
    </a>
  );
}

interface DownloadGuideBodyProps {
  channel: string;
  isCurrentDevice: boolean;
  chips?: string[];
  steps: string[];
  note: string;
  children: ReactNode;
  illustrations?: ReactNode;
  footer?: ReactNode;
}

export function DownloadGuideBody({
  channel,
  isCurrentDevice,
  chips = [],
  steps,
  note,
  children,
  illustrations,
  footer,
}: DownloadGuideBodyProps) {
  const { t } = useTranslation();

  return (
    <div className="px-4 py-4">
      <div className="flex items-center justify-between gap-2">
        <p className="min-w-0 flex-1 text-[13px] font-semibold text-black/70">
          {channel}
        </p>
        {isCurrentDevice && (
          <span className="shrink-0 rounded-full bg-ola-primary/12 px-2.5 py-1 text-[11px] font-semibold text-ola-primary-dark">
            {t('download.yourDevice')}
          </span>
        )}
      </div>

      {chips.length > 0 && (
        <div className="mt-2.5 flex flex-wrap gap-1.5">
          {chips.map((chip) => (
            <span
              key={chip}
              className="rounded-full bg-black/5 px-2.5 py-1 text-[11px] text-black/60"
            >
              {chip}
            </span>
          ))}
        </div>
      )}

      <div className="mt-3 flex flex-col gap-2">{children}</div>

      <p className="pt-4 pb-2.5 text-[13px] font-semibold text-black/70">
        {t('download.stepsTitle')}
      </p>
      <ol className="space-y-2.5">
        {steps.map((step, index) => (
          <li key={step} className="flex gap-2.5">
            <span className="mt-px flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-ola-primary text-[11px] font-bold text-ola-on-primary">
              {index + 1}
            </span>
            <span className="text-[13px] leading-relaxed text-black/75">
              {step}
            </span>
          </li>
        ))}
      </ol>

      {illustrations}

      <p className="mt-3.5 rounded-xl bg-[#fff8e1] px-3 py-2.5 text-xs leading-relaxed text-[#6d4c00]">
        {note}
      </p>

      {footer}
    </div>
  );
}
