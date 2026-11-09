export type TileMarkName = 'chance' | 'chest' | 'tax' | 'go';

const CHANCE_PATHS = ['M6 10V7l4-4h12l4 4v7l-8 7v2h-6v-5l8-7V9l-2-1h-4l-2 2v2H6Z', 'M12 26h6v5h-6Z'];
const CHEST_PATHS = [
  'M5 10h10a3 3 0 1 0-3-3 2 2 0 0 1-4 0 7 7 0 1 1 7 7H5a2 2 0 0 1 0-4Z',
  'M3 17h22a2 2 0 1 0 0-4 2 2 0 0 1 0-4 6 6 0 0 1 0 12H3a2 2 0 0 1 0-4Z',
  'M8 24a2 2 0 0 1 2-2h9a5 5 0 1 1-5 5 2 2 0 0 1 4 0 1 1 0 1 0 1-1h-9a2 2 0 0 1-2-2Z',
];

export function TileMark({ name, color }: { name: TileMarkName; color?: string }) {
  return (
    <svg viewBox="0 0 32 32" aria-hidden="true" focusable="false">
      {name === 'chance' ? CHANCE_PATHS.map((d) => <path key={d} fill={color ?? '#E0560E'} d={d} />) : null}
      {name === 'chest' ? CHEST_PATHS.map((d) => <path key={d} fill={color ?? '#0D95EE'} d={d} />) : null}
      {name === 'tax' ? (
        <>
          <path fill="#F2B807" stroke="#1F2A44" strokeWidth="1" strokeLinejoin="round" d="m12 9-3-6 5 1 2-2 2 2 5-1-3 6c1 3 8 7 8 14 0 5-5 7-12 7S4 28 4 23c0-7 7-11 8-14Z" />
          <path fill="#1F2A44" d="M11 8.5h10v2H11Z" />
          <path fill="#E0564A" d="m20 14 2 1.5-10 12-2-1.5Z" />
          <path fill="#E0564A" fillRule="evenodd" d="M12 13a3.5 3.5 0 1 1 0 7 3.5 3.5 0 0 1 0-7Zm0 2.2a1.3 1.3 0 1 0 0 2.6 1.3 1.3 0 0 0 0-2.6ZM21 21a3.5 3.5 0 1 1 0 7 3.5 3.5 0 0 1 0-7Zm0 2.2a1.3 1.3 0 1 0 0 2.6 1.3 1.3 0 0 0 0-2.6Z" />
        </>
      ) : null}
      {name === 'go' ? <path fill="#1F8A5B" stroke="#1F2A44" strokeWidth="1" strokeLinejoin="round" d="M16 2 30 16H22v14H10V16H2Z" /> : null}
    </svg>
  );
}
