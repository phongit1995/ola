import { useRef, useState } from 'react';
import { useOutsideClick } from './useOutsideClick';

export function useAttachPanel() {
  const [open, setOpen] = useState(false);
  const areaRef = useRef<HTMLDivElement>(null);

  useOutsideClick(areaRef, open, () => setOpen(false));

  return {
    open,
    areaRef,
    toggle: () => setOpen((value) => !value),
    close: () => setOpen(false),
  };
}
