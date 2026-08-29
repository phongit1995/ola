import { useEffect } from 'react';
import { totalUnreadOf } from '@ola/shared/stores/chat/chatHelpers';
import { useChatStore } from '@/store/chat/chatStore';

const baseTitle = document.title;

export function useUnreadTitle() {
  const unread = useChatStore((state) => totalUnreadOf(state.conversations));

  useEffect(() => {
    document.title =
      unread > 0
        ? `(${unread > 99 ? '99+' : unread}) ${baseTitle}`
        : baseTitle;
  }, [unread]);
}
