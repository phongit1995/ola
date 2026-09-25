import { SHORT_SIDE } from './Layout.constants';
import { ResolutionPolicy, view } from 'cc';

let appliedKey = '';

/**
 * Fill the frame with no letterbox: fix the width in portrait and the height in landscape.
 * Widgets re-align on the resulting `design-resolution-changed`; nothing is rebuilt.
 * Returns true when the policy or frame actually changed.
 */
export function applyDesignResolution(): boolean {
  const frame = view.getFrameSize();
  const portrait = frame.width < frame.height;
  const key = `${portrait ? 'p' : 'l'}:${frame.width}x${frame.height}`;
  if (key === appliedKey) return false;
  appliedKey = key;
  view.setDesignResolutionSize(
    SHORT_SIDE,
    SHORT_SIDE,
    portrait ? ResolutionPolicy.FIXED_WIDTH : ResolutionPolicy.FIXED_HEIGHT
  );
  return true;
}
