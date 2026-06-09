package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzaca {
    private final byte[] buffer;
    private int zzbtp;
    private final int zzbyw;
    private final int zzbyx;
    private int zzbyy;
    private int zzbyz;
    private int zzbza;
    private int zzbzb;
    private int zzbtr = Integer.MAX_VALUE;
    private int zzbtk = 64;
    private int zzbtl = 67108864;

    private zzaca(byte[] bArr, int i, int i2) {
        this.buffer = bArr;
        this.zzbyw = i;
        int i3 = i2 + i;
        this.zzbyy = i3;
        this.zzbyx = i3;
        this.zzbyz = i;
    }

    public static zzaca zza(byte[] bArr, int i, int i2) {
        return new zzaca(bArr, 0, i2);
    }

    private final void zzan(int i) throws zzaci {
        if (i < 0) {
            throw zzaci.zzvx();
        }
        if (this.zzbyz + i > this.zzbtr) {
            zzan(this.zzbtr - this.zzbyz);
            throw zzaci.zzvw();
        }
        if (i > this.zzbyy - this.zzbyz) {
            throw zzaci.zzvw();
        }
        this.zzbyz += i;
    }

    public static zzaca zzi(byte[] bArr) {
        return zza(bArr, 0, bArr.length);
    }

    private final void zztp() {
        this.zzbyy += this.zzbtp;
        int i = this.zzbyy;
        if (i <= this.zzbtr) {
            this.zzbtp = 0;
        } else {
            this.zzbtp = i - this.zzbtr;
            this.zzbyy -= this.zzbtp;
        }
    }

    private final byte zzvs() throws zzaci {
        if (this.zzbyz == this.zzbyy) {
            throw zzaci.zzvw();
        }
        byte[] bArr = this.buffer;
        int i = this.zzbyz;
        this.zzbyz = i + 1;
        return bArr[i];
    }

    public final int getPosition() {
        return this.zzbyz - this.zzbyw;
    }

    public final String readString() throws zzaci {
        int iZzvn = zzvn();
        if (iZzvn < 0) {
            throw zzaci.zzvx();
        }
        if (iZzvn > this.zzbyy - this.zzbyz) {
            throw zzaci.zzvw();
        }
        String str = new String(this.buffer, this.zzbyz, iZzvn, zzach.UTF_8);
        this.zzbyz += iZzvn;
        return str;
    }

    public final void zza(zzacj zzacjVar) throws zzaci {
        int iZzvn = zzvn();
        if (this.zzbzb >= this.zzbtk) {
            throw zzaci.zzvz();
        }
        int iZzaf = zzaf(iZzvn);
        this.zzbzb++;
        zzacjVar.zzb(this);
        zzaj(0);
        this.zzbzb--;
        zzal(iZzaf);
    }

    public final void zza(zzacj zzacjVar, int i) throws zzaci {
        if (this.zzbzb >= this.zzbtk) {
            throw zzaci.zzvz();
        }
        this.zzbzb++;
        zzacjVar.zzb(this);
        zzaj((i << 3) | 4);
        this.zzbzb--;
    }

    public final int zzaf(int i) throws zzaci {
        if (i < 0) {
            throw zzaci.zzvx();
        }
        int i2 = i + this.zzbyz;
        int i3 = this.zzbtr;
        if (i2 > i3) {
            throw zzaci.zzvw();
        }
        this.zzbtr = i2;
        zztp();
        return i3;
    }

    public final void zzaj(int i) throws zzaci {
        if (this.zzbza != i) {
            throw new zzaci("Protocol message end-group tag did not match expected tag.");
        }
    }

    public final boolean zzak(int i) throws zzaci {
        int iZzvl;
        switch (i & 7) {
            case 0:
                zzvn();
                return true;
            case 1:
                zzvq();
                return true;
            case 2:
                zzan(zzvn());
                return true;
            case 3:
                break;
            case 4:
                return false;
            case 5:
                zzvp();
                return true;
            default:
                throw new zzaci("Protocol message tag had invalid wire type.");
        }
        do {
            iZzvl = zzvl();
            if (iZzvl != 0) {
            }
            zzaj(((i >>> 3) << 3) | 4);
            return true;
        } while (zzak(iZzvl));
        zzaj(((i >>> 3) << 3) | 4);
        return true;
    }

    public final void zzal(int i) {
        this.zzbtr = i;
        zztp();
    }

    public final void zzam(int i) {
        zzd(i, this.zzbza);
    }

    public final byte[] zzc(int i, int i2) {
        if (i2 == 0) {
            return zzacm.zzbzz;
        }
        byte[] bArr = new byte[i2];
        System.arraycopy(this.buffer, this.zzbyw + i, bArr, 0, i2);
        return bArr;
    }

    final void zzd(int i, int i2) {
        if (i > this.zzbyz - this.zzbyw) {
            int i3 = this.zzbyz - this.zzbyw;
            StringBuilder sb = new StringBuilder(50);
            sb.append("Position ");
            sb.append(i);
            sb.append(" is beyond current ");
            sb.append(i3);
            throw new IllegalArgumentException(sb.toString());
        }
        if (i >= 0) {
            this.zzbyz = this.zzbyw + i;
            this.zzbza = i2;
        } else {
            StringBuilder sb2 = new StringBuilder(24);
            sb2.append("Bad position ");
            sb2.append(i);
            throw new IllegalArgumentException(sb2.toString());
        }
    }

    public final int zzvl() throws zzaci {
        if (this.zzbyz == this.zzbyy) {
            this.zzbza = 0;
            return 0;
        }
        this.zzbza = zzvn();
        if (this.zzbza == 0) {
            throw new zzaci("Protocol message contained an invalid tag (zero).");
        }
        return this.zzbza;
    }

    public final boolean zzvm() {
        return zzvn() != 0;
    }

    public final int zzvn() throws zzaci {
        int i;
        byte bZzvs = zzvs();
        if (bZzvs >= 0) {
            return bZzvs;
        }
        int i2 = bZzvs & 127;
        byte bZzvs2 = zzvs();
        if (bZzvs2 >= 0) {
            i = bZzvs2 << 7;
        } else {
            i2 |= (bZzvs2 & 127) << 7;
            byte bZzvs3 = zzvs();
            if (bZzvs3 >= 0) {
                i = bZzvs3 << 14;
            } else {
                i2 |= (bZzvs3 & 127) << 14;
                byte bZzvs4 = zzvs();
                if (bZzvs4 < 0) {
                    int i3 = i2 | ((bZzvs4 & 127) << 21);
                    byte bZzvs5 = zzvs();
                    int i4 = i3 | (bZzvs5 << 28);
                    if (bZzvs5 >= 0) {
                        return i4;
                    }
                    for (int i5 = 0; i5 < 5; i5++) {
                        if (zzvs() >= 0) {
                            return i4;
                        }
                    }
                    throw zzaci.zzvy();
                }
                i = bZzvs4 << 21;
            }
        }
        return i2 | i;
    }

    public final long zzvo() throws zzaci {
        int i = 0;
        long j = 0;
        while (i < 64) {
            byte bZzvs = zzvs();
            long j2 = j | (((long) (bZzvs & 127)) << i);
            if ((bZzvs & 128) == 0) {
                return j2;
            }
            i += 7;
            j = j2;
        }
        throw zzaci.zzvy();
    }

    public final int zzvp() throws zzaci {
        return (zzvs() & 255) | ((zzvs() & 255) << 8) | ((zzvs() & 255) << 16) | ((zzvs() & 255) << 24);
    }

    public final long zzvq() throws zzaci {
        return (((long) zzvs()) & 255) | ((((long) zzvs()) & 255) << 8) | ((((long) zzvs()) & 255) << 16) | ((((long) zzvs()) & 255) << 24) | ((((long) zzvs()) & 255) << 32) | ((((long) zzvs()) & 255) << 40) | ((((long) zzvs()) & 255) << 48) | ((((long) zzvs()) & 255) << 56);
    }

    public final int zzvr() {
        if (this.zzbtr == Integer.MAX_VALUE) {
            return -1;
        }
        return this.zzbtr - this.zzbyz;
    }
}
