import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  REPORT_NOTE_MAX_LENGTH,
  REPORT_REASONS,
  type ReportReason,
} from '@constants';
import type { ReportTarget } from '@app-types';
import { useReportSubmit } from '@ola/shared/stores/report/useReportSubmit';
import { Dialog, DialogButton } from './Dialog';

interface ReportDialogProps {
  target: ReportTarget;
  onClose: () => void;
}

export function ReportDialog({ target, onClose }: ReportDialogProps) {
  const { t } = useTranslation();
  const [reason, setReason] = useState<ReportReason | null>(null);
  const [note, setNote] = useState('');
  const { submitting, submit } = useReportSubmit(target, onClose);

  function handleSubmit() {
    if (reason != null) void submit(reason, note);
  }

  return (
    <Dialog
      open
      onClose={onClose}
      title={t('report.title')}
      footer={
        <>
          <DialogButton onClick={onClose}>{t('dialog.cancel')}</DialogButton>
          <DialogButton
            variant="green"
            disabled={reason == null || submitting}
            onClick={handleSubmit}
          >
            {t('report.send')}
          </DialogButton>
        </>
      }
    >
      <div className="flex flex-col">
        {REPORT_REASONS.map((item, index) => {
          const selected = reason === item.value;
          return (
            <button
              key={item.value}
              type="button"
              aria-pressed={selected}
              onClick={() => setReason(item.value)}
              className={`flex items-center gap-2 px-1 py-2.5 text-left text-sm text-black/87 hover:bg-black/5 ${
                index > 0 ? 'border-t border-black/8' : ''
              }`}
            >
              <span
                className={`flex h-[18px] w-[18px] shrink-0 items-center justify-center rounded-full border-2 ${
                  selected ? 'border-ola-primary' : 'border-black/30'
                }`}
              >
                {selected && (
                  <span className="h-2.5 w-2.5 rounded-full bg-ola-primary" />
                )}
              </span>
              {t(item.labelKey)}
            </button>
          );
        })}
        <textarea
          value={note}
          onChange={(event) => setNote(event.target.value)}
          placeholder={t('report.notePlaceholder')}
          rows={3}
          maxLength={REPORT_NOTE_MAX_LENGTH}
          className="mt-2 w-full resize-none rounded-sm border border-black/12 bg-white p-2 text-sm text-black/87 outline-none placeholder:text-black/38 focus:border-ola-primary"
        />
      </div>
    </Dialog>
  );
}
