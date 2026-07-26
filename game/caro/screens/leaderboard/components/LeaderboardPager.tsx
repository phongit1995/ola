import { assetBg } from '../../../assets';

interface LeaderboardPagerProps {
  page: number;
  pageCount: number;
  onChange: (page: number) => void;
}

export function LeaderboardPager({ page, pageCount, onChange }: LeaderboardPagerProps) {
  return (
    <nav className="leaderboard-pager" aria-label="Phân trang bảng xếp hạng">
      <button
        type="button"
        className="leaderboard-page-arrow"
        style={assetBg('leaderboardPageArrow')}
        disabled={page === 0}
        aria-label="Trang trước"
        onClick={() => onChange(Math.max(0, page - 1))}
      >
        &lt;
      </button>
      <span className="leaderboard-page-number" style={assetBg('leaderboardPageNumber')}>
        {page + 1}
      </span>
      <button
        type="button"
        className="leaderboard-page-arrow"
        style={assetBg('leaderboardPageArrow')}
        disabled={page >= pageCount - 1}
        aria-label="Trang sau"
        onClick={() => onChange(Math.min(pageCount - 1, page + 1))}
      >
        &gt;
      </button>
    </nav>
  );
}
