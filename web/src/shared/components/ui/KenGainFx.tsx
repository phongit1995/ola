import { useState } from 'react';
import { formatKen } from '@lib';
import kenIconUrl from '@/assets/icons/apps/ken.png';

interface KenGain {
  id: number;
  amount: number;
}

interface KenGainFxProps {
  ken?: number;
}

export function KenGainFx({ ken }: KenGainFxProps) {
  const [prevKen, setPrevKen] = useState(ken);
  const [gains, setGains] = useState<KenGain[]>([]);
  const [seq, setSeq] = useState(0);

  if (ken !== prevKen) {
    const gained = typeof ken === 'number' && typeof prevKen === 'number' && ken > prevKen;
    const amount = gained ? ken - prevKen : 0;
    setPrevKen(ken);
    if (gained) {
      setGains((list) => [...list, { id: seq, amount }]);
      setSeq((n) => n + 1);
    }
  }

  if (gains.length === 0) return null;

  const remove = (id: number) => setGains((list) => list.filter((gain) => gain.id !== id));

  return (
    <div className="pointer-events-none absolute inset-x-0 bottom-full">
      {gains.map((gain) => (
        <span
          key={gain.id}
          onAnimationEnd={() => remove(gain.id)}
          className="animate-ola-ken-rise absolute bottom-1 left-1/2 flex items-center gap-1 whitespace-nowrap rounded-full bg-[#1f9d4d] px-3 py-1 text-sm font-extrabold text-white shadow-[0_4px_14px_rgba(0,0,0,0.35)]"
        >
          +{formatKen(gain.amount)}
          <img src={kenIconUrl} alt="" className="h-4 w-4 object-contain" />
        </span>
      ))}
    </div>
  );
}
