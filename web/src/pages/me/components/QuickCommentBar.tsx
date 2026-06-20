import { useTranslation } from 'react-i18next';
import { MeCommentComposer } from './MeCommentComposer';

interface QuickCommentBarProps {
  contextLabel?: string;
  submitting: boolean;
  onSubmit: (text: string) => Promise<boolean>;
  onClose: () => void;
}

export function QuickCommentBar({ contextLabel, submitting, onSubmit, onClose }: QuickCommentBarProps) {
  const { t } = useTranslation();

  return (
    <>
      <button
        type="button"
        aria-label={t('chat.back')}
        onClick={onClose}
        className="fixed inset-0 z-30 bg-black/20"
      />
      <div className="fixed inset-x-0 bottom-0 z-40">
        {contextLabel != null && (
          <div className="flex items-center gap-2 border-t border-black/12 bg-white/95 px-3 py-1.5 text-xs text-black/54">
            <span className="shrink-0">{t('me.commentingOn')}</span>
            <span className="min-w-0 flex-1 truncate text-black/87">{contextLabel}</span>
          </div>
        )}
        <MeCommentComposer submitting={submitting} onSubmit={onSubmit} autoFocus />
      </div>
    </>
  );
}
