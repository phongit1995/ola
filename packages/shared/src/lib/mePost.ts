import type { Post, PostAudio } from '../types/api/me.type';
import type { MeAudioDraft } from '../types/client/feed.type';

export function hasMePostBody(
  content: string | null | undefined,
  attachmentCount: number,
  sticker: string | null | undefined,
  checkIn: unknown
): boolean {
  return (
    (content ?? '').trim() !== '' ||
    attachmentCount > 0 ||
    (sticker ?? '').trim() !== '' ||
    checkIn != null
  );
}

export function postAudio(post: Pick<Post, 'audios'> | null | undefined): PostAudio | null {
  return post?.audios?.[0] ?? null;
}

export function meAudioDraftFromPost(
  post: Pick<Post, 'audios'> | null | undefined
): MeAudioDraft | null {
  const audio = postAudio(post);
  if (audio == null) return null;
  return { url: audio.url, duration: audio.duration, waveform: audio.waveform };
}

export function shouldCleanupRejectedPostUpload(status: number): boolean {
  return status === 0 || status >= 400;
}
