import type { ReactNode } from 'react';
import { Dialog } from './Dialog';

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
  loadingText?: string;
  divided?: boolean;
  listMaxHeightClass?: string;
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
  loadingText,
  divided = true,
  listMaxHeightClass = 'max-h-72',
}: UserListDialogProps) {
  return (
    <Dialog open={open} onClose={onClose} title={title}>
      {search != null && (
        <input
          value={search.value}
          onChange={(event) => search.onChange(event.target.value)}
          placeholder={search.placeholder}
          className="w-full rounded-md border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
        />
      )}
      <div className={`${listMaxHeightClass} overflow-y-auto ${search != null ? 'mt-3' : ''}`}>
        {loading ? (
          loadingText != null ? (
            <p className="py-6 text-center text-sm text-black/54">{loadingText}</p>
          ) : (
            <div className="flex justify-center py-6">
              <span className="h-7 w-7 animate-spin rounded-full border-4 border-ola-primary/30 border-t-ola-primary" />
            </div>
          )
        ) : isEmpty ? (
          empty
        ) : (
          <ul className={divided ? 'divide-y divide-black/8' : ''}>{children}</ul>
        )}
      </div>
    </Dialog>
  );
}
