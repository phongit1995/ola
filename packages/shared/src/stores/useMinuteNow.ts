import { useEffect, useState } from 'react';

const MINUTE_MS = 60_000;

export function useMinuteNow(): number {
  const [now, setNow] = useState(() => Date.now());

  useEffect(() => {
    const interval = setInterval(() => setNow(Date.now()), MINUTE_MS);
    return () => clearInterval(interval);
  }, []);

  return now;
}
