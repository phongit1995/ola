import { useEffect, useMemo } from 'react';
import { useChatStore } from '@/store/chat/chatStore';
import { useFriendsStore } from '@/store/friendsStore';
import { usePresenceStore, type PresenceInfo } from '@/store/presenceStore';
import type { Conversation, Friend } from '@app-types';

export function useConversationsWithPresence(): Conversation[] {
  const conversations = useChatStore((s) => s.conversations);
  const presence = usePresenceStore((s) => s.presence);
  return useMemo(
    () =>
      conversations.map((conversation) => {
        const otherId = conversation.otherUser?.id;
        const live = otherId != null ? presence.get(otherId) : undefined;
        if (live == null || conversation.otherUser == null) return conversation;
        return {
          ...conversation,
          otherUser: { ...conversation.otherUser, isOnline: live.isOnline, lastActiveAt: live.lastActiveAt },
        };
      }),
    [conversations, presence]
  );
}

export function useFriendsWithPresence(): Friend[] {
  const friends = useFriendsStore((s) => s.friends);
  const presence = usePresenceStore((s) => s.presence);
  return useMemo(
    () =>
      friends.map((friend) => {
        const live = presence.get(friend.id);
        if (live == null) return friend;
        return { ...friend, isOnline: live.isOnline, lastActiveAt: live.lastActiveAt };
      }),
    [friends, presence]
  );
}

export function usePresenceListPolling(): void {
  useEffect(() => {
    usePresenceStore.getState().startListPolling(() => {
      const ids = new Set<string>();
      for (const conversation of useChatStore.getState().conversations) {
        const otherId = conversation.otherUser?.id;
        if (conversation.type === 'direct' && otherId != null && otherId !== '') ids.add(otherId);
      }
      for (const friend of useFriendsStore.getState().friends) ids.add(friend.id);
      return [...ids];
    });
    return () => usePresenceStore.getState().stopListPolling();
  }, []);
}

export function useFocusPresence(peerId: string | null): PresenceInfo | undefined {
  const live = usePresenceStore((s) => (peerId != null ? s.presence.get(peerId) : undefined));
  useEffect(() => {
    if (peerId == null || peerId === '') return;
    const store = usePresenceStore.getState();
    store.startFocusPolling(peerId);
    return () => store.stopFocusPolling();
  }, [peerId]);
  return live;
}
