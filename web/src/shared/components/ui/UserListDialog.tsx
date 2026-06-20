import type { ReactNode } from 'react';
import { Dialog } from './Dialog';
import { Spinner } from './Spinner';

interface UserListSearch {
  value: string;
  onChange: (value: string) => void;
  placeholder: string;
}

interface UserListDialogProps {
  open: boolean;
  title: string;
  onClose: () => void;
  loading: boolean;
  isEmpty: boolean;
  empty: ReactNode;
  children: ReactNode;
  search?: UserListSearch;
}

export function UserListDialog({
  open,
  title,
  onClose,
  loading,
  isEmpty,
  empty,
  children,
  search,
}: UserListDialogProps) {
  return (
    <Dialog open={open} onClose={onClose} title={title}>
      {search != null && (
        <input
          value={search.value}
          onChange={(event) => search.onChange(event.target.value)}
          placeholder={search.placeholder}
          className="w-full rounded-md border border-black/12 px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary"
        />
      )}
      <div className={`max-h-72 overflow-y-auto ${search != null ? 'mt-3' : ''}`}>
        {loading ? (
          <div className="flex justify-center py-6">
            <Spinner size={28} thickness={4} />
          </div>
        ) : isEmpty ? (
          empty
        ) : (
          <ul className="divide-y divide-black/8">{children}</ul>
        )}
      </div>
    </Dialog>
  );
}
