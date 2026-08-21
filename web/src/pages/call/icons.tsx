interface IconProps {
  className?: string;
}

function Svg({
  className,
  children,
}: IconProps & { children: React.ReactNode }) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth={1.8}
      strokeLinecap="round"
      strokeLinejoin="round"
      className={className ?? 'h-5 w-5'}
      aria-hidden="true"
    >
      {children}
    </svg>
  );
}

function ChatSvg({
  className,
  children,
}: IconProps & { children: React.ReactNode }) {
  return (
    <svg
      viewBox="0 0 48 48"
      fill="none"
      stroke="currentColor"
      strokeWidth={3.5}
      strokeLinecap="round"
      strokeLinejoin="round"
      className={className ?? 'h-6 w-6'}
      aria-hidden="true"
    >
      {children}
    </svg>
  );
}

export function ChatPhoneIcon({ className }: IconProps) {
  return (
    <ChatSvg className={className}>
      <path d="M10.5 10 16 8.7c1.1-.3 2.2.3 2.7 1.4l2.3 5.8c.4.9.1 1.9-.7 2.6l-3.5 3c1.9 3.8 5 6.9 8.8 8.8l3-3.5c.7-.8 1.7-1.1 2.6-.7l5.8 2.3c1.1.4 1.7 1.6 1.4 2.7l-1.3 5.5c-.3 1.1-1.3 1.9-2.4 1.9-16.5 0-25.2-8.7-25.2-26.1 0-1.1.8-2.1 2-2.4Z" />
      <path d="M29.5 8.5a10 10 0 0 1 10 10M30.5 14.5a4.5 4.5 0 0 1 3 3" />
      <circle cx="39.5" cy="8.5" r="2.2" fill="currentColor" stroke="none" />
    </ChatSvg>
  );
}

export function ChatVideoIcon({ className }: IconProps) {
  return (
    <ChatSvg className={className}>
      <rect x="4" y="9" width="31" height="30" rx="6" />
      <path d="m35 19 9-5v20l-9-5" />
      <circle cx="19" cy="19" r="4" fill="currentColor" stroke="none" />
      <path d="M11.5 31c.7-4.2 3.2-6.5 7.5-6.5s6.8 2.3 7.5 6.5" />
    </ChatSvg>
  );
}

export function PhoneIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M6.6 3.5 8.9 3c.5-.1 1 .2 1.2.7l1 2.6c.2.4 0 .9-.3 1.2L9.3 8.8c.9 1.9 2.4 3.4 4.3 4.3l1.3-1.5c.3-.3.8-.5 1.2-.3l2.6 1c.5.2.8.7.7 1.2l-.5 2.3c-.1.5-.6.9-1.1.9C10.2 16.7 7.3 13.8 5.7 4.6c0-.5.4-1 .9-1.1Z" />
    </Svg>
  );
}

export function VideoIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <rect x="2.5" y="6" width="12.5" height="12" rx="2.5" />
      <path d="M15 11.2l5-2.7v7l-5-2.7" />
    </Svg>
  );
}

export function MicIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <rect x="9" y="2.5" width="6" height="11" rx="3" />
      <path d="M5.5 11a6.5 6.5 0 0 0 13 0M12 17.5V21" />
    </Svg>
  );
}

export function MicOffIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M15 5.4A3 3 0 0 0 9 5.5v5M9 13.4a3 3 0 0 0 5.6-1.4" />
      <path d="M5.5 11a6.5 6.5 0 0 0 10 5.5M18.5 11a6.4 6.4 0 0 1-.6 2.7M12 17.5V21" />
      <path d="m3.5 3 17 17.5" />
    </Svg>
  );
}

export function CamIcon({ className }: IconProps) {
  return <VideoIcon className={className} />;
}

export function CamOffIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M15 9.2V8.5A2.5 2.5 0 0 0 12.5 6H7.8M4.2 6.5A2.5 2.5 0 0 0 2.5 8.5v7A2.5 2.5 0 0 0 5 18h7.5c.7 0 1.3-.3 1.8-.7" />
      <path d="M15 11.2 20 8.5v7l-2.4-1.3" />
      <path d="m3.5 3 17 17.5" />
    </Svg>
  );
}

export function EndCallIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M2.8 13.3c4.9-4.6 13.5-4.6 18.4 0" />
      <path d="M7.6 11.6 6.2 14c-.2.4-.7.6-1.1.4l-2.2-1c-.5-.2-.7-.8-.4-1.3M16.4 11.6l1.4 2.4c.2.4.7.6 1.1.4l2.2-1c.5-.2.7-.8.4-1.3" />
    </Svg>
  );
}

export function SettingsIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <circle cx="12" cy="12" r="3" />
      <path d="M19.4 15a1.6 1.6 0 0 0 .3 1.8l.1.1a2 2 0 1 1-2.8 2.8l-.1-.1a1.6 1.6 0 0 0-1.8-.3 1.6 1.6 0 0 0-1 1.5V21a2 2 0 1 1-4 0v-.1A1.6 1.6 0 0 0 9 19.4a1.6 1.6 0 0 0-1.8.3l-.1.1a2 2 0 1 1-2.8-2.8l.1-.1a1.6 1.6 0 0 0 .3-1.8 1.6 1.6 0 0 0-1.5-1H3a2 2 0 1 1 0-4h.1A1.6 1.6 0 0 0 4.6 9a1.6 1.6 0 0 0-.3-1.8l-.1-.1a2 2 0 1 1 2.8-2.8l.1.1a1.6 1.6 0 0 0 1.8.3H9a1.6 1.6 0 0 0 1-1.5V3a2 2 0 1 1 4 0v.1a1.6 1.6 0 0 0 1 1.5 1.6 1.6 0 0 0 1.8-.3l.1-.1a2 2 0 1 1 2.8 2.8l-.1.1a1.6 1.6 0 0 0-.3 1.8V9a1.6 1.6 0 0 0 1.5 1H21a2 2 0 1 1 0 4h-.1a1.6 1.6 0 0 0-1.5 1Z" />
    </Svg>
  );
}

export function MinimizeIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M5 12h14" />
    </Svg>
  );
}

export function ExpandIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M8 3H5a2 2 0 0 0-2 2v3M16 3h3a2 2 0 0 1 2 2v3M8 21H5a2 2 0 0 1-2-2v-3M16 21h3a2 2 0 0 0 2-2v-3" />
    </Svg>
  );
}

export function CloseIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="m6 6 12 12M18 6 6 18" />
    </Svg>
  );
}

export function SpeakerIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M4 9.5v5h3l4.5 3.5v-12L7 9.5H4Z" />
      <path d="M15.5 9a4 4 0 0 1 0 6M18 6.5a7.5 7.5 0 0 1 0 11" />
    </Svg>
  );
}
