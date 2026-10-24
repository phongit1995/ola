import {
  useReelTrayLifecycle,
  type ReelVisibilityListener,
} from '@ola/shared/stores/reel/useReelTrayLifecycle';

function subscribeDocumentVisibility(listener: ReelVisibilityListener) {
  const onVisibility = () => listener(!document.hidden);
  const onPageHide = () => listener(false);
  document.addEventListener('visibilitychange', onVisibility);
  window.addEventListener('pagehide', onPageHide);
  return () => {
    document.removeEventListener('visibilitychange', onVisibility);
    window.removeEventListener('pagehide', onPageHide);
  };
}

export function useReelTraySync() {
  useReelTrayLifecycle(subscribeDocumentVisibility);
}
