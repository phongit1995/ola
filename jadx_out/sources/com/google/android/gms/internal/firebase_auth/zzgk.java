package com.google.android.gms.internal.firebase_auth;

import java.io.IOException;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgk {
    private final byte[] buffer;
    private int zzmq;
    private int zzmx;
    private int zzmz;
    private final int zzxk;
    private final int zzxl;
    private int zzxm;
    private int zzxn;
    private zzcd zzxo;
    private int zzna = Integer.MAX_VALUE;
    private int zzmr = 64;
    private int zzms = 67108864;

    private zzgk(byte[] bArr, int i, int i2) {
        this.buffer = bArr;
        this.zzxk = i;
        int i3 = i2 + i;
        this.zzxm = i3;
        this.zzxl = i3;
        this.zzxn = i;
    }

    private final void zzcy() {
        this.zzxm += this.zzmx;
        int i = this.zzxm;
        if (i <= this.zzna) {
            this.zzmx = 0;
        } else {
            this.zzmx = i - this.zzna;
            this.zzxm -= this.zzmx;
        }
    }

    private final byte zzcz() throws zzgs {
        if (this.zzxn == this.zzxm) {
            throw zzgs.zzgp();
        }
        byte[] bArr = this.buffer;
        int i = this.zzxn;
        this.zzxn = i + 1;
        return bArr[i];
    }

    public static zzgk zzi(byte[] bArr, int i, int i2) {
        return new zzgk(bArr, 0, i2);
    }

    private final void zzr(int i) throws zzgs {
        if (i < 0) {
            throw zzgs.zzgq();
        }
        if (this.zzxn + i > this.zzna) {
            zzr(this.zzna - this.zzxn);
            throw zzgs.zzgp();
        }
        if (i > this.zzxm - this.zzxn) {
            throw zzgs.zzgp();
        }
        this.zzxn += i;
    }

    public final int getPosition() {
        return this.zzxn - this.zzxk;
    }

    public final byte[] readBytes() throws zzgs {
        int iZzcu = zzcu();
        if (iZzcu < 0) {
            throw zzgs.zzgq();
        }
        if (iZzcu == 0) {
            return zzgw.zzyk;
        }
        if (iZzcu > this.zzxm - this.zzxn) {
            throw zzgs.zzgp();
        }
        byte[] bArr = new byte[iZzcu];
        System.arraycopy(this.buffer, this.zzxn, bArr, 0, iZzcu);
        this.zzxn += iZzcu;
        return bArr;
    }

    public final String readString() throws zzgs {
        int iZzcu = zzcu();
        if (iZzcu < 0) {
            throw zzgs.zzgq();
        }
        if (iZzcu > this.zzxm - this.zzxn) {
            throw zzgs.zzgp();
        }
        String str = new String(this.buffer, this.zzxn, iZzcu, zzgr.UTF_8);
        this.zzxn += iZzcu;
        return str;
    }

    public final <T extends zzdb<T, ?>> T zza(zzer<T> zzerVar) throws IOException {
        try {
            if (this.zzxo == null) {
                this.zzxo = zzcd.zzd(this.buffer, this.zzxk, this.zzxl);
            }
            int iZzct = this.zzxo.zzct();
            int i = this.zzxn - this.zzxk;
            if (iZzct > i) {
                throw new IOException(String.format("CodedInputStream read ahead of CodedInputByteBufferNano: %s > %s", Integer.valueOf(iZzct), Integer.valueOf(i)));
            }
            this.zzxo.zzr(i - iZzct);
            this.zzxo.zzo(this.zzmr - this.zzmq);
            T t = (T) this.zzxo.zza(zzerVar, zzco.zzdl());
            zzn(this.zzmz);
            return t;
        } catch (zzdh e) {
            throw new zzgs("", e);
        }
    }

    public final void zzay(int i) {
        zzs(i, this.zzmz);
    }

    public final void zzb(zzgt zzgtVar) throws zzgs {
        int iZzcu = zzcu();
        if (this.zzmq >= this.zzmr) {
            throw new zzgs("Protocol message had too many levels of nesting.  May be malicious.  Use CodedInputStream.setRecursionLimit() to increase the depth limit.");
        }
        int iZzp = zzp(iZzcu);
        this.zzmq++;
        zzgtVar.zza(this);
        zzm(0);
        this.zzmq--;
        zzq(iZzp);
    }

    public final int zzcc() throws zzgs {
        if (this.zzxn == this.zzxm) {
            this.zzmz = 0;
            return 0;
        }
        this.zzmz = zzcu();
        if (this.zzmz == 0) {
            throw new zzgs("Protocol message contained an invalid tag (zero).");
        }
        return this.zzmz;
    }

    public final long zzce() {
        return zzcv();
    }

    public final boolean zzci() {
        return zzcu() != 0;
    }

    public final int zzcu() throws zzgs {
        int i;
        byte bZzcz = zzcz();
        if (bZzcz >= 0) {
            return bZzcz;
        }
        int i2 = bZzcz & 127;
        byte bZzcz2 = zzcz();
        if (bZzcz2 >= 0) {
            i = bZzcz2 << 7;
        } else {
            i2 |= (bZzcz2 & 127) << 7;
            byte bZzcz3 = zzcz();
            if (bZzcz3 >= 0) {
                i = bZzcz3 << 14;
            } else {
                i2 |= (bZzcz3 & 127) << 14;
                byte bZzcz4 = zzcz();
                if (bZzcz4 < 0) {
                    int i3 = i2 | ((bZzcz4 & 127) << 21);
                    byte bZzcz5 = zzcz();
                    int i4 = i3 | (bZzcz5 << 28);
                    if (bZzcz5 >= 0) {
                        return i4;
                    }
                    for (int i5 = 0; i5 < 5; i5++) {
                        if (zzcz() >= 0) {
                            return i4;
                        }
                    }
                    throw zzgs.zzgr();
                }
                i = bZzcz4 << 21;
            }
        }
        return i2 | i;
    }

    public final long zzcv() throws zzgs {
        int i = 0;
        long j = 0;
        while (i < 64) {
            byte bZzcz = zzcz();
            long j2 = j | (((long) (bZzcz & 127)) << i);
            if ((bZzcz & 128) == 0) {
                return j2;
            }
            i += 7;
            j = j2;
        }
        throw zzgs.zzgr();
    }

    public final int zzgl() {
        if (this.zzna == Integer.MAX_VALUE) {
            return -1;
        }
        return this.zzna - this.zzxn;
    }

    public final void zzm(int i) throws zzgs {
        if (this.zzmz != i) {
            throw new zzgs("Protocol message end-group tag did not match expected tag.");
        }
    }

    public final boolean zzn(int i) throws zzgs {
        int iZzcc;
        switch (i & 7) {
            case 0:
                zzcu();
                return true;
            case 1:
                zzcz();
                zzcz();
                zzcz();
                zzcz();
                zzcz();
                zzcz();
                zzcz();
                zzcz();
                return true;
            case 2:
                zzr(zzcu());
                return true;
            case 3:
                break;
            case 4:
                return false;
            case 5:
                zzcz();
                zzcz();
                zzcz();
                zzcz();
                return true;
            default:
                throw new zzgs("Protocol message tag had invalid wire type.");
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

    public final int zzp(int i) throws zzgs {
        if (i < 0) {
            throw zzgs.zzgq();
        }
        int i2 = i + this.zzxn;
        int i3 = this.zzna;
        if (i2 > i3) {
            throw zzgs.zzgp();
        }
        this.zzna = i2;
        zzcy();
        return i3;
    }

    public final void zzq(int i) {
        this.zzna = i;
        zzcy();
    }

    public final byte[] zzr(int i, int i2) {
        if (i2 == 0) {
            return zzgw.zzyk;
        }
        byte[] bArr = new byte[i2];
        System.arraycopy(this.buffer, this.zzxk + i, bArr, 0, i2);
        return bArr;
    }

    final void zzs(int i, int i2) {
        if (i > this.zzxn - this.zzxk) {
            int i3 = this.zzxn - this.zzxk;
            StringBuilder sb = new StringBuilder(50);
            sb.append("Position ");
            sb.append(i);
            sb.append(" is beyond current ");
            sb.append(i3);
            throw new IllegalArgumentException(sb.toString());
        }
        if (i >= 0) {
            this.zzxn = this.zzxk + i;
            this.zzmz = i2;
        } else {
            StringBuilder sb2 = new StringBuilder(24);
            sb2.append("Bad position ");
            sb2.append(i);
            throw new IllegalArgumentException(sb2.toString());
        }
    }
}
