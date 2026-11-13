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
  onError?: () => void;
}

export function useUserSearch(
  query: string,
  {
    limit = USER_SEARCH_LIMIT,
    debounceMs = USER_SEARCH_DEBOUNCE_MS,
    enabled = true,
    onError,
  }: UserSearchOptions = {}
): { results: UserSearchResult[]; searching: boolean } {
  const value = enabled ? query.trim() : '';
  const [answer, setAnswer] = useState<UserSearchAnswer>({ query: '', users: [] });
  const onErrorRef = useRef(onError);

  useEffect(() => {
    onErrorRef.current = onError;
  }, [onError]);

  useEffect(() => {
    if (value === '') return;
    let cancelled = false;
    const timer = setTimeout(() => {
      UserService.search(value, limit)
        .then((res) => res.users)
        .catch(() => {
          if (!cancelled) onErrorRef.current?.();
          return [] as UserSearchResult[];
        })
        .then((users) => {
          if (!cancelled) setAnswer({ query: value, users });
        });
    }, debounceMs);
    return () => {
      cancelled = true;
      clearTimeout(timer);
    };
  }, [value, limit, debounceMs]);

  const answered = answer.query === value;
  return { results: answered ? answer.users : [], searching: value !== '' && !answered };
}
