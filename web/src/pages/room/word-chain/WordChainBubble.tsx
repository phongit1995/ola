import { useTranslation } from 'react-i18next';
import { FloatingBubble } from '@components';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { WordChainRoomIcon } from './components/WordChainRoomIcon';

const WORD_CHAIN_BUBBLE_STORAGE_KEY = 'ola.word-chain.bubble-position';

export function WordChainBubble({ onRestore }: { onRestore: () => void }) {
  const { t } = useTranslation();
  const opened = useWordChainStore((store) => store.opened);
  const minimized = useWordChainStore((store) => store.minimized);
  const notify = useWordChainStore((store) => store.notify);
  const syllable = useWordChainStore((store) => store.state?.requiredSyllable);
  const restore = useWordChainStore((store) => store.restore);
  const close = useWordChainStore((store) => store.close);

  if (!opened || !minimized) return null;

  const restoreLabel = notify
    ? `${t('wordChain.restore')}. ${t('wordChain.hasNotification')}`
    : t('wordChain.restore');

  return (
    <FloatingBubble
      storageKey={WORD_CHAIN_BUBBLE_STORAGE_KEY}
      positionClassName="right-4 bottom-28"
      notify={notify}
      label={`${restoreLabel}. ${t('wordChain.dragToLeave')}`}
      onRestore={() => {
        restore();
        onRestore();
      }}
      onClose={close}
    >
      <span className="relative flex">
        <WordChainRoomIcon className="h-11 w-11" />
        {syllable != null && syllable !== '' && (
          <span className="absolute -bottom-3.5 left-1/2 max-w-16 -translate-x-1/2 truncate rounded-full bg-ola-primary px-1.5 text-[11px] leading-4 font-semibold text-ola-on-primary shadow">
            {syllable}
          </span>
        )}
      </span>
    </FloatingBubble>
  );
}
