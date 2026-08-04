import { useEffect } from 'react';
import { signApiGuard } from '@api';
import { authTokens } from '@lib';
import { env } from '@ola/shared/config';
import { useCallStore } from '@/store/callStore';

function pathnameOf(url: string): string {
  const withoutProtocol = url.replace(/^[a-z][a-z0-9+.-]*:\/\/[^/]*/i, '');
  const path = withoutProtocol.split(/[?#]/, 1)[0] ?? '';
  return path.replace(/\/$/, '');
}

export function useEndCallOnUnload() {
  useEffect(() => {
    const handlePageHide = () => {
      const active = useCallStore.getState().active;
      if (active == null) return;

      const relative = `/calls/${active.callId}/end`;
      const headers: Record<string, string> = {};
      const token = authTokens.getAccessToken();
      if (token != null) headers.Authorization = `Bearer ${token}`;

      const signed = signApiGuard('POST', `${pathnameOf(env.apiUrl)}${relative}`);
      if (signed != null) {
        headers['X-Timestamp'] = signed.timestamp;
        headers['X-Nonce'] = signed.nonce;
        headers['X-Signature'] = signed.signature;
      }

      void fetch(`${env.apiUrl.replace(/\/$/, '')}${relative}`, {
        method: 'POST',
        keepalive: true,
        headers,
      }).catch(() => {});
    };

    window.addEventListener('pagehide', handlePageHide);
    return () => window.removeEventListener('pagehide', handlePageHide);
  }, []);
}
