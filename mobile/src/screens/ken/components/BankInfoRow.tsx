import { Text, View } from 'react-native';
import { TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';

export function BankInfoRow({ label, value }: { label: string; value: string }) {
  return (
    <View
      className="py-2"
      style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.08)' }}
    >
      <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>{label}</Text>
      <Text className="text-sm font-medium" style={{ color: TEXT_PRIMARY }}>{value}</Text>
    </View>
  );
}
