import type { ReactNode } from 'react';
import { Spinner } from '@components';
import { PenPagination } from './PenPagination';

interface PenHistoryTableProps {
  rowGrid: string;
  gridCols: string;
  minWidthClass: string;
  minHeight: number;
  header: ReactNode;
  loading: boolean;
  isEmpty: boolean;
  emptyText: string;
  page: number;
  pageCount: number;
  onPage: (page: number) => void;
  children: ReactNode;
  footer?: ReactNode;
}

export function PenHistoryTable({
  rowGrid,
  gridCols,
  minWidthClass,
  minHeight,
  header,
  loading,
  isEmpty,
  emptyText,
  page,
  pageCount,
  onPage,
  children,
  footer,
}: PenHistoryTableProps) {
  return (
    <section className="rounded-2xl border border-[#1e6fe0]/40 bg-[#001026]/50 p-2">
      <div className="pen-scroll overflow-x-auto">
        <div className={`min-w-0 ${minWidthClass}`}>
          <div
            className={`${rowGrid} border-b border-white/10 px-1.5 pb-1.5 text-[9px] font-semibold uppercase tracking-wide text-[#5aa0e0]`}
            style={{ gridTemplateColumns: gridCols }}
          >
            {header}
          </div>

          <div className="flex flex-col" style={{ minHeight: `${minHeight}px` }}>
            {loading ? (
              <div className="flex flex-1 items-center justify-center">
                <Spinner />
              </div>
            ) : isEmpty ? (
              <div className="flex flex-1 items-center justify-center text-xs text-white/50">
                {emptyText}
              </div>
            ) : (
              children
            )}
          </div>
        </div>
      </div>

      <PenPagination page={page} pageCount={pageCount} loading={loading} onPage={onPage} />

      {footer}
    </section>
  );
}
