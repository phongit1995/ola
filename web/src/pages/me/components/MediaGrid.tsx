interface MediaGridProps {
  photos: string[];
  onOpen?: (index: number) => void;
}

interface CellProps {
  url: string;
  index: number;
  heightClass: string;
  onOpen?: (index: number) => void;
  extra?: number;
}

function Cell({ url, index, heightClass, onOpen, extra }: CellProps) {
  return (
    <button
      type="button"
      onClick={() => onOpen?.(index)}
      className="relative block"
    >
      <img
        src={url}
        alt=""
        className={`w-full cursor-pointer rounded object-cover ${heightClass}`}
      />
      {extra != null && extra > 0 && (
        <div className="absolute inset-0 flex items-center justify-center rounded bg-black/50 text-lg font-medium text-white">
          +{extra}
        </div>
      )}
    </button>
  );
}

export function MediaGrid({ photos, onOpen }: MediaGridProps) {
  const count = photos.length;
  if (count === 0) return null;

  if (count === 1) {
    return (
      <div className="mx-4 mt-3">
        <button
          type="button"
          onClick={() => onOpen?.(0)}
          className="block w-full"
        >
          <img
            src={photos[0]}
            alt=""
            className="max-h-96 w-full cursor-pointer rounded object-cover md:max-h-[34rem]"
          />
        </button>
      </div>
    );
  }

  if (count <= 4) {
    const cols = count === 3 ? 'grid-cols-3' : 'grid-cols-2';
    const height =
      count === 2
        ? 'h-44 md:h-72 lg:h-[26rem]'
        : count === 3
        ? 'h-28 md:h-52 lg:h-72'
        : 'h-40 md:h-64 lg:h-80';
    return (
      <div className={`mx-4 mt-3 grid gap-2 ${cols}`}>
        {photos.map((url, index) => (
          <Cell
            key={url}
            url={url}
            index={index}
            heightClass={height}
            onOpen={onOpen}
          />
        ))}
      </div>
    );
  }

  const top = photos.slice(0, 2);
  const bottom = photos.slice(2, 5);
  const extra = count - 5;
  return (
    <div className="mx-4 mt-3 flex flex-col gap-2">
      <div className="grid grid-cols-2 gap-2">
        {top.map((url, index) => (
          <Cell
            key={url}
            url={url}
            index={index}
            heightClass="h-44 md:h-72"
            onOpen={onOpen}
          />
        ))}
      </div>
      <div className="grid grid-cols-3 gap-2">
        {bottom.map((url, index) => (
          <Cell
            key={url}
            url={url}
            index={index + 2}
            heightClass="h-28 md:h-52"
            onOpen={onOpen}
            extra={index === bottom.length - 1 ? extra : undefined}
          />
        ))}
      </div>
    </div>
  );
}
