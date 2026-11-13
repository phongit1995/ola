import { useEffect, useRef, useState } from 'react';
import { UserService } from '../../services/user.service';
import type { UserSearchResult } from '../../types/api/user.type';

const USER_SEARCH_DEBOUNCE_MS = 300;
export const USER_SEARCH_TYPING_DEBOUNCE_MS = 350;
const USER_SEARCH_LIMIT = 30;

interface UserSearchAnswer {
  query: string;
  users: UserSearchResult[];
}

export interface UserSearchOptions {
  limit?: number;
  debounceMs?: number;
  enabled?: boolean;
  keepPreviousResults?: boolean;
  onError?: () => void;
}

export function useUserSearch(
  query: string,
  {
    limit = USER_SEARCH_LIMIT,
    debounceMs = USER_SEARCH_DEBOUNCE_MS,
    enabled = true,
    keepPreviousResults = false,
    onError,
  }: UserSearchOptions = {}
): { results: UserSearchResult[]; searching: boolean } {
  const value = enabled ? query.trim() : '';
  const [answer, setAnswer] = useState<UserSearchAnswer>({ query: '', users: [] });
  const [requested, setRequested] = useState<string | null>(null);
  const onErrorRef = useRef(onError);

  useEffect(() => {
    onErrorRef.current = onError;
  }, [onError]);

  useEffect(() => {
    if (value === '' && !keepPreviousResults) return;
    let cancelled = false;
    const timer = setTimeout(() => {
      if (value === '') {
        setAnswer({ query: '', users: [] });
        return;
      }
      setRequested(value);
      UserService.search(value, limit)
        .then((res) => {
          if (!cancelled) setAnswer({ query: value, users: res.users });
        })
        .catch(() => {
          if (cancelled) return;
          onErrorRef.current?.();
          setAnswer((prev) => ({ query: value, users: keepPreviousResults ? prev.users : [] }));
        });
    }, debounceMs);
    return () => {
      cancelled = true;
      clearTimeout(timer);
    };
  }, [value, limit, debounceMs, keepPreviousResults]);

  const answered = answer.query === value;
  if (keepPreviousResults) {
    return { results: answer.users, searching: value !== '' && requested === value && !answered };
  }
  return { results: answered ? answer.users : [], searching: value !== '' && !answered };
}
