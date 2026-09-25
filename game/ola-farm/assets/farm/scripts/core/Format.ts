export const format = (n: number): string => Math.floor(n).toLocaleString('vi-VN');
/** Unity's DString.ConvertToMoneyString groups both wallet balances with commas. */
export const formatWallet = (n: number): string => Math.floor(n).toLocaleString('en-US');
