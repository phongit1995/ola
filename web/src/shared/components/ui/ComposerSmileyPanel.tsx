import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import smileyTabIcon from '@/assets/icons/chat/ic_tab_smiley.png';
import emojiTabIcon from '@/assets/icons/chat/ic_tab_emoji.png';
import { SmileyGrid } from './SmileyGrid';
import { EmojiGrid } from './EmojiGrid';

interface ComposerSmileyPanelProps {
  onPick: (code: string) => void;
}

export function ComposerSmileyPanel({ onPick }: ComposerSmileyPanelProps) {
  const { t } = useTranslation();
  const [sub, setSub] = useState<'smiley' | 'emoji'>('smiley');
  const tabs = [
    { key: 'smiley' as const, label: t('chat.attachTabSmiley'), icon: smileyTabIcon },
    { key: 'emoji' as const, label: t('chat.attachTabEmoji'), icon: emojiTabIcon },
  ];
  return (
    <div>
      <div className="flex border-b border-black/12">
        {tabs.map((tab) => {
          const isActive = tab.key === sub;
          return (
            <button
              key={tab.key}
              type="button"
              aria-label={tab.label}
              onClick={() => setSub(tab.key)}
              className={`relative flex h-10 flex-1 items-center justify-center transition-colors ${
                isActive ? 'bg-ola-primary/10' : 'hover:bg-black/5'
              }`}
            >
              <img
                src={tab.icon}
                alt=""
                className={`h-6 w-6 object-contain transition-opacity ${isActive ? 'opacity-100' : 'opacity-60'}`}
              />
              {isActive && <span className="absolute inset-x-0 bottom-0 h-0.5 bg-ola-primary" />}
            </button>
          );
        })}
      </div>
      <div className="max-h-44 overflow-y-auto">
        {sub === 'smiley' ? <SmileyGrid onPick={onPick} /> : <EmojiGrid onPick={onPick} />}
      </div>
    </div>
  );
}
