import { renderRichText } from './richText';
import { copySelectionWithSmileyCodes } from './textSelection';

interface SelectableRichTextProps {
  content: string;
  onMention: (nick: string) => void;
  onPrimary: boolean;
}

export function SelectableRichText({
  content,
  onMention,
  onPrimary,
}: SelectableRichTextProps) {
  return (
    <span
      data-selectable-text=""
      onCopy={copySelectionWithSmileyCodes}
      className={`pointer-fine:select-text ${
        onPrimary ? 'selection:bg-white/35 selection:text-ola-on-primary' : ''
      }`}
    >
      {renderRichText(content, onMention)}
    </span>
  );
}
