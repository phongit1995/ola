import { useLayoutEffect, useRef, useState } from 'react';

function horizontalChrome(el: Element) {
  const s = getComputedStyle(el);
  return (
    parseFloat(s.paddingLeft) +
    parseFloat(s.paddingRight) +
    parseFloat(s.borderLeftWidth) +
    parseFloat(s.borderRightWidth)
  );
}

export function useLobbyTopbarWrap(enabled = true) {
  const topRef = useRef<HTMLElement>(null);
  const profileRef = useRef<HTMLDivElement>(null);
  const kenBodyRef = useRef<HTMLSpanElement>(null);
  const soundRef = useRef<HTMLButtonElement>(null);
  const [wrap, setWrap] = useState(false);

  useLayoutEffect(() => {
    if (!enabled) {
      setWrap(false);
      return;
    }
    const top = topRef.current;
    const profile = profileRef.current;
    const kenBody = kenBodyRef.current;
    const sound = soundRef.current;
    const kenPill = kenBody?.parentElement;
    if (!top || !profile || !kenBody || !sound || !kenPill) return;

    const measure = () => {
      const gap = parseFloat(getComputedStyle(top).columnGap) || 0;
      const kenWidth = kenBody.scrollWidth + horizontalChrome(kenPill);
      const profileMin = parseFloat(getComputedStyle(profile).minWidth) || 0;
      const room = top.clientWidth - sound.offsetWidth - kenWidth - gap * 2;
      setWrap(room < profileMin);
    };

    measure();
    const observer = new ResizeObserver(measure);
    observer.observe(top);
    observer.observe(kenBody);
    return () => observer.disconnect();
  }, [enabled]);

  return { topRef, profileRef, kenBodyRef, soundRef, wrap };
}
