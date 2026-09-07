import { useEffect, useRef, useState, type ChangeEvent } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Dialog,
  DialogButton,
  SmileyInput,
  type SmileyInputHandle,
} from '@components';
import {
  VoiceRecorderControl,
  type VoiceRecorderControlHandle,
} from '@components/chat/voice/VoiceRecorderControl';
import { useOutsideClick, type VoiceRecording } from '@hooks';
import { hasMePostBody, toast } from '@lib';
import {
  ATTACH_BUTTONS,
  MAX_IMAGES,
  PRIVACY_OPTIONS,
  type AttachButtonKey,
} from '../constants';
import { type ComposedCheckIn } from './ComposerCheckInPanel';
import {
  ComposerPreview,
  type ComposerAudioPreview,
} from './ComposerPreview';
import { ComposerAttachPanels } from './ComposerAttachPanels';
import type { MeAudioDraft, PostVisibility } from '@app-types';

type AttachPanel = 'tag' | 'checkin' | 'sticker' | 'smiley' | null;
type PickedPhoto = { url: string; file?: File };
type PickedAudio = { draft: MeAudioDraft; preview: ComposerAudioPreview };

export interface ComposedPost {
  content: string;
  files: File[];
  imageUrls: string[];
  audio: MeAudioDraft | null;
  checkIn: ComposedCheckIn | null;
  sticker: string | null;
  visibility: PostVisibility;
}

function pickedAudioFromDraft(draft: MeAudioDraft | null | undefined): PickedAudio | null {
  if (draft == null || draft.url == null || draft.url === '') return null;
  return {
    draft,
    preview: { url: draft.url, duration: draft.duration, waveform: draft.waveform },
  };
}

function pickedAudioFromRecording(recording: VoiceRecording): PickedAudio {
  const draft: MeAudioDraft = {
    file: recording.blob,
    duration: recording.duration,
    waveform: recording.waveform,
  };
  return {
    draft,
    preview: {
      url: URL.createObjectURL(recording.blob),
      duration: recording.duration,
      waveform: recording.waveform,
    },
  };
}

function revokePickedAudio(audio: PickedAudio | null) {
  if (audio?.draft.file != null) URL.revokeObjectURL(audio.preview.url);
}

interface MeComposerDialogProps {
  open: boolean;
  onClose: () => void;
  onPost: (post: ComposedPost) => Promise<boolean>;
  initial?: ComposedPost | null;
  title?: string;
  submitLabel?: string;
  privacyOptions?: PostVisibility[];
}

