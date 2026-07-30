type PlaybackOwner = object;

interface ActivePlayback {
  owner: PlaybackOwner;
  release: () => void;
}

let activePlayback: ActivePlayback | null = null;

export function activateVoicePlayback(
  owner: PlaybackOwner,
  release: () => void,
): void {
  if (activePlayback?.owner === owner) return;
  const previous = activePlayback;
  activePlayback = { owner, release };
  previous?.release();
}

export function deactivateVoicePlayback(owner: PlaybackOwner): void {
  if (activePlayback?.owner === owner) activePlayback = null;
}

// Ghi âm phải giải phóng hẳn playback đang hoạt động, không chỉ pause: không để
// audio phát vào mic và không giữ player cũ qua lần đổi audio route trên iOS.
export function releaseVoicePlayback(): void {
  const previous = activePlayback;
  activePlayback = null;
  previous?.release();
}
