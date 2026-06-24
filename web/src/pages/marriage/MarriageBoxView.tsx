import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, ConfirmDialog, Dialog, DialogButton } from '@components';
import { DEFAULT_AVATAR_COLOR, toast } from '@lib';
import { useAuthStore } from '@/store/authStore';
import { HeartAvatar } from './HeartAvatar';
import { useMarriageStore } from './marriageStore';
import type { DiaryEntry } from './marriage.types';

const DAY_MS = 86_400_000;

function formatDate(ms: number): string {
  const d = new Date(ms);
  const pad = (n: number) => String(n).padStart(2, '0');
  return `${pad(d.getDate())}/${pad(d.getMonth() + 1)}/${d.getFullYear()}`;
}

export function MarriageBoxView() {
  const { t } = useTranslation();
  const meName = useAuthStore((s) => s.user?.username ?? t('home.guest'));
  const spouse = useMarriageStore((s) => s.spouse);
  const marriedSince = useMarriageStore((s) => s.marriedSince);
  const diary = useMarriageStore((s) => s.diary);
  const divorce = useMarriageStore((s) => s.divorce);
  const writeBox = useMarriageStore((s) => s.writeBox);

  const [divorceOpen, setDivorceOpen] = useState(false);
  const [writeOpen, setWriteOpen] = useState(false);
  const [draft, setDraft] = useState('');
  const [now] = useState(() => Date.now());

  if (!spouse) return null;

  const daysTogether = marriedSince ? Math.max(0, Math.floor((now - marriedSince) / DAY_MS)) : 0;

  function ago(ms: number): string {
    const min = Math.floor((now - ms) / 60_000);
    if (min < 1) return t('marriage.justNow');
    if (min < 60) return t('marriage.minutesAgo', { n: min });
    const hours = Math.floor(min / 60);
    if (hours < 24) return t('marriage.hoursAgo', { n: hours });
    return t('marriage.daysAgo', { n: Math.floor(hours / 24) });
  }

  async function save() {
    const content = draft.trim();
    if (content.length === 0) return;
    try {
      await writeBox(content);
      setDraft('');
      setWriteOpen(false);
      toast.success(t('marriage.saved'));
    } catch {
      toast.error(t('common.error'));
    }
  }

  async function handleDivorce() {
    try {
      await divorce();
      toast.success(t('marriage.divorcedToast'));
    } catch {
      toast.error(t('common.error'));
    } finally {
      setDivorceOpen(false);
    }
  }

  return (
    <div className="flex flex-col">
      <div className="flex flex-col items-center bg-gradient-to-b from-[#ffe3ec] to-white px-4 pb-5 pt-6">
        <div className="flex items-center gap-3">
          <HeartAvatar idKey="me" name={meName} color={DEFAULT_AVATAR_COLOR} size={88} />
          <span className="text-3xl text-[#ff4d7d]">❤</span>
          <HeartAvatar
            idKey="spouse"
            name={spouse.name}
            color={spouse.avatarColor}
            size={88}
            src={spouse.avatarUrl}
          />
        </div>
        <p className="mt-3 text-base font-bold text-[#c2185b]">
          {meName} <span className="text-[#ff4d7d]">&</span> {spouse.name}
        </p>
        {marriedSince != null && (
          <p className="text-xs text-black/55">
            {t('marriage.marriedSince', { date: formatDate(marriedSince) })}
          </p>
        )}
        <div className="mt-3 rounded-full bg-white px-4 py-1.5 text-sm font-semibold text-[#ff4d7d] shadow-sm">
          💞 {t('marriage.daysTogether', { days: daysTogether })}
        </div>
        <button
          type="button"
          onClick={() => setDivorceOpen(true)}
          className="mt-3 text-xs font-medium text-black/40 underline-offset-2 hover:underline"
        >
          {t('marriage.divorce')}
        </button>
      </div>

      <div className="flex items-center justify-between px-4 pb-2 pt-4">
        <h3 className="text-sm font-bold text-[#c2185b]">{t('marriage.diaryTitle')}</h3>
        <button
          type="button"
          onClick={() => setWriteOpen(true)}
          className="rounded-full bg-[#ff4d7d] px-3 py-1.5 text-xs font-semibold text-white"
        >
          ✎ {t('marriage.writeBox')}
        </button>
      </div>

      {diary.length === 0 ? (
        <p className="px-6 py-10 text-center text-sm text-black/45">{t('marriage.emptyDiary')}</p>
      ) : (
        <div className="flex flex-col gap-2 px-3 pb-6">
          {diary.map((entry) => (
            <DiaryCard
              key={entry.id}
              entry={entry}
              authorName={entry.author === 'me' ? meName : spouse.name}
              authorColor={entry.author === 'me' ? DEFAULT_AVATAR_COLOR : spouse.avatarColor}
              timeLabel={ago(entry.createdAt)}
            />
          ))}
        </div>
      )}

      <ConfirmDialog
        open={divorceOpen}
        title={t('marriage.confirmTitle')}
        message={t('marriage.confirmDivorce', { nick: spouse.nick })}
        confirmLabel={t('marriage.yes')}
        cancelLabel={t('marriage.no')}
        danger
        onConfirm={() => void handleDivorce()}
        onCancel={() => setDivorceOpen(false)}
      />

      <Dialog
        open={writeOpen}
        onClose={() => setWriteOpen(false)}
        title={t('marriage.writeTitle')}
        footer={
          <>
            <DialogButton variant="green" onClick={() => void save()}>
              {t('marriage.send')}
            </DialogButton>
            <DialogButton variant="default" onClick={() => setWriteOpen(false)}>
              {t('marriage.no')}
            </DialogButton>
          </>
        }
      >
        <textarea
          value={draft}
          onChange={(event) => setDraft(event.target.value)}
          rows={4}
          placeholder={t('marriage.writeHint')}
          className="w-full resize-none rounded-lg border border-black/10 p-2 text-sm outline-none focus:border-[#ff4d7d]"
        />
      </Dialog>
    </div>
  );
}

interface DiaryCardProps {
  entry: DiaryEntry;
  authorName: string;
  authorColor: string;
  timeLabel: string;
}

function DiaryCard({ entry, authorName, authorColor, timeLabel }: DiaryCardProps) {
  return (
    <div className="rounded-xl bg-[#fff5f8] p-3">
      <div className="flex items-center gap-2">
        <Avatar name={authorName} color={authorColor} size={36} />
        <div className="min-w-0 flex-1">
          <p className="truncate text-sm font-semibold text-black/80">{authorName}</p>
          <p className="text-xs text-black/45">{timeLabel}</p>
        </div>
      </div>
      <p className="mt-2 whitespace-pre-wrap text-sm text-black/80">{entry.content}</p>
    </div>
  );
}
