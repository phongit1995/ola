import { SMILEYS } from '../smileys';

interface ComposerSmileyPanelProps {
  onPick: (code: string) => void;
}

export function ComposerSmileyPanel({ onPick }: ComposerSmileyPanelProps) {
  return (
    <div className="mt-2 grid max-h-44 grid-cols-8 gap-1 overflow-y-auto rounded-md border border-black/12 p-2">
      {SMILEYS.map((item) => (
        <button
          key={item.index}
          type="button"
          onClick={() => onPick(item.code)}
          className="flex h-9 items-center justify-center rounded hover:bg-gray-100"
        >
          <img src={item.src} alt={item.code} className="h-7 w-7 object-contain" />
        </button>
      ))}
    </div>
  );
}
