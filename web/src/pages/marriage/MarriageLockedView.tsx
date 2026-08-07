import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, VipAvatar } from '@components';
import { createTimeFormatter, toast } from '@lib';
import { useMarriageStore } from '@/store/marriageStore';
import type { PendingProposal } from '@ola/shared/types';

interface MarriageLockedViewProps {
  onPropose: () => void;
}

type PendingAction = {
  proposal: PendingProposal;
  kind: 'accept' | 'deny';
} | null;

export function MarriageLockedView({ onPropose }: MarriageLockedViewProps) {
  const { t, i18n } = useTranslation();
  const formatSentTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );
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
        toast.success(
          t('marriage.acceptedToast', { nick: current.proposal.fromNick })
        );
      } else {
        await denyProposal(current.proposal.id);
      }
    } catch {
      toast.error(t('common.error'));
    }
  }

  return (
    <div className="flex flex-col items-center px-6 py-10">
      <div className="text-7xl text-ola-marriage/30">♥</div>
      <h2 className="mt-4 text-lg font-bold text-ola-marriage-deep">
        {t('marriage.lockedTitle')}
      </h2>
      <p className="mt-2 max-w-xs text-center text-sm text-black/55">
        {t('marriage.lockedDesc')}
      </p>
      <button
        type="button"
        onClick={onPropose}
        className="mt-6 rounded-full bg-ola-marriage px-6 py-2.5 font-bold text-white shadow-[0_3px_0_#c2185b] transition-transform active:translate-y-0.5 active:shadow-none"
      >
        💍 {t('marriage.getMarried')}
      </button>

      {sent.length > 0 && (
        <div className="mt-10 w-full max-w-md">
          <p className="mb-2 text-sm font-bold text-ola-marriage-deep">
            {t('marriage.sentTitle')}
          </p>
          <div className="flex flex-col gap-2">
            {sent.map((item) => (
              <div
                key={item.id}
                className="flex items-center gap-3 rounded-xl border border-ola-marriage-soft bg-[#fff5f8] p-3"
              >
                <VipAvatar className="h-10 w-10" />
                <div className="min-w-0 flex-1">
                  <p className="truncate text-sm font-semibold text-black/80">
                    {t('marriage.sentTo', { nick: item.toNick })}
                  </p>
                  <p className="truncate text-xs text-black/55">
                    {item.message}
                  </p>
                </div>
                <div className="flex shrink-0 items-center gap-2">
                  <span className="text-[10px] text-black/45">
                    {formatSentTime(new Date(item.createdAt).toISOString())}
                  </span>
                  <button
                    type="button"
                    onClick={() => void revoke(item.id)}
                    className="rounded-full bg-black/10 px-3 py-1.5 text-xs font-semibold text-black/70"
                  >
                    {t('marriage.revoke')}
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {pending.length > 0 && (
        <div className="mt-8 w-full max-w-md">
          <p className="mb-2 text-sm font-bold text-ola-marriage-deep">
            {t('marriage.receivedTitle')}
          </p>
          <div className="flex flex-col gap-2">
            {pending.map((proposal) => (
              <div
                key={proposal.id}
                className="flex items-center gap-3 rounded-xl border border-ola-marriage-soft bg-[#fff5f8] p-3"
              >
                <VipAvatar className="h-10 w-10" />
                <div className="min-w-0 flex-1">
                  <p className="truncate text-sm font-semibold text-black/80">
                    {t('marriage.proposalFrom', { name: proposal.fromName })}
                  </p>
                  <p className="truncate text-xs text-black/55">
                    {proposal.message}
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => setAction({ proposal, kind: 'accept' })}
                  className="rounded-full bg-ola-marriage px-3 py-1.5 text-xs font-semibold text-white"
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
        confirmLabel={
          action?.kind === 'deny' ? t('marriage.deny') : t('marriage.accept')
        }
        cancelLabel={t('marriage.no')}
        danger={action?.kind === 'deny'}
        onConfirm={() => void confirm()}
        onCancel={() => setAction(null)}
      />
    </div>
  );
}
