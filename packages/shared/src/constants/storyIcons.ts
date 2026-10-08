export interface StoryIconGlyph {
  viewBox: string;
  outline: string;
  detail?: string;
  accent?: string;
  accentFill?: string;
  tint?: string;
}

export const STORY_ICON_STYLE = {
  outlineWidth: 1.8,
  detailWidth: 1.25,
  accentWidth: 1.5,
  tintOpacity: 0.14,
} as const;

const MATERIAL_VIEW_BOX = '0 0 24 24';

export const STORY_ICON_GLYPHS = {
  chevronLeft: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M14.7 4.8 7.5 12l7.2 7.2',
    accent: 'M16.8 4.8 9.6 12l7.2 7.2',
  },
  chevronRight: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M9.3 4.8 16.5 12l-7.2 7.2',
    accent: 'M7.2 4.8 14.4 12l-7.2 7.2',
  },
  list: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M6.8 5.5h13M6.8 12h13M6.8 18.5h13',
    accentFill:
      'M3.5 4.4a1.1 1.1 0 1 0 0 2.2 1.1 1.1 0 0 0 0-2.2ZM3.5 10.9a1.1 1.1 0 1 0 0 2.2 1.1 1.1 0 0 0 0-2.2ZM3.5 17.4a1.1 1.1 0 1 0 0 2.2 1.1 1.1 0 0 0 0-2.2Z',
  },
  formatSize: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M3 7V4.5h11V7M8.5 4.5v15M6 19.5h5M15 12v-2h6v2M18 10v9.5M16 19.5h4',
    accent: 'M5.5 7h6',
  },
  importExport: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M8 4v12M5 7l3-3 3 3M16 20V8M13 17l3 3 3-3',
    accent: 'M4.2 19.6h7.3M12.5 4.4h7.3',
  },
  visibility: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M2.2 12s3.5-6.1 9.8-6.1S21.8 12 21.8 12 18.3 18.1 12 18.1 2.2 12 2.2 12Z',
    detail: 'M12 8.1a3.9 3.9 0 1 0 0 7.8 3.9 3.9 0 0 0 0-7.8Z',
    accentFill: 'M12 10.1a1.9 1.9 0 1 1 0 3.8 1.9 1.9 0 0 1 0-3.8Z',
  },
  menuBook: {
    viewBox: MATERIAL_VIEW_BOX,
    outline:
      'M2.8 5.3c2.8-.8 5.7-.3 9.2 1.5v13.4c-3.5-1.8-6.4-2.3-9.2-1.5V5.3ZM21.2 5.3c-2.8-.8-5.7-.3-9.2 1.5v13.4c3.5-1.8 6.4-2.3 9.2-1.5V5.3ZM12 6.8v13.4',
    detail:
      'M4.7 8.3c2-.3 4.1.1 6.1 1.1M4.7 11.1c2-.3 4.1.1 6.1 1.1M19.3 8.3c-2-.3-4.1.1-6.1 1.1M19.3 11.1c-2-.3-4.1.1-6.1 1.1',
    accent: 'M12 6.8v13.4',
    tint: 'M3.1 5.8c2.6-.6 5.3 0 8.4 1.6v11.4c-3-1.4-5.7-2-8.4-1.4zM20.9 5.8c-2.6-.6-5.3 0-8.4 1.6v11.4c3-1.4 5.7-2 8.4-1.4z',
  },
  article: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M5 3.2h10.7L19 6.5v14.3H5zM15.7 3.2v3.3H19',
    detail: 'M8 10h8M8 13.2h8M8 16.4h5.1',
    accent: 'M15.7 3.2v3.3H19',
    accentFill: 'M7.1 7.1h3.1v.8H7.1z',
  },
  chatBubble: {
    viewBox: MATERIAL_VIEW_BOX,
    outline:
      'M5.5 4h13A2.5 2.5 0 0 1 21 6.5v8a2.5 2.5 0 0 1-2.5 2.5H10l-5 4v-4a2 2 0 0 1-2-2V6.5A2.5 2.5 0 0 1 5.5 4Z',
    accentFill:
      'M8 9.3a1.1 1.1 0 1 0 0 2.2 1.1 1.1 0 0 0 0-2.2ZM12 9.3a1.1 1.1 0 1 0 0 2.2 1.1 1.1 0 0 0 0-2.2ZM16 9.3a1.1 1.1 0 1 0 0 2.2 1.1 1.1 0 0 0 0-2.2Z',
    tint: 'M5.5 5h13A1.5 1.5 0 0 1 20 6.5v8a1.5 1.5 0 0 1-1.5 1.5H9.7L6 19v-3H5a1 1 0 0 1-1-1V6.5A1.5 1.5 0 0 1 5.5 5Z',
  },
  schedule: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M12 3.1a8.9 8.9 0 1 0 0 17.8 8.9 8.9 0 0 0 0-17.8Z',
    detail: 'M12 3.5v1M20.5 12h-1M12 20.5v-1M3.5 12h1',
    accent: 'M12 6.1v6l4.1 2.3',
  },
  done: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'm3.7 12.2 4.9 4.9L20.3 5.5',
    detail: 'M6.1 12.2 8.6 14.7',
    accent: 'm8.6 17.1 11.7-11.6',
  },
  inkPen: {
    viewBox: MATERIAL_VIEW_BOX,
    outline:
      'm4.2 16.4 9.4-9.4 3.4 3.4-9.4 9.4-4 .6zM13.6 7l2-2 3.4 3.4-2 2M18.8 4.4l1-1 1.8 1.8-1 1',
    detail: 'M6.2 17.8 8 19.6M8.1 16l1.8 1.8M4.2 20.4h4',
    accent: 'M13.6 7l3.4 3.4',
  },
  bookmark: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M6 3.3h12v17.4l-6-3.2-6 3.2z',
    detail: 'M8.5 5.8h7',
    accent: 'M10 8.8h4v4l-2-1.2-2 1.2z',
    tint: 'M7.1 4.2h9.8v13.7l-4.9-2.6-4.9 2.6z',
  },
  autoAwesome: {
    viewBox: MATERIAL_VIEW_BOX,
    outline:
      'm8.5 3.4 1.1 3.1 3.1 1.1-3.1 1.1-1.1 3.1-1.1-3.1-3.1-1.1 3.1-1.1zM17.4 12.1l.8 2.2 2.2.8-2.2.8-.8 2.2-.8-2.2-2.2-.8 2.2-.8zM5 14.1l.6 1.6 1.6.6-1.6.6L5 18.5l-.6-1.6-1.6-.6 1.6-.6z',
    accentFill:
      'M8.5 5.2 9 6.7l1.5.5-1.5.5-.5 1.5L8 7.7l-1.5-.5L8 6.7zM17.4 13.8l.4 1.1 1.1.4-1.1.4-.4 1.1-.4-1.1-1.1-.4 1.1-.4z',
  },
  lightMode: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M12 7.2a4.8 4.8 0 1 0 0 9.6 4.8 4.8 0 0 0 0-9.6Z',
    detail:
      'M12 2.7v2M12 19.3v2M2.7 12h2M19.3 12h2M5.4 5.4l1.4 1.4M17.2 17.2l1.4 1.4M18.6 5.4l-1.4 1.4M6.8 17.2l-1.4 1.4',
    accent: 'M12 7.2a4.8 4.8 0 1 0 0 9.6 4.8 4.8 0 0 0 0-9.6Z',
  },
  darkMode: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M18.5 14.9A7.1 7.1 0 0 1 9.1 5.5 7.9 7.9 0 1 0 18.5 14.9Z',
    detail: 'M16.8 5.1h.1M19.3 8.1h.1M14.8 3.1h.1',
    accentFill: 'M16.55 4.85h.6v.6h-.6zM19.05 7.85h.6v.6h-.6zM14.55 2.85h.6v.6h-.6z',
  },
  palette: {
    viewBox: MATERIAL_VIEW_BOX,
    outline:
      'M12 3C7 3 3 6.9 3 12a9 9 0 0 0 9 9h1a2 2 0 0 0 0-4h-.5a1.75 1.75 0 0 1 0-3.5H16a5 5 0 0 0 5-5C21 5.5 17 3 12 3Z',
    detail: 'M6.5 15.5h1.5',
    accentFill:
      'M7 9.5a1.1 1.1 0 1 0 0 2.2 1.1 1.1 0 0 0 0-2.2ZM10 6.2a1.1 1.1 0 1 0 0 2.2 1.1 1.1 0 0 0 0-2.2ZM14 6a1.1 1.1 0 1 0 0 2.2 1.1 1.1 0 0 0 0-2.2ZM17.5 8a1.1 1.1 0 1 0 0 2.2 1.1 1.1 0 0 0 0-2.2Z',
  },
  textFields: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M3 19 8 5l5 14M5 14h6M15 11c3-2 6-.9 6 2v6M21 14h-3a2.5 2.5 0 0 0 0 5c1.5 0 3-.9 3-2',
    detail: 'M2 19h3M11 19h3',
    accent: 'M5 14h6',
  },
  formatLineSpacing: {
    viewBox: MATERIAL_VIEW_BOX,
    outline:
      'M9.5 5.2h11M9.5 11.8h11M9.5 18.4h11M4.2 5.2v13.2M2.5 7.1l1.7-1.9 1.7 1.9M2.5 16.5l1.7 1.9 1.7-1.9',
    detail: 'M11.8 4.1v2.2M11.8 10.7v2.2M11.8 17.3v2.2',
    accent: 'M9.5 11.8h11',
  },
  priorityHigh: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M10.8 4h2.4l-.4 9h-1.6Z',
    accentFill: 'M10.9 16.8h2.2v2.2h-2.2z',
    tint: 'M12 2.4a9.6 9.6 0 1 0 0 19.2 9.6 9.6 0 0 0 0-19.2Z',
  },
  arrowDropDown: {
    viewBox: MATERIAL_VIEW_BOX,
    outline: 'M5.2 8.5 12 15.3l6.8-6.8',
    detail: 'M8.1 8.5 12 12.4l3.9-3.9',
    accent: 'M10 13.3 12 15.3l2-2',
  },
} as const satisfies Record<string, StoryIconGlyph>;

export const STORY_ICON_ASSET_NAMES = [
  'book',
  'emojiEvents',
  'libraryBooks',
  'filterAlt',
  'search',
] as const;

export type StoryIconName =
  | keyof typeof STORY_ICON_GLYPHS
  | (typeof STORY_ICON_ASSET_NAMES)[number];
