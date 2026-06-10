export function Placeholder({ text }: { text: string }) {
  return (
    <div className="flex h-full items-center justify-center bg-[#f3f3f3] text-sm text-gray-400">
      {text}
    </div>
  );
}
