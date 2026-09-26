/** Envelope shared with the Ola web and mobile hosts (`ArcadeBridgeMessage`). */
export interface OlaBridgeMessage {
  source: string;
  type: string;
  data?: unknown;
}

/** Injected by react-native-webview inside the Ola mobile app. */
export interface ReactNativeWebViewPort {
  postMessage(message: string): void;
}
