import { useEffect, useRef, useState } from 'react';
import type { AttachTab } from '@components';

export function useAttachPanel() {
  const [openTab, setOpenTab] = useState<AttachTab | null>(null);
  const [lastTab, setLastTab] = useState<AttachTab>('smiley');
  const areaRef = useRef<HTMLDivElement>(null);

  if (openTab != null && openTab !== lastTab) setLastTab(openTab);

  useEffect(() => {
    if (openTab == null) return;
    function handlePointerDown(event: PointerEvent) {
      const area = areaRef.current;
      if (area != null && !area.contains(event.target as Node)) setOpenTab(null);
    }
    document.addEventListener('pointerdown', handlePointerDown);
    return () => document.removeEventListener('pointerdown', handlePointerDown);
  }, [openTab]);

  function toggle(tab: AttachTab) {
    setOpenTab((current) => (current === tab ? null : tab));
  }

  function toggleLast() {
    setOpenTab((current) => (current == null ? lastTab : null));
  }

  function close() {
    setOpenTab(null);
  }

  return { openTab, areaRef, toggle, toggleLast, close };
}
