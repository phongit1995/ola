package com.google.android.gms.internal.ads;

import java.util.Arrays;

/* JADX INFO: loaded from: classes.dex */
final class zzbas extends zzbaq {
    private final byte[] buffer;
    private int limit;
    private int pos;
    private final boolean zzdqd;
    private int zzdqe;
    private int zzdqf;
    private int zzdqg;
    private int zzdqh;

    private zzbas(byte[] bArr, int i, int i2, boolean z) {
        super();
        this.zzdqh = Integer.MAX_VALUE;
        this.buffer = bArr;
        this.limit = i2 + i;
        this.pos = i;
        this.zzdqf = this.pos;
        this.zzdqd = z;
    }

    /* JADX WARN: Code restructure failed: missing block: B:31:0x0068, code lost:
    
        if (r1[r2] >= 0) goto L32;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final int zzacc() {
        /*
            r5 = this;
            int r0 = r5.pos
            int r1 = r5.limit
            if (r1 == r0) goto L6d
            byte[] r1 = r5.buffer
            int r2 = r0 + 1
            r0 = r1[r0]
            if (r0 < 0) goto L11
            r5.pos = r2
            return r0
        L11:
            int r3 = r5.limit
            int r3 = r3 - r2
            r4 = 9
            if (r3 < r4) goto L6d
            int r3 = r2 + 1
            r2 = r1[r2]
            int r2 = r2 << 7
            r0 = r0 ^ r2
            if (r0 >= 0) goto L24
            r0 = r0 ^ (-128(0xffffffffffffff80, float:NaN))
            goto L6a
        L24:
            int r2 = r3 + 1
            r3 = r1[r3]
            int r3 = r3 << 14
            r0 = r0 ^ r3
            if (r0 < 0) goto L31
            r0 = r0 ^ 16256(0x3f80, float:2.278E-41)
        L2f:
            r3 = r2
            goto L6a
        L31:
            int r3 = r2 + 1
            r2 = r1[r2]
            int r2 = r2 << 21
            r0 = r0 ^ r2
            if (r0 >= 0) goto L3f
            r1 = -2080896(0xffffffffffe03f80, float:NaN)
            r0 = r0 ^ r1
            goto L6a
        L3f:
            int r2 = r3 + 1
            r3 = r1[r3]
            int r4 = r3 << 28
            r0 = r0 ^ r4
            r4 = 266354560(0xfe03f80, float:2.2112565E-29)
            r0 = r0 ^ r4
            if (r3 >= 0) goto L2f
            int r3 = r2 + 1
            r2 = r1[r2]
            if (r2 >= 0) goto L6a
            int r2 = r3 + 1
            r3 = r1[r3]
            if (r3 >= 0) goto L2f
            int r3 = r2 + 1
            r2 = r1[r2]
            if (r2 >= 0) goto L6a
            int r2 = r3 + 1
            r3 = r1[r3]
            if (r3 >= 0) goto L2f
            int r3 = r2 + 1
            r1 = r1[r2]
            if (r1 < 0) goto L6d
        L6a:
            r5.pos = r3
            return r0
        L6d:
            long r0 = r5.zzabz()
            int r0 = (int) r0
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbas.zzacc():int");
    }

    private final long zzacd() {
        int i;
        long j;
        long j2;
        long j3;
        int i2;
        long j4;
        int i3 = this.pos;
        if (this.limit != i3) {
            byte[] bArr = this.buffer;
            int i4 = i3 + 1;
            byte b = bArr[i3];
            if (b >= 0) {
                this.pos = i4;
                return b;
            }
            if (this.limit - i4 >= 9) {
                int i5 = i4 + 1;
                int i6 = b ^ (bArr[i4] << 7);
                if (i6 < 0) {
                    i2 = i6 ^ (-128);
                } else {
                    int i7 = i5 + 1;
                    int i8 = i6 ^ (bArr[i5] << 14);
                    if (i8 >= 0) {
                        j4 = i8 ^ 16256;
                        i = i7;
                        j = j4;
                        this.pos = i;
                        return j;
                    }
                    i5 = i7 + 1;
                    int i9 = i8 ^ (bArr[i7] << 21);
                    if (i9 >= 0) {
                        long j5 = i9;
                        i = i5 + 1;
                        long j6 = j5 ^ (((long) bArr[i5]) << 28);
                        if (j6 < 0) {
                            int i10 = i + 1;
                            long j7 = j6 ^ (((long) bArr[i]) << 35);
                            if (j7 < 0) {
                                j2 = -34093383808L;
                            } else {
                                i = i10 + 1;
                                j6 = j7 ^ (((long) bArr[i10]) << 42);
                                if (j6 >= 0) {
                                    j3 = 4363953127296L;
                                } else {
                                    i10 = i + 1;
                                    j7 = j6 ^ (((long) bArr[i]) << 49);
                                    if (j7 >= 0) {
                                        i = i10 + 1;
                                        long j8 = (j7 ^ (((long) bArr[i10]) << 56)) ^ 71499008037633920L;
                                        if (j8 < 0) {
                                            int i11 = i + 1;
                                            if (bArr[i] >= 0) {
                                                i = i11;
                                            }
                                        }
                                        j = j8;
                                        this.pos = i;
                                        return j;
                                    }
                                    j2 = -558586000294016L;
                                }
                            }
                            j = j7 ^ j2;
                            i = i10;
                            this.pos = i;
                            return j;
                        }
                        j3 = 266354560;
                        j = j6 ^ j3;
                        this.pos = i;
                        return j;
                    }
                    i2 = i9 ^ (-2080896);
                }
                j4 = i2;
                i = i5;
                j = j4;
                this.pos = i;
                return j;
            }
        }
        return zzabz();
    }

    private final int zzace() throws zzbbu {
        int i = this.pos;
        if (this.limit - i < 4) {
            throw zzbbu.zzadl();
        }
        byte[] bArr = this.buffer;
        this.pos = i + 4;
        return ((bArr[i + 3] & 255) << 24) | (bArr[i] & 255) | ((bArr[i + 1] & 255) << 8) | ((bArr[i + 2] & 255) << 16);
    }

    private final long zzacf() throws zzbbu {
        int i = this.pos;
        if (this.limit - i < 8) {
            throw zzbbu.zzadl();
        }
        byte[] bArr = this.buffer;
        this.pos = i + 8;
        return (((long) bArr[i]) & 255) | ((((long) bArr[i + 1]) & 255) << 8) | ((((long) bArr[i + 2]) & 255) << 16) | ((((long) bArr[i + 3]) & 255) << 24) | ((((long) bArr[i + 4]) & 255) << 32) | ((((long) bArr[i + 5]) & 255) << 40) | ((((long) bArr[i + 6]) & 255) << 48) | ((((long) bArr[i + 7]) & 255) << 56);
    }

    private final void zzacg() {
        this.limit += this.zzdqe;
        int i = this.limit - this.zzdqf;
        if (i <= this.zzdqh) {
            this.zzdqe = 0;
        } else {
            this.zzdqe = i - this.zzdqh;
            this.limit -= this.zzdqe;
        }
    }

    private final byte zzach() throws zzbbu {
        if (this.pos == this.limit) {
            throw zzbbu.zzadl();
        }
        byte[] bArr = this.buffer;
        int i = this.pos;
        this.pos = i + 1;
        return bArr[i];
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final double readDouble() {
        return Double.longBitsToDouble(zzacf());
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final float readFloat() {
        return Float.intBitsToFloat(zzace());
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final String readString() throws zzbbu {
        int iZzacc = zzacc();
        if (iZzacc > 0 && iZzacc <= this.limit - this.pos) {
            String str = new String(this.buffer, this.pos, iZzacc, zzbbq.UTF_8);
            this.pos += iZzacc;
            return str;
        }
        if (iZzacc == 0) {
            return "";
        }
        if (iZzacc < 0) {
            throw zzbbu.zzadm();
        }
        throw zzbbu.zzadl();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final int zzabk() throws zzbbu {
        if (zzaca()) {
            this.zzdqg = 0;
            return 0;
        }
        this.zzdqg = zzacc();
        if ((this.zzdqg >>> 3) == 0) {
            throw zzbbu.zzado();
        }
        return this.zzdqg;
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final long zzabl() {
        return zzacd();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final long zzabm() {
        return zzacd();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final int zzabn() {
        return zzacc();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final long zzabo() {
        return zzacf();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final int zzabp() {
        return zzace();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final boolean zzabq() {
        return zzacd() != 0;
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final String zzabr() throws zzbbu {
        int iZzacc = zzacc();
        if (iZzacc <= 0 || iZzacc > this.limit - this.pos) {
            if (iZzacc == 0) {
                return "";
            }
            if (iZzacc <= 0) {
                throw zzbbu.zzadm();
            }
            throw zzbbu.zzadl();
        }
        if (!zzbem.zzf(this.buffer, this.pos, this.pos + iZzacc)) {
            throw zzbbu.zzads();
        }
        int i = this.pos;
        this.pos += iZzacc;
        return new String(this.buffer, i, iZzacc, zzbbq.UTF_8);
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final zzbah zzabs() throws zzbbu {
        byte[] bArrCopyOfRange;
        int iZzacc = zzacc();
        if (iZzacc > 0 && iZzacc <= this.limit - this.pos) {
            zzbah zzbahVarZzc = zzbah.zzc(this.buffer, this.pos, iZzacc);
            this.pos += iZzacc;
            return zzbahVarZzc;
        }
        if (iZzacc == 0) {
            return zzbah.zzdpq;
        }
        if (iZzacc > 0 && iZzacc <= this.limit - this.pos) {
            int i = this.pos;
            this.pos += iZzacc;
            bArrCopyOfRange = Arrays.copyOfRange(this.buffer, i, this.pos);
        } else {
            if (iZzacc > 0) {
                throw zzbbu.zzadl();
            }
            if (iZzacc != 0) {
                throw zzbbu.zzadm();
            }
            bArrCopyOfRange = zzbbq.zzduq;
        }
        return zzbah.zzp(bArrCopyOfRange);
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final int zzabt() {
        return zzacc();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final int zzabu() {
        return zzacc();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final int zzabv() {
        return zzace();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final long zzabw() {
        return zzacf();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final int zzabx() {
        return zzbu(zzacc());
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final long zzaby() {
        return zzl(zzacd());
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    final long zzabz() throws zzbbu {
        long j = 0;
        int i = 0;
        while (i < 64) {
            byte bZzach = zzach();
            long j2 = j | (((long) (bZzach & 127)) << i);
            if ((bZzach & 128) == 0) {
                return j2;
            }
            i += 7;
            j = j2;
        }
        throw zzbbu.zzadn();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final boolean zzaca() {
        return this.pos == this.limit;
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final int zzacb() {
        return this.pos - this.zzdqf;
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final void zzbp(int i) throws zzbbu {
        if (this.zzdqg != i) {
            throw zzbbu.zzadp();
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final boolean zzbq(int i) throws zzbbu {
        int iZzabk;
        int i2 = 0;
        switch (i & 7) {
            case 0:
                if (this.limit - this.pos < 10) {
                    while (i2 < 10) {
                        if (zzach() < 0) {
                            i2++;
                        }
                    }
                    throw zzbbu.zzadn();
                }
                while (i2 < 10) {
                    byte[] bArr = this.buffer;
                    int i3 = this.pos;
                    this.pos = i3 + 1;
                    if (bArr[i3] < 0) {
                        i2++;
                    }
                }
                throw zzbbu.zzadn();
                return true;
            case 1:
                zzbt(8);
                return true;
            case 2:
                zzbt(zzacc());
                return true;
            case 3:
                break;
            case 4:
                return false;
            case 5:
                zzbt(4);
                return true;
            default:
                throw zzbbu.zzadq();
        }
        do {
            iZzabk = zzabk();
            if (iZzabk != 0) {
            }
            zzbp(((i >>> 3) << 3) | 4);
            return true;
        } while (zzbq(iZzabk));
        zzbp(((i >>> 3) << 3) | 4);
        return true;
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final int zzbr(int i) throws zzbbu {
        if (i < 0) {
            throw zzbbu.zzadm();
        }
        int iZzacb = i + zzacb();
        int i2 = this.zzdqh;
        if (iZzacb > i2) {
            throw zzbbu.zzadl();
        }
        this.zzdqh = iZzacb;
        zzacg();
        return i2;
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final void zzbs(int i) {
        this.zzdqh = i;
        zzacg();
    }

    @Override // com.google.android.gms.internal.ads.zzbaq
    public final void zzbt(int i) throws zzbbu {
        if (i >= 0 && i <= this.limit - this.pos) {
            this.pos += i;
        } else {
            if (i >= 0) {
                throw zzbbu.zzadl();
            }
            throw zzbbu.zzadm();
        }
    }
}
