interface TabItem<T extends string> {
  key: T;
  label: string;
}

interface TabsProps<T extends string> {
  items: readonly TabItem<T>[];
  value: T;
  onChange: (key: T) => void;
}

export function WordChainSegmentedTabs<T extends string>({
  items,
  value,
  onChange,
}: TabsProps<T>) {
  return (
    <div role="tablist" className="flex rounded-full bg-black/6 p-1">
      {items.map((item) => {
        const active = item.key === value;
        return (
          <button
            key={item.key}
            type="button"
            role="tab"
            aria-selected={active}
            onClick={() => onChange(item.key)}
            className={`flex-1 rounded-full py-1.5 text-sm font-medium transition-colors ${
              active
                ? 'bg-white text-ola-primary-ink shadow-sm'
                : 'text-black/54 hover:text-black/80'
            }`}
          >
            {item.label}
          </button>
        );
      })}
    </div>
  );
}

export function WordChainFilterChips<T extends string>({
  items,
  value,
  onChange,
}: TabsProps<T>) {
  return (
    <div className="flex flex-wrap gap-1.5">
      {items.map((item) => {
        const active = item.key === value;
        return (
          <button
            key={item.key}
            type="button"
            aria-pressed={active}
            onClick={() => onChange(item.key)}
            className={`rounded-full px-3 py-1 text-xs font-medium transition-colors ${
              active
                ? 'bg-ola-primary text-white'
                : 'bg-black/5 text-black/60 hover:bg-black/10'
            }`}
          >
            {item.label}
          </button>
        );
      })}
    </div>
  );
}
