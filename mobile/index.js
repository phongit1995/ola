/**
 * @format
 */

import { registerGlobals } from '@livekit/react-native';
import './src/bootstrap';
import './src/i18n';
import { AppRegistry } from 'react-native';
import { registerPushBackgroundHandler } from './src/lib/push';

registerGlobals();
registerPushBackgroundHandler();

import App from './src/App';
import { name as appName } from './app.json';

AppRegistry.registerComponent(appName, () => App);
