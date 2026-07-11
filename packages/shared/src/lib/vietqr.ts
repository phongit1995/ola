export interface VietQrImageParams {
  bankBin: string;
  accountNumber: string;
  amount?: number;
  memo?: string;
  accountName?: string;
}

export function normalizeTransferMemo(raw: string): string {
  return raw
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .replace(/[^A-Za-z0-9 @._-]/g, '')
    .trim()
    .slice(0, 50);
}

export function fillMemoTemplate(template: string, username: string): string {
  return normalizeTransferMemo(template.replace(/\{username\}/g, username));
}

export function buildVietQrImageUrl({
  bankBin,
  accountNumber,
  amount,
  memo,
  accountName,
}: VietQrImageParams): string {
  const query: string[] = [];
  if (amount != null && amount > 0) query.push(`amount=${Math.round(amount)}`);
  const cleanMemo = memo ? normalizeTransferMemo(memo) : '';
  if (cleanMemo !== '') query.push(`addInfo=${encodeURIComponent(cleanMemo)}`);
  if (accountName) query.push(`accountName=${encodeURIComponent(accountName)}`);
  const base = `https://img.vietqr.io/image/${bankBin}-${accountNumber}-compact.png`;
  return query.length > 0 ? `${base}?${query.join('&')}` : base;
}
