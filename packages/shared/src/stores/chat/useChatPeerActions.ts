import i18n from 'i18next';
import { toast } from '../../lib/toast';
import { useChatStore } from './chatStore';

export function useChatPeerActions(peerName: string, blocked: boolean) {
  const blockPeer = useChatStore((s) => s.blockPeer);
  const unblockPeer = useChatStore((s) => s.unblockPeer);
  const friendAction = useChatStore((s) => s.friendAction);
  const t = i18n.t;

  async function handleFriendAction() {
    if (blocked) {
      toast.info(t('chat.makeFriendBlocked'));
      return;
    }
    const result = await friendAction();
    if (result === 'error') {
      toast.error(t('chat.actionError'));
      return;
    }
    if (result === 'request') toast.success(t('chat.friendRequestSent'));
    else if (result === 'cancel') toast.success(t('chat.requestCancelled'));
    else if (result === 'accept') toast.success(t('chat.friendAccepted'));
    else if (result === 'unfriend') toast.success(t('chat.unfriendDone'));
  }

  async function handleBlock() {
    const ok = await blockPeer();
    if (ok) toast.success(t('chat.blockDone', { name: peerName }));
    else toast.error(t('chat.actionError'));
  }

  async function handleUnblock() {
    const ok = await unblockPeer();
    if (ok) toast.success(t('chat.unblockDone', { name: peerName }));
    else toast.error(t('chat.actionError'));
  }

  return { handleFriendAction, handleBlock, handleUnblock };
}
