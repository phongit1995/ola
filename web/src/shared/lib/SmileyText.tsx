import { splitSmileys } from './chatSmiley';

export function SmileyText({ text }: { text: string }) {
  return (
    <>
      {splitSmileys(text).map((segment, index) =>
        segment.kind === 'image' ? (
          <img
            key={index}
            src={segment.src}
            alt={segment.code}
            className="inline-block h-[1.25em] w-auto align-text-bottom"
          />
        ) : (
          <span key={index}>{segment.value}</span>
        )
      )}
    </>
  );
}
