import type { ColorValue, HostComponent, ViewProps } from 'react-native';
import type {
  DirectEventHandler,
  Float,
  Int32,
} from 'react-native/Libraries/Types/CodegenTypes';
import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';

interface MentionPressEvent {
  nick: string;
}

interface UrlPressEvent {
  url: string;
}

export interface NativeProps extends ViewProps {
  content: string;
  fontSize: Float;
  textColor: ColorValue;
  accentColor: ColorValue;
  maxLines: Int32;
  onMentionPress?: DirectEventHandler<MentionPressEvent>;
  onUrlPress?: DirectEventHandler<UrlPressEvent>;
}

export default codegenNativeComponent<NativeProps>(
  'OlaRichTextView'
) as HostComponent<NativeProps>;
