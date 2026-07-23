import { useEffect, useState } from 'react';
import { vipIconUrl } from '@ola/shared/lib/vip';
import { assetBg, assetSrc, type AssetKey } from './assets';
import { useCaroStore } from './store';

type LeaderboardPeriod = 'day' | 'week';

interface LeaderboardPlayer {
  username: string;
  ken: number;
  vipType: number;
}

const PAGE_SIZE = 10;

const DAY_PLAYERS: LeaderboardPlayer[] = [
  { username: 'pain', ken: 50_000, vipType: 129 },
  { username: 'vua_caro', ken: 42_600, vipType: 113 },
  { username: 'meomeo', ken: 37_850, vipType: 98 },
  { username: 'songlong', ken: 31_200, vipType: 67 },
  { username: 'bot_hunter', ken: 28_450, vipType: 45 },
  { username: 'hoa_mua_he', ken: 24_900, vipType: 76 },
  { username: 'kien_con', ken: 21_300, vipType: 33 },
  { username: 'toilabot', ken: 19_750, vipType: 16 },
  { username: 'caro_pro', ken: 17_100, vipType: 58 },
  { username: 'tay_choi_moi', ken: 15_600, vipType: 28 },
  { username: 'co_thu_lang', ken: 13_250, vipType: 84 },
  { username: 'sieu_nhan_x', ken: 11_900, vipType: 107 },
];

const WEEK_PLAYERS: LeaderboardPlayer[] = [
  { username: 'vua_caro', ken: 385_000, vipType: 113 },
  { username: 'pain', ken: 352_700, vipType: 129 },
  { username: 'songlong', ken: 298_400, vipType: 67 },
  { username: 'co_thu_lang', ken: 266_100, vipType: 84 },
  { username: 'meomeo', ken: 241_550, vipType: 98 },
  { username: 'caro_pro', ken: 219_800, vipType: 58 },
  { username: 'hoa_mua_he', ken: 203_400, vipType: 76 },
  { username: 'toilabot', ken: 185_050, vipType: 16 },
  { username: 'bot_hunter', ken: 172_600, vipType: 45 },
  { username: 'kien_con', ken: 158_900, vipType: 33 },
];

function formatKen(value: number): string {
  return value.toLocaleString('vi-VN');
}

const RANK_ASSETS: Partial<Record<number, AssetKey>> = {
  1: 'leaderboardRank1',
  2: 'leaderboardRank2',
  3: 'leaderboardRank3',
  4: 'leaderboardRank4',
  5: 'leaderboardRank5',
  6: 'leaderboardRank6',
  7: 'leaderboardRank7',
  8: 'leaderboardRank8',
  9: 'leaderboardRank9',
  10: 'leaderboardRank10',
};

function rankAsset(rank: number): AssetKey | null {
  return RANK_ASSETS[rank] ?? null;
}

export function Leaderboard() {
  const visible = useCaroStore((s) => s.leaderboardVisible);
  const close = useCaroStore((s) => s.hideLeaderboard);
  const [period, setPeriod] = useState<LeaderboardPeriod>('day');
  const [page, setPage] = useState(0);
  const players = period === 'day' ? DAY_PLAYERS : WEEK_PLAYERS;
  const pageCount = Math.max(1, Math.ceil(players.length / PAGE_SIZE));
  const visiblePlayers = players.slice(page * PAGE_SIZE, page * PAGE_SIZE + PAGE_SIZE);

  useEffect(() => {
    if (!visible) return;
    const onKeyDown = (event: KeyboardEvent): void => {
      if (event.key === 'Escape') close();
    };
    window.addEventListener('keydown', onKeyDown);
    return () => window.removeEventListener('keydown', onKeyDown);
  }, [close, visible]);

  const changePeriod = (next: LeaderboardPeriod): void => {
    setPeriod(next);
    setPage(0);
  };

  return (
    <div
      id="leaderboard"
      className={visible ? '' : 'hidden'}
      role="dialog"
      aria-modal="true"
      aria-labelledby="leaderboard-title-text"
      onClick={(event) => event.target === event.currentTarget && close()}
    >
      <div id="leaderboard-inner" style={assetBg('leaderboardPanel')}>
        <div className="leaderboard-title" style={assetBg('leaderboardTitleFrame')}>
          <img src={assetSrc('leaderboardCup')} alt="" />
          <span id="leaderboard-title-text">Bảng xếp hạng</span>
        </div>

        <button
          type="button"
          id="leaderboard-close"
          style={assetBg('leaderboardCloseFrame')}
          aria-label="Đóng bảng xếp hạng"
          onClick={close}
        >
          <img src={assetSrc('leaderboardCloseX')} alt="" />
        </button>

        <div className="leaderboard-body">
        <div className="leaderboard-tabs" role="tablist" aria-label="Thời gian xếp hạng">
          <button
            type="button"
            role="tab"
            aria-selected={period === 'day'}
            className={period === 'day' ? 'active' : ''}
            style={assetBg(period === 'day' ? 'leaderboardTabActive' : 'leaderboardTabInactive')}
            onClick={() => changePeriod('day')}
          >
            Top ngày
          </button>
          <button
            type="button"
            role="tab"
            aria-selected={period === 'week'}
            className={period === 'week' ? 'active' : ''}
            style={assetBg(period === 'week' ? 'leaderboardTabActive' : 'leaderboardTabInactive')}
            onClick={() => changePeriod('week')}
          >
            Top tuần
          </button>
        </div>

        <section className="leaderboard-table" aria-label={period === 'day' ? 'Top ngày' : 'Top tuần'}>
          <div className="leaderboard-head">
            <span>Hạng</span>
            <span>Người chơi</span>
            <span>Ken thắng</span>
          </div>
          <div className="leaderboard-rows">
            {visiblePlayers.map((player, index) => {
              const rank = page * PAGE_SIZE + index + 1;
              const medal = rankAsset(rank);
              return (
                <div className="leaderboard-row" key={player.username}>
                  <div className="leaderboard-rank">
                    {medal ? <img src={assetSrc(medal)} alt={`Hạng ${rank}`} /> : <span>{rank}</span>}
                  </div>
                  <div className="leaderboard-player">
                    <img src={vipIconUrl(player.vipType)} alt="" />
                    <span>@{player.username}</span>
                  </div>
                  <div className="leaderboard-ken">
                    <span>{formatKen(player.ken)}</span>
                    <img src={assetSrc('leaderboardKen')} alt="Ken" />
                  </div>
                  <div className="leaderboard-divider" style={assetBg('leaderboardDivider')} />
                </div>
              );
            })}
          </div>
        </section>

        <nav className="leaderboard-pager" aria-label="Phân trang bảng xếp hạng">
          <button
            type="button"
            className="leaderboard-page-arrow"
            style={assetBg('leaderboardPageArrow')}
            disabled={page === 0}
            aria-label="Trang trước"
            onClick={() => setPage((current) => Math.max(0, current - 1))}
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
            onClick={() => setPage((current) => Math.min(pageCount - 1, current + 1))}
          >
            &gt;
          </button>
        </nav>
        </div>
      </div>
    </div>
  );
}
