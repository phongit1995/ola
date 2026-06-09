package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
final class zzbeq extends zzben {
    zzbeq() {
    }

    private static int zza(byte[] bArr, int i, long j, int i2) {
        switch (i2) {
            case 0:
                return zzbem.zzda(i);
            case 1:
                return zzbem.zzz(i, zzbek.zza(bArr, j));
            case 2:
                return zzbem.zzf(i, zzbek.zza(bArr, j), zzbek.zza(bArr, j + 1));
            default:
                throw new AssertionError();
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:51:0x00ac, code lost:
    
        return -1;
     */
    @Override // com.google.android.gms.internal.ads.zzben
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    final int zzb(int r12, byte[] r13, int r14, int r15) {
        /*
            Method dump skipped, instruction units count: 216
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbeq.zzb(int, byte[], int, int):int");
    }

    @Override // com.google.android.gms.internal.ads.zzben
    final int zzb(CharSequence charSequence, byte[] bArr, int i, int i2) {
        long j;
        int i3;
        int i4;
        char cCharAt;
        long j2 = i;
        long j3 = j2 + ((long) i2);
        int length = charSequence.length();
        if (length > i2 || bArr.length - i2 < i) {
            char cCharAt2 = charSequence.charAt(length - 1);
            StringBuilder sb = new StringBuilder(37);
            sb.append("Failed writing ");
            sb.append(cCharAt2);
            sb.append(" at index ");
            sb.append(i + i2);
            throw new ArrayIndexOutOfBoundsException(sb.toString());
        }
        int i5 = 0;
        while (i5 < length && (cCharAt = charSequence.charAt(i5)) < 128) {
            zzbek.zza(bArr, j2, (byte) cCharAt);
            i5++;
            j2++;
        }
        if (i5 == length) {
            return (int) j2;
        }
        while (i5 < length) {
            char cCharAt3 = charSequence.charAt(i5);
            if (cCharAt3 >= 128 || j2 >= j3) {
                if (cCharAt3 < 2048 && j2 <= j3 - 2) {
                    long j4 = j2 + 1;
                    zzbek.zza(bArr, j2, (byte) ((cCharAt3 >>> 6) | 960));
                    j2 = j4 + 1;
                    zzbek.zza(bArr, j4, (byte) ((cCharAt3 & '?') | 128));
                } else {
                    if ((cCharAt3 >= 55296 && 57343 >= cCharAt3) || j2 > j3 - 3) {
                        if (j2 > j3 - 4) {
                            if (55296 <= cCharAt3 && cCharAt3 <= 57343 && ((i3 = i5 + 1) == length || !Character.isSurrogatePair(cCharAt3, charSequence.charAt(i3)))) {
                                throw new zzbep(i5, length);
                            }
                            StringBuilder sb2 = new StringBuilder(46);
                            sb2.append("Failed writing ");
                            sb2.append(cCharAt3);
                            sb2.append(" at index ");
                            sb2.append(j2);
                            throw new ArrayIndexOutOfBoundsException(sb2.toString());
                        }
                        int i6 = i5 + 1;
                        if (i6 != length) {
                            char cCharAt4 = charSequence.charAt(i6);
                            if (Character.isSurrogatePair(cCharAt3, cCharAt4)) {
                                int codePoint = Character.toCodePoint(cCharAt3, cCharAt4);
                                long j5 = j2 + 1;
                                zzbek.zza(bArr, j2, (byte) ((codePoint >>> 18) | 240));
                                long j6 = j5 + 1;
                                zzbek.zza(bArr, j5, (byte) (((codePoint >>> 12) & 63) | 128));
                                long j7 = j6 + 1;
                                zzbek.zza(bArr, j6, (byte) (((codePoint >>> 6) & 63) | 128));
                                j2 = j7 + 1;
                                zzbek.zza(bArr, j7, (byte) ((codePoint & 63) | 128));
                                i5 = i6;
                            }
                        } else {
                            i6 = i5;
                        }
                        throw new zzbep(i6 - 1, length);
                    }
                    long j8 = j2 + 1;
                    zzbek.zza(bArr, j2, (byte) ((cCharAt3 >>> '\f') | 480));
                    j2 = j8 + 1;
                    zzbek.zza(bArr, j8, (byte) (((cCharAt3 >>> 6) & 63) | 128));
                    j = j2 + 1;
                    i4 = (cCharAt3 & '?') | 128;
                }
                i5++;
            } else {
                j = j2 + 1;
                i4 = cCharAt3;
            }
            zzbek.zza(bArr, j2, (byte) i4);
            j2 = j;
            i5++;
        }
        return (int) j2;
    }
}
