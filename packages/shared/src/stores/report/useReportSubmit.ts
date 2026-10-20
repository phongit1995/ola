import { useCallback, useRef, useState } from 'react';
import i18n from 'i18next';
import { REPORT_ERROR_CODE } from '../../constants/report';
import { toApiError } from '../../lib/apiError';
import { toast } from '../../lib/toast';
import { ReportService } from '../../services/report.service';
import type { ReportReason, ReportTarget } from '../../types/report';

const HTTP_NOT_FOUND = 404;

export function useReportSubmit(target: ReportTarget, onDone: () => void) {
  const [submitting, setSubmitting] = useState(false);
  const inFlight = useRef(false);
  const { type, id, contextId } = target;

  const submit = useCallback(
    async (reason: ReportReason, note: string) => {
      if (inFlight.current) return;
      inFlight.current = true;
      setSubmitting(true);
      try {
        const trimmedNote = note.trim();
        await ReportService.create({
          targetType: type,
          targetId: id,
          contextId,
          reason,
          note: trimmedNote === '' ? undefined : trimmedNote,
        });
        toast.success(i18n.t('report.sent'));
        onDone();
      } catch (error) {
        const apiError = toApiError(error);
        if (apiError.code === REPORT_ERROR_CODE.alreadySubmitted) {
          toast.info(i18n.t('report.already'));
          onDone();
        } else if (apiError.status === HTTP_NOT_FOUND) {
          toast.error(i18n.t('report.notFound'));
          onDone();
        } else {
          toast.error(i18n.t('report.error'));
        }
      } finally {
        inFlight.current = false;
        setSubmitting(false);
      }
    },
    [type, id, contextId, onDone]
  );

  return { submitting, submit };
}
