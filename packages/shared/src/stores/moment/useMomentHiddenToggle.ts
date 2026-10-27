import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { MOMENT_ERROR_CODE } from '../../constants/moment';
import { toApiError } from '../../lib/apiError';
import { isMomentHiddenByAdmin } from '../../lib/moment';
import { toast } from '../../lib/toast';
import type { Moment } from '../../types/api/moment.type';
import { useMomentStore } from './momentStore';

export function useMomentHiddenToggle() {
  const { t } = useTranslation();
  const setHidden = useMomentStore((s) => s.setHidden);
  const [busyId, setBusyId] = useState<string | null>(null);

  async function toggleHidden(moment: Moment) {
    if (isMomentHiddenByAdmin(moment)) {
      toast.error(t('moment.hiddenByAdminError'));
      return;
    }
    const hidden = moment.hidden !== true;
    setBusyId(moment.id);
    try {
      await setHidden(moment.id, hidden);
      toast.success(t(hidden ? 'moment.hiddenToast' : 'moment.shownToast'));
    } catch (error) {
      const blocked = toApiError(error).code === MOMENT_ERROR_CODE.hiddenByAdmin;
      toast.error(t(blocked ? 'moment.hiddenByAdminError' : 'moment.toggleFailed'));
    } finally {
      setBusyId(null);
    }
  }

  return { busyId, toggleHidden };
}
