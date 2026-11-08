import { useTranslation } from 'react-i18next';
import { Dialog } from '@components';
import { formatKen } from '@lib';
import type { AvatarFrameShopItem } from '@app-types';
import { AvatarFrameTile } from './AvatarFrameTile';

interface AvatarFramePickerDialogProps {
  open: boolean;
  selectedId: string | undefined;
  items: AvatarFrameShopItem[];
  onSelect: (item: AvatarFrameShopItem) => void;
  onClose: () => void;
}

export function AvatarFramePickerDialog({
  open,
  selectedId,
  items,
  onSelect,
  onClose,
}: AvatarFramePickerDialogProps) {
  const { t } = useTranslation();
  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('avatarFrame.pickFrameTitle')}
    >
      <div className="grid max-h-[60vh] grid-cols-3 gap-2 overflow-y-auto p-1">
        {items.map((item) => (
          <AvatarFrameTile
            key={item.id}
            frameId={item.frameId}
            subtitle={t('avatarFrame.price', {
              price: formatKen(item.kenPrice),
            })}
            badge={item.owned ? t('avatarFrame.owned') : undefined}
            highlighted={item.id === selectedId}
            onClick={() => {
              onSelect(item);
              onClose();
            }}
          />
        ))}
      </div>
    </Dialog>
  );
}
