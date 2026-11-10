import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { fitMomentMusic } from '../../lib/momentMusic';
import { toast } from '../../lib/toast';
import type { MomentMusicDraft } from '../../types/client/moment.type';

export function useMomentMusicFit(music: MomentMusicDraft | null, slideCount: number) {
  const { t } = useTranslation();
  const fitted = music == null ? null : fitMomentMusic(music, slideCount);
  const seconds = fitted?.slideSeconds ?? null;
  const previous = useRef({ slideCount, seconds });

  useEffect(() => {
    const last = previous.current;
    previous.current = { slideCount, seconds };
    if (slideCount <= last.slideCount || seconds == null || last.seconds == null) return;
    if (seconds < last.seconds) {
      toast.info(t('moment.musicAutoFit', { seconds, pages: slideCount }));
    }
  }, [slideCount, seconds, t]);

  return { fitted, tooShort: music != null && fitted == null };
}
