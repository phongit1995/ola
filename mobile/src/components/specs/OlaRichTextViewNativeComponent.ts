import type { CodegenTypes, ColorValue, HostComponent, ViewProps } from 'react-native';
import { codegenNativeComponent } from 'react-native';

interface MentionPressEvent {
  nick: string;
}

interface UrlPressEvent {
  url: string;
}

export interface NativeProps extends ViewProps {
  content: string;
  fontSize: CodegenTypes.Float;
  textColor: ColorValue;
  accentColor: ColorValue;
  maxLines: CodegenTypes.Int32;
  onMentionPress?: CodegenTypes.DirectEventHandler<MentionPressEvent>;
  onUrlPress?: CodegenTypes.DirectEventHandler<UrlPressEvent>;
}

export default codegenNativeComponent<NativeProps>(
  'OlaRichTextView'
) as HostComponent<NativeProps>;
