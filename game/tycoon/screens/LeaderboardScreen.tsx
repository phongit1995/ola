import { useEffect, useId, useLayoutEffect, useRef, type CSSProperties, type KeyboardEvent, type ReactNode } from 'react';
import { useShallow } from 'zustand/react/shallow';
import bgUrl from '../assets/lobby/bg-board-pixel.webp';
import leaderboardUrl from '../assets/lobby/ill-leaderboard.webp';
import { MEDAL_RANKS, RankMedal } from '../components/RankMedal';
import { RoomIcon } from '../components/RoomIcon';
import { ScrollRows } from '../components/ScrollRows';
import { TyIcon } from '../components/TyIcon';
import {
  LEADERBOARD_ERROR_TEXT,
  LEADERBOARD_LIMIT,
  LEADERBOARD_TABS,
  lvLabel,
  pinnedMe,
  tabConfig,
  type LeaderboardRow,
  type LeaderboardTab,
  type LeaderboardTabConfig,
} from '../helpers/leaderboard';
import { avatarIconUrl } from '../helpers/player';
import { useLeaderboard } from '../store/useLeaderboard';
import { useTycoon } from '../store/useTycoon';

const SKELETON_ROWS = Array.from({ length: 6 }, (_, index) => index);

function Row({ row, config, mine }: { row: LeaderboardRow; config: LeaderboardTabConfig; mine: boolean }) {
  const level = config.id === 'level';
  return (
    <li className={mine ? 'ty-lboard-row ty-lboard-row-me' : 'ty-lboard-row'}>
      <span className="ty-lboard-cell-rank">
        {row.rank > MEDAL_RANKS ? <span className="ty-visually-hidden">Hạng </span> : null}
        <RankMedal rank={row.rank} className="ty-lboard-rank" />
      </span>
      <span className="ty-lboard-player">
        <img className="ty-lboard-avatar" src={avatarIconUrl(row.vipType)} alt="" draggable={false} />
        <span className="ty-lboard-who">
          <span className="ty-lboard-name">@{row.username}</span>
          {level ? null : <span className="ty-lboard-lv ty-lboard-lv-small">{lvLabel(row.level)}</span>}
        </span>
      </span>
      <span className="ty-lboard-stat">
        <span className="ty-visually-hidden">{config.stats[0]} </span>
        {level ? <span className="ty-lboard-lv">{lvLabel(row.level)}</span> : (row.wins ?? '—')}
      </span>
      <span className="ty-lboard-stat">
        <span className="ty-visually-hidden">{config.stats[1]} </span>
        {level ? (row.exp?.toLocaleString('vi-VN') ?? '—') : (row.matches ?? '—')}
      </span>
    </li>
  );
}

function Sheet({ config, children }: { config: LeaderboardTabConfig; children: ReactNode }) {
  return (
    <div className="ty-lboard-sheet">
      <div className="ty-lboard-head" aria-hidden="true">
        <span>Hạng</span>
        <span>Người chơi</span>
        <span>{config.stats[0]}</span>
        <span>{config.stats[1]}</span>
      </div>
      {children}
    </div>
  );
}

function Body({ config }: { config: LeaderboardTabConfig }) {
  const { board, load } = useLeaderboard(useShallow((s) => ({ board: s.boards[config.id], load: s.load })));
  const myId = useTycoon((s) => s.profile?.id);
  const data = board.data;

  if (!data && board.status === 'error') {
    return (
      <Sheet config={config}>
        <div className="ty-lboard-state" role="alert">
          <TyIcon name="warning" size={32} />
          <p className="ty-lboard-state-title">{LEADERBOARD_ERROR_TEXT}</p>
          <button type="button" className="ty-btn ty-btn-paper ty-btn-small" onClick={() => void load(config.id, true)}>
            Thử lại
          </button>
        </div>
      </Sheet>
    );
  }

  if (!data) {
    return (
      <Sheet config={config}>
        <p className="ty-visually-hidden" role="status">
          Đang tải bảng xếp hạng…
        </p>
        <ul className="ty-lboard-rows" aria-hidden="true">
          {SKELETON_ROWS.map((index) => (
            <li key={index} className="ty-lboard-row ty-lboard-skel">
              <i className="ty-lboard-skel-dot" />
              <span className="ty-lboard-player">
                <i className="ty-lboard-skel-avatar" />
                <i className="ty-lboard-skel-bar" />
              </span>
              <i className="ty-lboard-skel-bar ty-lboard-skel-short" />
              <i className="ty-lboard-skel-bar ty-lboard-skel-short" />
            </li>
          ))}
        </ul>
      </Sheet>
    );
  }

  if (data.items.length === 0) {
    return (
      <Sheet config={config}>
        <div className="ty-lboard-state">
          <img className="ty-lboard-state-art" src={leaderboardUrl} alt="" draggable={false} />
          <p className="ty-lboard-state-title">{config.empty}</p>
          <p className="ty-lboard-state-hint">Chưa có kết quả trong kỳ này.</p>
        </div>
      </Sheet>
    );
  }

  const pinned = pinnedMe(data, myId);
  return (
    <>
      <Sheet config={config}>
        <ScrollRows className="ty-lboard-rows" label={`Top ${Math.min(data.items.length, LEADERBOARD_LIMIT)}`} count={data.items.length}>
          {data.items.map((row) => (
            <Row key={row.userId} row={row} config={config} mine={row.userId === myId} />
          ))}
        </ScrollRows>
      </Sheet>
      {pinned === undefined ? null : (
        <ul className="ty-lboard-pinned" aria-label="Hạng của bạn">
          {pinned ? (
            <Row row={pinned} config={config} mine />
          ) : (
            <li className="ty-lboard-row ty-lboard-row-me ty-lboard-row-note">Bạn chưa có trong top {LEADERBOARD_LIMIT}</li>
          )}
        </ul>
      )}
    </>
  );
}

