import {
  forwardRef,
  useEffect,
  useImperativeHandle,
  useRef,
  useState,
  type ChangeEvent,
} from 'react';
import { useTranslation } from 'react-i18next';
import {
  compressImageForUpload,
  ImageTooLargeError,
  kulToken,
  toast,
} from '@lib';
import { useAttachPanel, useLongPress } from '@hooks';
import {
  SmileyGroupPanel,
  SmileyInput,
  type SmileyInputHandle,
} from '@components';
import likeIcon from '@/assets/icons/chat/smiley_35.png';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import smileyIconActive from '@/assets/icons/chat/ic_smiley_selected.png';
import photoIcon from '@/assets/icons/chat/ic_local.png';
import voiceIcon from '@/assets/icons/chat/ic_voice.png';
import { VoicePreviewBar } from '@components/chat/voice/VoicePreviewBar';
import {
  VoiceRecorderControl,
  type VoiceRecorderControlHandle,
} from '@components/chat/voice/VoiceRecorderControl';
import type { RoomAudioSendResult } from '@ola/shared/types';

export interface RoomComposerHandle {
  focus: () => void;
  insertMention: (name: string) => void;
}

interface PendingImage {
  id: string;
  file: File;
  url: string;
}

interface RoomComposerBarProps {
  disabled: boolean;
  onBeforeSend: () => void;
  onSendText: (text: string) => Promise<void>;
  onSendImage: (file: File) => Promise<void>;
  onSendAudio: (
    file: Blob,
    duration: number,
    waveform: number[]
  ) => Promise<RoomAudioSendResult>;
}

export const RoomComposerBar = forwardRef<
  RoomComposerHandle,
  RoomComposerBarProps
