import { Children, type ReactNode } from 'react';
import { ActivityIndicator, ScrollView, Text, TextInput, View } from 'react-native';
import { Dialog } from './Dialog';

interface UserListSearch {
  value: string;
  onChange: (value: string) => void;
  placeholder: string;
  autoFocus?: boolean;
}

interface UserListDialogProps {
  visible: boolean;
  title: string;
  onClose: () => void;
  loading: boolean;
  isEmpty: boolean;
  empty: ReactNode;
  children: ReactNode;
  search?: UserListSearch;
  loadingText?: string;
  divided?: boolean;
  listMaxHeight?: number;
}

export function UserListDialog({
  visible,
  title,
  onClose,
  loading,
  isEmpty,
  empty,
  children,
  search,
  loadingText,
  divided = true,
  listMaxHeight = 288,
}: UserListDialogProps) {
  const rows = Children.toArray(children);
  return (
    <Dialog visible={visible} onClose={onClose} title={title}>
      {search != null && (
        <TextInput
          value={search.value}
          onChangeText={search.onChange}
          placeholder={search.placeholder}
          placeholderTextColor="rgba(0,0,0,0.38)"
          autoFocus={search.autoFocus}
          autoCapitalize="none"
          className="w-full rounded-md px-3 py-2 text-base"
          style={{
            borderWidth: 1,
            borderColor: 'rgba(0,0,0,0.12)',
            color: 'rgba(0,0,0,0.87)',
          }}
        />
      )}
      <View style={{ maxHeight: listMaxHeight, marginTop: search != null ? 12 : 0 }}>
        {loading ? (
          loadingText != null ? (
            <Text className="py-6 text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {loadingText}
            </Text>
          ) : (
            <ActivityIndicator className="py-6" color="#7cb342" />
          )
        ) : isEmpty ? (
          empty
        ) : (
          <ScrollView keyboardShouldPersistTaps="handled">
            {rows.map((row, index) => (
              <View
                key={index}
                style={
                  divided && index > 0
                    ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' }
                    : null
                }
              >
                {row}
              </View>
            ))}
          </ScrollView>
        )}
      </View>
    </Dialog>
  );
}
