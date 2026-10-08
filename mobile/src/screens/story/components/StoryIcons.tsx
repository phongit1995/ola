import { SvgAst, parse } from 'react-native-svg';
import type { StoryIconName } from '@ola/shared/types';
import { STORY_ICON_XML } from './storyIconXml';

const STORY_ICON_AST = Object.fromEntries(
  Object.entries(STORY_ICON_XML).map(([name, xml]) => [name, parse(xml)])
) as Record<StoryIconName, ReturnType<typeof parse>>;

interface StoryIconProps {
  name: StoryIconName;
  color: string;
  size?: number;
}

export function StoryIcon({ name, color, size = 24 }: StoryIconProps) {
  return <SvgAst ast={STORY_ICON_AST[name]} override={{ width: size, height: size, color }} />;
}
