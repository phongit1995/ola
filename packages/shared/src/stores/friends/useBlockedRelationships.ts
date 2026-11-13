import { useEffect, useState } from 'react';
import i18n from 'i18next';
import { toast } from '../../lib/toast';
import { RelationshipService } from '../../services/relationship.service';
import type { Relationship } from '../../types/api/relationship.type';

const BLOCKED_PAGE_SIZE = 100;

export function blockedRelationshipName(relationship: Relationship): string {
  return relationship.addressee?.fullName || relationship.addressee?.username || '';
}

export function useBlockedRelationships() {
  const [items, setItems] = useState<Relationship[]>([]);
  const [loading, setLoading] = useState(true);
  const [busyId, setBusyId] = useState<string | null>(null);

  useEffect(() => {
    let active = true;
    RelationshipService.blocked({ limit: BLOCKED_PAGE_SIZE })
      .then((result) => {
        if (active) setItems(result.relationships);
      })
      .catch(() => {
        if (active) toast.error(i18n.t('chat.blockListError'));
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, []);

  async function unblock(relationship: Relationship) {
    setBusyId(relationship.id);
    try {
      await RelationshipService.unblock(relationship.id);
      setItems((list) => list.filter((item) => item.id !== relationship.id));
      toast.success(
        i18n.t('chat.unblockDone', { name: blockedRelationshipName(relationship) })
      );
    } catch {
      toast.error(i18n.t('chat.actionError'));
    } finally {
      setBusyId(null);
    }
  }

  return { items, loading, busyId, unblock };
}
