import { Button } from '@/components/ui/Button';
import { useCounter } from '@/hooks/useCounter';

export function HomePage() {
  const { count, increment, decrement, reset } = useCounter();

  return (
    <main className="flex min-h-full flex-col items-center justify-center gap-8 p-6">
      <div className="text-center">
        <h1 className="text-4xl font-bold tracking-tight text-ola-primary">
          Ola Web
        </h1>
        <p className="mt-2 text-gray-500">
          React 19 + Vite + TypeScript + Tailwind CSS v4
        </p>
      </div>

      <div className="flex items-center gap-3 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
        <Button variant="outline" onClick={decrement}>
          −
        </Button>
        <span className="w-16 text-center text-2xl font-semibold tabular-nums">
          {count}
        </span>
        <Button variant="primary" onClick={increment}>
          +
        </Button>
        <Button variant="accent" onClick={reset}>
          Reset
        </Button>
      </div>

      <p className="text-sm text-gray-400">
        Sửa{' '}
        <code className="rounded bg-gray-100 px-1">src/pages/HomePage.tsx</code>{' '}
        và lưu để test HMR.
      </p>
    </main>
  );
}
