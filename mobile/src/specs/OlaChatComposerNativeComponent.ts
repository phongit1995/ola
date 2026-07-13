import type * as React from 'react';
import type { ColorValue, HostComponent, ViewProps } from 'react-native';
import type {
  DirectEventHandler,
  Float,
  WithDefault,
} from 'react-native/Libraries/Types/CodegenTypes';
import codegenNativeCommands from 'react-native/Libraries/Utilities/codegenNativeCommands';
import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';

interface ChangeTextEvent {
  text: string;
}

interface ComposerHeightEvent {
  height: Float;
}

export interface NativeProps extends ViewProps {
  fontSize: Float;
  maxHeight: Float;
  paddingH?: WithDefault<Float, 12>;
  paddingV?: WithDefault<Float, 8>;
  placeholder?: string;
  placeholderTextColor?: ColorValue;
  textColor?: ColorValue;
  selectionColor?: ColorValue;
  editable?: WithDefault<boolean, true>;
  alignTop?: WithDefault<boolean, false>;
  initialText?: string;
  onChangeText?: DirectEventHandler<ChangeTextEvent>;
  onComposerHeight?: DirectEventHandler<ComposerHeightEvent>;
  onComposerFocus?: DirectEventHandler<null>;
  onComposerBlur?: DirectEventHandler<null>;
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
