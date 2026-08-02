import { useTranslation } from 'react-i18next';
import type { CallType } from '@app-types';
import { useCallStore } from '@/store/callStore';
import { useChatStore } from '@/store/chat/chatStore';
import { ensureCallPermissions } from './lib/callPermissionGuard';
import { PhoneIcon, VideoIcon } from './icons';

export function ChatCallButtons() {
  const { t } = useTranslation();
  const conversation = useChatStore(
    (s) =>
      s.conversations.find((item) => item.id === s.currentConversationId) ??
      null
  );
  const mode = useCallStore((s) => s.mode);
  const pendingAction = useCallStore((s) => s.pendingAction);
  const startCall = useCallStore((s) => s.startCall);

  const peer = conversation?.type === 'direct' ? conversation.otherUser : null;
  if (conversation == null || peer == null) return null;

  const busy = mode !== 'idle' || pendingAction != null;

  const handleCall = async (callType: CallType) => {
    if (busy) return;
    const allowed = await ensureCallPermissions(callType, t);
    if (!allowed) return;
    await startCall(conversation.id, callType, {
      id: peer.id,
      username: peer.username,
      fullName: peer.fullName,
      avatar: peer.avatar,
    });
  };

  return (
    <>
      <button
        type="button"
        aria-label={t('call.voiceCall')}
        disabled={busy}
        onClick={() => void handleCall('audio')}
        className="flex h-9 w-9 items-center justify-center rounded-full text-white hover:bg-white/15 disabled:opacity-40"
      >
        <PhoneIcon />
      </button>
      <button
        type="button"
        aria-label={t('call.videoCall')}
        disabled={busy}
        onClick={() => void handleCall('video')}
        className="flex h-9 w-9 items-center justify-center rounded-full text-white hover:bg-white/15 disabled:opacity-40"
      >
        <VideoIcon />
      </button>
    </>
  );
}
