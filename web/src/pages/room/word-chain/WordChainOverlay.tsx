import { useTranslation } from 'react-i18next';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { RoomJoiningOverlay } from '../components/RoomJoiningOverlay';
import { WordChainView } from './components/WordChainView';

export function WordChainOverlay({ visible }: { visible: boolean }) {
  const { t } = useTranslation();
  const opened = useWordChainStore((store) => store.opened);
  const status = useWordChainStore((store) => store.status);
  const close = useWordChainStore((store) => store.close);

  if (!opened) return null;

  return (
    <div className={visible ? '' : 'hidden'}>
      {status === 'joined' ? (
        <WordChainView visible={visible} onClose={close} />
      ) : (
        <RoomJoiningOverlay
          status={status}
          joiningText={t('wordChain.joining')}
          errorText={t('wordChain.joinError')}
          onClose={close}
        />
      )}
    </div>
  );
}
