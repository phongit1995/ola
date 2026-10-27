import {
  useMomentTrayLifecycle,
  type MomentVisibilityListener,
} from '@ola/shared/stores/moment/useMomentTrayLifecycle';

function subscribeDocumentVisibility(listener: MomentVisibilityListener) {
  const onVisibility = () => listener(!document.hidden);
  const onPageHide = () => listener(false);
  document.addEventListener('visibilitychange', onVisibility);
  window.addEventListener('pagehide', onPageHide);
  return () => {
    document.removeEventListener('visibilitychange', onVisibility);
    window.removeEventListener('pagehide', onPageHide);
  };
}

export function useMomentTraySync(enabled: boolean) {
  useMomentTrayLifecycle(subscribeDocumentVisibility, enabled);
}
