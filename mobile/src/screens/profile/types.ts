export type OpenProfileHandler = (nick: string, color: string) => void;

export type OpenViewerHandler = (images: string[], index?: number) => void;

export interface ProfileViewerState {
  images: string[];
  index: number;
}
