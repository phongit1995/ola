import type { BrowserGlobals } from './SaveFiles.types';
import { MAX_IMPORT_BYTES, PICKER_ID } from './SaveFiles.constants';
import { sys } from 'cc';
const browser = (): BrowserGlobals | null => (sys.isBrowser ? (globalThis as unknown as BrowserGlobals) : null);

/** Offer a JSON text as a download. Returns false when no browser document is available. */
export function downloadJson(text: string, filename: string): boolean {
  const g = browser();
  if (!g) return false;
  const url = g.URL.createObjectURL(new g.Blob([text], { type: 'application/json' }));
  const link = g.document.createElement('a');
  link.href = url;
  link.download = filename;
  link.click();
  setTimeout(() => g.URL.revokeObjectURL(url), 5000);
  return true;
}

/** Open the browser file picker for a JSON save. Returns false when no browser document is available. */
export function pickJsonFile(onText: (text: string) => void, onTooLarge: () => void): boolean {
  const g = browser();
  if (!g) return false;
  const d = g.document,
    file = d.createElement('input');
  file.type = 'file';
  file.accept = 'application/json,.json';
  file.id = PICKER_ID;
  file.style.display = 'none';
  d.getElementById(file.id)?.remove();
  d.body.appendChild(file);
  file.addEventListener('change', async () => {
    const chosen = file.files?.[0];
    if (chosen) {
      if (chosen.size > MAX_IMPORT_BYTES) onTooLarge();
      else onText(await chosen.text());
    }
    file.remove();
  });
  file.click();
  return true;
}
