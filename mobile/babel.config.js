module.exports = {
  presets: [
    ['module:@react-native/babel-preset', { disableDeepImportWarnings: true }],
    'nativewind/babel',
  ],
  plugins: [
    [
      'module-resolver',
      {
        alias: {
          '@components': './src/components',
          '@constants': './src/constants',
          '@screens': './src/screens',
          '@store': './src/store',
          '@lib': './src/lib',
          '@hooks': './src/hooks',
          '@services': './src/services',
          '@navigation': './src/navigation',
          '@assets': './src/assets',
          '@i18n': './src/i18n',
          '@platform': './src/platform',
        },
      },
    ],
    'react-native-worklets/plugin',
  ],
};
