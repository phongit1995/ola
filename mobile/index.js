/**
 * @format
 */

import { registerGlobals } from '@livekit/react-native';
import './src/bootstrap';
import './src/i18n';
import { AppRegistry } from 'react-native';

registerGlobals();

import App from './src/App';
import { name as appName } from './app.json';

AppRegistry.registerComponent(appName, () => App);
