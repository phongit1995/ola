export interface DialogHeader {
  scale: number;
  titleTop: number;
  titleHeight: number;
  fontSize: number;
  closeX: number;
  closeTop: number;
  closeWidth: number;
  closeHeight: number;
}

export interface AuthoredPose {
  x: number;
  y: number;
  width: number;
  height: number;
  scaleX: number;
  scaleY: number;
}

export interface DialogPresentation {
  width: number;
  height: number;
  screenWidth: number;
  screenHeight: number;
  unit: number;
  kind: 'factory' | 'livestock' | 'building' | 'window';
  scale: number;
  title: string;
  header: DialogHeader | null;
}
