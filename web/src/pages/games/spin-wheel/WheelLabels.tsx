import { VipIcon } from '@components';
import type { WheelPlayerSegment } from '@app-types';
import { segmentTheme } from './spinWheel.constants';
import { labelStyle } from './wheelGeometry';
import { rewardVisual } from './spinWheelReward';
import { segmentLabelStyle } from './spinWheelStyles';

interface WheelLabelsProps {
  segments: WheelPlayerSegment[];
  angle: number;
}

export function WheelLabels({ segments, angle }: WheelLabelsProps) {
  return (
    <>
      {segments.map((segment, index) => {
        const theme = segmentTheme(index);
        const visual = rewardVisual(segment);
        return (
          <div
            key={segment.id}
            className="absolute flex w-[26%] flex-col items-center leading-[0.9]"
            style={labelStyle(index, angle)}
          >
            {visual.vipTypeId != null ? (
              <VipIcon
                typeId={visual.vipTypeId}
                className="h-auto w-[56%] drop-shadow-md"
                rounded
              />
            ) : visual.icon != null ? (
              <img
                src={visual.icon}
                alt=""
                className={`${visual.iconClass} drop-shadow-md`}
              />
            ) : null}
            <span
              className="mt-0.5 block text-[12px] font-extrabold"
              style={segmentLabelStyle(theme)}
            >
              {segment.label}
            </span>
          </div>
        );
      })}
    </>
  );
}