>(function RoomComposerBar(
  { disabled, onBeforeSend, onSendText, onSendImage, onSendAudio },
  ref
) {
  const { t } = useTranslation();
  const [draft, setDraft] = useState('');
  const [pendingImages, setPendingImages] = useState<PendingImage[]>([]);
  const [pendingAudio, setPendingAudio] = useState<{
    blob: Blob;
    duration: number;
    waveform: number[];
  } | null>(null);
  const [voiceRecording, setVoiceRecording] = useState(false);
  const {
    open: attachOpen,
    areaRef: composerAreaRef,
    toggle: toggleAttachPanel,
    close: closeAttachPanel,
  } = useAttachPanel();
  const fileInputRef = useRef<HTMLInputElement>(null);
  const composerRef = useRef<SmileyInputHandle>(null);
  const voiceRecorderRef = useRef<VoiceRecorderControlHandle>(null);
  const mountedRef = useRef(true);
  const draftRef = useRef(draft);
  const suppressLikeClick = useRef(false);
  const imageIdRef = useRef(0);
  const pendingImagesRef = useRef(pendingImages);

  useEffect(() => {
    draftRef.current = draft;
  }, [draft]);
  useEffect(() => {
    pendingImagesRef.current = pendingImages;
  }, [pendingImages]);
  useEffect(() => {
    mountedRef.current = true;
    return () => {
      mountedRef.current = false;
      pendingImagesRef.current.forEach((image) =>
        URL.revokeObjectURL(image.url)
      );
    };
  }, []);

  useImperativeHandle(ref, () => ({
    focus: () => composerRef.current?.focus(),
    insertMention: (name) => {
      const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
      const alreadyTagged = new RegExp(`@${escaped}(?![\\p{L}\\p{N}_])`, 'iu');
      if (!alreadyTagged.test(draftRef.current))
        composerRef.current?.insertText(`@${name} `);
      composerRef.current?.focus();
    },
  }));

  async function sendText(text: string) {
    const trimmed = text.trim();
    if (trimmed === '' || disabled) return;
    onBeforeSend();
    setDraft('');
    composerRef.current?.reset();
    try {
      await onSendText(trimmed);
    } catch {
      setDraft(trimmed);
      toast.error(t('room.sendError'));
    }
  }

  async function addImageFiles(files: File[]) {
    if (files.length === 0 || disabled) return;
    closeAttachPanel();
    setDraft('');
    composerRef.current?.reset();
    for (const file of files) {
      try {
        const prepared = await compressImageForUpload(file);
        const url = URL.createObjectURL(prepared);
        imageIdRef.current += 1;
        setPendingImages((current) => [
          ...current,
          { id: String(imageIdRef.current), file: prepared, url },
        ]);
      } catch (error) {
        toast.error(
          error instanceof ImageTooLargeError
            ? t('chat.imageTooLarge')
            : t('room.sendError')
        );
      }
    }
  }

  async function handleFileChange(event: ChangeEvent<HTMLInputElement>) {
    const files = Array.from(event.target.files ?? []);
    event.target.value = '';
    await addImageFiles(files);
  }

  function removePendingImage(id: string) {
    setPendingImages((current) => {
      const target = current.find((image) => image.id === id);
      if (target != null) URL.revokeObjectURL(target.url);
      return current.filter((image) => image.id !== id);
    });
  }

  function clearPendingImages() {
    setPendingImages((current) => {
      current.forEach((image) => URL.revokeObjectURL(image.url));
      return [];
    });
  }

  async function sendPendingImages() {
    const images = pendingImages;
    if (images.length === 0) return;
    onBeforeSend();
    setPendingImages([]);
    closeAttachPanel();
    for (const image of images) {
      await onSendImage(image.file);
      URL.revokeObjectURL(image.url);
    }
  }

  async function sendPendingAudio() {
    if (pendingAudio == null || disabled) return;
    const audio = pendingAudio;
    onBeforeSend();
    setPendingAudio(null);
    closeAttachPanel();
    try {
      await onSendAudio(audio.blob, audio.duration, audio.waveform);
    } catch {
      if (mountedRef.current) setPendingAudio(audio);
    }
  }

  async function handleSend() {
    if (disabled) return;
    if (pendingImages.length > 0) {
      await sendPendingImages();
      return;
    }
    if (draft.trim() !== '') void sendText(draft);
  }

  const likeLongPress = useLongPress(() => {
    suppressLikeClick.current = true;
    void sendText('(Y)');
  });

  const isTyping = draft.trim() !== '';

  return (
    <div ref={composerAreaRef} className="shrink-0">
      <div className="relative flex min-h-12 shrink-0 items-center gap-1 border-t border-black/12 bg-white px-2 py-2">
        {pendingAudio == null && !voiceRecording && (
          <>
            <button
              type="button"
              aria-label={t('chat.attachTabSmiley')}
              onClick={toggleAttachPanel}
              className={`flex h-9 w-9 shrink-0 select-none items-center justify-center ${
                attachOpen ? 'opacity-100' : 'opacity-60'
              }`}
            >
              <img
                src={attachOpen ? smileyIconActive : smileyIcon}
                alt=""
                className="h-6 w-6 object-contain"
              />
            </button>
            <button
              type="button"
              aria-label={t('chat.attachPickImage')}
              onClick={() => fileInputRef.current?.click()}
              disabled={disabled}
              className="flex h-9 w-9 shrink-0 select-none items-center justify-center opacity-60 disabled:opacity-40"
            >
              <img src={photoIcon} alt="" className="h-6 w-6 object-contain" />
            </button>
            <button
              type="button"
              aria-label={t('chat.voiceTapStart')}
              title={t('chat.attachRecord')}
              onClick={() => {
                closeAttachPanel();
                voiceRecorderRef.current?.start();
              }}
              disabled={disabled || pendingImages.length > 0}
              className="flex h-9 w-9 shrink-0 select-none items-center justify-center opacity-60 disabled:opacity-30"
            >
              <img src={voiceIcon} alt="" className="h-6 w-6 object-contain" />
            </button>
          </>
        )}
        {pendingAudio != null ? (
          <VoicePreviewBar
            blob={pendingAudio.blob}
            duration={pendingAudio.duration}
            waveform={pendingAudio.waveform}
            onSend={() => void sendPendingAudio()}
            onDiscard={() => setPendingAudio(null)}
          />
        ) : pendingImages.length > 0 ? (
          <div className="flex min-h-9 flex-1 items-center gap-2 overflow-x-auto py-1">
            {pendingImages.map((image) => (
              <div key={image.id} className="relative shrink-0">
                <img
                  src={image.url}
                  alt=""
                  className="h-11 w-11 rounded-lg object-cover"
                />
                <button
                  type="button"
                  aria-label={t('dialog.cancel')}
                  onClick={() => removePendingImage(image.id)}
                  className="absolute -top-1.5 -right-1.5 flex h-5 w-5 items-center justify-center rounded-full bg-black/60 text-xs leading-none text-white"
                >
                  ×
                </button>
              </div>
            ))}
            <button
              type="button"
              onClick={clearPendingImages}
              className="ml-1 h-9 shrink-0 rounded-full border border-black/12 px-3 text-sm font-medium text-black/54 hover:bg-black/5"
            >
              {t('dialog.cancel')}
            </button>
          </div>
        ) : (
          <SmileyInput
            ref={composerRef}
            value={draft}
            onChange={setDraft}
            onEnter={() => void handleSend()}
            onFocus={() => closeAttachPanel()}
            onImagePaste={(files) => void addImageFiles(files)}
            disabled={disabled}
            placeholder={t('room.chatInputHint')}
            multiline
            className={`max-h-28 min-h-9 flex-1 overflow-y-auto rounded-2xl border border-black/12 px-3 py-2 text-base text-black/87 focus:border-ola-primary ${
              disabled ? 'opacity-50' : ''
            }`}
          />
        )}
        {pendingAudio == null &&
          !voiceRecording &&
          (isTyping || pendingImages.length > 0 ? (
            <button
              type="button"
              onPointerDown={(event) => event.preventDefault()}
              onClick={() => void handleSend()}
              disabled={disabled}
              className="h-9 shrink-0 rounded-full bg-ola-primary px-4 text-sm font-semibold text-white shadow-sm transition active:scale-95 disabled:opacity-40"
            >
              {t('chat.send')}
            </button>
          ) : (
            <button
              type="button"
              aria-label={t('chat.like')}
              disabled={disabled}
              {...likeLongPress}
              onPointerDown={(event) => {
                suppressLikeClick.current = false;
                likeLongPress.onPointerDown(event);
              }}
              onClick={() => {
                if (suppressLikeClick.current) {
                  suppressLikeClick.current = false;
                  return;
                }
                void sendText('(y)');
              }}
              className="flex h-9 w-9 shrink-0 select-none items-center justify-center disabled:opacity-40"
            >
              <img src={likeIcon} alt="" className="h-7 w-7 object-contain" />
            </button>
          ))}
        {pendingAudio == null && (
          <VoiceRecorderControl
            ref={voiceRecorderRef}
            onRecorded={({ blob, duration, waveform }) => {
              setPendingAudio({ blob, duration, waveform });
              setVoiceRecording(false);
              closeAttachPanel();
            }}
            onRecordingChange={(recording) => {
              setVoiceRecording(recording);
              if (recording) closeAttachPanel();
            }}
          />
        )}
      </div>

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        multiple
        className="hidden"
        onChange={handleFileChange}
      />

      {!disabled && !voiceRecording && pendingAudio == null && (
        <div
          className={`h-52 shrink-0 border-t border-black/12 bg-white ${
            attachOpen ? '' : 'hidden'
          }`}
        >
          <SmileyGroupPanel
            onPick={(code) =>
              composerRef.current?.insertCode(code, true, false)
            }
            onSendKul={(index) => {
              void sendText(kulToken(index));
              closeAttachPanel();
            }}
          />
        </div>
      )}
    </div>
  );
});