export function LeaderboardScreen() {
  const setLeaderboardOpen = useTycoon((s) => s.setLeaderboardOpen);
  const { tab, open, select } = useLeaderboard(useShallow((s) => ({ tab: s.tab, open: s.open, select: s.select })));
  const baseId = useId();
  const tabsRef = useRef<HTMLDivElement>(null);
  const config = tabConfig(tab);
  const back = () => setLeaderboardOpen(false);

  useLayoutEffect(() => {
    open();
  }, [open]);

  useEffect(() => {
    tabsRef.current?.querySelector<HTMLButtonElement>(`[data-tab="${LEADERBOARD_TABS[0].id}"]`)?.focus();
  }, []);

  useEffect(() => {
    const onKeyDown = (event: globalThis.KeyboardEvent) => {
      if (event.key === 'Escape') setLeaderboardOpen(false);
    };
    window.addEventListener('keydown', onKeyDown);
    return () => window.removeEventListener('keydown', onKeyDown);
  }, [setLeaderboardOpen]);

  const choose = (next: LeaderboardTab) => select(next);

  const onTabKeyDown = (event: KeyboardEvent<HTMLDivElement>) => {
    const index = LEADERBOARD_TABS.findIndex((item) => item.id === tab);
    const last = LEADERBOARD_TABS.length - 1;
    const next =
      event.key === 'ArrowRight'
        ? (index + 1) % LEADERBOARD_TABS.length
        : event.key === 'ArrowLeft'
          ? (index + last) % LEADERBOARD_TABS.length
          : event.key === 'Home'
            ? 0
            : event.key === 'End'
              ? last
              : -1;
    if (next < 0) return;
    event.preventDefault();
    choose(LEADERBOARD_TABS[next].id);
    event.currentTarget.querySelector<HTMLButtonElement>(`[data-tab="${LEADERBOARD_TABS[next].id}"]`)?.focus();
  };

  return (
    <div className="ty-lobby ty-lboard" style={{ '--ty-lb-bg': `url(${bgUrl})` } as CSSProperties}>
      <header className="ty-lboard-top">
        <button type="button" className="ty-rooms-round" aria-label="Quay lại" onClick={back}>
          <RoomIcon name="chevron-left" />
        </button>
        <h1 className="ty-lboard-title">
          <img src={leaderboardUrl} alt="" draggable={false} />
          <span>Bảng xếp hạng</span>
        </h1>
      </header>

      <section className="ty-lboard-panel">
        <div ref={tabsRef} className="ty-lboard-tabs" role="tablist" aria-label="Loại bảng xếp hạng" onKeyDown={onTabKeyDown}>
          {LEADERBOARD_TABS.map((item) => {
            const selected = item.id === tab;
            return (
              <button
                key={item.id}
                type="button"
                role="tab"
                id={`${baseId}-tab-${item.id}`}
                data-tab={item.id}
                aria-selected={selected}
                aria-controls={`${baseId}-panel`}
                tabIndex={selected ? 0 : -1}
                className={selected ? 'ty-lboard-tab ty-lboard-tab-on' : 'ty-lboard-tab'}
                onClick={() => choose(item.id)}
              >
                {item.label}
              </button>
            );
          })}
        </div>
        <p className="ty-lboard-hint">{config.hint}</p>

        <div
          className={config.id === 'level' ? 'ty-lboard-table ty-lboard-table-level' : 'ty-lboard-table'}
          role="tabpanel"
          id={`${baseId}-panel`}
          aria-labelledby={`${baseId}-tab-${tab}`}
        >
          <Body key={config.id} config={config} />
        </div>
      </section>
    </div>
  );
}
