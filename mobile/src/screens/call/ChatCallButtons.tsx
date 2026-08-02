import { useState } from 'react';
import { Pressable, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import type { CallerBrief, CallType } from '@ola/shared/types';
import { useCallStore } from '@store/callStore';
import { ensureCallPermissions } from './lib/callPermissionGuard';
import { PhoneIcon, VideoIcon } from './icons';

export function ChatCallButtons() {
  const { t } = useTranslation();
  const conversation = useChatStore(
    (s) => s.conversations.find((item) => item.id === s.currentConversationId) ?? null,
  );
  const draftRecipient = useChatStore((s) => s.draftRecipient);
  const ensureDirectConversation = useChatStore((s) => s.ensureDirectConversation);
  const mode = useCallStore((s) => s.mode);
  const pendingAction = useCallStore((s) => s.pendingAction);
  const startCall = useCallStore((s) => s.startCall);
  const push = useToastStore((s) => s.push);
  const [preparing, setPreparing] = useState(false);

  const otherUser = conversation?.type === 'direct' ? conversation.otherUser : null;
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

      const conversationId = await ensureDirectConversation(peer.id).catch(() => {
        push('error', t('call.startFailed'));
        return null;
      });
      if (conversationId == null) return;

      await startCall(conversationId, callType, peer);
    } finally {
      setPreparing(false);
    }
  };

  return (
    <View className="flex-row items-center">
      <Pressable
        accessibilityLabel={t('call.voiceCall')}
        disabled={busy}
        onPress={() => void handleCall('audio')}
        className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
        style={{ opacity: busy ? 0.4 : 1 }}
      >
        <PhoneIcon size={20} />
      </Pressable>
      <Pressable
        accessibilityLabel={t('call.videoCall')}
        disabled={busy}
        onPress={() => void handleCall('video')}
        className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
        style={{ opacity: busy ? 0.4 : 1 }}
      >
        <VideoIcon size={22} />
      </Pressable>
    </View>
  );
}
