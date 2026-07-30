import { View } from 'react-native';
import { DIVIDER } from '@constants';

export function InsetListSeparator() {
  return (
    <View
      style={{
        height: 1,
        marginHorizontal: 16,
        backgroundColor: DIVIDER,
      }}
    />
  );
}
