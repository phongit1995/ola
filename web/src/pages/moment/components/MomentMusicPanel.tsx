import {
  useEffect,
  useRef,
  useState,
  type ChangeEvent,
  type KeyboardEvent,
  type PointerEvent,
} from 'react';
import { useTranslation } from 'react-i18next';
import {
  MOMENT_MUSIC_ACCEPT,
  MOMENT_MUSIC_MAX_BYTES,
  MOMENT_MUSIC_MAX_MS,
  MOMENT_MUSIC_MIN_MS,
  MOMENT_MUSIC_TITLE_MAX,
  MOMENT_MUSIC_TOTAL_MS,
} from '@constants';
import {
  cn,
  formatMomentMusicTime,
  isMomentMusicFile,
  momentMusicDefaultTitle,
  momentMusicEndMs,
  momentMusicLoops,
  momentMusicMaxStartMs,
  momentMusicTrimBars,
  resolveMomentMusicTitle,
  snapMomentMusicStart,
  toast,
} from '@lib';
import type { MomentMusicDraft } from '@app-types';
import {
  MomentCloseIcon,
  MomentMusicIcon,
  MomentPauseIcon,
  MomentPencilIcon,
  MomentPlayIcon,
  MomentTrashIcon,
} from './MomentIcons';

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
  onOpen,
}: {
  music: MomentMusicDraft | null;
  onOpen: () => void;
}) {
  const { t } = useTranslation();
  return (
    <button
      type="button"
      onClick={onOpen}
      className="flex max-w-full min-w-0 items-center gap-1.5 rounded-full bg-white px-3 py-1.5 text-sm font-medium text-ola-primary-ink shadow-sm ring-1 ring-black/5 transition-colors hover:bg-ola-primary-light"
    >
      <MomentMusicIcon className="h-4 w-4 shrink-0" />
      <span className="truncate">{music?.title ?? t('moment.musicAdd')}</span>
    </button>
  );
}

const TRIM_BAR_COUNT = 56;
const TRIM_BAR_MAX_PERCENT = 70;
const TRIM_KEY_STEP_MS = 1000;
const TRIM_BARS = momentMusicTrimBars(TRIM_BAR_COUNT);

interface MusicTrimmerProps {
  durationMs: number;
  startMs: number;
  maxStartMs: number;
  positionMs: number | null;
  label: string;
  onChange: (startMs: number) => void;
}

function MusicTrimmer({ durationMs, startMs, maxStartMs, positionMs, label, onChange }: MusicTrimmerProps) {
  const trackRef = useRef<HTMLDivElement>(null);
  const grabOffsetRef = useRef<number | null>(null);
  const windowMs = Math.min(durationMs, MOMENT_MUSIC_TOTAL_MS);
  const locked = maxStartMs === 0;
  const startRatio = startMs / durationMs;
  const endRatio = (startMs + windowMs) / durationMs;

  function clampStart(value: number) {
    return snapMomentMusicStart(value, maxStartMs);
  }

  function pointerMs(clientX: number) {
    const rect = trackRef.current?.getBoundingClientRect();
    if (rect == null || rect.width === 0) return 0;
    return ((clientX - rect.left) / rect.width) * durationMs;
  }

  function handlePointerDown(event: PointerEvent<HTMLDivElement>) {
    if (locked) return;
    const at = pointerMs(event.clientX);
    const inside = at >= startMs && at <= startMs + windowMs;
    grabOffsetRef.current = inside ? at - startMs : windowMs / 2;
    event.currentTarget.setPointerCapture(event.pointerId);
    onChange(clampStart(at - grabOffsetRef.current));
  }

  function handlePointerMove(event: PointerEvent<HTMLDivElement>) {
    if (grabOffsetRef.current == null) return;
    onChange(clampStart(pointerMs(event.clientX) - grabOffsetRef.current));
  }

  function handlePointerEnd() {
    grabOffsetRef.current = null;
  }

  function handleKeyDown(event: KeyboardEvent<HTMLDivElement>) {
    if (locked) return;
    if (event.key === 'ArrowLeft') onChange(clampStart(startMs - TRIM_KEY_STEP_MS));
    if (event.key === 'ArrowRight') onChange(clampStart(startMs + TRIM_KEY_STEP_MS));
  }

  const playheadRatio =
    positionMs == null ? null : Math.min(endRatio, Math.max(startRatio, positionMs / durationMs));

  return (
    <div
      ref={trackRef}
      role="slider"
      tabIndex={locked ? -1 : 0}
      aria-label={label}
      aria-valuemin={0}
      aria-valuemax={maxStartMs}
      aria-valuenow={startMs}
      aria-valuetext={formatMomentMusicTime(startMs)}
      aria-disabled={locked}
      onPointerDown={handlePointerDown}
      onPointerMove={handlePointerMove}
      onPointerUp={handlePointerEnd}
      onPointerCancel={handlePointerEnd}
      onKeyDown={handleKeyDown}
      className={cn(
        'relative h-16 touch-none overflow-hidden rounded-2xl bg-ola-surface outline-none select-none focus-visible:ring-2 focus-visible:ring-ola-primary',
        locked ? 'cursor-default' : 'cursor-grab active:cursor-grabbing'
      )}
    >
      <div className="absolute inset-0 flex items-center gap-[2px] px-1">
        {TRIM_BARS.map((height, index) => {
          const center = (index + 0.5) / TRIM_BAR_COUNT;
          const selected = center >= startRatio && center <= endRatio;
          return (
            <span
              key={index}
              className={cn('flex-1 rounded-full', selected ? 'bg-ola-primary' : 'bg-black/15')}
              style={{ height: `${height * TRIM_BAR_MAX_PERCENT}%` }}
            />
          );
        })}
      </div>
      <div
        className="pointer-events-none absolute inset-y-0 rounded-xl border-2 border-ola-primary bg-ola-primary/10"
        style={{ left: `${startRatio * 100}%`, width: `${(endRatio - startRatio) * 100}%` }}
      >
        <span className="absolute inset-y-3 left-0.5 w-1 rounded-full bg-ola-primary" />
        <span className="absolute inset-y-3 right-0.5 w-1 rounded-full bg-ola-primary" />
      </div>
      {playheadRatio != null && (
        <span
          className="pointer-events-none absolute inset-y-1 w-0.5 rounded-full bg-ola-primary-darker"
          style={{ left: `${playheadRatio * 100}%` }}
        />
      )}
    </div>
  );
}

