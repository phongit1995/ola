import type { ReactNode } from 'react';
import { Dialog } from './Dialog';

export interface ListOption {
  key: string;
  label: ReactNode;
  danger?: boolean;
  onSelect: () => void;
}

interface ListOptionDialogProps {
  open: boolean;
  title: ReactNode;
  options: ListOption[];
  onClose: () => void;
}

export function ListOptionDialog({
  open,
  title,
  options,
  onClose,
}: ListOptionDialogProps) {
  return (
    <Dialog open={open} onClose={onClose} title={title}>
      <ul className="-mx-2 -my-1">
        {options.map((option) => (
          <li key={option.key}>
            <button
              type="button"
              onClick={() => {
                option.onSelect();
                onClose();
              }}
              className={`w-full border-b border-black/8 px-4 py-3 text-left text-sm last:border-b-0 hover:bg-gray-50 ${
                option.danger ? 'text-[#dd4b39]' : 'text-black/87'
              }`}
            >
              {option.label}
            </button>
          </li>
        ))}
      </ul>
    </Dialog>
  );
}
