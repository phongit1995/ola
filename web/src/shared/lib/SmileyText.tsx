import { smileyImgClass, splitSmileys } from './chatSmiley';

export function SmileyText({ text }: { text: string }) {
  return (
    <>
      {splitSmileys(text).map((segment, index) =>
        segment.kind === 'image' ? (
          <img
            key={index}
            src={segment.src}
            alt={segment.code}
            className={smileyImgClass(segment.variant)}
          />
        ) : (
          <span key={index}>{segment.value}</span>
        )
      )}
    </>
  );
}
