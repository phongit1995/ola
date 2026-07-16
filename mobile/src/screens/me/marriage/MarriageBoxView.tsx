import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, Text, TextInput, View } from 'react-native';
import { colorForName, toast } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useMarriageStore, type DiaryEntry } from '@ola/shared/stores/marriageStore';
import { Avatar } from '@components/Avatar';
import { ConfirmDialog } from '@components/ConfirmDialog';
import { Dialog, DialogButton } from '@components/Dialog';
import { VipAvatar } from '@components/VipAvatar';
import { VerticalGradient } from '@screens/games/pen/penUi';

const DAY_MS = 86_400_000;

function FramedAvatar({
  name,
  color,
  src,
  size,
}: {
  name: string;
  color: string;
  src?: string;
  size: number;
}) {
  return (
    <View className="bg-white" style={{ borderWidth: 2, borderColor: color, padding: 2 }}>
      <Avatar name={name} color={color} uri={src} size={size} rounded={false} />
    </View>
  );
}

function formatDate(ms: number): string {
  const d = new Date(ms);
  const pad = (n: number) => String(n).padStart(2, '0');
  return `${pad(d.getDate())}/${pad(d.getMonth() + 1)}/${d.getFullYear()}`;
}

export function MarriageBoxView() {
  const { t } = useTranslation();
  const meName = useAuthStore((s) => s.user?.username ?? t('home.guest'));
  const meAvatar = useAuthStore((s) => s.user?.avatar);
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
    <View>
      <View className="items-center px-4 pb-5 pt-6">
        <VerticalGradient
          stops={[
            { color: '#ffe3ec', pos: 0 },
            { color: '#ffffff', pos: 1 },
          ]}
          style={StyleSheet.absoluteFill}
        />
        <View className="flex-row items-center" style={{ gap: 12 }}>
          <FramedAvatar name={meName} color={colorForName(meName)} src={meAvatar} size={84} />
          <Text style={{ fontSize: 30, color: '#ff4d7d' }}>❤</Text>
          <FramedAvatar
            name={spouse.name}
            color={spouse.avatarColor}
            src={spouse.avatarUrl}
            size={84}
          />
        </View>
        <Text className="mt-3 text-base font-bold" style={{ color: '#c2185b' }}>
          @{meName} <Text style={{ color: '#ff4d7d' }}>&</Text> @{spouse.nick}
        </Text>
        {marriedSince != null && (
          <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.55)' }}>
            {t('marriage.marriedSince', { date: formatDate(marriedSince) })}
          </Text>
        )}
        <View
          className="mt-3 rounded-full bg-white px-4"
          style={{
            paddingVertical: 6,
            shadowColor: '#000',
            shadowOpacity: 0.1,
            shadowRadius: 3,
            shadowOffset: { width: 0, height: 1 },
            elevation: 2,
          }}
        >
          <Text className="text-sm font-semibold" style={{ color: '#ff4d7d' }}>
            💞 {t('marriage.daysTogether', { days: daysTogether })}
          </Text>
        </View>
        <Pressable onPress={() => setDivorceOpen(true)} className="mt-3">
          <Text className="text-xs font-medium" style={{ color: 'rgba(0,0,0,0.4)' }}>
            {t('marriage.divorce')}
          </Text>
        </Pressable>
      </View>

      <View className="flex-row items-center justify-between px-4 pb-2 pt-4">
        <Text className="text-sm font-bold" style={{ color: '#c2185b' }}>
          {t('marriage.diaryTitle')}
        </Text>
        <Pressable
          onPress={() => setWriteOpen(true)}
          className="rounded-full px-3 active:opacity-90"
          style={{ paddingVertical: 6, backgroundColor: '#ff4d7d' }}
        >
          <Text className="text-xs font-semibold text-white">✎ {t('marriage.writeBox')}</Text>
        </Pressable>
      </View>

      {diary.length === 0 ? (
        <Text className="px-6 py-10 text-center text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
          {t('marriage.emptyDiary')}
        </Text>
      ) : (
        <View className="gap-2 px-3 pb-6">
          {diary.map((entry) => (
            <DiaryCard
              key={entry.id}
              entry={entry}
              authorName={entry.author === 'me' ? meName : spouse.name}
              timeLabel={ago(entry.createdAt)}
            />
          ))}
        </View>
      )}

      <ConfirmDialog
        visible={divorceOpen}
        title={t('marriage.confirmTitle')}
        message={t('marriage.confirmDivorce', { nick: spouse.nick })}
        confirmLabel={t('marriage.yes')}
        cancelLabel={t('marriage.no')}
        danger
        onConfirm={() => void handleDivorce()}
        onCancel={() => setDivorceOpen(false)}
      />

      <Dialog
        visible={writeOpen}
        onClose={() => setWriteOpen(false)}
        title={t('marriage.writeTitle')}
        footer={
          <>
            <DialogButton variant="green" onPress={() => void save()}>
              {t('marriage.send')}
            </DialogButton>
            <DialogButton onPress={() => setWriteOpen(false)}>{t('marriage.no')}</DialogButton>
          </>
        }
      >
        <TextInput
          value={draft}
          onChangeText={setDraft}
          multiline
          placeholder={t('marriage.writeHint')}
          placeholderTextColor="rgba(0,0,0,0.35)"
          className="rounded-lg p-2 text-sm"
          style={{
            height: 96,
            textAlignVertical: 'top',
            borderWidth: 1,
            borderColor: 'rgba(0,0,0,0.1)',
            color: 'rgba(0,0,0,0.87)',
          }}
        />
      </Dialog>
    </View>
  );
}

interface DiaryCardProps {
  entry: DiaryEntry;
  authorName: string;
  timeLabel: string;
}

function DiaryCard({ entry, authorName, timeLabel }: DiaryCardProps) {
  return (
    <View
      className="rounded-xl bg-white p-3"
      style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.1)' }}
    >
      <View className="flex-row items-center" style={{ gap: 8 }}>
        <VipAvatar size={36} />
        <View className="min-w-0 flex-1">
          <Text numberOfLines={1} className="text-sm font-semibold" style={{ color: 'rgba(0,0,0,0.8)' }}>
            {authorName}
          </Text>
          <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
            {timeLabel}
          </Text>
        </View>
      </View>
      <Text className="mt-2 text-sm" style={{ color: 'rgba(0,0,0,0.8)' }}>
        {entry.content}
      </Text>
    </View>
  );
}
