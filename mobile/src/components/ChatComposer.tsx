import {
  forwardRef,
  useEffect,
  useImperativeHandle,
  useRef,
  useState,
  type ElementRef,
} from 'react';
import { TextInput, View } from 'react-native';
import OlaChatComposerNative, {
  Commands as ComposerCommands,
} from '../specs/OlaChatComposerNativeComponent';
import { richTextNativeAvailable } from '../lib/richTextNativeConfig';
import { useSmileyDraft } from '../hooks/useSmileyDraft';
import {
  ComposerDraftOverlay,
  composerSingleLineHeight,
  useComposerScrollSync,
} from './SmileyDraftOverlay';

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
  minHeight?: number;
  maxHeight?: number;
  paddingH?: number;
  paddingV?: number;
  alignTop?: boolean;
  textColor?: string;
  placeholderTextColor?: string;
  selectionColor?: string;
}

let nativeComposerEnabled = true;

export function setNativeComposerEnabled(enabled: boolean): void {
  nativeComposerEnabled = enabled;
}

const NativeComposer = forwardRef<ChatComposerHandle, ChatComposerProps>(function NativeComposer(
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
      onComposerFocus={onFocus}
      onComposerBlur={onBlur}
    />
  );
});

const LegacyComposer = forwardRef<ChatComposerHandle, ChatComposerProps>(function LegacyComposer(
  {
    value,
    onChange,
    onFocus,
    onBlur,
    placeholder,
    editable = true,
    fontSize = 16,
    minHeight,
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
  const {
    draft,
    inputValue,
    codes,
    applyDraft,
    handleChangeText,
    insertAtCursor,
    backspaceAtCursor,
    selection,
    handleSelectionChange,
  } = useSmileyDraft(value);
  const inputRef = useRef<TextInput>(null);
  const lastReported = useRef(value);
  const { scrollY, handleScroll } = useComposerScrollSync(draft);

  useEffect(() => {
    if (value !== lastReported.current) {
      lastReported.current = value;
      applyDraft(value);
    }
  }, [value, applyDraft]);

  useEffect(() => {
    if (draft !== lastReported.current) {
      lastReported.current = draft;
      onChange(draft);
    }
  }, [draft, onChange]);

  useImperativeHandle(ref, () => ({
    focus: () => inputRef.current?.focus(),
    blur: () => inputRef.current?.blur(),
    insertCode: (code, trailingSpace = true) =>
      insertAtCursor(trailingSpace ? `${code} ` : code),
    insertText: (text) => insertAtCursor(text),
    backspace: backspaceAtCursor,
  }));

  return (
    <View className="flex-1 justify-center">
      <TextInput
        ref={inputRef}
        style={[
          {
            color: textColor,
            fontSize,
            textAlignVertical: alignTop ? 'top' : 'center',
            maxHeight,
            paddingHorizontal: paddingH,
            paddingVertical: paddingV,
          },
          minHeight != null ? { minHeight } : null,
          draft === '' && !alignTop ? { height: composerSingleLineHeight(paddingV) } : null,
        ]}
        selectionColor={selectionColor}
        cursorColor={selectionColor}
        placeholder={placeholder}
        placeholderTextColor={placeholderTextColor}
        multiline
        editable={editable}
        value={inputValue}
        selection={selection}
        onSelectionChange={handleSelectionChange}
        onChangeText={handleChangeText}
        onScroll={handleScroll}
        onFocus={onFocus}
        onBlur={onBlur}
      />
      {inputValue !== '' && (
        <ComposerDraftOverlay
          display={inputValue}
          codes={codes}
          scrollY={scrollY}
          inputRef={inputRef}
        />
      )}
    </View>
  );
});

export const ChatComposer = forwardRef<ChatComposerHandle, ChatComposerProps>(
  function ChatComposer(props, ref) {
    if (richTextNativeAvailable && nativeComposerEnabled) {
      return <NativeComposer ref={ref} {...props} />;
    }
    return <LegacyComposer ref={ref} {...props} />;
  }
);
