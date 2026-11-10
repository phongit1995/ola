import { useEffect, useRef, useState, type ChangeEvent } from 'react';
import { useTranslation } from 'react-i18next';
import {
  MOMENT_MUSIC_ACCEPT,
  MOMENT_MUSIC_DEFAULT_SECONDS,
  MOMENT_MUSIC_MAX_BYTES,
  MOMENT_MUSIC_MAX_MS,
  MOMENT_MUSIC_MIN_MS,
  MOMENT_MUSIC_SLIDE_SECONDS,
  MOMENT_MUSIC_START_STEP_MS,
  MOMENT_MUSIC_TITLE_MAX,
} from '@constants';
import {
  cn,
  fitMomentMusic,
  formatMomentMusicTime,
  isMomentMusicFile,
  momentMusicDefaultTitle,
  momentMusicFits,
  momentMusicMaxStartMs,
  momentMusicTotalMs,
  resolveMomentMusicTitle,
  toast,
} from '@lib';
import type { MomentMusicDraft } from '@app-types';
import { MomentMusicIcon, MomentPauseIcon, MomentPlayIcon } from './MomentIcons';

const MS_PER_SECOND = 1000;

function readAudioDuration(url: string): Promise<number> {
  return new Promise((resolve, reject) => {
    const audio = new Audio();
    audio.preload = 'metadata';
    audio.onloadedmetadata = () => {
      if (Number.isFinite(audio.duration) && audio.duration > 0) resolve(audio.duration);
      else reject(new Error('unknown duration'));
    };
    audio.onerror = () => reject(new Error('unplayable'));
    audio.src = url;
  });
}

export function MomentMusicBar({
  music,
  tooShort,
  slideCount,
  onOpen,
}: {
  music: MomentMusicDraft | null;
  tooShort: boolean;
  slideCount: number;
  onOpen: () => void;
}) {
  const { t } = useTranslation();
  function label() {
    if (music == null) return t('moment.musicAdd');
    if (tooShort) return t('moment.musicChipTooShort', { pages: slideCount });
    return t('moment.musicChip', { title: music.title, seconds: music.slideSeconds });
  }
  return (
    <div className="flex items-center justify-center py-1.5 text-sm">
      <button
        type="button"
        onClick={onOpen}
        className={cn(
          'flex max-w-full min-w-0 items-center gap-1.5 rounded-full bg-white px-3 py-1.5 font-medium shadow-sm ring-1 ring-black/5 transition-colors hover:bg-ola-primary-light',
          tooShort ? 'text-ola-error' : 'text-ola-primary-ink'
        )}
      >
        <MomentMusicIcon className="h-4 w-4 shrink-0" />
        <span className="truncate">{label()}</span>
      </button>
    </div>
  );
}

interface MomentMusicPanelProps {
  initial: MomentMusicDraft | null;
  slideCount: number;
  onApply: (music: MomentMusicDraft | null) => void;
  onClose: () => void;
}

