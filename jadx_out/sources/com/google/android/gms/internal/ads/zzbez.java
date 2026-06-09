package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzbez {
    private final byte[] buffer;
    private int zzdpx;
    private int zzdqe;
    private int zzdqg;
    private final int zzebf;
    private final int zzebg;
    private int zzebh;
    private int zzebi;
    private int zzdqh = Integer.MAX_VALUE;
    private int zzdpy = 64;
    private int zzdpz = 67108864;

    private zzbez(byte[] bArr, int i, int i2) {
        this.buffer = bArr;
        this.zzebf = i;
        int i3 = i2 + i;
        this.zzebh = i3;
        this.zzebg = i3;
        this.zzebi = i;
    }

    private final void zzacg() {
        this.zzebh += this.zzdqe;
        int i = this.zzebh;
        if (i <= this.zzdqh) {
            this.zzdqe = 0;
        } else {
            this.zzdqe = i - this.zzdqh;
            this.zzebh -= this.zzdqe;
        }
    }

    private final byte zzach() throws zzbfh {
        if (this.zzebi == this.zzebh) {
            throw zzbfh.zzagq();
        }
        byte[] bArr = this.buffer;
        int i = this.zzebi;
        this.zzebi = i + 1;
        return bArr[i];
    }

    private final void zzbt(int i) throws zzbfh {
        if (i < 0) {
            throw zzbfh.zzagr();
        }
        if (this.zzebi + i > this.zzdqh) {
            zzbt(this.zzdqh - this.zzebi);
            throw zzbfh.zzagq();
        }
        if (i > this.zzebh - this.zzebi) {
            throw zzbfh.zzagq();
        }
        this.zzebi += i;
    }

    public static zzbez zzi(byte[] bArr, int i, int i2) {
        return new zzbez(bArr, 0, i2);
    }

    public final int getPosition() {
        return this.zzebi - this.zzebf;
    }

    public final byte[] readBytes() throws zzbfh {
        int iZzacc = zzacc();
        if (iZzacc < 0) {
            throw zzbfh.zzagr();
        }
        if (iZzacc == 0) {
            return zzbfl.zzecf;
        }
        if (iZzacc > this.zzebh - this.zzebi) {
            throw zzbfh.zzagq();
        }
        byte[] bArr = new byte[iZzacc];
        System.arraycopy(this.buffer, this.zzebi, bArr, 0, iZzacc);
        this.zzebi += iZzacc;
        return bArr;
    }

    public final String readString() throws zzbfh {
        int iZzacc = zzacc();
        if (iZzacc < 0) {
            throw zzbfh.zzagr();
        }
        if (iZzacc > this.zzebh - this.zzebi) {
            throw zzbfh.zzagq();
        }
        String str = new String(this.buffer, this.zzebi, iZzacc, zzbfg.UTF_8);
        this.zzebi += iZzacc;
        return str;
    }

    public final void zza(zzbfi zzbfiVar) throws zzbfh {
        int iZzacc = zzacc();
        if (this.zzdpx >= this.zzdpy) {
            throw new zzbfh("Protocol message had too many levels of nesting.  May be malicious.  Use CodedInputStream.setRecursionLimit() to increase the depth limit.");
        }
        int iZzbr = zzbr(iZzacc);
        this.zzdpx++;
        zzbfiVar.zza(this);
        zzbp(0);
        this.zzdpx--;
        zzbs(iZzbr);
    }

    public final byte[] zzab(int i, int i2) {
        if (i2 == 0) {
            return zzbfl.zzecf;
        }
        byte[] bArr = new byte[i2];
        System.arraycopy(this.buffer, this.zzebf + i, bArr, 0, i2);
        return bArr;
    }

    public final int zzabk() throws zzbfh {
        if (this.zzebi == this.zzebh) {
            this.zzdqg = 0;
            return 0;
        }
        this.zzdqg = zzacc();
        if (this.zzdqg == 0) {
            throw new zzbfh("Protocol message contained an invalid tag (zero).");
        }
        return this.zzdqg;
    }

    public final long zzabm() {
        return zzacd();
    }

    public final int zzabn() {
        return zzacc();
    }

    public final boolean zzabq() {
        return zzacc() != 0;
    }

    final void zzac(int i, int i2) {
        if (i > this.zzebi - this.zzebf) {
            int i3 = this.zzebi - this.zzebf;
            StringBuilder sb = new StringBuilder(50);
            sb.append("Position ");
            sb.append(i);
            sb.append(" is beyond current ");
            sb.append(i3);
            throw new IllegalArgumentException(sb.toString());
        }
        if (i >= 0) {
            this.zzebi = this.zzebf + i;
            this.zzdqg = i2;
        } else {
            StringBuilder sb2 = new StringBuilder(24);
            sb2.append("Bad position ");
            sb2.append(i);
            throw new IllegalArgumentException(sb2.toString());
        }
    }

    public final int zzacc() throws zzbfh {
        int i;
        byte bZzach = zzach();
        if (bZzach >= 0) {
            return bZzach;
        }
        int i2 = bZzach & 127;
        byte bZzach2 = zzach();
        if (bZzach2 >= 0) {
            i = bZzach2 << 7;
        } else {
            i2 |= (bZzach2 & 127) << 7;
            byte bZzach3 = zzach();
            if (bZzach3 >= 0) {
                i = bZzach3 << 14;
            } else {
                i2 |= (bZzach3 & 127) << 14;
                byte bZzach4 = zzach();
                if (bZzach4 < 0) {
                    int i3 = i2 | ((bZzach4 & 127) << 21);
                    byte bZzach5 = zzach();
                    int i4 = i3 | (bZzach5 << 28);
                    if (bZzach5 >= 0) {
                        return i4;
                    }
                    for (int i5 = 0; i5 < 5; i5++) {
                        if (zzach() >= 0) {
                            return i4;
                        }
                    }
                    throw zzbfh.zzags();
                }
                i = bZzach4 << 21;
            }
        }
        return i2 | i;
    }

    public final long zzacd() throws zzbfh {
        int i = 0;
        long j = 0;
        while (i < 64) {
            byte bZzach = zzach();
            long j2 = j | (((long) (bZzach & 127)) << i);
            if ((bZzach & 128) == 0) {
                return j2;
            }
            i += 7;
            j = j2;
        }
        throw zzbfh.zzags();
    }

    public final int zzagn() {
        if (this.zzdqh == Integer.MAX_VALUE) {
            return -1;
        }
        return this.zzdqh - this.zzebi;
    }

    public final void zzbp(int i) throws zzbfh {
        if (this.zzdqg != i) {
            throw new zzbfh("Protocol message end-group tag did not match expected tag.");
        }
    }

    public final boolean zzbq(int i) throws zzbfh {
        int iZzabk;
        switch (i & 7) {
            case 0:
                zzacc();
                return true;
            case 1:
                zzach();
                zzach();
                zzach();
                zzach();
                zzach();
                zzach();
                zzach();
                zzach();
                return true;
            case 2:
                zzbt(zzacc());
                return true;
            case 3:
                break;
            case 4:
                return false;
            case 5:
                zzach();
                zzach();
                zzach();
                zzach();
                return true;
            default:
                throw new zzbfh("Protocol message tag had invalid wire type.");
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

    public final int zzbr(int i) throws zzbfh {
        if (i < 0) {
            throw zzbfh.zzagr();
        }
        int i2 = i + this.zzebi;
        int i3 = this.zzdqh;
        if (i2 > i3) {
            throw zzbfh.zzagq();
        }
        this.zzdqh = i2;
        zzacg();
        return i3;
    }

    public final void zzbs(int i) {
        this.zzdqh = i;
        zzacg();
    }

    public final void zzdc(int i) {
        zzac(i, this.zzdqg);
    }
}
