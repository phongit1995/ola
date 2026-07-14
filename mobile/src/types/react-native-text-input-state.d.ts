declare module 'react-native/Libraries/Components/TextInput/TextInputState' {
  interface TextInputStateModule {
    registerInput(input: unknown): void;
    unregisterInput(input: unknown): void;
    focusInput(input: unknown): void;
    blurInput(input: unknown): void;
    currentlyFocusedInput(): unknown;
    blurTextInput(input: unknown): void;
    isTextInput(input: unknown): boolean;
  }
  const TextInputState: TextInputStateModule;
  export default TextInputState;
}