export function MomentMusicPanel({ initial, slideCount, onApply, onClose }: MomentMusicPanelProps) {
  const { t } = useTranslation();
  const [draft, setDraft] = useState<MomentMusicDraft | null>(initial);
  const [playing, setPlaying] = useState(false);
  const inputRef = useRef<HTMLInputElement>(null);
  const audioRef = useRef<HTMLAudioElement>(null);
  const draftUrlRef = useRef(initial?.url);

  useEffect(() => {
    draftUrlRef.current = draft?.url;
  }, [draft?.url]);

  useEffect(() => {
    const audio = audioRef.current;
    if (audio == null || draft == null || !playing) return;
    audio.currentTime = draft.startMs / MS_PER_SECOND;
  }, [draft?.startMs, draft?.slideSeconds, playing, draft]);

  function discardUnapplied(url: string | undefined) {
    if (url != null && url !== initial?.url) URL.revokeObjectURL(url);
  }

  function close() {
    discardUnapplied(draftUrlRef.current);
    onClose();
  }

  function apply() {
    if (initial != null && initial.url !== draft?.url) URL.revokeObjectURL(initial.url);
    onApply(draft == null ? null : { ...draft, title: resolveMomentMusicTitle(draft) });
  }

  async function handleFile(event: ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (file == null) return;
    if (!isMomentMusicFile(file.name)) {
      toast.info(t('moment.musicUnsupported'));
      return;
    }
    if (file.size > MOMENT_MUSIC_MAX_BYTES) {
      toast.info(t('moment.musicTooLarge'));
      return;
    }
    const url = URL.createObjectURL(file);
    const seconds = await readAudioDuration(url).catch(() => null);
    if (seconds == null) {
      URL.revokeObjectURL(url);
      toast.info(t('moment.musicUnplayable'));
      return;
    }
    const durationMs = Math.floor(seconds * MS_PER_SECOND);
    if (durationMs < MOMENT_MUSIC_MIN_MS || durationMs > MOMENT_MUSIC_MAX_MS) {
      URL.revokeObjectURL(url);
      toast.info(t(durationMs < MOMENT_MUSIC_MIN_MS ? 'moment.musicTooShort' : 'moment.musicTooLong'));
      return;
    }
    const fitted = fitMomentMusic(
      {
        file,
        url,
        fileName: file.name,
        title: momentMusicDefaultTitle(file.name),
        durationMs,
        startMs: 0,
        slideSeconds: MOMENT_MUSIC_DEFAULT_SECONDS,
      },
      slideCount
    );
    if (fitted == null) {
      URL.revokeObjectURL(url);
      toast.info(t('moment.musicNotFit'));
      return;
    }
    discardUnapplied(draft?.url);
    setPlaying(false);
    setDraft(fitted);
  }

  function togglePreview() {
    const audio = audioRef.current;
    if (audio == null || draft == null) return;
    if (playing) {
      audio.pause();
      setPlaying(false);
      return;
    }
    audio.currentTime = draft.startMs / MS_PER_SECOND;
    void audio.play().then(() => setPlaying(true)).catch(() => {
      toast.info(t('moment.musicUnplayable'));
    });
  }

  function keepInsideSelection() {
    const audio = audioRef.current;
    if (audio == null || draft == null) return;
    const endSeconds =
      (draft.startMs + momentMusicTotalMs(draft.slideSeconds, slideCount)) / MS_PER_SECOND;
    if (audio.currentTime >= endSeconds) audio.currentTime = draft.startMs / MS_PER_SECOND;
  }

  function removeMusic() {
    audioRef.current?.pause();
    discardUnapplied(draft?.url);
    setPlaying(false);
    setDraft(null);
  }

  const maxStart =
    draft == null ? 0 : momentMusicMaxStartMs(draft.durationMs, draft.slideSeconds, slideCount);
  const endMs =
    draft == null ? 0 : draft.startMs + momentMusicTotalMs(draft.slideSeconds, slideCount);

  return (
    <div className="absolute inset-0 z-[60] flex flex-col justify-end bg-black/50" role="dialog">
      <div className="max-h-full overflow-y-auto rounded-t-2xl bg-white p-4 text-black/85">
        <div className="mb-3 flex items-center justify-between">
          <h2 className="text-base font-semibold">{t('moment.musicPanelTitle')}</h2>
          <button
            type="button"
            onClick={close}
            aria-label={t('dialog.close')}
            className="rounded-full px-2 py-1 text-black/50 hover:bg-black/5"
          >
            ✕
          </button>
        </div>

        {draft == null ? (
          <button
            type="button"
            onClick={() => inputRef.current?.click()}
            className="flex w-full items-center justify-center gap-2 rounded-xl border border-dashed border-ola-primary py-6 font-medium text-ola-primary-ink hover:bg-ola-primary-light"
          >
            <MomentMusicIcon className="h-5 w-5" />
            {t('moment.musicPick')}
          </button>
        ) : (
          <div className="flex flex-col gap-4">
            <audio
              ref={audioRef}
              src={draft.url}
              onTimeUpdate={keepInsideSelection}
              onEnded={() => setPlaying(false)}
            />
            <label className="block text-sm">
              <span className="mb-1 block text-black/60">{t('moment.musicName')}</span>
              <input
                value={draft.title}
                maxLength={MOMENT_MUSIC_TITLE_MAX}
                placeholder={t('moment.musicNamePlaceholder')}
                onChange={(event) => setDraft({ ...draft, title: event.target.value })}
                className="w-full rounded-lg border border-black/15 px-3 py-2 outline-none focus:border-ola-primary"
              />
            </label>

            <div className="text-sm">
              <span className="mb-1 block text-black/60">{t('moment.musicSlideLength')}</span>
              <div className="flex gap-2">
                {MOMENT_MUSIC_SLIDE_SECONDS.map((seconds) => {
                  const fits = momentMusicFits(draft.durationMs, seconds, slideCount);
                  const selected = draft.slideSeconds === seconds;
                  return (
                    <button
                      key={seconds}
                      type="button"
                      disabled={!fits}
                      aria-pressed={selected}
                      onClick={() =>
                        setDraft({
                          ...draft,
                          slideSeconds: seconds,
                          startMs: Math.min(
                            draft.startMs,
                            momentMusicMaxStartMs(draft.durationMs, seconds, slideCount)
                          ),
                        })
                      }
                      className={cn(
                        'flex-1 rounded-lg border py-2 font-medium disabled:opacity-40',
                        selected
                          ? 'border-ola-primary bg-ola-primary text-white'
                          : 'border-black/15 text-black/70'
                      )}
                    >
                      {t('moment.musicSeconds', { count: seconds })}
                    </button>
                  );
                })}
              </div>
            </div>

            <div className="text-sm">
              <div className="mb-1 flex items-center justify-between text-black/60">
                <span>{t('moment.musicSegment')}</span>
                <span>
                  {formatMomentMusicTime(draft.startMs)} – {formatMomentMusicTime(endMs)}
                </span>
              </div>
              <input
                type="range"
                min={0}
                max={maxStart}
                step={MOMENT_MUSIC_START_STEP_MS}
                value={draft.startMs}
                disabled={maxStart === 0}
                aria-label={t('moment.musicSegment')}
                onChange={(event) => setDraft({ ...draft, startMs: Number(event.target.value) })}
                className="w-full accent-ola-primary"
              />
              <div className="flex justify-between text-xs text-black/40">
                <span>0:00</span>
                <span>{formatMomentMusicTime(draft.durationMs)}</span>
              </div>
            </div>

            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={togglePreview}
                className="flex items-center gap-1.5 rounded-full bg-ola-primary-light px-3 py-1.5 text-sm font-medium text-ola-primary-ink"
              >
                {playing ? <MomentPauseIcon className="h-4 w-4" /> : <MomentPlayIcon className="h-4 w-4" />}
                {t(playing ? 'moment.musicPreviewPause' : 'moment.musicPreviewPlay')}
              </button>
              <button
                type="button"
                onClick={() => inputRef.current?.click()}
                className="rounded-full px-3 py-1.5 text-sm text-black/60 hover:bg-black/5"
              >
                {t('moment.musicChange')}
              </button>
              <button
                type="button"
                onClick={removeMusic}
                className="rounded-full px-3 py-1.5 text-sm text-ola-error hover:bg-black/5"
              >
                {t('moment.musicRemove')}
              </button>
            </div>
          </div>
        )}

        <p className="mt-3 text-xs text-black/50">{t('moment.musicFormats')}</p>
        <p className="mt-1 text-xs text-black/50">{t('moment.musicRights')}</p>

        <button
          type="button"
          onClick={apply}
          className="mt-3 w-full rounded-full bg-ola-primary py-2.5 font-semibold text-white"
        >
          {t('moment.musicApply')}
        </button>
      </div>
      <input
        ref={inputRef}
        type="file"
        accept={MOMENT_MUSIC_ACCEPT}
        hidden
        onChange={(event) => void handleFile(event)}
      />
    </div>
  );
}
