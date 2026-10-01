interface TabItem<T extends string> {
  key: T;
  label: string;
}

const TAB_STYLES = {
  segmented: {
    list: 'flex rounded-full bg-black/6 p-1',
    item: 'flex-1 rounded-full py-1.5 text-sm font-medium transition-colors',
    active: 'bg-white text-ola-primary-ink shadow-sm',
    idle: 'text-black/54 hover:text-black/80',
  },
  chips: {
    list: 'flex flex-wrap gap-1.5',
    item: 'rounded-full px-3 py-1 text-xs font-medium transition-colors',
    active: 'bg-ola-primary text-ola-on-primary',
    idle: 'bg-black/5 text-black/60 hover:bg-black/10',
  },
} as const;

interface WordChainTabsProps<T extends string> {
  items: readonly TabItem<T>[];
  value: T;
  onChange: (key: T) => void;
  variant: keyof typeof TAB_STYLES;
}

export function WordChainTabs<T extends string>({
  items,
  value,
  onChange,
  variant,
}: WordChainTabsProps<T>) {
  const styles = TAB_STYLES[variant];
  return (
    <div className={styles.list}>
      {items.map((item) => {
        const active = item.key === value;
        return (
          <button
            key={item.key}
            type="button"
            aria-pressed={active}
            onClick={() => onChange(item.key)}
            className={`${styles.item} ${active ? styles.active : styles.idle}`}
          >
            {item.label}
          </button>
        );
      })}
    </div>
  );
}
