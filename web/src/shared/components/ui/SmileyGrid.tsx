import { SMILEY_PANEL } from '@lib';

interface SmileyGridProps {
  onPick: (code: string) => void;
}

export function SmileyGrid({ onPick }: SmileyGridProps) {
  return (
    <div className="grid grid-cols-8 gap-1 p-2">
      {SMILEY_PANEL.map((smiley, index) => (
        <button
          key={index}
          type="button"
          aria-label={smiley.code}
          onMouseDown={(event) => event.preventDefault()}
          onClick={() => onPick(smiley.code)}
          className="flex h-9 items-center justify-center rounded hover:bg-gray-100"
        >
          <img
            src={smiley.image}
            alt=""
            className="h-6 w-auto object-contain"
          />
        </button>
      ))}
    </div>
  );
}
