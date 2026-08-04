let sharedContext: AudioContext | null = null;

export function getAudioContext(): AudioContext | null {
  if (sharedContext != null) return sharedContext;
  try {
    sharedContext = new AudioContext();
  } catch {
    return null;
  }
  return sharedContext;
}

export interface AnalyserHandle {
  analyser: AnalyserNode;
  release: () => void;
}

export function createAnalyser(
  track: MediaStreamTrack,
  fftSize: number
): AnalyserHandle | null {
  const context = getAudioContext();
  if (context == null) return null;
  try {
    void context.resume();
    const source = context.createMediaStreamSource(new MediaStream([track]));
    const analyser = context.createAnalyser();
    analyser.fftSize = fftSize;
    source.connect(analyser);
    return {
      analyser,
      release: () => {
        try {
          source.disconnect();
          analyser.disconnect();
        } catch {
          return;
        }
      },
    };
  } catch {
    return null;
  }
}
