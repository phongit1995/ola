import { penHistoryAssets } from './penAssets';
import { bgImage } from './penUi';

function PageNav({
  dir,
  disabled,
  onClick,
}: {
  dir: 'prev' | 'next';
  disabled: boolean;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      disabled={disabled}
      onClick={onClick}
      aria-label={dir}
      style={bgImage(penHistoryAssets.pageNext)}
      className="flex h-9 w-9 items-center justify-center bg-no-repeat text-white transition active:scale-95 disabled:opacity-30"
    >
      <svg
        viewBox="0 0 24 24"
        className={`h-3.5 w-3.5 ${dir === 'prev' ? 'rotate-180' : ''}`}
        fill="currentColor"
        aria-hidden="true"
      >
        <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6z" />
      </svg>
    </button>
  );
}

export function PenPagination({
  page,
  pageCount,
  loading,
  onPage,
  className = 'mt-2',
}: {
  page: number;
  pageCount: number;
  loading: boolean;
  onPage: (page: number) => void;
  className?: string;
}) {
  return (
    <div className={`flex items-center justify-center gap-2 ${className}`}>
      <PageNav
        dir="prev"
        disabled={loading || page <= 0}
        onClick={() => onPage(page - 1)}
      />
      <span
        style={bgImage(penHistoryAssets.pageCurrent)}
        className="flex h-9 min-w-16 items-center justify-center bg-no-repeat px-3 text-sm font-extrabold text-white"
      >
        {page + 1}
      </span>
      <PageNav
        dir="next"
        disabled={loading || page >= pageCount - 1}
        onClick={() => onPage(page + 1)}
      />
    </div>
  );
}