export function MeComposerDialog({
  open,
  onClose,
  onPost,
  initial,
  title,
  submitLabel,
  privacyOptions,
}: MeComposerDialogProps) {
  const { t } = useTranslation();
  const options =
    privacyOptions != null && privacyOptions.length > 0
      ? privacyOptions
      : PRIVACY_OPTIONS;
  const defaultPrivacy =
    initial != null && options.includes(initial.visibility)
      ? initial.visibility
      : options[0] ?? 'public';
  const [content, setContent] = useState(initial?.content ?? '');
  const [privacy, setPrivacy] = useState<PostVisibility>(defaultPrivacy);
  const [photos, setPhotos] = useState<PickedPhoto[]>(() =>
    (initial?.imageUrls ?? []).map((url) => ({ url }))
  );
  const [checkIn, setCheckIn] = useState<ComposedCheckIn | null>(
    initial?.checkIn ?? null
  );
  const [sticker, setSticker] = useState<string | null>(
    initial?.sticker ?? null
  );
  const [audio, setAudio] = useState<PickedAudio | null>(() =>
    pickedAudioFromDraft(initial?.audio)
  );
  const [voiceRecording, setVoiceRecording] = useState(false);
  const [panel, setPanel] = useState<AttachPanel>(null);
  const [submitting, setSubmitting] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const composerRef = useRef<SmileyInputHandle>(null);
  const attachAreaRef = useRef<HTMLDivElement>(null);
  const voiceRecorderRef = useRef<VoiceRecorderControlHandle>(null);

  useOutsideClick(attachAreaRef, panel != null, () => setPanel(null));
  const attachmentCount = photos.length + (audio != null ? 1 : 0);
  const canSubmit =
    !submitting &&
    !voiceRecording &&
    hasMePostBody(content, attachmentCount, sticker, checkIn);

  function reset() {
    setContent('');
    setPrivacy(defaultPrivacy);
    setPhotos([]);
    setCheckIn(null);
    setSticker(null);
    setAudio(null);
    setPanel(null);
  }

  function removeAudio() {
    revokePickedAudio(audio);
    setAudio(null);
  }

  function replaceAudio(recording: VoiceRecording) {
    revokePickedAudio(audio);
    setAudio(pickedAudioFromRecording(recording));
  }

  function revokePhotos(items: PickedPhoto[]) {
    items.forEach((photo) => {
      if (photo.file != null) URL.revokeObjectURL(photo.url);
    });
  }

  const photosRef = useRef<PickedPhoto[]>([]);
  const audioRef = useRef<PickedAudio | null>(null);
  useEffect(() => {
    photosRef.current = photos;
  }, [photos]);
  useEffect(() => {
    audioRef.current = audio;
  }, [audio]);
  useEffect(() => {
    return () => {
      photosRef.current.forEach((photo) => {
        if (photo.file != null) URL.revokeObjectURL(photo.url);
      });
      revokePickedAudio(audioRef.current);
    };
  }, []);

  function handleClose() {
    if (voiceRecording) return;
    revokePhotos(photos);
    revokePickedAudio(audio);
    reset();
    onClose();
  }

  function pickPhotos(event: ChangeEvent<HTMLInputElement>) {
    const files = Array.from(event.target.files ?? []);
    event.target.value = '';
    if (files.length === 0) return;
    setPhotos((current) => {
      const room = MAX_IMAGES - current.length;
      if (room <= 0) return current;
      const added = files
        .slice(0, room)
        .map((file) => ({ url: URL.createObjectURL(file), file }));
      return [...current, ...added];
    });
  }

  function removePhoto(url: string) {
    const target = photos.find((item) => item.url === url);
    if (target?.file != null) URL.revokeObjectURL(url);
    setPhotos((current) => current.filter((item) => item.url !== url));
  }

  function insertMention(nick: string) {
    composerRef.current?.insertText(` @${nick} `);
  }

  function insertSmiley(code: string) {
    composerRef.current?.insertCode(code, true);
  }

  function handleAttach(key: AttachButtonKey) {
    if (key === 'local') {
      fileInputRef.current?.click();
      return;
    }
    if (key === 'voice') {
      if (audio != null || voiceRecording) return;
      setPanel(null);
      voiceRecorderRef.current?.start();
      return;
    }
    setPanel((current) => (current === key ? null : key));
  }

  async function submit() {
    if (!canSubmit) return;
    const text = content.trim();
    setSubmitting(true);
    let ok = false;
    try {
      ok = await onPost({
        content: text,
        files: photos
          .filter((photo) => photo.file != null)
          .map((photo) => photo.file as File),
        imageUrls: photos
          .filter((photo) => photo.file == null)
          .map((photo) => photo.url),
        audio: audio?.draft ?? null,
        checkIn,
        sticker,
        visibility: privacy,
      });
    } catch {
      toast.error(t('me.postError'));
    } finally {
      setSubmitting(false);
    }
    if (ok) {
      revokePhotos(photos);
      revokePickedAudio(audio);
      reset();
      onClose();
    }
  }

  return (
    <Dialog
      open={open}
      onClose={handleClose}
      title={title ?? t('me.composerTitle')}
      footer={
        <>
          <DialogButton variant="green" onClick={submit} disabled={!canSubmit}>
            {submitLabel ?? t('me.post')}
          </DialogButton>
          <DialogButton variant="default" onClick={handleClose}>
            {t('dialog.cancel')}
          </DialogButton>
        </>
      }
    >
      <div className="flex items-center gap-2 text-sm text-black/54">
        <label className="flex items-center gap-2">
          {t('me.privacyTo')}
          <select
            value={privacy}
            onChange={(event) =>
              setPrivacy(event.target.value as PostVisibility)
            }
            className="rounded border border-black/12 px-2 py-1 text-black/87 outline-none"
          >
            {options.map((option) => (
              <option key={option} value={option}>
                {t(`me.privacy_${option}` as 'me.privacy_public')}
              </option>
            ))}
          </select>
        </label>
      </div>

      <SmileyInput
        ref={composerRef}
        value={content}
        onChange={setContent}
        placeholder={t('me.composerHint')}
        multiline
        className="mt-3 max-h-60 min-h-24 w-full overflow-y-auto rounded-md border border-black/12 px-3 py-2 text-base text-black/87 focus:border-ola-primary"
      />

      <ComposerPreview
        sticker={sticker}
        checkIn={checkIn}
        photos={photos}
        audio={audio?.preview ?? null}
        maxReached={photos.length >= MAX_IMAGES}
        onRemoveSticker={() => setSticker(null)}
        onRemoveCheckIn={() => setCheckIn(null)}
        onRemovePhoto={removePhoto}
        onRemoveAudio={removeAudio}
      />

      <div ref={attachAreaRef}>
        <div className="relative mt-3 flex justify-around border-t border-black/12 pt-2">
          {ATTACH_BUTTONS.map((button) => (
            <button
              key={button.key}
              type="button"
              aria-label={t(button.labelKey)}
              disabled={button.key === 'voice' && audio != null}
              onClick={() => handleAttach(button.key)}
              className={`flex flex-col items-center gap-0.5 text-xs disabled:opacity-40 ${
                panel === button.key ? 'text-ola-primary-ink' : 'text-black/54'
              }`}
            >
              {'icon' in button ? (
                <img
                  src={button.icon}
                  alt=""
                  className="h-6 w-6 object-contain"
                />
              ) : (
                <span className="text-2xl leading-none">{button.glyph}</span>
              )}
              {t(button.labelKey)}
            </button>
          ))}
          <VoiceRecorderControl
            ref={voiceRecorderRef}
            onRecorded={(recording) => {
              replaceAudio(recording);
              setVoiceRecording(false);
            }}
            onRecordingChange={setVoiceRecording}
          />
        </div>

        <ComposerAttachPanels
          panel={panel}
          onMention={insertMention}
          onSticker={(code) => {
            setSticker(code);
            setPanel(null);
          }}
          onCheckIn={(value) => {
            setCheckIn(value);
            setPanel(null);
          }}
          onSmiley={insertSmiley}
        />
      </div>

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        multiple
        hidden
        onChange={pickPhotos}
      />
    </Dialog>
  );
}
