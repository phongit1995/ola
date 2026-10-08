import { cn } from '@lib';
import type { StoryIconName } from '@app-types';
import bookIcon from '@/assets/icons/story/book.svg';
import emojiEventsIcon from '@/assets/icons/story/emoji-events.svg';
import libraryBooksIcon from '@/assets/icons/story/library-books.svg';
import searchIcon from '@/assets/icons/story/search.svg';
import filterAltIcon from '@/assets/icons/story/filter-alt.svg';
import chevronLeftIcon from '@/assets/icons/story/chevron-left.svg';
import chevronRightIcon from '@/assets/icons/story/chevron-right.svg';
import listIcon from '@/assets/icons/story/list.svg';
import formatSizeIcon from '@/assets/icons/story/format-size.svg';
import importExportIcon from '@/assets/icons/story/import-export.svg';
import visibilityIcon from '@/assets/icons/story/visibility.svg';
import menuBookIcon from '@/assets/icons/story/menu-book.svg';
import articleIcon from '@/assets/icons/story/article.svg';
import chatBubbleIcon from '@/assets/icons/story/chat-bubble.svg';
import scheduleIcon from '@/assets/icons/story/schedule.svg';
import doneIcon from '@/assets/icons/story/done.svg';
import inkPenIcon from '@/assets/icons/story/ink-pen.svg';
import bookmarkIcon from '@/assets/icons/story/bookmark.svg';
import autoAwesomeIcon from '@/assets/icons/story/auto-awesome.svg';
import lightModeIcon from '@/assets/icons/story/light-mode.svg';
import darkModeIcon from '@/assets/icons/story/dark-mode.svg';
import paletteIcon from '@/assets/icons/story/palette.svg';
import textFieldsIcon from '@/assets/icons/story/text-fields.svg';
import formatLineSpacingIcon from '@/assets/icons/story/format-line-spacing.svg';
import priorityHighIcon from '@/assets/icons/story/priority-high.svg';
import arrowDropDownIcon from '@/assets/icons/story/arrow-drop-down.svg';

interface StoryIconProps {
  name: StoryIconName;
  className?: string;
}

const STORY_ICON_ASSETS: Record<StoryIconName, string> = {
  chevronLeft: chevronLeftIcon,
  chevronRight: chevronRightIcon,
  list: listIcon,
  formatSize: formatSizeIcon,
  importExport: importExportIcon,
  visibility: visibilityIcon,
  menuBook: menuBookIcon,
  article: articleIcon,
  chatBubble: chatBubbleIcon,
  schedule: scheduleIcon,
  done: doneIcon,
  inkPen: inkPenIcon,
  bookmark: bookmarkIcon,
  autoAwesome: autoAwesomeIcon,
  lightMode: lightModeIcon,
  darkMode: darkModeIcon,
  palette: paletteIcon,
  textFields: textFieldsIcon,
  formatLineSpacing: formatLineSpacingIcon,
  priorityHigh: priorityHighIcon,
  arrowDropDown: arrowDropDownIcon,
  book: bookIcon,
  emojiEvents: emojiEventsIcon,
  libraryBooks: libraryBooksIcon,
  search: searchIcon,
  filterAlt: filterAltIcon,
};

export function StoryIcon({
  name,
  className = 'h-6 w-6',
}: StoryIconProps) {
  const asset = STORY_ICON_ASSETS[name];
  return (
    <span
      className={cn('inline-block', className)}
      aria-hidden="true"
      style={{
        backgroundColor: 'currentColor',
        maskImage: `url("${asset}")`,
        maskPosition: 'center',
        maskRepeat: 'no-repeat',
        maskSize: 'contain',
        WebkitMaskImage: `url("${asset}")`,
        WebkitMaskPosition: 'center',
        WebkitMaskRepeat: 'no-repeat',
        WebkitMaskSize: 'contain',
      }}
    />
  );
}
