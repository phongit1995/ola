import type { ParseKeys } from 'i18next';
import { STORY_SORT, STORY_STATUS, STORY_STATUS_FILTER } from '@constants';
import type {
  StoryReaderFont,
  StoryReaderTheme,
  StorySort,
  StoryStatus,
  StoryStatusFilter,
} from '@app-types';
import type { ReaderPalette } from './interface';

export const SEARCH_DEBOUNCE_MS = 300;

export const SORT_OPTIONS: { value: StorySort; labelKey: ParseKeys }[] = [
  { value: STORY_SORT.updated, labelKey: 'story.sortUpdated' },
  { value: STORY_SORT.views, labelKey: 'story.sortViews' },
  { value: STORY_SORT.new, labelKey: 'story.sortNew' },
];

export const STATUS_FILTER_OPTIONS: {
  value: StoryStatusFilter;
  labelKey: ParseKeys;
}[] = [
  { value: STORY_STATUS_FILTER.all, labelKey: 'story.statusAll' },
  { value: STORY_STATUS_FILTER.ongoing, labelKey: 'story.statusOngoing' },
  { value: STORY_STATUS_FILTER.completed, labelKey: 'story.statusCompleted' },
];

export const STATUS_LABEL: Record<StoryStatus, ParseKeys> = {
  [STORY_STATUS.ongoing]: 'story.statusOngoing',
  [STORY_STATUS.completed]: 'story.statusCompleted',
  [STORY_STATUS.unknown]: 'story.statusUnknown',
};

export const READER_PALETTES: Record<StoryReaderTheme, ReaderPalette> = {
  light: {
    labelKey: 'story.themeLight',
    background: '#ffffff',
    panel: '#f4f4f4',
    text: '#212121',
    muted: 'rgba(33,33,33,.55)',
    border: 'rgba(0,0,0,.1)',
  },
  sepia: {
    labelKey: 'story.themeSepia',
    background: '#f6efdd',
    panel: '#ece2c9',
    text: '#4a3b2a',
    muted: 'rgba(74,59,42,.6)',
    border: 'rgba(74,59,42,.15)',
  },
  green: {
    labelKey: 'story.themeGreen',
    background: '#e5efdf',
    panel: '#d6e5cd',
    text: '#26331f',
    muted: 'rgba(38,51,31,.6)',
    border: 'rgba(38,51,31,.14)',
  },
  gray: {
    labelKey: 'story.themeGray',
    background: '#e2e3e5',
    panel: '#d3d5d8',
    text: '#26282b',
    muted: 'rgba(38,40,43,.6)',
    border: 'rgba(38,40,43,.14)',
  },
  dark: {
    labelKey: 'story.themeDark',
    background: '#17181b',
    panel: '#24262a',
    text: '#c8c9cc',
    muted: 'rgba(200,201,204,.55)',
    border: 'rgba(255,255,255,.1)',
  },
};

export const READER_THEME_ORDER: StoryReaderTheme[] = [
  'light',
  'sepia',
  'green',
  'gray',
  'dark',
];

export const READER_FONTS: Record<
  StoryReaderFont,
  { labelKey: ParseKeys; family: string }
> = {
  serif: {
    labelKey: 'story.fontSerif',
    family: "'Noto Serif', Georgia, 'Times New Roman', serif",
  },
  sans: {
    labelKey: 'story.fontSans',
    family: "Roboto, 'Helvetica Neue', system-ui, -apple-system, sans-serif",
  },
};
