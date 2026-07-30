import { Text, View } from 'react-native';

interface TransferWarningProps {
  children: string;
}

export function TransferWarning({ children }: TransferWarningProps) {
  return (
    <View
      className="mt-3 rounded-lg px-3 py-2.5"
      style={{
        borderWidth: 1,
        borderColor: 'rgba(227,69,69,0.3)',
        backgroundColor: 'rgba(227,69,69,0.05)',
      }}
    >
      <Text
        className="text-center text-sm font-semibold"
        style={{ color: 'rgba(227,69,69,0.8)' }}
      >
        {children}
      </Text>
    </View>
  );
}
