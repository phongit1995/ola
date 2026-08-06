import Svg, { Circle, Path, Rect } from 'react-native-svg';

interface IconProps {
  size?: number;
  color?: string;
}

const DEFAULT_SIZE = 20;
const DEFAULT_COLOR = '#ffffff';

function Frame({
  size,
  color,
  children,
}: IconProps & { children: React.ReactNode }) {
  return (
    <Svg
      width={size ?? DEFAULT_SIZE}
      height={size ?? DEFAULT_SIZE}
      viewBox="0 0 24 24"
      fill="none"
      stroke={color ?? DEFAULT_COLOR}
      strokeWidth={1.8}
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      {children}
    </Svg>
  );
}

export function PhoneIcon(props: IconProps) {
  return (
    <Frame {...props}>
      <Path d="M6.6 3.5 8.9 3c.5-.1 1 .2 1.2.7l1 2.6c.2.4 0 .9-.3 1.2L9.3 8.8c.9 1.9 2.4 3.4 4.3 4.3l1.3-1.5c.3-.3.8-.5 1.2-.3l2.6 1c.5.2.8.7.7 1.2l-.5 2.3c-.1.5-.6.9-1.1.9C10.2 16.7 7.3 13.8 5.7 4.6c0-.5.4-1 .9-1.1Z" />
    </Frame>
  );
}

export function VideoIcon(props: IconProps) {
  return (
    <Frame {...props}>
      <Rect x="2.5" y="6" width="12.5" height="12" rx="2.5" />
      <Path d="M15 11.2l5-2.7v7l-5-2.7" />
    </Frame>
  );
}

export function MicIcon(props: IconProps) {
  return (
    <Frame {...props}>
      <Rect x="9" y="2.5" width="6" height="11" rx="3" />
      <Path d="M5.5 11a6.5 6.5 0 0 0 13 0M12 17.5V21" />
    </Frame>
  );
}

export function MicOffIcon(props: IconProps) {
  return (
    <Frame {...props}>
      <Path d="M15 5.4A3 3 0 0 0 9 5.5v5M9 13.4a3 3 0 0 0 5.6-1.4" />
      <Path d="M5.5 11a6.5 6.5 0 0 0 10 5.5M18.5 11a6.4 6.4 0 0 1-.6 2.7M12 17.5V21" />
      <Path d="m3.5 3 17 17.5" />
    </Frame>
  );
}

export function CamIcon(props: IconProps) {
  return <VideoIcon {...props} />;
}

export function CamOffIcon(props: IconProps) {
  return (
    <Frame {...props}>
      <Path d="M15 9.2V8.5A2.5 2.5 0 0 0 12.5 6H7.8M4.2 6.5A2.5 2.5 0 0 0 2.5 8.5v7A2.5 2.5 0 0 0 5 18h7.5c.7 0 1.3-.3 1.8-.7" />
      <Path d="M15 11.2 20 8.5v7l-2.4-1.3" />
      <Path d="m3.5 3 17 17.5" />
    </Frame>
  );
}

export function EndCallIcon(props: IconProps) {
  return (
    <Frame {...props}>
      <Path d="M2.8 13.3c4.9-4.6 13.5-4.6 18.4 0" />
      <Path d="M7.6 11.6 6.2 14c-.2.4-.7.6-1.1.4l-2.2-1c-.5-.2-.7-.8-.4-1.3M16.4 11.6l1.4 2.4c.2.4.7.6 1.1.4l2.2-1c.5-.2.7-.8.4-1.3" />
    </Frame>
  );
}

export function SpeakerIcon(props: IconProps) {
  return (
    <Frame {...props}>
      <Path d="M4 9.5v5h3l4.5 3.5v-12L7 9.5H4Z" />
      <Path d="M15.5 9a4 4 0 0 1 0 6M18 6.5a7.5 7.5 0 0 1 0 11" />
    </Frame>
  );
}

export function SwitchCameraIcon(props: IconProps) {
  return (
    <Frame {...props}>
      <Path d="M3 8.5A2.5 2.5 0 0 1 5.5 6h2l1.2-2h6.6L16.5 6h2A2.5 2.5 0 0 1 21 8.5v8a2.5 2.5 0 0 1-2.5 2.5h-13A2.5 2.5 0 0 1 3 16.5Z" />
      <Circle cx="12" cy="12" r="3" />
    </Frame>
  );
}

export function MinimizeIcon(props: IconProps) {
  return (
    <Frame {...props}>
      <Path d="M5 12h14" />
    </Frame>
  );
}

export function ExpandIcon(props: IconProps) {
  return (
    <Frame {...props}>
      <Path d="M8 3H5a2 2 0 0 0-2 2v3M16 3h3a2 2 0 0 1 2 2v3M8 21H5a2 2 0 0 1-2-2v-3M16 21h3a2 2 0 0 0 2-2v-3" />
    </Frame>
  );
}
