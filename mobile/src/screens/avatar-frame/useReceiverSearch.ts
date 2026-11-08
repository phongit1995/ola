import { useEffect, useState } from 'react';
import { UserService } from '@ola/shared/services';
import type { UserSearchResult } from '@ola/shared/types';
import { RECEIVER_SEARCH_DEBOUNCE_MS, RECEIVER_SEARCH_LIMIT } from '@screens/vip/constants';

export function useReceiverSearch() {
  const [receiverUser, setReceiverUser] = useState<UserSearchResult | null>(null);
  const [receiverQuery, setReceiverQuery] = useState('');
  const [receiverResults, setReceiverResults] = useState<UserSearchResult[]>([]);
  const [receiverSearching, setReceiverSearching] = useState(false);

  useEffect(() => {
    const value = receiverQuery.trim();
    let cancelled = false;
    const timer = setTimeout(() => {
      if (value === '') {
        setReceiverResults([]);
        setReceiverSearching(false);
        return;
      }
      setReceiverSearching(true);
      UserService.search(value, RECEIVER_SEARCH_LIMIT)
        .then((res) => {
          if (!cancelled) setReceiverResults(res.users);
        })
        .catch(() => {
          if (!cancelled) setReceiverResults([]);
        })
        .finally(() => {
          if (!cancelled) setReceiverSearching(false);
        });
    }, RECEIVER_SEARCH_DEBOUNCE_MS);
    return () => {
      cancelled = true;
      clearTimeout(timer);
    };
  }, [receiverQuery]);

  function pickReceiver(picked: UserSearchResult) {
    setReceiverUser(picked);
    setReceiverQuery('');
    setReceiverResults([]);
  }

  function clearReceiver() {
    setReceiverUser(null);
    setReceiverQuery('');
    setReceiverResults([]);
  }

  return {
    receiverUser,
    receiverQuery,
    setReceiverQuery,
    receiverResults,
    receiverSearching,
    pickReceiver,
    clearReceiver,
  };
}