interface MomentMusicPanelProps {
  initial: MomentMusicDraft | null;
  onApply: (music: MomentMusicDraft | null) => void;
  onClose: () => void;
}

export function MomentMusicPanel({ initial, onApply, onClose }: MomentMusicPanelProps) {
  const { t } = useTranslation();
  const [draft, setDraft] = useState<MomentMusicDraft | null>(initial);
  const [playing, setPlaying] = useState(false);
  const [positionMs, setPositionMs] = useState(0);
  const inputRef = useRef<HTMLInputElement>(null);
  const audioRef = useRef<HTMLAudioElement>(null);
  const draftUrlRef = useRef(initial?.url);

  useEffect(() => {
    draftUrlRef.current = draft?.url;
  }, [draft?.url]);

  const startMs = draft?.startMs;

  useEffect(() => {
    const audio = audioRef.current;
    if (audio == null || startMs == null || !playing) return;
    audio.currentTime = startMs / MS_PER_SECOND;
  }, [startMs, playing]);

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
    discardUnapplied(draft?.url);
    setPlaying(false);
    setDraft({
      file,
      url,
      fileName: file.name,
      title: momentMusicDefaultTitle(file.name),
      durationMs,
      startMs: 0,
    });
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

  function handleTimeUpdate() {
    const audio = audioRef.current;
    if (audio == null || draft == null) return;
    setPositionMs(audio.currentTime * MS_PER_SECOND);
    if (momentMusicLoops(draft.durationMs)) return;
    const endSeconds = momentMusicEndMs(draft) / MS_PER_SECOND;
    if (audio.currentTime >= endSeconds) audio.currentTime = draft.startMs / MS_PER_SECOND;
  }

  function removeMusic() {
    audioRef.current?.pause();
    discardUnapplied(draft?.url);
    setPlaying(false);
    setDraft(null);
  }

  const maxStart = draft == null ? 0 : momentMusicMaxStartMs(draft.durationMs);
  const endMs = draft == null ? 0 : momentMusicEndMs(draft);
  const loops = draft != null && momentMusicLoops(draft.durationMs);

  return (
    <div className="absolute inset-0 z-[60] flex flex-col justify-end bg-black/50" role="dialog">
      <div className="max-h-full overflow-y-auto rounded-t-3xl bg-white px-4 pt-2 pb-4 text-black/85 shadow-[0_-8px_24px_rgba(0,0,0,0.18)]">
        <span className="mx-auto mb-2 block h-1 w-10 rounded-full bg-black/15" />
        <div className="mb-4 flex items-center justify-between">
          <h2 className="text-lg font-semibold">{t('moment.musicPanelTitle')}</h2>
          <button
            type="button"
            onClick={close}
            aria-label={t('dialog.close')}
            className="flex h-8 w-8 items-center justify-center rounded-full bg-black/5 text-black/60 hover:bg-black/10"
          >
            <MomentCloseIcon className="h-4 w-4" />
          </button>
        </div>

        {draft == null ? (
          <button
            type="button"
            onClick={() => inputRef.current?.click()}
            className="flex w-full flex-col items-center gap-2 rounded-2xl bg-ola-primary-light px-4 py-7 transition-colors hover:bg-ola-primary/15"
          >
            <span className="flex h-14 w-14 items-center justify-center rounded-full bg-ola-primary text-white shadow-sm">
              <MomentMusicIcon className="h-7 w-7" />
            </span>
            <span className="text-base font-semibold text-black/85">{t('moment.musicPick')}</span>
            <span className="text-center text-xs text-black/50">{t('moment.musicFormatsWeb')}</span>
          </button>
        ) : (
          <div className="flex flex-col gap-4">
            <audio
              ref={audioRef}
              src={draft.url}
              loop={loops}
              onTimeUpdate={handleTimeUpdate}
              onEnded={() => setPlaying(false)}
            />
            <div className="flex items-center gap-3 rounded-2xl bg-ola-surface p-3">
              <button
                type="button"
                onClick={togglePreview}
                aria-label={t(playing ? 'moment.musicPreviewPause' : 'moment.musicPreviewPlay')}
                className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-ola-primary text-white shadow-sm transition-transform active:scale-95"
              >
                {playing ? <MomentPauseIcon className="h-5 w-5" /> : <MomentPlayIcon className="h-5 w-5" />}
              </button>
              <label className="min-w-0 flex-1">
                <span className="flex items-center gap-1 text-xs text-black/50">
                  <MomentPencilIcon className="h-3 w-3" />
                  {t('moment.musicName')}
                </span>
                <input
                  value={draft.title}
                  maxLength={MOMENT_MUSIC_TITLE_MAX}
                  placeholder={t('moment.musicNamePlaceholder')}
                  onChange={(event) => setDraft({ ...draft, title: event.target.value })}
                  className="mt-1 w-full rounded-lg bg-white px-2.5 py-1.5 text-base font-semibold ring-1 ring-black/10 outline-none placeholder:font-normal placeholder:text-black/35 focus:ring-2 focus:ring-ola-primary"
                />
              </label>
              <button
                type="button"
                onClick={() => inputRef.current?.click()}
                className="shrink-0 rounded-full bg-white px-3 py-1.5 text-sm font-medium text-black/70 ring-1 ring-black/10 hover:bg-black/5"
              >
                {t('moment.musicChange')}
              </button>
              <button
                type="button"
                onClick={removeMusic}
                aria-label={t('moment.musicRemove')}
                title={t('moment.musicRemove')}
                className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full text-ola-error hover:bg-ola-error/10"
              >
                <MomentTrashIcon className="h-5 w-5" />
              </button>
            </div>

            <div>
              <div className="mb-2 flex items-center justify-between">
                <span className="text-sm font-medium text-black/70">{t('moment.musicSegment')}</span>
                <span className="rounded-full bg-ola-primary-light px-2.5 py-0.5 text-sm font-semibold text-ola-primary-dark tabular-nums">
                  {formatMomentMusicTime(draft.startMs)} – {formatMomentMusicTime(endMs)}
                </span>
              </div>
              <MusicTrimmer
                durationMs={draft.durationMs}
                startMs={draft.startMs}
                maxStartMs={maxStart}
                positionMs={playing ? positionMs : null}
                label={t('moment.musicSegment')}
                onChange={(next) => setDraft({ ...draft, startMs: next })}
              />
              <div className="mt-1 flex justify-between text-xs text-black/40 tabular-nums">
                <span>0:00</span>
                {maxStart > 0 && <span>{t('moment.musicDragHint')}</span>}
                <span>{formatMomentMusicTime(draft.durationMs)}</span>
              </div>
              {loops && (
                <p
                  role="status"
                  className="mt-3 flex items-start gap-2 rounded-xl bg-ola-megaphone-soft px-3 py-2.5 text-sm text-ola-megaphone-ink"
                >
                  <span aria-hidden className="font-bold">!</span>
                  {t('moment.musicLoopNotice')}
                </p>
              )}
            </div>
          </div>
        )}

        <p className="mt-4 text-xs leading-relaxed text-black/45">
          {t('moment.musicLengthHint')} {t('moment.musicRights')}
        </p>

        <button
          type="button"
          onClick={apply}
          className="mt-3 w-full rounded-full bg-ola-primary py-3 text-base font-semibold text-white shadow-sm transition-opacity active:opacity-80"
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
