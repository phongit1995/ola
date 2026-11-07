import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ComposerSmileyPanel, SmileyInput, type SmileyInputHandle } from '@components';
import { cn } from '@lib';
import smileyIcon from '@/assets/icons/chat/ic_tab_emoji.png';

interface MegaphoneContentInputProps {
  value: string;
  tooLong: boolean;
  counter: string;
  onChange: (value: string) => void;
}

export function MegaphoneContentInput({ value, tooLong, counter, onChange }: MegaphoneContentInputProps) {
  const { t } = useTranslation();
  const inputRef = useRef<SmileyInputHandle>(null);
  const [smileyOpen, setSmileyOpen] = useState(false);

  useEffect(() => {
    inputRef.current?.focus();
  }, []);

  return (
    <div className="flex flex-col gap-2">
      <div className="relative">
        <SmileyInput
          ref={inputRef}
          value={value}
          onChange={onChange}
          placeholder={t('megaphone.placeholder')}
          multiline
          className={cn(
            'max-h-28 min-h-[84px] w-full overflow-y-auto rounded border px-3 pt-2 pb-8 text-sm text-black/87 outline-none',
            tooLong ? 'border-ola-error' : 'border-black/12 focus:border-ola-warning'
          )}
        />
        <button
          type="button"
          aria-label={t('chat.attachTabSmiley')}
          aria-pressed={smileyOpen}
          onClick={() => setSmileyOpen((open) => !open)}
          className="absolute bottom-1 left-1 flex h-7 w-7 items-center justify-center"
        >
          <img src={smileyIcon} alt="" className="h-6 w-6 object-contain" />
        </button>
        <span
          className={cn(
            'pointer-events-none absolute right-2 bottom-2 text-xs',
            tooLong ? 'font-semibold text-ola-error' : 'text-black/40'
          )}
        >
          {counter}
        </span>
      </div>
      {smileyOpen && (
        <div className="max-h-[min(14rem,30vh)] overflow-y-auto rounded border border-black/12 bg-white">
          <ComposerSmileyPanel onPick={(code) => inputRef.current?.insertCode(code, true)} />
        </div>
      )}
    </div>
  );
}
