import { useRef, useState } from 'react';
import { useOutsideClick } from '@hooks';

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
