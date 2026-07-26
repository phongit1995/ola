import { assetBg } from '../../../assets';

interface HistoryPagerProps {
  page: number;
  pageCount: number;
  onChange: (page: number) => void;
}

export function HistoryPager({ page, pageCount, onChange }: HistoryPagerProps) {
  return (
    <nav className="history-pager" aria-label="Phân trang lịch sử">
      <button
        type="button"
        className="history-page-btn"
        style={assetBg('historyPageBtn')}
        disabled={page === 0}
        aria-label="Trang trước"
        onClick={() => onChange(Math.max(0, page - 1))}
      >
        &lt;
      </button>
      <span className="history-page-btn history-page-number" style={assetBg('historyPageBtn')}>
        {page + 1}
      </span>
      <button
        type="button"
        className="history-page-btn"
        style={assetBg('historyPageBtn')}
        disabled={page >= pageCount - 1}
        aria-label="Trang sau"
        onClick={() => onChange(Math.min(pageCount - 1, page + 1))}
      >
        &gt;
      </button>
    </nav>
  );
}
