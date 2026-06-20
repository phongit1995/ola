import { Avatar, ComposerSmileyPanel } from '@components';
import { SUGGESTED_FRIENDS } from '../../chat/data';
import { KUL_STICKERS, kulCode } from '../stickers';
import { ComposerCheckInPanel, type ComposedCheckIn } from './ComposerCheckInPanel';

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
    return (
      <div className="mt-2 max-h-44 overflow-y-auto rounded-md border border-black/12">
        {SUGGESTED_FRIENDS.map((contact) => (
          <button
            key={contact.name}
            type="button"
            onClick={() => onMention(contact.name)}
            className="flex w-full items-center gap-2 px-3 py-2 text-left text-sm hover:bg-ola-primary-light"
          >
            <Avatar name={contact.name} color={contact.color} size={28} />
            <span className="text-black/87">@{contact.name}</span>
          </button>
        ))}
      </div>
    );
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
