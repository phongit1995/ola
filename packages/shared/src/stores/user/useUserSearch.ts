import { useEffect, useState } from 'react';
import { UserService } from '../../services/user.service';
import type { UserSearchResult } from '../../types/api/user.type';

const USER_SEARCH_DEBOUNCE_MS = 300;
const USER_SEARCH_LIMIT = 30;

interface UserSearchAnswer {
  query: string;
  users: UserSearchResult[];
}

export function useUserSearch(query: string): { results: UserSearchResult[]; searching: boolean } {
  const value = query.trim();
  const [answer, setAnswer] = useState<UserSearchAnswer>({ query: '', users: [] });

  useEffect(() => {
    if (value === '') return;
    let cancelled = false;
    const timer = setTimeout(() => {
      UserService.search(value, USER_SEARCH_LIMIT)
        .then((res) => res.users)
        .catch(() => [] as UserSearchResult[])
        .then((users) => {
          if (!cancelled) setAnswer({ query: value, users });
        });
    }, USER_SEARCH_DEBOUNCE_MS);
    return () => {
      cancelled = true;
      clearTimeout(timer);
    };
  }, [value]);

  const answered = answer.query === value;
  return { results: answered ? answer.users : [], searching: value !== '' && !answered };
}
