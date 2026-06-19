import { SmileyGrid } from './SmileyGrid';

interface ComposerSmileyPanelProps {
  onPick: (code: string) => void;
}

export function ComposerSmileyPanel({ onPick }: ComposerSmileyPanelProps) {
  return (
    <div className="mt-2 max-h-44 overflow-y-auto rounded-md border border-black/12">
      <SmileyGrid onPick={onPick} />
    </div>
  );
}
