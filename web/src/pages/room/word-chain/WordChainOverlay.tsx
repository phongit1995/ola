import { useTranslation } from 'react-i18next';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { RoomJoiningOverlay } from '../components/RoomJoiningOverlay';
import { WordChainView } from './components/WordChainView';

export function WordChainOverlay({ visible }: { visible: boolean }) {
  const { t } = useTranslation();
  const opened = useWordChainStore((store) => store.opened);
  const minimized = useWordChainStore((store) => store.minimized);
  const status = useWordChainStore((store) => store.status);
  const close = useWordChainStore((store) => store.close);
  const pushOverlay = useAppOverlayStore((store) => store.push);

  if (!opened) return null;

  const shown = visible && !minimized;

  function buyVip() {
    close();
    pushOverlay('vipBuy', 'extend');
  }

  return (
    <div className={shown ? '' : 'hidden'}>
      {status === 'joined' ? (
        <WordChainView visible={shown} onClose={close} />
      ) : (
        <RoomJoiningOverlay
          status={status}
          joiningText={t('wordChain.joining')}
          errorText={t('wordChain.joinError')}
          vipRequiredText={t('wordChain.vipToView')}
          onClose={close}
          onBuyVip={buyVip}
        />
      )}
    </div>
  );
}
