import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, ConfirmDialog } from '@components';
import { colorForName, toast } from '@lib';
import { useMarriageStore } from './marriageStore';
import type { PendingProposal } from './marriage.types';

interface MarriageLockedViewProps {
  onPropose: () => void;
}

type PendingAction = { proposal: PendingProposal; kind: 'accept' | 'deny' } | null;

export function MarriageLockedView({ onPropose }: MarriageLockedViewProps) {
  const { t } = useTranslation();
  const pending = useMarriageStore((s) => s.pendingProposals);
  const sent = useMarriageStore((s) => s.sentProposals);
  const acceptProposal = useMarriageStore((s) => s.acceptProposal);
  const denyProposal = useMarriageStore((s) => s.denyProposal);
  const cancelSent = useMarriageStore((s) => s.cancelSent);
  const [action, setAction] = useState<PendingAction>(null);

  function revoke(id: string) {
    cancelSent(id);
    toast.info(t('marriage.revokedToast'));
  }

  function confirm() {
    if (!action) return;
    if (action.kind === 'accept') {
      acceptProposal(action.proposal.id);
      toast.success(t('marriage.acceptedToast', { nick: action.proposal.fromNick }));
    } else {
      denyProposal(action.proposal.id);
    }
    setAction(null);
  }

  return (
    <div className="flex flex-col items-center px-6 py-10">
      <div className="text-7xl text-[#ff4d7d]/30">♥</div>
      <h2 className="mt-4 text-lg font-bold text-[#c2185b]">{t('marriage.lockedTitle')}</h2>
      <p className="mt-2 max-w-xs text-center text-sm text-black/55">{t('marriage.lockedDesc')}</p>
      <button
        type="button"
        onClick={onPropose}
        className="mt-6 rounded-full bg-[#ff4d7d] px-6 py-2.5 font-bold text-white shadow-[0_3px_0_#c2185b] transition-transform active:translate-y-0.5 active:shadow-none"
      >
        💍 {t('marriage.getMarried')}
      </button>

      {sent.length > 0 && (
        <div className="mt-10 w-full max-w-md">
          <p className="mb-2 text-sm font-bold text-[#c2185b]">{t('marriage.sentTitle')}</p>
          <div className="flex flex-col gap-2">
            {sent.map((item) => (
              <div
                key={item.id}
                className="flex items-center gap-3 rounded-xl border border-[#ffd0de] bg-[#fff5f8] p-3"
              >
                <Avatar name={item.toNick} color={colorForName(item.toNick)} size={40} />
                <div className="min-w-0 flex-1">
                  <p className="truncate text-sm font-semibold text-black/80">
                    {t('marriage.sentTo', { nick: item.toNick })}
                  </p>
                  <p className="truncate text-xs text-black/55">{item.message}</p>
                  <span className="mt-1 inline-block rounded-full bg-[#ffe0a3]/60 px-2 py-0.5 text-[10px] font-medium text-[#8a6d3b]">
                    {t('marriage.awaitingPartner')}
                  </span>
                </div>
                <button
                  type="button"
                  onClick={() => revoke(item.id)}
                  className="rounded-full bg-black/10 px-3 py-1.5 text-xs font-semibold text-black/70"
                >
                  {t('marriage.revoke')}
                </button>
              </div>
            ))}
          </div>
        </div>
      )}

      {pending.length > 0 && (
        <div className="mt-8 w-full max-w-md">
          <p className="mb-2 text-sm font-bold text-[#c2185b]">{t('marriage.receivedTitle')}</p>
          <div className="flex flex-col gap-2">
            {pending.map((proposal) => (
              <div
                key={proposal.id}
                className="flex items-center gap-3 rounded-xl border border-[#ffd0de] bg-[#fff5f8] p-3"
              >
                <Avatar name={proposal.fromName} color={proposal.avatarColor} size={40} />
                <div className="min-w-0 flex-1">
                  <p className="truncate text-sm font-semibold text-black/80">
                    {t('marriage.proposalFrom', { name: proposal.fromName })}
                  </p>
                  <p className="truncate text-xs text-black/55">{proposal.message}</p>
                </div>
                <button
                  type="button"
                  onClick={() => setAction({ proposal, kind: 'accept' })}
                  className="rounded-full bg-[#ff4d7d] px-3 py-1.5 text-xs font-semibold text-white"
                >
                  {t('marriage.accept')}
                </button>
                <button
                  type="button"
                  onClick={() => setAction({ proposal, kind: 'deny' })}
                  className="rounded-full bg-black/10 px-3 py-1.5 text-xs font-semibold text-black/70"
                >
                  {t('marriage.deny')}
                </button>
              </div>
            ))}
          </div>
        </div>
      )}

      <ConfirmDialog
        open={action != null}
        title={t('marriage.boxTitle')}
        message={
          action?.kind === 'deny'
            ? t('marriage.confirmDeny', { nick: action?.proposal.fromNick })
            : t('marriage.confirmAccept', { nick: action?.proposal.fromNick })
        }
        confirmLabel={action?.kind === 'deny' ? t('marriage.deny') : t('marriage.accept')}
        cancelLabel={t('marriage.no')}
        danger={action?.kind === 'deny'}
        onConfirm={confirm}
        onCancel={() => setAction(null)}
      />
    </div>
  );
}
