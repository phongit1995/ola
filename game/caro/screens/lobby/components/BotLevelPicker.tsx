import { assetBg, assetSrc } from '../../../assets';
import type { BotLevel } from '../../../types';

interface BotLevelPickerProps {
  open: boolean;
  onChoose: (level: BotLevel) => void;
  onClose: () => void;
}

export function BotLevelPicker({ open, onChoose, onClose }: BotLevelPickerProps) {
  return (
    <div id="lobby-pick" className={open ? '' : 'hidden'} onClick={(event) => event.target === event.currentTarget && onClose()}>
      <div id="lobby-pick-card" style={assetBg('pickBg')}>
        <div className="pick-body">
          <div id="lobby-pick-title" style={assetBg('pickTitle')}>
            <span>Chơi với máy</span>
          </div>
          <div id="lobby-pick-levels">
            <button type="button" data-level="easy" style={assetBg('pickLevel')} onClick={() => onChoose('easy')}>
              <span>Dễ</span>
            </button>
            <button type="button" data-level="normal" style={assetBg('pickLevel')} onClick={() => onChoose('normal')}>
              <span>Vừa</span>
            </button>
            <button type="button" data-level="hard" style={assetBg('pickLevel')} onClick={() => onChoose('hard')}>
              <span>Khó</span>
            </button>
          </div>
        </div>
        <button type="button" id="lobby-pick-close" style={assetBg('pickClose')} aria-label="Đóng" onClick={onClose}>
          <img src={assetSrc('pickX')} alt="Đóng" />
        </button>
      </div>
    </div>
  );
}
