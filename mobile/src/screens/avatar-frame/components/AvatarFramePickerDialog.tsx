import { useTranslation } from 'react-i18next';
import { FlatList } from 'react-native';
import { formatKen } from '@ola/shared/lib';
import type { AvatarFrameShopItem } from '@ola/shared/types';
import { Dialog } from '@components/ui/Dialog';
import { FRAME_GRID_COLUMNS, FRAME_PICKER_MAX_HEIGHT } from '../constants';
import { AvatarFrameCard } from './AvatarFrameCard';

interface AvatarFramePickerDialogProps {
  visible: boolean;
  selectedId: string | undefined;
  items: AvatarFrameShopItem[];
  onSelect: (item: AvatarFrameShopItem) => void;
  onClose: () => void;
}

export function AvatarFramePickerDialog({
  visible,
  selectedId,
  items,
  onSelect,
  onClose,
}: AvatarFramePickerDialogProps) {
  const { t } = useTranslation();
  return (
    <Dialog visible={visible} title={t('avatarFrame.pickFrameTitle')} onClose={onClose}>
      <FlatList
        style={{ maxHeight: FRAME_PICKER_MAX_HEIGHT }}
        data={items}
        numColumns={FRAME_GRID_COLUMNS}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <AvatarFrameCard
            frameId={item.frameId}
            subtitle={t('avatarFrame.price', { price: formatKen(item.kenPrice) })}
            badge={item.owned ? t('avatarFrame.owned') : undefined}
            highlighted={item.id === selectedId}
            onPress={() => {
              onSelect(item);
              onClose();
            }}
          />
        )}
      />
    </Dialog>
  );
}
