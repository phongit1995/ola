import { OLA_BRIDGE_EVENT, OLA_BRIDGE_SOURCE, TOKEN_TIMEOUT_MS } from './OlaBridge.constants';
import type { OlaBridgeMessage, ReactNativeWebViewPort } from './OlaBridge.types';
import { parseLocale } from '../../core/i18n/I18n';
import type { Locale } from '../../core/i18n/I18n.types';

/**
 * The Ola arcade bridge, as in game/src/sdk/bridge.ts: the web host embeds the game in an iframe and answers with
 * `postMessage`; the mobile host runs it in a WebView and dispatches `message` events on `document`.
 */
const browser = typeof window !== 'undefined' && typeof document !== 'undefined';

function nativePort(): ReactNativeWebViewPort | null {
  return (globalThis as { ReactNativeWebView?: ReactNativeWebViewPort }).ReactNativeWebView ?? null;
}

function framed(): boolean {
  return browser && window.parent !== window;
}

function parentOrigin(): string | null {
  if (!framed() || !document.referrer) return null;
  try {
    return new URL(document.referrer).origin;
  } catch {
    return null;
  }
}

function hosted(): boolean {
  return nativePort() !== null || framed();
}

function send(type: string, data?: unknown): void {
  const message: OlaBridgeMessage = { source: OLA_BRIDGE_SOURCE.Game, type, data };
  const native = nativePort();
  if (native) native.postMessage(JSON.stringify(message));
  else if (framed()) window.parent.postMessage(message, parentOrigin() ?? '*');
}

function hostMessage(raw: unknown): OlaBridgeMessage | null {
  let value = raw;
  if (typeof raw === 'string')
    try {
      value = JSON.parse(raw);
    } catch {
      return null;
    }
  const message = value as OlaBridgeMessage | null;
  return message && message.source === OLA_BRIDGE_SOURCE.Host && typeof message.type === 'string' ? message : null;
}

/** Resolves with the data of the next host message of this type, or undefined after the timeout. */
function nextFromHost(type: string, timeoutMs: number): Promise<unknown> {
  return new Promise(resolve => {
    const origin = parentOrigin();
    const accept = (raw: unknown): void => {
      const message = hostMessage(raw);
      if (message?.type === type) finish(message.data);
    };
    const fromParent = (event: MessageEvent): void => {
      if (!framed() || event.source !== window.parent || (origin !== null && event.origin !== origin)) return;
      accept(event.data);
    };
    const fromNative = (event: Event): void => accept((event as MessageEvent).data);
    const timer = setTimeout(() => finish(undefined), timeoutMs);
    function finish(data: unknown): void {
      clearTimeout(timer);
      window.removeEventListener('message', fromParent);
      document.removeEventListener('message', fromNative);
      resolve(data);
    }
    window.addEventListener('message', fromParent);
    document.addEventListener('message', fromNative);
  });
}

/** Tells the Ola host the farm is on screen; the host then pushes its state, as for every arcade game. */
export function olaReady(): void {
  if (browser) send(OLA_BRIDGE_EVENT.Ready);
}

/** The language from `?lang=vi|en` on the game URL, which the Ola host can set; Vietnamese when absent. */
export function olaLocale(): Locale {
  if (!browser) return 'vi';
  return parseLocale(new URLSearchParams(location.search).get('lang')) ?? 'vi';
}

/**
 * The player's Ola access token: `?token=` first (standalone testing), otherwise asked from the host.
 * Null when the farm runs on its own or the host has no signed-in player; the farm then keeps the device save.
 */
export async function requestOlaToken(): Promise<string | null> {
  if (!browser) return null;
  const query = new URLSearchParams(location.search).get('token')?.trim();
  if (query) return query;
  if (!hosted()) return null;
  const reply = nextFromHost(OLA_BRIDGE_EVENT.Token, TOKEN_TIMEOUT_MS);
  send(OLA_BRIDGE_EVENT.GetToken);
  const token = String((await reply) ?? '').trim();
  return token || null;
}

let kenBalance: number | null = null;
const kenListeners = new Set<(ken: number) => void>();
let watchingKen = false;

/**
 * Listens for the host's KEN balance (`ken_updated`), which Ola sends after `ready` and whenever it changes.
 * Call before `olaReady()` so the first balance is not missed. Standalone play never receives one.
 */
export function watchOlaKen(): void {
  if (!browser || watchingKen) return;
  watchingKen = true;
  const origin = parentOrigin();
  const accept = (raw: unknown): void => {
    const message = hostMessage(raw);
    if (message?.type !== OLA_BRIDGE_EVENT.KenUpdated) return;
    const ken = (message.data as { ken?: unknown } | undefined)?.ken;
    if (typeof ken !== 'number' || !Number.isSafeInteger(ken) || ken < 0) return;
    kenBalance = ken;
    kenListeners.forEach(listener => listener(ken));
  };
  window.addEventListener('message', event => {
    if (!framed() || event.source !== window.parent || (origin !== null && event.origin !== origin)) return;
    accept(event.data);
  });
  document.addEventListener('message', event => accept((event as MessageEvent).data));
}

/** The player's KEN as last reported by the host; null until Ola sends one (or when playing standalone). */
export function olaKen(): number | null {
  return kenBalance;
}

export function onOlaKen(listener: (ken: number) => void): () => void {
  kenListeners.add(listener);
  return () => kenListeners.delete(listener);
}
