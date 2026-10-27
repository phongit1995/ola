const POSTER_TIME_S = 0.1;
const POSTER_MAX_EDGE = 480;
const POSTER_QUALITY = 0.8;
const READ_TIMEOUT_MS = 8000;

export interface VideoFileInfo {
  duration: number;
  posterUrl: string | undefined;
}

function capturePoster(video: HTMLVideoElement): string | undefined {
  const longest = Math.max(video.videoWidth, video.videoHeight);
  if (longest === 0) return undefined;
  const scale = Math.min(1, POSTER_MAX_EDGE / longest);
  const canvas = document.createElement('canvas');
  canvas.width = Math.round(video.videoWidth * scale);
  canvas.height = Math.round(video.videoHeight * scale);
  const context = canvas.getContext('2d');
  if (context == null) return undefined;
  context.drawImage(video, 0, 0, canvas.width, canvas.height);
  try {
    return canvas.toDataURL('image/jpeg', POSTER_QUALITY);
  } catch {
    return undefined;
  }
}

export function readVideoFile(url: string): Promise<VideoFileInfo> {
  return new Promise((resolve, reject) => {
    const video = document.createElement('video');
    let timer = 0;
    const release = () => {
      window.clearTimeout(timer);
      video.removeAttribute('src');
      video.load();
    };
    const fail = (reason: string) => {
      release();
      reject(new Error(reason));
    };
    timer = window.setTimeout(() => fail('video read timeout'), READ_TIMEOUT_MS);
    video.preload = 'auto';
    video.muted = true;
    video.playsInline = true;
    video.onloadedmetadata = () => {
      if (!Number.isFinite(video.duration)) {
        fail('unknown duration');
        return;
      }
      video.currentTime = Math.min(POSTER_TIME_S, video.duration / 2);
    };
    video.onseeked = () => {
      const info = { duration: video.duration, posterUrl: capturePoster(video) };
      release();
      resolve(info);
    };
    video.onerror = () => fail('unreadable video');
    video.src = url;
  });
}
