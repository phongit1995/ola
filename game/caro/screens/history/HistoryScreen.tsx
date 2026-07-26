import { useEffect, useRef } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { assetBg, assetSrc } from '../../assets';
import { handleDialogKeyDown, useDialogFocus } from '../../helpers/dialog';
import { useCaro } from '../../store/useCaro';
import { HistoryPager } from './components/HistoryPager';
import { HistoryRow } from './components/HistoryRow';
import { useHistory } from './useHistory';

const PAGE_SIZE = 10;

export function HistoryScreen() {
  const dialogRef = useRef<HTMLDivElement>(null);
  const { visible, close, history, loading, error, retry } = useCaro(
    useShallow((state) => ({
      visible: state.historyVisible,
      close: state.hideHistory,
      history: state.history,
      loading: state.historyLoading,
      error: state.historyError,
      retry: state.loadHistory,
    })),
  );
  const { page, setPage, resetPage } = useHistory(
    useShallow((state) => ({
      page: state.page,
      setPage: state.setPage,
      resetPage: state.resetPage,
    })),
  );

  const pageCount = Math.max(1, Math.ceil(history.length / PAGE_SIZE));
  const visibleEntries = history.slice(page * PAGE_SIZE, page * PAGE_SIZE + PAGE_SIZE);
  useDialogFocus(visible, dialogRef);

  useEffect(() => {
    if (visible) resetPage();
  }, [resetPage, visible]);

  useEffect(() => {
    setPage((current) => Math.min(current, pageCount - 1));
  }, [pageCount, setPage]);

  return (
    <div
      id="history"
      className={visible ? '' : 'hidden'}
      role="dialog"
      aria-modal="true"
      aria-labelledby="history-title-text"
      onClick={(event) => event.target === event.currentTarget && close()}
      onKeyDown={(event) => handleDialogKeyDown(event, dialogRef, close)}
    >
      <div ref={dialogRef} id="history-inner" style={assetBg('historyPanel')}>
        <div className="history-title" style={assetBg('historyTitleFrame')}>
          <img src={assetSrc('historyIcon')} alt="" />
          <span id="history-title-text">Lịch sử</span>
        </div>

        <button
          type="button"
          id="history-close"
          style={assetBg('historyCloseFrame')}
          aria-label="Đóng lịch sử"
          onClick={close}
        >
          <img src={assetSrc('historyCloseX')} alt="" />
        </button>

        <div className="history-body">
          <section className="history-table" style={assetBg('historyTable')} aria-label="Lịch sử ván đấu">
            <div className="history-cell history-head">THỜI GIAN</div>
            <div className="history-cell history-head">ĐỐI THỦ</div>
            <div className="history-cell history-head">KEN CƯỢC</div>
            <div className="history-cell history-head">KẾT QUẢ</div>
            {visibleEntries.map((entry) => (
              <HistoryRow key={entry.id} entry={entry} />
            ))}
          </section>

          {(loading || error || history.length === 0) && (
            <div className="history-state" role={error ? 'alert' : 'status'}>
              {loading ? (
                <span>Đang tải lịch sử...</span>
              ) : error ? (
                <>
                  <span>{error}</span>
                  <button type="button" onClick={retry}>
                    Thử lại
                  </button>
                </>
              ) : (
                <span>Chưa có ván nào trong lịch sử.</span>
              )}
            </div>
          )}

          {history.length > 0 && <HistoryPager page={page} pageCount={pageCount} onChange={setPage} />}
        </div>
      </div>
    </div>
  );
}
