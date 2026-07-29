import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActionButton, UserListDialog, UserRow } from '@components';
import { colorForName, toast } from '@lib';
import { RelationshipService } from '@services';
import type { Relationship } from '@app-types';

interface BlockedListDialogProps {
  open: boolean;
  onClose: () => void;
}

function blockedName(relationship: Relationship): string {
  return (
    relationship.addressee?.fullName || relationship.addressee?.username || ''
  );
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
    <UserListDialog
      open={open}
      onClose={onClose}
      title={t('chat.menuBlockList')}
      loading={loading}
      isEmpty={items.length === 0}
      empty={
        <p className="py-2 text-center text-black/54">
          {t('chat.blockListEmpty')}
        </p>
      }
      divided={false}
      listMaxHeightClass="max-h-80"
    >
      {items.map((relationship) => {
        const name = blockedName(relationship);
        return (
          <li key={relationship.id}>
            <UserRow
              name={name}
              color={colorForName(name)}
              avatar={relationship.addressee?.avatar}
              layout="inline"
              trailing={
                <ActionButton
                  variant="outline"
                  disabled={busyId === relationship.id}
                  onClick={() => void unblock(relationship)}
                >
                  {t('chat.unblock')}
                </ActionButton>
              }
            />
          </li>
        );
      })}
    </UserListDialog>
  );
}
