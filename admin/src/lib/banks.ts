export interface VietQrBank {
  bin: string
  code: string
  name: string
}

export const VIETQR_BANKS: VietQrBank[] = [
  { bin: '970436', code: 'VCB', name: 'Vietcombank' },
  { bin: '970415', code: 'ICB', name: 'VietinBank' },
  { bin: '970418', code: 'BIDV', name: 'BIDV' },
  { bin: '970405', code: 'VBA', name: 'Agribank' },
  { bin: '970407', code: 'TCB', name: 'Techcombank' },
  { bin: '970422', code: 'MB', name: 'MB Bank' },
  { bin: '970416', code: 'ACB', name: 'ACB' },
  { bin: '970432', code: 'VPB', name: 'VPBank' },
  { bin: '970423', code: 'TPB', name: 'TPBank' },
  { bin: '970403', code: 'STB', name: 'Sacombank' },
  { bin: '970437', code: 'HDB', name: 'HDBank' },
  { bin: '970441', code: 'VIB', name: 'VIB' },
  { bin: '970443', code: 'SHB', name: 'SHB' },
  { bin: '970431', code: 'EIB', name: 'Eximbank' },
  { bin: '970426', code: 'MSB', name: 'MSB' },
  { bin: '970440', code: 'SEAB', name: 'SeABank' },
  { bin: '970448', code: 'OCB', name: 'OCB' },
  { bin: '970428', code: 'NAB', name: 'Nam A Bank' },
  { bin: '970425', code: 'ABB', name: 'ABBANK' },
  { bin: '970409', code: 'BAB', name: 'Bac A Bank' },
  { bin: '970412', code: 'PVCB', name: 'PVcomBank' },
  { bin: '970429', code: 'SCB', name: 'SCB' },
  { bin: '970427', code: 'VAB', name: 'VietABank' },
  { bin: '970406', code: 'DOB', name: 'DongA Bank' },
  { bin: '970449', code: 'LPB', name: 'LPBank' },
  { bin: '970452', code: 'KLB', name: 'KienlongBank' },
  { bin: '970433', code: 'VIETBANK', name: 'VietBank' },
  { bin: '970438', code: 'BVB', name: 'BaoViet Bank' },
  { bin: '970419', code: 'NCB', name: 'NCB' },
  { bin: '970430', code: 'PGB', name: 'PGBank' },
  { bin: '970400', code: 'SGICB', name: 'Saigonbank' },
  { bin: '970454', code: 'VCCB', name: 'BVBank (Viet Capital)' },
  { bin: '970446', code: 'COOPBANK', name: 'Co-opBank' },
  { bin: '970424', code: 'SHBVN', name: 'Shinhan Bank VN' },
  { bin: '970457', code: 'WVN', name: 'Woori Bank VN' },
  { bin: '970458', code: 'UOB', name: 'UOB Việt Nam' },
  { bin: '970410', code: 'SCVN', name: 'Standard Chartered VN' },
  { bin: '458761', code: 'HSBC', name: 'HSBC Việt Nam' },
  { bin: '422589', code: 'CIMB', name: 'CIMB Việt Nam' },
  { bin: '546034', code: 'CAKE', name: 'CAKE by VPBank' },
  { bin: '546035', code: 'UBANK', name: 'Ubank by VPBank' },
  { bin: '963388', code: 'TIMO', name: 'Timo by BVBank' },
]

export function findBankByBin(bin: string): VietQrBank | undefined {
  return VIETQR_BANKS.find((bank) => bank.bin === bin)
}
