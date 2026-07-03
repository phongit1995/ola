import { ComposerSmileyPanel } from '@components';
import { KUL_STICKERS, kulCode } from '../stickers';
import { ComposerCheckInPanel, type ComposedCheckIn } from './ComposerCheckInPanel';
import { ComposerTagPanel } from './ComposerTagPanel';

type AttachPanel = 'tag' | 'checkin' | 'sticker' | 'smiley' | null;

interface ComposerAttachPanelsProps {
  panel: AttachPanel;
  onMention: (nick: string) => void;
  onSticker: (code: string) => void;
  onCheckIn: (checkIn: ComposedCheckIn) => void;
  onSmiley: (code: string) => void;
}

export function ComposerAttachPanels({
  panel,
  onMention,
  onSticker,
  onCheckIn,
  onSmiley,
}: ComposerAttachPanelsProps) {
  if (panel === 'tag') {
    return <ComposerTagPanel onMention={onMention} />;
  }

  if (panel === 'checkin') {
    return <ComposerCheckInPanel onSelect={onCheckIn} />;
  }

  if (panel === 'sticker') {
    return (
      <div className="mt-2 grid max-h-44 grid-cols-6 gap-1 overflow-y-auto rounded-md border border-black/12 p-2">
        {KUL_STICKERS.map((item) => (
          <button
            key={item.index}
            type="button"
            onClick={() => onSticker(kulCode(item.index))}
            className="flex h-12 items-center justify-center rounded hover:bg-gray-100"
          >
            <img src={item.src} alt="" className="h-10 w-10 object-contain" />
          </button>
        ))}
      </div>
    );
  }

  if (panel === 'smiley') {
    return <ComposerSmileyPanel onPick={onSmiley} />;
  }

  return null;
}
