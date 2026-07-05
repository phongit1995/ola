import { useTranslation } from 'react-i18next';
import type { SpinSegment } from './spinWheel.constants';
import { spinRewardText } from './spinWheelText';
import { closeButtonUrl } from './spinWheelAssets';

interface SpinHistoryDialogProps {
  history: SpinSegment[];
  onClose: () => void;
}

export function SpinHistoryDialog({ history, onClose }: SpinHistoryDialogProps) {
  const { t } = useTranslation();

  return (
    <div
      className="fixed inset-0 z-[70] flex items-center justify-center bg-black/55 px-6"
      onClick={onClose}
    >
      <div
        className="relative w-[340px] max-w-[86vw] overflow-hidden rounded-2xl bg-white"
        onClick={(event) => event.stopPropagation()}
      >
        <div className="flex items-center justify-between bg-[#7cbf2a] px-4 py-3">
          <span className="text-base font-bold text-white">{t('wheelGame.historyTitle')}</span>
          <button
            type="button"
            onClick={onClose}
            aria-label={t('wheelGame.close')}
            className="h-8 w-8 active:scale-95"
          >
            <img src={closeButtonUrl} alt="" className="h-full w-full" />
          </button>
        </div>
        <ul className="max-h-[60vh] overflow-y-auto">
          {history.length === 0 ? (
            <li className="px-4 py-10 text-center text-sm text-black/45">
              {t('wheelGame.historyEmpty')}
            </li>
          ) : (
            history.map((segment, index) => (
              <li
                key={`${segment.id}-${index}`}
                className="flex items-center justify-between border-b border-black/8 px-4 py-3 last:border-b-0"
              >
                <span className="text-sm text-black/60">#{history.length - index}</span>
                <span
                  className={
                    segment.kind === 'miss'
                      ? 'text-sm font-semibold text-black/40'
                      : 'text-sm font-bold text-[#e0348b]'
                  }
                >
                  {spinRewardText(t, segment)}
                </span>
              </li>
            ))
          )}
        </ul>
      </div>
    </div>
  );
}
