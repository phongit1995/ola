export interface SourceClip {
  duration: number;
  frames: Array<{ time: number; keys: number[][] }>;
}
