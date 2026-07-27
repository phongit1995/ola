import {
  forwardRef,
  useEffect,
  useImperativeHandle,
  useRef,
  useState,
  type ElementRef,
} from 'react';
import { TextInput, useWindowDimensions } from 'react-native';
// eslint-disable-next-line @react-native/no-deep-imports -- TextInput.State không có registerInput; cần đăng ký composer native vào registry để tap-ra-ngoài/Keyboard.dismiss ẩn được bàn phím
import TextInputState from 'react-native/Libraries/Components/TextInput/TextInputState';
import OlaChatComposerNative, {
  Commands as ComposerCommands,
} from './specs/OlaChatComposerNativeComponent';
import { cappedFontScale } from '@constants';
import { richTextNativeAvailable } from '@lib/richTextNativeConfig';

export interface ChatComposerHandle {
  focus: () => void;
  blur: () => void;
  insertCode: (code: string, trailingSpace?: boolean) => void;
  insertText: (text: string) => void;
  backspace: () => void;
}

interface ChatComposerProps {
  value: string;
  onChange: (value: string) => void;
  onFocus?: () => void;
  onBlur?: () => void;
  placeholder?: string;
  editable?: boolean;
  fontSize?: number;
  maxFontSizeMultiplier?: number;
  minHeight?: number;
  maxHeight?: number;
  paddingH?: number;
  paddingV?: number;
  alignTop?: boolean;
  textColor?: string;
  placeholderTextColor?: string;
  selectionColor?: string;
  onPasteImage?: (uri: string) => void;
}

let nativeComposerEnabled = true;

export function setNativeComposerEnabled(enabled: boolean): void {
  nativeComposerEnabled = enabled;
}

const NativeComposer = forwardRef<ChatComposerHandle, ChatComposerProps>(function NativeComposerInner(
  {
    value,
    onChange,
    onFocus,
    onBlur,
    placeholder,
    editable = true,
    fontSize = 16,
    minHeight = 40,
    maxHeight = 112,
    paddingH = 12,
    paddingV = 8,
    alignTop = false,
    textColor = 'rgba(0,0,0,0.87)',
    placeholderTextColor = 'rgba(0,0,0,0.38)',
    selectionColor = '#7cb342',
    onPasteImage,
  },
  ref
) {
  const nativeRef = useRef<ElementRef<typeof OlaChatComposerNative>>(null);
  const lastEmitted = useRef(value);
  const initialValue = useRef(value);
  const [contentHeight, setContentHeight] = useState(minHeight);

  useEffect(() => {
    if (value === lastEmitted.current) return;
    lastEmitted.current = value;
    if (nativeRef.current != null) ComposerCommands.setText(nativeRef.current, value);
  }, [value]);

  useEffect(() => {
    const instance = nativeRef.current;
    if (instance == null) return;
    TextInputState.registerInput(instance);
    return () => TextInputState.unregisterInput(instance);
  }, []);

  useImperativeHandle(ref, () => ({
    focus: () => {
      if (nativeRef.current != null) ComposerCommands.focus(nativeRef.current);
    },
    blur: () => {
      if (nativeRef.current != null) ComposerCommands.blur(nativeRef.current);
    },
    insertCode: (code, trailingSpace = true) => {
      if (nativeRef.current != null) {
        ComposerCommands.insertCode(nativeRef.current, code, trailingSpace);
      }
    },
    insertText: (text) => {
      if (nativeRef.current != null) ComposerCommands.insertText(nativeRef.current, text);
    },
    backspace: () => {
      if (nativeRef.current != null) ComposerCommands.backspace(nativeRef.current);
    },
  }));

  const height = Math.min(Math.max(contentHeight, minHeight), maxHeight);

  return (
    <OlaChatComposerNative
      ref={nativeRef}
      style={{ height, flexGrow: 1, flexShrink: 1 }}
      fontSize={fontSize}
      maxHeight={maxHeight}
      paddingH={paddingH}
      paddingV={paddingV}
      alignTop={alignTop}
      placeholder={placeholder}
      placeholderTextColor={placeholderTextColor}
      textColor={textColor}
      selectionColor={selectionColor}
      editable={editable}
      initialText={initialValue.current}
      onChangeText={(event) => {
        lastEmitted.current = event.nativeEvent.text;
        onChange(event.nativeEvent.text);
      }}
      onComposerHeight={(event) => setContentHeight(Math.ceil(event.nativeEvent.height))}
      onComposerFocus={() => {
        if (nativeRef.current != null) TextInputState.focusInput(nativeRef.current);
        onFocus?.();
      }}
      onComposerBlur={() => {
        if (nativeRef.current != null) TextInputState.blurInput(nativeRef.current);
        onBlur?.();
      }}
      onPasteImage={(event) => onPasteImage?.(event.nativeEvent.uri)}
    />
  );
});

const PlainComposer = forwardRef<ChatComposerHandle, ChatComposerProps>(function PlainComposerInner(
  {
    value,
    onChange,
    onFocus,
    onBlur,
    placeholder,
    editable = true,
    fontSize = 16,
    maxFontSizeMultiplier,
    minHeight = 40,
    maxHeight = 112,
    paddingH = 12,
    paddingV = 8,
    alignTop = false,
    textColor = 'rgba(0,0,0,0.87)',
    placeholderTextColor = 'rgba(0,0,0,0.38)',
    selectionColor = '#7cb342',
  },
  ref
) {
  const inputRef = useRef<TextInput>(null);
  const valueRef = useRef(value);
  valueRef.current = value;

  useImperativeHandle(ref, () => ({
    focus: () => inputRef.current?.focus(),
    blur: () => inputRef.current?.blur(),
    insertCode: (code, trailingSpace = true) =>
      onChange(valueRef.current + code + (trailingSpace ? ' ' : '')),
    insertText: (text) => onChange(valueRef.current + text),
    backspace: () => onChange(Array.from(valueRef.current).slice(0, -1).join('')),
  }));

  return (
    <TextInput
      ref={inputRef}
      style={{
        color: textColor,
        fontSize,
        textAlignVertical: alignTop ? 'top' : 'center',
        minHeight,
        maxHeight,
        paddingHorizontal: paddingH,
        paddingVertical: paddingV,
        flexGrow: 1,
        flexShrink: 1,
      }}
      maxFontSizeMultiplier={maxFontSizeMultiplier}
      selectionColor={selectionColor}
      cursorColor={selectionColor}
      placeholder={placeholder}
      placeholderTextColor={placeholderTextColor}
      multiline
      editable={editable}
      value={value}
      onChangeText={onChange}
      onFocus={onFocus}
      onBlur={onBlur}
    />
  );
});

export const ChatComposer = forwardRef<ChatComposerHandle, ChatComposerProps>(
  function ChatComposerInner(props, ref) {
    const { fontScale } = useWindowDimensions();
    if (richTextNativeAvailable && nativeComposerEnabled) {
      const baseFontSize = props.fontSize ?? 16;
      const nativeFontSize =
        props.maxFontSizeMultiplier == null
          ? baseFontSize
          : baseFontSize * cappedFontScale(fontScale, props.maxFontSizeMultiplier);
      return <NativeComposer ref={ref} {...props} fontSize={nativeFontSize} />;
    }
    return <PlainComposer ref={ref} {...props} />;
  }
);
