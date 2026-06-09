package com.google.android.gms.internal.firebase_auth;

import java.util.Arrays;

/* JADX INFO: loaded from: classes2.dex */
final class zzcf extends zzcd {
    private final byte[] buffer;
    private int limit;
    private int pos;
    private final boolean zzmw;
    private int zzmx;
    private int zzmy;
    private int zzmz;
    private int zzna;

    private zzcf(byte[] bArr, int i, int i2, boolean z) {
        super();
        this.zzna = Integer.MAX_VALUE;
        this.buffer = bArr;
        this.limit = i2 + i;
        this.pos = i;
        this.zzmy = this.pos;
        this.zzmw = z;
    }

    /* JADX WARN: Code restructure failed: missing block: B:31:0x0068, code lost:
    
        if (r1[r2] >= 0) goto L32;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final int zzcu() {
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
            long r0 = r5.zzcr()
            int r0 = (int) r0
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzcf.zzcu():int");
    }

    private final long zzcv() {
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
        return zzcr();
    }

    private final int zzcw() throws zzdh {
        int i = this.pos;
        if (this.limit - i < 4) {
            throw zzdh.zzee();
        }
        byte[] bArr = this.buffer;
        this.pos = i + 4;
        return ((bArr[i + 3] & 255) << 24) | (bArr[i] & 255) | ((bArr[i + 1] & 255) << 8) | ((bArr[i + 2] & 255) << 16);
    }

    private final long zzcx() throws zzdh {
        int i = this.pos;
        if (this.limit - i < 8) {
            throw zzdh.zzee();
        }
        byte[] bArr = this.buffer;
        this.pos = i + 8;
        return (((long) bArr[i]) & 255) | ((((long) bArr[i + 1]) & 255) << 8) | ((((long) bArr[i + 2]) & 255) << 16) | ((((long) bArr[i + 3]) & 255) << 24) | ((((long) bArr[i + 4]) & 255) << 32) | ((((long) bArr[i + 5]) & 255) << 40) | ((((long) bArr[i + 6]) & 255) << 48) | ((((long) bArr[i + 7]) & 255) << 56);
    }

    private final void zzcy() {
        this.limit += this.zzmx;
        int i = this.limit - this.zzmy;
        if (i <= this.zzna) {
            this.zzmx = 0;
        } else {
            this.zzmx = i - this.zzna;
            this.limit -= this.zzmx;
        }
    }

    private final byte zzcz() throws zzdh {
        if (this.pos == this.limit) {
            throw zzdh.zzee();
        }
        byte[] bArr = this.buffer;
        int i = this.pos;
        this.pos = i + 1;
        return bArr[i];
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final double readDouble() {
        return Double.longBitsToDouble(zzcx());
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final float readFloat() {
        return Float.intBitsToFloat(zzcw());
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final String readString() throws zzdh {
        int iZzcu = zzcu();
        if (iZzcu > 0 && iZzcu <= this.limit - this.pos) {
            String str = new String(this.buffer, this.pos, iZzcu, zzdd.UTF_8);
            this.pos += iZzcu;
            return str;
        }
        if (iZzcu == 0) {
            return "";
        }
        if (iZzcu < 0) {
            throw zzdh.zzef();
        }
        throw zzdh.zzee();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final <T extends zzeh> T zza(zzer<T> zzerVar, zzco zzcoVar) throws zzdh {
        int iZzcu = zzcu();
        if (this.zzmq >= this.zzmr) {
            throw zzdh.zzej();
        }
        int iZzp = zzp(iZzcu);
        this.zzmq++;
        T tZza = zzerVar.zza(this, zzcoVar);
        zzm(0);
        this.zzmq--;
        zzq(iZzp);
        return tZza;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final int zzcc() throws zzdh {
        if (zzcs()) {
            this.zzmz = 0;
            return 0;
        }
        this.zzmz = zzcu();
        if ((this.zzmz >>> 3) == 0) {
            throw new zzdh("Protocol message contained an invalid tag (zero).");
        }
        return this.zzmz;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final long zzcd() {
        return zzcv();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final long zzce() {
        return zzcv();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final int zzcf() {
        return zzcu();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final long zzcg() {
        return zzcx();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final int zzch() {
        return zzcw();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final boolean zzci() {
        return zzcv() != 0;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final String zzcj() throws zzdh {
        int iZzcu = zzcu();
        if (iZzcu <= 0 || iZzcu > this.limit - this.pos) {
            if (iZzcu == 0) {
                return "";
            }
            if (iZzcu <= 0) {
                throw zzdh.zzef();
            }
            throw zzdh.zzee();
        }
        if (!zzfx.zzf(this.buffer, this.pos, this.pos + iZzcu)) {
            throw new zzdh("Protocol message had invalid UTF-8.");
        }
        int i = this.pos;
        this.pos += iZzcu;
        return new String(this.buffer, i, iZzcu, zzdd.UTF_8);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final zzbu zzck() throws zzdh {
        byte[] bArrCopyOfRange;
        int iZzcu = zzcu();
        if (iZzcu > 0 && iZzcu <= this.limit - this.pos) {
            zzbu zzbuVarZzb = zzbu.zzb(this.buffer, this.pos, iZzcu);
            this.pos += iZzcu;
            return zzbuVarZzb;
        }
        if (iZzcu == 0) {
            return zzbu.zzmi;
        }
        if (iZzcu > 0 && iZzcu <= this.limit - this.pos) {
            int i = this.pos;
            this.pos += iZzcu;
            bArrCopyOfRange = Arrays.copyOfRange(this.buffer, i, this.pos);
        } else {
            if (iZzcu > 0) {
                throw zzdh.zzee();
            }
            if (iZzcu != 0) {
                throw zzdh.zzef();
            }
            bArrCopyOfRange = zzdd.EMPTY_BYTE_ARRAY;
        }
        return zzbu.zza(bArrCopyOfRange);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final int zzcl() {
        return zzcu();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final int zzcm() {
        return zzcu();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final int zzcn() {
        return zzcw();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final long zzco() {
        return zzcx();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final int zzcp() {
        int iZzcu = zzcu();
        return (-(iZzcu & 1)) ^ (iZzcu >>> 1);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final long zzcq() {
        long jZzcv = zzcv();
        return (jZzcv >>> 1) ^ (-(jZzcv & 1));
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    final long zzcr() throws zzdh {
        long j = 0;
        int i = 0;
        while (i < 64) {
            byte bZzcz = zzcz();
            long j2 = j | (((long) (bZzcz & 127)) << i);
            if ((bZzcz & 128) == 0) {
                return j2;
            }
            i += 7;
            j = j2;
        }
        throw zzdh.zzeg();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final boolean zzcs() {
        return this.pos == this.limit;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final int zzct() {
        return this.pos - this.zzmy;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final void zzm(int i) throws zzdh {
        if (this.zzmz != i) {
            throw zzdh.zzeh();
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final boolean zzn(int i) throws zzdh {
        int iZzcc;
        int i2 = 0;
        switch (i & 7) {
            case 0:
                if (this.limit - this.pos < 10) {
                    while (i2 < 10) {
                        if (zzcz() < 0) {
                            i2++;
                        }
                    }
                    throw zzdh.zzeg();
                }
                while (i2 < 10) {
                    byte[] bArr = this.buffer;
                    int i3 = this.pos;
                    this.pos = i3 + 1;
                    if (bArr[i3] < 0) {
                        i2++;
                    }
                }
                throw zzdh.zzeg();
                return true;
            case 1:
                zzr(8);
                return true;
            case 2:
                zzr(zzcu());
                return true;
            case 3:
                break;
            case 4:
                return false;
            case 5:
                zzr(4);
                return true;
            default:
                throw zzdh.zzei();
        }
        do {
            iZzcc = zzcc();
            if (iZzcc != 0) {
            }
            zzm(((i >>> 3) << 3) | 4);
            return true;
        } while (zzn(iZzcc));
        zzm(((i >>> 3) << 3) | 4);
        return true;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final int zzp(int i) throws zzdh {
        if (i < 0) {
            throw zzdh.zzef();
        }
        int iZzct = i + zzct();
        int i2 = this.zzna;
        if (iZzct > i2) {
            throw zzdh.zzee();
        }
        this.zzna = iZzct;
        zzcy();
        return i2;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final void zzq(int i) {
        this.zzna = i;
        zzcy();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzcd
    public final void zzr(int i) throws zzdh {
        if (i >= 0 && i <= this.limit - this.pos) {
            this.pos += i;
        } else {
            if (i >= 0) {
                throw zzdh.zzee();
            }
            throw zzdh.zzef();
        }
    }
}
