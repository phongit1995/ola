const INTRO_LINES = [100, 94, 97, 62];

export function StoryDetailSkeleton() {
  return (
    <div
      aria-busy="true"
      className="flex-1 animate-pulse overflow-hidden motion-reduce:animate-none"
    >
      <div className="bg-white px-4 pt-4 pb-4">
        <div className="flex gap-4">
          <span className="aspect-3/4 w-28 shrink-0 rounded-lg bg-black/8" />
          <div className="flex flex-1 flex-col gap-2.5 pt-1">
            <span className="h-5 w-11/12 rounded bg-black/8" />
            <span className="h-5 w-2/3 rounded bg-black/8" />
            <span className="mt-1 h-4 w-3/4 rounded bg-black/6" />
            <span className="mt-auto h-3.5 w-24 rounded bg-black/6" />
          </div>
        </div>
        <span className="mt-4 block h-14 rounded-xl bg-black/6" />
        <span className="mt-4 block h-11 rounded-full bg-black/8" />
      </div>
      <div className="mt-2 flex flex-col gap-3 bg-white px-4 py-4">
        <span className="h-4 w-24 rounded bg-black/8" />
        {INTRO_LINES.map((width, index) => (
          <span
            key={index}
            className="h-3.5 rounded bg-black/6"
            style={{ width: `${width}%` }}
          />
        ))}
      </div>
    </div>
  );
}
