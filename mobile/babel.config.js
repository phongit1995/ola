module.exports = {
  presets: [
    ['module:@react-native/babel-preset', { disableDeepImportWarnings: true }],
    'nativewind/babel',
  ],
  plugins: ['react-native-worklets/plugin'],
};
