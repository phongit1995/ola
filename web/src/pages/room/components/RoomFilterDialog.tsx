import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import type { RoomFilters } from '../types';

interface RoomFilterDialogProps {
  open: boolean;
  value: RoomFilters;
  onApply: (value: RoomFilters) => void;
  onClose: () => void;
}

const FILTER_KEYS = [
  { key: 'showAll', labelKey: 'room.filterShowAll' },
  { key: 'media', labelKey: 'room.filterMedia' },
  { key: 'female', labelKey: 'room.filterFemale' },
  { key: 'male', labelKey: 'room.filterMale' },
  { key: 'flexible', labelKey: 'room.filterFlexible' },
] as const satisfies ReadonlyArray<{ key: keyof RoomFilters; labelKey: string }>;

export function RoomFilterDialog({
  open,
  value,
  onApply,
  onClose,
}: RoomFilterDialogProps) {
  const { t } = useTranslation();
  const [draft, setDraft] = useState(value);

  function toggle(key: keyof RoomFilters) {
    setDraft((current) => ({ ...current, [key]: !current[key] }));
  }

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('room.filterTitle')}
      footer={
        <>
          <DialogButton variant="green" onClick={() => onApply(draft)}>
            {t('dialog.accept')}
          </DialogButton>
          <DialogButton variant="default" onClick={onClose}>
            {t('dialog.cancel')}
          </DialogButton>
        </>
      }
    >
      <ul className="flex flex-col gap-1">
        {FILTER_KEYS.map(({ key, labelKey }) => (
          <li key={key}>
            <label className="flex items-center gap-2 py-1.5 text-sm text-black/87">
              <input
                type="checkbox"
                checked={draft[key]}
                onChange={() => toggle(key)}
                className="h-4 w-4 accent-ola-primary"
              />
              {t(labelKey)}
            </label>
          </li>
        ))}
      </ul>
    </Dialog>
  );
}
