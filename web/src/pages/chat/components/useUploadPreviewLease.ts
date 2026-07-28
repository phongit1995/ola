import { useEffect } from 'react';
import { releaseUploadPreviewUrl } from '@lib';

interface UploadPreviewLease {
  consumers: number;
  pendingRelease?: ReturnType<typeof setTimeout>;
}

const uploadPreviewLeases = new Map<string, UploadPreviewLease>();

function retainUploadPreview(url: string | undefined) {
  if (url == null || !url.startsWith('blob:')) return;
  const lease = uploadPreviewLeases.get(url) ?? { consumers: 0 };
  if (lease.pendingRelease != null) clearTimeout(lease.pendingRelease);
  lease.pendingRelease = undefined;
  lease.consumers += 1;
  uploadPreviewLeases.set(url, lease);
}

function releaseUploadPreviewAfterUnmount(url: string | undefined) {
  if (url == null || !url.startsWith('blob:')) return;
  const lease = uploadPreviewLeases.get(url);
  if (lease == null) return;
  lease.consumers = Math.max(0, lease.consumers - 1);
  if (lease.consumers > 0) return;
  if (lease.pendingRelease != null) clearTimeout(lease.pendingRelease);
  lease.pendingRelease = setTimeout(() => {
    const current = uploadPreviewLeases.get(url);
    if (current == null || current.consumers > 0) return;
    uploadPreviewLeases.delete(url);
    releaseUploadPreviewUrl(url);
  }, 0);
}

export function useUploadPreviewLease(url: string | undefined) {
  useEffect(() => {
    retainUploadPreview(url);
    return () => releaseUploadPreviewAfterUnmount(url);
  }, [url]);
}
