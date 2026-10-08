import type { StoryIconName } from '@ola/shared/types';

export const STORY_ICON_XML: Record<StoryIconName, string> = {
  chevronLeft:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M14.7 4.8 7.5 12l7.2 7.2" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  chevronRight:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M9.3 4.8 16.5 12l-7.2 7.2" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  list:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><g stroke="currentColor" stroke-width="1.5" stroke-linecap="round"><path d="M7 5.5h13M7 12h13M7 18.5h13"/></g><g fill="currentColor"><circle cx="3.8" cy="5.5" r="1.05"/><circle cx="3.8" cy="12" r="1.05"/><circle cx="3.8" cy="18.5" r="1.05"/></g></svg>',
  formatSize:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><g stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 7V4.5h11V7M8.5 4.5v15M6 19.5h5"/><path d="M15 12v-2h6v2M18 10v9.5M16 19.5h4"/></g></svg>',
  importExport:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><g stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M8 4v12M5 7l3-3 3 3M16 20V8M13 17l3 3 3-3"/><path d="M4.2 19.6h7.3M12.5 4.4h7.3" stroke-width="1.125"/></g></svg>',
  visibility:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M2.75 12s3.3-5.8 9.25-5.8S21.25 12 21.25 12s-3.3 5.8-9.25 5.8S2.75 12 2.75 12Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><circle cx="12" cy="12" r="3.35" stroke="currentColor" stroke-width="1.125"/></svg>',
  menuBook:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><g stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"><path d="M12 6.7C9.4 4.8 6.3 4.2 3.5 5v14c2.8-.8 5.9-.2 8.5 1.7M12 6.7c2.6-1.9 5.7-2.5 8.5-1.7v14c-2.8-.8-5.9-.2-8.5 1.7M12 6.7v14" stroke-width="1.5"/><path d="M5.5 8.3c1.7-.3 3.3 0 4.8.8M5.5 11c1.7-.3 3.3 0 4.8.8M18.5 8.3c-1.7-.3-3.3 0-4.8.8M18.5 11c-1.7-.3-3.3 0-4.8.8" stroke-width="1.125"/></g></svg>',
  article:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><g stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"><path d="M6 3.5h8l4 4v13H6zM14 3.5v4h4" stroke-width="1.5"/><path d="M8.8 11h6.4M8.8 14.25h6.4M8.8 17.5h4.4" stroke-width="1.125"/></g></svg>',
  chatBubble:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M5.5 4.5h13A2.5 2.5 0 0 1 21 7v7.5a2.5 2.5 0 0 1-2.5 2.5H10l-5 3.5v-3.8a2.5 2.5 0 0 1-2-2.4V7a2.5 2.5 0 0 1 2.5-2.5Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M8 11.5h.01M12 11.5h.01M16 11.5h.01" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg>',
  schedule:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="8.75" stroke="currentColor" stroke-width="1.5"/><path d="M12 6.3v5.9l4 2.25" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  done:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="m4.2 12.3 4.7 4.7L19.8 6.2" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  inkPen:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><g stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"><path d="m4.2 19.8 2.7-7L16.8 2.9l4.3 4.3-9.9 9.9-7 2.7Z" stroke-width="1.5"/><path d="m16.8 2.9 4.3 4.3M13.5 6.2l4.3 4.3M6.9 16.1l1.2 1.2" stroke-width="1.125"/></g></svg>',
  bookmark:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M6.3 3.5h11.4v17l-5.7-3.2-5.7 3.2z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  autoAwesome:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="m8.5 3.8 1.2 3.3L13 8.3l-3.3 1.2-1.2 3.3-1.2-3.3L4 8.3l3.3-1.2z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="m17.2 12.2.8 2.2 2.2.8-2.2.8-.8 2.2-.8-2.2-2.2-.8 2.2-.8zM5.1 14.6l.5 1.4 1.4.5-1.4.5-.5 1.4-.5-1.4-1.4-.5 1.4-.5z" stroke="currentColor" stroke-width="1.125" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  lightMode:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="4.8" stroke="currentColor" stroke-width="1.5"/><path d="M12 2.7v2M12 19.3v2M2.7 12h2M19.3 12h2M5.4 5.4l1.4 1.4M17.2 17.2l1.4 1.4M18.6 5.4l-1.4 1.4M6.8 17.2l-1.4 1.4" stroke="currentColor" stroke-width="1.125" stroke-linecap="round"/></svg>',
  darkMode:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M18.5 14.9A7.1 7.1 0 0 1 9.1 5.5 7.9 7.9 0 1 0 18.5 14.9Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><g fill="currentColor"><circle cx="16.8" cy="5.1" r="0.7"/><circle cx="19.3" cy="8.1" r="0.7"/><circle cx="14.8" cy="3.1" r="0.7"/></g></svg>',
  palette:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M12 3C7 3 3 6.9 3 12a9 9 0 0 0 9 9h1a2 2 0 0 0 0-4h-.5a1.75 1.75 0 0 1 0-3.5H16a5 5 0 0 0 5-5C21 5.5 17 3 12 3Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><g fill="currentColor"><circle cx="7" cy="10.6" r="1.05"/><circle cx="10" cy="7.3" r="1.05"/><circle cx="14" cy="7.1" r="1.05"/><circle cx="17.5" cy="9.1" r="1.05"/></g></svg>',
  textFields:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><g stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 19 8 5l5 14M5 14h6"/><path d="M15 11c3-2 6-.9 6 2v6M21 14h-3a2.5 2.5 0 0 0 0 5c1.5 0 3-.9 3-2"/></g></svg>',
  formatLineSpacing:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><g stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M9.5 5.2h11M9.5 11.8h11M9.5 18.4h11"/><path d="M4.2 5.2v13.2M2.5 7.1l1.7-1.9 1.7 1.9M2.5 16.5l1.7 1.9 1.7-1.9"/></g></svg>',
  priorityHigh:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M11 4.2h2l-.35 9.1h-1.3z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M12 17.8v.01" stroke="currentColor" stroke-width="2.25" stroke-linecap="round"/></svg>',
  arrowDropDown:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="m6 9 6 6 6-6" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  book:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><g stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 5.75c3.4-.6 6.5.4 9 2.75v12c-2.5-2.35-5.6-3.35-9-2.75ZM12 8.5c1.75-2.3 4-3.8 6.5-4.5v12c-2.5.7-4.75 2.2-6.5 4.5M18.5 7.5H21V19h-4"/><path d="M6 10.25c1 .15 2 .5 3 1M6 13.5c1 .15 2 .5 3 1" stroke-width="1.125"/></g></svg>',
  emojiEvents:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M7.25 3.75h9.5v6.75A3.75 3.75 0 0 1 13 14.25h-2a3.75 3.75 0 0 1-3.75-3.75ZM7.25 5.75H4V8c0 2.5 1.5 4.25 3.75 4.25M16.75 5.75H20V8c0 2.5-1.5 4.25-3.75 4.25M12 14.25v3.25M8 20.5c.5-2 1.8-3 4-3s3.5 1 4 3Z" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  libraryBooks:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><g stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M9.5 3.5H20v11H9.5a2 2 0 0 0 0 4H20M7.5 16.5v-11a2 2 0 0 1 2-2M3.5 7.5v11A2.5 2.5 0 0 0 6 21h10.5"/><path d="M10.5 6.5v5M13.5 7h3.5M13.5 10h2M10 16.5h7.5" stroke-width="1.125"/></g></svg>',
  filterAlt:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><g stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M4.5 4h15a1 1 0 0 1 .8 1.6l-5.55 7.2a2 2 0 0 0-.4 1.2v4.5a1 1 0 0 1-.65.94L10 20.5V14a2 2 0 0 0-.4-1.2L3.7 5.6A1 1 0 0 1 4.5 4Z"/><path d="M7.5 7h9" stroke-width="1.125"/></g></svg>',
  search:
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M16.25 10a6.25 6.25 0 1 1-12.5 0 6.25 6.25 0 0 1 12.5 0ZM14.45 14.45l1.25 1.25M17.2 15.6l3.65 3.65a1.13 1.13 0 0 1-1.6 1.6L15.6 17.2a1.13 1.13 0 0 1 1.6-1.6Z" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
};
