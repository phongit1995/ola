import { useTranslation } from 'react-i18next';
import { ActionButton, UserListDialog, UserRow } from '@components';
import { colorForName } from '@lib';
import {
  blockedRelationshipName,
  useBlockedRelationships,
} from '@ola/shared/stores/friends/useBlockedRelationships';

interface BlockedListDialogProps {
  open: boolean;
  onClose: () => void;
}

export function BlockedListDialog({ open, onClose }: BlockedListDialogProps) {
  const { t } = useTranslation();
  const { items, loading, busyId, unblock } = useBlockedRelationships();

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
        const name = blockedRelationshipName(relationship);
        return (
          <li key={relationship.id}>
            <UserRow
              name={name}
              color={colorForName(name)}
              avatar={relationship.addressee?.avatar}
              frameId={relationship.addressee?.avatarFrameId}
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
