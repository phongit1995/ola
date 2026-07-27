import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { createTimeFormatter, toast } from '@ola/shared/lib';
import { useMarriageStore, type PendingProposal } from '@ola/shared/stores/marriageStore';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { VipAvatar } from '@components/ui/VipAvatar';

interface MarriageLockedViewProps {
  onPropose: () => void;
}

type PendingAction = { proposal: PendingProposal; kind: 'accept' | 'deny' } | null;

export function MarriageLockedView({ onPropose }: MarriageLockedViewProps) {
  const { t, i18n } = useTranslation();
  const formatSentTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const pending = useMarriageStore((s) => s.pendingProposals);
  const sent = useMarriageStore((s) => s.sentProposals);
  const acceptProposal = useMarriageStore((s) => s.acceptProposal);
  const denyProposal = useMarriageStore((s) => s.denyProposal);
  const cancelSent = useMarriageStore((s) => s.cancelSent);
  const [action, setAction] = useState<PendingAction>(null);

  async function revoke(id: string) {
    try {
      await cancelSent(id);
      toast.info(t('marriage.revokedToast'));
    } catch {
      toast.error(t('common.error'));
    }
  }

  async function confirm() {
    if (!action) return;
    const current = action;
    setAction(null);
    try {
      if (current.kind === 'accept') {
        await acceptProposal(current.proposal.id);
        toast.success(t('marriage.acceptedToast', { nick: current.proposal.fromNick }));
      } else {
        await denyProposal(current.proposal.id);
      }
    } catch {
      toast.error(t('common.error'));
    }
  }

  return (
    <View className="items-center px-6 py-10">
      <Text style={{ fontSize: 72, color: 'rgba(255,77,125,0.3)' }}>♥</Text>
      <Text className="mt-4 text-lg font-bold" style={{ color: '#c2185b' }}>
        {t('marriage.lockedTitle')}
      </Text>
      <Text
        className="mt-2 text-center text-sm"
        style={{ maxWidth: 320, color: 'rgba(0,0,0,0.55)' }}
      >
        {t('marriage.lockedDesc')}
      </Text>
      <Pressable
        onPress={onPropose}
        className="mt-6 rounded-full px-6 active:opacity-90"
        style={{
          paddingVertical: 10,
          backgroundColor: '#ff4d7d',
          shadowColor: '#c2185b',
          shadowOpacity: 1,
          shadowRadius: 0,
          shadowOffset: { width: 0, height: 3 },
          elevation: 3,
        }}
      >
        <Text className="font-bold text-white">💍 {t('marriage.getMarried')}</Text>
      </Pressable>

      {sent.length > 0 && (
        <View className="mt-10 w-full">
          <Text className="mb-2 text-sm font-bold" style={{ color: '#c2185b' }}>
            {t('marriage.sentTitle')}
          </Text>
          <View className="gap-2">
            {sent.map((item) => (
              <View
                key={item.id}
                className="flex-row items-center rounded-xl p-3"
                style={{ gap: 12, borderWidth: 1, borderColor: '#ffd0de', backgroundColor: '#fff5f8' }}
              >
                <VipAvatar size={40} />
                <View className="min-w-0 flex-1">
                  <Text
                    numberOfLines={1}
                    className="text-sm font-semibold"
                    style={{ color: 'rgba(0,0,0,0.8)' }}
                  >
                    {t('marriage.sentTo', { nick: item.toNick })}
                  </Text>
                  <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.55)' }}>
                    {item.message}
                  </Text>
                </View>
                <View className="flex-row items-center" style={{ gap: 8 }}>
                  <Text className="text-[10px]" style={{ color: 'rgba(0,0,0,0.45)' }}>
                    {formatSentTime(new Date(item.createdAt).toISOString())}
                  </Text>
                  <Pressable
                    onPress={() => void revoke(item.id)}
                    className="rounded-full px-3 active:opacity-80"
                    style={{ paddingVertical: 6, backgroundColor: 'rgba(0,0,0,0.1)' }}
                  >
                    <Text className="text-xs font-semibold" style={{ color: 'rgba(0,0,0,0.7)' }}>
                      {t('marriage.revoke')}
                    </Text>
                  </Pressable>
                </View>
              </View>
            ))}
          </View>
        </View>
      )}

      {pending.length > 0 && (
        <View className="mt-8 w-full">
          <Text className="mb-2 text-sm font-bold" style={{ color: '#c2185b' }}>
            {t('marriage.receivedTitle')}
          </Text>
          <View className="gap-2">
            {pending.map((proposal) => (
              <View
                key={proposal.id}
                className="flex-row items-center rounded-xl p-3"
                style={{ gap: 12, borderWidth: 1, borderColor: '#ffd0de', backgroundColor: '#fff5f8' }}
              >
                <VipAvatar size={40} />
                <View className="min-w-0 flex-1">
                  <Text
                    numberOfLines={1}
                    className="text-sm font-semibold"
                    style={{ color: 'rgba(0,0,0,0.8)' }}
                  >
                    {t('marriage.proposalFrom', { name: proposal.fromName })}
                  </Text>
                  <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.55)' }}>
                    {proposal.message}
                  </Text>
                </View>
                <Pressable
                  onPress={() => setAction({ proposal, kind: 'accept' })}
                  className="rounded-full px-3 active:opacity-90"
                  style={{ paddingVertical: 6, backgroundColor: '#ff4d7d' }}
                >
                  <Text className="text-xs font-semibold text-white">{t('marriage.accept')}</Text>
                </Pressable>
                <Pressable
                  onPress={() => setAction({ proposal, kind: 'deny' })}
                  className="rounded-full px-3 active:opacity-80"
                  style={{ paddingVertical: 6, backgroundColor: 'rgba(0,0,0,0.1)' }}
                >
                  <Text className="text-xs font-semibold" style={{ color: 'rgba(0,0,0,0.7)' }}>
                    {t('marriage.deny')}
                  </Text>
                </Pressable>
              </View>
            ))}
          </View>
        </View>
      )}

      <ConfirmDialog
        visible={action != null}
        title={t('marriage.boxTitle')}
        message={
          action?.kind === 'deny'
            ? t('marriage.confirmDeny', { nick: action?.proposal.fromNick })
            : t('marriage.confirmAccept', { nick: action?.proposal.fromNick })
        }
        confirmLabel={action?.kind === 'deny' ? t('marriage.deny') : t('marriage.accept')}
        cancelLabel={t('marriage.no')}
        danger={action?.kind === 'deny'}
        onConfirm={() => void confirm()}
        onCancel={() => setAction(null)}
      />
    </View>
  );
}
