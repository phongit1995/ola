import { useTranslation } from 'react-i18next';
import type { SuggestionKey } from '../types';

interface ChatBotSuggestionsProps {
  keys: SuggestionKey[];
  onPick: (prompt: string) => void;
}

export function ChatBotSuggestions({ keys, onPick }: ChatBotSuggestionsProps) {
  const { t } = useTranslation();

  return (
    <div className="flex shrink-0 gap-2 overflow-x-auto scrollbar-none border-t border-black/12 bg-white px-2 py-2">
      {keys.map((key) => (
        <button
          key={key}
          type="button"
          onClick={() => onPick(t(key))}
          className="shrink-0 rounded-full border border-black/12 bg-[#f3f3f3] px-3 py-1.5 text-xs whitespace-nowrap text-black/70 active:scale-95"
        >
          {t(key)}
        </button>
      ))}
    </div>
  );
}
