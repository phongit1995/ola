import type * as React from 'react';
import type { CodegenTypes, ColorValue, HostComponent, ViewProps } from 'react-native';
import { codegenNativeCommands, codegenNativeComponent } from 'react-native';

interface ChangeTextEvent {
  text: string;
}

interface ComposerHeightEvent {
  height: CodegenTypes.Float;
}

interface PasteImageEvent {
  uri: string;
}

export interface NativeProps extends ViewProps {
  fontSize: CodegenTypes.Float;
  maxHeight: CodegenTypes.Float;
  paddingH?: CodegenTypes.WithDefault<CodegenTypes.Float, 12>;
  paddingV?: CodegenTypes.WithDefault<CodegenTypes.Float, 8>;
  placeholder?: string;
  placeholderTextColor?: ColorValue;
  textColor?: ColorValue;
  selectionColor?: ColorValue;
  editable?: CodegenTypes.WithDefault<boolean, true>;
  alignTop?: CodegenTypes.WithDefault<boolean, false>;
  initialText?: string;
  onChangeText?: CodegenTypes.DirectEventHandler<ChangeTextEvent>;
  onComposerHeight?: CodegenTypes.DirectEventHandler<ComposerHeightEvent>;
  onComposerFocus?: CodegenTypes.DirectEventHandler<null>;
  onComposerBlur?: CodegenTypes.DirectEventHandler<null>;
  onPasteImage?: CodegenTypes.DirectEventHandler<PasteImageEvent>;
}

type ComposerComponent = HostComponent<NativeProps>;

interface NativeCommands {
  insertCode: (
    viewRef: React.ElementRef<ComposerComponent>,
    code: string,
    trailingSpace: boolean
  ) => void;
  insertText: (viewRef: React.ElementRef<ComposerComponent>, text: string) => void;
  backspace: (viewRef: React.ElementRef<ComposerComponent>) => void;
  setText: (viewRef: React.ElementRef<ComposerComponent>, text: string) => void;
  focus: (viewRef: React.ElementRef<ComposerComponent>) => void;
  blur: (viewRef: React.ElementRef<ComposerComponent>) => void;
}

export const Commands = codegenNativeCommands<NativeCommands>({
  supportedCommands: ['insertCode', 'insertText', 'backspace', 'setText', 'focus', 'blur'],
});

export default codegenNativeComponent<NativeProps>(
  'OlaChatComposer'
) as HostComponent<NativeProps>;
