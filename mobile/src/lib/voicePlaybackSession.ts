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
