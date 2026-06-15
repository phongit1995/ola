interface MediaGridProps {
  photos: string[];
}

export function MediaGrid({ photos }: MediaGridProps) {
  const shown = photos.slice(0, 5);
  const top = shown.slice(0, 2);
  const bottom = shown.slice(2, 5);
  const extra = photos.length - 5;
  return (
    <div className="mx-4 mt-3 flex flex-col gap-2">
      {top.length > 0 && (
        <div className={`grid gap-2 ${top.length === 1 ? 'grid-cols-1' : 'grid-cols-2'}`}>
          {top.map((url, index) => (
            <img key={index} src={url} alt="" className="h-44 w-full rounded object-cover" />
          ))}
        </div>
      )}
      {bottom.length > 0 && (
        <div className="grid grid-cols-3 gap-2">
          {bottom.map((url, index) => {
            const isLast = index === bottom.length - 1 && extra > 0;
            return (
              <div key={index} className="relative">
                <img src={url} alt="" className="aspect-square w-full rounded object-cover" />
                {isLast && (
                  <div className="absolute inset-0 flex items-center justify-center rounded bg-black/50 text-lg font-medium text-white">
                    +{extra}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
