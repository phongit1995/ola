import { useEffect, useState } from 'react';
import { subscribePipModeChanged } from '../lib/callPip';

export function usePipMode(): boolean {
  const [inPip, setInPip] = useState(false);

  useEffect(() => subscribePipModeChanged(setInPip), []);

  return inPip;
}
