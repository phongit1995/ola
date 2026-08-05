export interface ChatBotViewer {
  name: string;
  color: string;
  avatar?: string;
}

export interface MessageGrouping {
  isOut: boolean;
  firstInGroup: boolean;
  lastInGroup: boolean;
  spaced: boolean;
  showTime: boolean;
  time: string;
  surface: string;
  corners: string;
}
