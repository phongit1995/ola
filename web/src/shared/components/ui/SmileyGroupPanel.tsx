import { useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import smileyTabIcon from '@/assets/icons/chat/ic_tab_smiley.png';
import emojiTabIcon from '@/assets/icons/chat/ic_tab_emoji.png';
import kulTabIcon from '@/assets/icons/chat/ic_tab_kul.png';
import backspaceIcon from '@/assets/icons/chat/ic_backspace_selected.png';
import { KUL_IMAGES } from '@lib';
import { SmileyGrid } from './SmileyGrid';
import { EmojiGrid } from './EmojiGrid';

function InsertPanel({ onBackspace, children }: { onBackspace?: () => void; children: ReactNode }) {
  return (
    <div className="flex h-full flex-col">
      <div className="flex-1 overflow-y-auto">{children}</div>
      {onBackspace != null && (
        <div className="flex h-8 shrink-0 items-center justify-end gap-1 border-t border-black/12 bg-white px-2">
          <span className="mr-1 h-4 w-px bg-black/12" />
          <button
            type="button"
            onMouseDown={(event) => event.preventDefault()}
            onClick={onBackspace}
            aria-label="backspace"
            title="backspace"
            className="flex h-full w-12 items-center justify-center"
          >
            <img src={backspaceIcon} alt="" className="h-5 w-5 object-contain" />
          </button>
        </div>
      )}
    </div>
  );
}

export function SmileyPanel({ onPick, onBackspace }: { onPick: (code: string) => void; onBackspace?: () => void }) {
  return (
    <InsertPanel onBackspace={onBackspace}>
      <SmileyGrid onPick={onPick} />
    </InsertPanel>
  );
}

export function EmojiPanel({ onPick, onBackspace }: { onPick: (token: string) => void; onBackspace?: () => void }) {
  return (
    <InsertPanel onBackspace={onBackspace}>
      <EmojiGrid onPick={onPick} />
    </InsertPanel>
  );
}

export function KulPanel({ onSendKul }: { onSendKul: (index: number) => void }) {
  return (
    <div className="grid grid-cols-6 gap-1 p-2">
      {KUL_IMAGES.map((image, index) => (
        <button
          key={index}
          type="button"
          onClick={() => onSendKul(index + 1)}
          className="flex aspect-square items-center justify-center rounded-lg hover:bg-gray-100"
        >
          <img src={image} alt="" className="max-h-full max-w-full object-contain" />
        </button>
      ))}
    </div>
  );
}

interface SmileyGroupPanelProps {
  onPick: (code: string) => void;
  onSendKul: (index: number) => void;
  onBackspace?: () => void;
}

export function SmileyGroupPanel({ onPick, onSendKul, onBackspace }: SmileyGroupPanelProps) {
  const { t } = useTranslation();
  const [sub, setSub] = useState<'emoji' | 'smiley' | 'kul'>('smiley');
  const subTabs = [
    { key: 'emoji' as const, label: t('chat.attachTabEmoji'), icon: emojiTabIcon },
    { key: 'smiley' as const, label: t('chat.attachTabSmiley'), icon: smileyTabIcon },
    { key: 'kul' as const, label: t('chat.attachTabKul'), icon: kulTabIcon },
  ];
  return (
    <div className="flex h-full flex-col">
      <div className="flex shrink-0">
        {subTabs.map((tab) => {
          const isActive = tab.key === sub;
          return (
            <button
              key={tab.key}
              type="button"
              aria-label={tab.label}
              onClick={() => setSub(tab.key)}
              className={`relative flex h-11 flex-1 select-none items-center justify-center transition-colors ${
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
      <div className="min-h-0 flex-1 overflow-y-auto border-t border-black/12">
        {sub === 'emoji' && <EmojiPanel onPick={onPick} onBackspace={onBackspace} />}
        {sub === 'smiley' && <SmileyPanel onPick={onPick} onBackspace={onBackspace} />}
        {sub === 'kul' && <KulPanel onSendKul={onSendKul} />}
      </div>
    </div>
  );
}
