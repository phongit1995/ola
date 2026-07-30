import { Image, Text, View } from 'react-native';
import { WHEEL_LABEL_RADIUS, segmentTheme, wheelPolar } from '@ola/shared/lib';
import { VipIconImage } from '@screens/vip/components/VipIconImage';
import { assetRatio } from '@screens/games/pen/penUi';
import { rewardVisual } from './spinWheelReward';
import { segmentLabelTextStyle } from './spinWheelStyles';
import type { WheelLayerProps } from './types';

export function WheelLabels({ segments, angle, size }: WheelLayerProps) {
  const labelSize = size * 0.26;
  return (
    <>
      {segments.map((segment, index) => {
        const theme = segmentTheme(index);
        const visual = rewardVisual(segment);
        const point = wheelPolar(index * angle, WHEEL_LABEL_RADIUS);
        const iconWidth = labelSize * visual.widthFraction;
        return (
          <View
            key={segment.id}
            style={{
              position: 'absolute',
              left: (point.x / 100) * size - labelSize / 2,
              top: (point.y / 100) * size - labelSize / 2,
              width: labelSize,
              height: labelSize,
              alignItems: 'center',
              justifyContent: 'center',
            }}
          >
            {visual.vipTypeId != null ? (
              <VipIconImage typeId={visual.vipTypeId} size={labelSize * 0.56} rounded />
            ) : visual.icon != null ? (
              <Image
                source={visual.icon}
                style={{ width: iconWidth, height: iconWidth / assetRatio(visual.icon) }}
                resizeMode="contain"
              />
            ) : null}
            <Text
              numberOfLines={2}
              style={[
                {
                  marginTop: 2,
                  fontSize: 12,
                  lineHeight: 12,
                  fontWeight: '800',
                  textAlign: 'center',
                },
                segmentLabelTextStyle(theme),
              ]}
            >
              {segment.label}
            </Text>
          </View>
        );
      })}
    </>
  );
}
