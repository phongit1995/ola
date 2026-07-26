import { useEffect } from 'react';
import type { GameReactionType } from '../../../../src/sdk';
import { CARO_REACTIONS } from '../../../helpers/reaction';

interface ReactionPickerProps {
  open: boolean;
  onPick: (type: GameReactionType) => void;
  onClose: () => void;
}

export function ReactionPicker({ open, onPick, onClose }: ReactionPickerProps) {
  useEffect(() => {
    if (!open) return;
    const onKeyDown = (event: KeyboardEvent): void => {
      if (event.key === 'Escape') onClose();
    };
    document.addEventListener('keydown', onKeyDown);
    return () => document.removeEventListener('keydown', onKeyDown);
  }, [onClose, open]);

  if (!open) return null;

  return (
    <div id="caro-reaction-picker" className="caro-reaction-picker" role="dialog" aria-label="Chọn cảm xúc">
      {CARO_REACTIONS.map((reaction) => (
        <button
          key={reaction.type}
          type="button"
          aria-label={reaction.label}
          title={reaction.label}
          onClick={() => onPick(reaction.type)}
        >
          <img src={reaction.src} alt="" />
        </button>
      ))}
    </div>
  );
}
