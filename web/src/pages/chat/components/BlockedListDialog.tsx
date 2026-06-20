import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, Dialog } from '@components';
import { colorForName, toast } from '@lib';
import { RelationshipService } from '@services';
import type { Relationship } from '@app-types';

interface BlockedListDialogProps {
  open: boolean;
  onClose: () => void;
}

function blockedName(relationship: Relationship): string {
  return relationship.addressee?.fullName || relationship.addressee?.username || '';
}

export function BlockedListDialog({ open, onClose }: BlockedListDialogProps) {
  const { t } = useTranslation();
  const [items, setItems] = useState<Relationship[]>([]);
  const [loading, setLoading] = useState(true);
  const [busyId, setBusyId] = useState<string | null>(null);

  useEffect(() => {
    let active = true;
    RelationshipService.blocked({ limit: 100 })
      .then((result) => {
        if (active) setItems(result.relationships);
      })
      .catch(() => {
        if (active) toast.error(t('chat.blockListError'));
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [t]);

  async function unblock(relationship: Relationship) {
    setBusyId(relationship.id);
    try {
      await RelationshipService.unblock(relationship.id);
      setItems((list) => list.filter((item) => item.id !== relationship.id));
      toast.success(t('chat.unblockDone', { name: blockedName(relationship) }));
    } catch {
      toast.error(t('chat.actionError'));
    } finally {
      setBusyId(null);
    }
  }

  return (
    <Dialog open={open} onClose={onClose} title={t('chat.menuBlockList')}>
      {loading ? (
        <div className="flex justify-center py-6">
          <span className="h-7 w-7 animate-spin rounded-full border-4 border-ola-primary/30 border-t-ola-primary" />
        </div>
      ) : items.length === 0 ? (
        <p className="py-2 text-center text-black/54">{t('chat.blockListEmpty')}</p>
      ) : (
        <ul className="max-h-80 overflow-y-auto">
          {items.map((relationship) => {
            const name = blockedName(relationship);
            return (
              <li key={relationship.id} className="flex items-center gap-3 py-2">
                <Avatar name={name} color={colorForName(name)} src={relationship.addressee?.avatar} size={40} />
                <span className="min-w-0 flex-1 truncate text-base text-black/87">{name}</span>
                <button
                  type="button"
                  disabled={busyId === relationship.id}
                  onClick={() => void unblock(relationship)}
                  className="shrink-0 rounded-full border border-ola-primary px-3 py-1 text-sm font-medium text-ola-primary disabled:opacity-50"
                >
                  {t('chat.unblock')}
                </button>
              </li>
            );
          })}
        </ul>
      )}
    </Dialog>
  );
}
