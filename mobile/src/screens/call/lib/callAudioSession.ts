import Sound from 'react-native-sound';
import {
  AudioSession,
  AndroidAudioTypePresets,
} from '@livekit/react-native';
import { releaseVoicePlayback } from '@lib/voicePlaybackSession';

const SPEAKER_KEYWORD = 'speaker';

let sessionDepth = 0;
let queue: Promise<unknown> = Promise.resolve();

// Nối tiếp mọi thao tác vào/ra: nếu overlay unmount giữa lúc configureAudio còn
// await thì cleanup phải đợi setup xong mới chạy, không thì stop() rơi vào giữa
// và session bị bỏ lại ở trạng thái đang bật.
function serialize<T>(task: () => Promise<T>): Promise<T> {
  const next = queue.then(task, task);
  queue = next.catch(() => undefined);
  return next;
}

// Ba thứ tranh nhau audio route: react-native-sound (SFX, category Ambient đặt ở
// top-level lib/sound.ts), nitro-sound (ghi/phát voice message) và WebRTC. Vào
// cuộc gọi phải nhả hẳn voice playback rồi mới đổi category, nếu không iOS giữ
// route cũ và cuộc gọi không có tiếng.
export function enterCallAudioSession(withVideo = false): Promise<void> {
  return serialize(async () => {
    sessionDepth += 1;
    if (sessionDepth > 1) return;

    releaseVoicePlayback();
    Sound.setCategory('PlayAndRecord', true);

    const outputs: ['speaker', 'earpiece'] | ['earpiece', 'speaker'] = withVideo
      ? ['speaker', 'earpiece']
      : ['earpiece', 'speaker'];

    try {
      await AudioSession.configureAudio({
        android: {
          preferredOutputList: outputs,
          audioTypeOptions: AndroidAudioTypePresets.communication,
        },
        ios: { defaultOutput: outputs[0] },
      });
      await AudioSession.startAudioSession();
    } catch (error) {
      sessionDepth -= 1;
      Sound.setCategory('Ambient', true);
      throw error;
    }
  });
}

export function leaveCallAudioSession(): Promise<void> {
  return serialize(async () => {
    if (sessionDepth === 0) return;
    sessionDepth -= 1;
    if (sessionDepth > 0) return;

    await AudioSession.stopAudioSession();
    Sound.setCategory('Ambient', true);
  });
}

export async function setSpeakerEnabled(enabled: boolean): Promise<boolean> {
  const outputs = await AudioSession.getAudioOutputs();
  const speaker = outputs.find((id) => id.toLowerCase().includes(SPEAKER_KEYWORD));
  const earpiece = outputs.find((id) => !id.toLowerCase().includes(SPEAKER_KEYWORD));
  const target = enabled ? speaker : earpiece;
  if (target == null) return false;
  await AudioSession.selectAudioOutput(target);
  return true;
}
