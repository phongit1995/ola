interface CheckInCardProps {
  venue: string;
  label: string;
}

export function CheckInCard({ venue, label }: CheckInCardProps) {
  return (
    <div className="mx-4 mt-3 flex h-24 items-end overflow-hidden rounded bg-gradient-to-br from-ola-primary to-ola-primary-darker">
      <div className="flex w-full items-center gap-2 bg-black/50 px-3 py-2 text-white">
        <span className="text-lg leading-none">📍</span>
        <span className="flex-1 truncate text-sm">{venue}</span>
        <span aria-label={label} className="text-base text-white/80">
          ›
        </span>
      </div>
    </div>
  );
}
