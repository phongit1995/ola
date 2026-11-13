import { useState } from 'react';
import type { UserSearchResult } from '../../types/api/user.type';
import { useUserSearch, type UserSearchOptions } from './useUserSearch';

export function useReceiverSearch(options?: UserSearchOptions) {
  const [receiverUser, setReceiverUser] = useState<UserSearchResult | null>(null);
  const [receiverQuery, setReceiverQuery] = useState('');
  const { results, searching } = useUserSearch(receiverQuery, options);

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
