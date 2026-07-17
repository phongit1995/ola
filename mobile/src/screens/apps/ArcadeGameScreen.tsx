import { useRef } from 'react';
import { Platform, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import WebView, { type WebViewMessageEvent } from 'react-native-webview';
import { ensureFreshToken } from '@ola/shared/api';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';

interface GameBridgeMessage {
  source?: string;
  type?: string;
}

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.ArcadeGame>;

export function ArcadeGameScreen({ navigation, route }: Props) {
  const { game } = route.params;
  const insets = useSafeAreaInsets();
  const webRef = useRef<WebView<object>>(null);

  function sendToGame(message: { source: string; type: string; data?: unknown }) {
    const payload = JSON.stringify(JSON.stringify(message));
    webRef.current?.injectJavaScript(
      `document.dispatchEvent(new MessageEvent('message',{data:${payload}}));true;`,
    );
  }

  async function handleGetToken() {
    const token = await ensureFreshToken();
    sendToGame({ source: 'ola-host', type: 'token', data: token });
  }

  function handleMessage(event: WebViewMessageEvent) {
    let message: GameBridgeMessage | null = null;
    try {
      message = JSON.parse(event.nativeEvent.data) as GameBridgeMessage;
    } catch {
      return;
    }
    if (message?.source !== 'ola-game') return;
    if (message.type === 'get_token') void handleGetToken();
    if (message.type === 'exit') navigation.goBack();
  }

  const androidInsets =
    Platform.OS === 'android'
      ? { paddingTop: insets.top, paddingBottom: insets.bottom }
      : undefined;

  return (
    <View className="flex-1" style={[{ backgroundColor: '#141428' }, androidInsets]}>
      <WebView<object>
        ref={webRef}
        source={{ uri: game.gameUrl }}
        onMessage={handleMessage}
        style={{ flex: 1, backgroundColor: '#141428' }}
        allowsInlineMediaPlayback
        mediaPlaybackRequiresUserAction={false}
      />
    </View>
  );
}
