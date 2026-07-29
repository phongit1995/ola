import { bottomButtonFrameUrl } from './spinWheelAssets';
import { CHIP_TEXT_STYLE } from './spinWheelStyles';

interface WheelActionButtonProps {
  icon: string;
  label: string;
  onClick: () => void;
}

export function WheelActionButton({
  icon,
  label,
  onClick,
}: WheelActionButtonProps) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="relative h-11 flex-1 active:scale-95"
    >
      <img
        src={bottomButtonFrameUrl}
        alt=""
        className="absolute inset-0 h-full w-full"
      />
      <span
        className="absolute inset-0 flex items-center justify-center gap-1.5 text-sm font-bold"
        style={CHIP_TEXT_STYLE}
      >
        <img src={icon} alt="" className="h-5 w-5" />
        {label}
      </span>
    </button>
  );
}
