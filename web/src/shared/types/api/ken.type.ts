export interface TransferKenRequest {
  toUserId: string;
  amount: number;
  password: string;
}

export interface TransferKenResult {
  toUserId: string;
  amount: number;
  kenBalance: number;
}
