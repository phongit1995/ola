import type { ReactNode } from 'react';
import { ActivityIndicator, Text, View } from 'react-native';
import { PenPagination } from './PenPagination';

interface PenHistoryTableProps {
  header: ReactNode;
  minHeight: number;
  loading: boolean;
  isEmpty: boolean;
  emptyText: string;
  page: number;
  pageCount: number;
  onPage: (page: number) => void;
  children: ReactNode;
  footer?: ReactNode;
}

export function PenHistoryTable({
  header,
  minHeight,
  loading,
  isEmpty,
  emptyText,
  page,
  pageCount,
  onPage,
  children,
  footer,
}: PenHistoryTableProps) {
  return (
    <View
      style={{
        borderRadius: 16,
        borderWidth: 1,
        borderColor: 'rgba(30,111,224,0.4)',
        backgroundColor: 'rgba(0,16,38,0.5)',
        padding: 8,
      }}
    >
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          gap: 4,
          borderBottomWidth: 1,
          borderBottomColor: 'rgba(255,255,255,0.1)',
          paddingHorizontal: 6,
          paddingBottom: 6,
        }}
      >
        {header}
      </View>

      <View style={{ minHeight }}>
        {loading ? (
          <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
            <ActivityIndicator color="#5aa0e0" />
          </View>
        ) : isEmpty ? (
          <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
            <Text style={{ fontSize: 12, color: 'rgba(255,255,255,0.5)' }}>{emptyText}</Text>
          </View>
        ) : (
          children
        )}
      </View>

      <PenPagination page={page} pageCount={pageCount} loading={loading} onPage={onPage} style={{ marginTop: 8 }} />

      {footer}
    </View>
  );
}

export function PenColHeader({ flex, align, children }: { flex: number; align?: 'center' | 'right'; children: string }) {
  return (
    <Text
      style={{
        flex,
        fontSize: 9,
        fontWeight: '600',
        letterSpacing: 0.5,
        textTransform: 'uppercase',
        color: '#5aa0e0',
        textAlign: align === 'center' ? 'center' : align === 'right' ? 'right' : 'left',
      }}
    >
      {children}
    </Text>
  );
}
