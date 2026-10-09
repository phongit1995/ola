export const KEN_TX_TYPE: Record<string, string> = {
  VIP_PACKAGE: 'Mua gói VIP',
  VIP_ICON: 'Mua VIP icon',
  ADMIN_GRANT: 'Admin cộng',
  ADMIN_DEDUCT: 'Admin trừ',
  REWARD: 'Phần thưởng',
  TOPUP: 'Nạp ken',
  REFUND: 'Hoàn ken',
  GIFT_SENT: 'Tặng quà',
  GIFT_RECEIVED: 'Nhận quà',
  TRANSFER_IN: 'Nhận chuyển',
  TRANSFER_OUT: 'Chuyển đi',
  WORD_CHAIN_HINT: 'Gợi ý nối từ',
  WORD_CHAIN_GUESS: 'Mua lượt nối từ',
}

export function kenTypeLabel(type: string): string {
  return KEN_TX_TYPE[type] ?? type
}
