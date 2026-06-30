export interface TransferKenRequest {
  toUserId: string;
  amount: number;
}

export interface TransferKenResult {
  toUserId: string;
  amount: number;
  kenBalance: number;
}
