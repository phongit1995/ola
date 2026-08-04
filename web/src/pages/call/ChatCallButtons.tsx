import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { toast } from '@lib';
import type { CallerBrief, CallType } from '@app-types';
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
  const draftRecipient = useChatStore((s) => s.draftRecipient);
  const ensureDirectConversation = useChatStore(
    (s) => s.ensureDirectConversation
  );
  const mode = useCallStore((s) => s.mode);
  const pendingAction = useCallStore((s) => s.pendingAction);
  const startCall = useCallStore((s) => s.startCall);
  const [preparing, setPreparing] = useState(false);

  const otherUser =
    conversation?.type === 'direct' ? conversation.otherUser : null;
  const peer: CallerBrief | null =
    otherUser != null
      ? {
          id: otherUser.id,
          username: otherUser.username,
          fullName: otherUser.fullName,
          avatar: otherUser.avatar,
        }
      : draftRecipient != null
      ? {
          id: draftRecipient.id,
          fullName: draftRecipient.name,
          avatar: draftRecipient.avatar,
        }
      : null;

  if (peer == null) return null;

  const busy = mode !== 'idle' || pendingAction != null || preparing;

  const handleCall = async (callType: CallType) => {
    if (busy) return;
    setPreparing(true);
    try {
      const allowed = await ensureCallPermissions(callType, t);
      if (!allowed) return;

      const conversationId = await ensureDirectConversation(peer.id).catch(
        () => {
          toast.error(t('call.startFailed'));
          return null;
        }
      );
      if (conversationId == null) return;

      await startCall(conversationId, callType, peer);
    } finally {
      setPreparing(false);
    }
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
