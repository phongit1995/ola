import { EMOJI_IMAGES, emojiToken } from '@lib';

interface EmojiGridProps {
  onPick: (code: string) => void;
}

export function EmojiGrid({ onPick }: EmojiGridProps) {
  return (
    <div className="grid grid-cols-8 gap-1 p-2">
      {EMOJI_IMAGES.map((image, index) => (
        <button
          key={index}
          type="button"
          onMouseDown={(event) => event.preventDefault()}
          onClick={() => onPick(emojiToken(index + 1))}
          className="flex h-9 items-center justify-center rounded hover:bg-gray-100"
        >
          <img src={image} alt="" className="h-[22px] w-auto object-contain" />
        </button>
      ))}
    </div>
  );
}
