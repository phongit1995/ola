import { useEffect, useState } from 'react';
import { PERM_STATE } from '../constants';
import type { PermName, PermState } from '../interfaces';

export function usePermissionStatus(name: PermName): PermState {
  const [state, setState] = useState<PermState>(() =>
    navigator.permissions?.query == null
      ? PERM_STATE.unsupported
      : PERM_STATE.prompt
  );

  useEffect(() => {
    if (navigator.permissions?.query == null) return;

    let cancelled = false;
    let status: PermissionStatus | null = null;

    const handleChange = () => {
      if (cancelled || status == null) return;
      setState(status.state as PermState);
    };

    navigator.permissions
      .query({ name: name as PermissionName })
      .then((result) => {
        if (cancelled) return;
        status = result;
        setState(result.state as PermState);
        result.addEventListener('change', handleChange);
      })
      .catch(() => {
        if (!cancelled) setState(PERM_STATE.unsupported);
      });

    return () => {
      cancelled = true;
      status?.removeEventListener('change', handleChange);
    };
  }, [name]);

  return state;
}
