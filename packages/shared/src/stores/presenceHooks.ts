import { useEffect, useMemo } from 'react';
import { useChatStore } from './chat/chatStore';
import { useFriendsStore } from './friendsStore';
import { usePresenceStore, type PresenceInfo } from './presenceStore';
import type { Conversation, Friend } from '../types';

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

function lastActiveMs(value?: string): number {
  if (value == null || value === '') return 0;
  const ms = Date.parse(value);
  return Number.isNaN(ms) ? 0 : ms;
}

function byOnlineThenRecent(a: Friend, b: Friend): number {
  if (a.isOnline !== b.isOnline) return a.isOnline ? -1 : 1;
  if (a.isOnline) return 0;
  return lastActiveMs(b.lastActiveAt) - lastActiveMs(a.lastActiveAt);
}

export function useFriendsWithPresence(): Friend[] {
  const friends = useFriendsStore((s) => s.friends);
  const presence = usePresenceStore((s) => s.presence);
  return useMemo(
    () =>
      friends
        .map((friend) => {
          const live = presence.get(friend.id);
          if (live == null) return friend;
          return { ...friend, isOnline: live.isOnline, lastActiveAt: live.lastActiveAt };
        })
        .sort(byOnlineThenRecent),
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
