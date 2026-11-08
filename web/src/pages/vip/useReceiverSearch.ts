import { useState } from 'react';
import { useUserSearch } from '@ola/shared/stores/user/useUserSearch';
import type { UserSearchResult } from '@app-types';

export function useReceiverSearch() {
  const [receiverUser, setReceiverUser] = useState<UserSearchResult | null>(
    null
  );
  const [receiverQuery, setReceiverQuery] = useState('');
  const { results, searching } = useUserSearch(receiverQuery);

  function pickReceiver(picked: UserSearchResult) {
    setReceiverUser(picked);
    setReceiverQuery('');
  }

  function clearReceiver() {
    setReceiverUser(null);
    setReceiverQuery('');
  }

  return {
    receiverUser,
    receiverQuery,
    setReceiverQuery,
    receiverResults: results,
    receiverSearching: searching,
    pickReceiver,
    clearReceiver,
  };
}
