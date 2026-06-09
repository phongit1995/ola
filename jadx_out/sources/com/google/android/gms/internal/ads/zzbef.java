package com.google.android.gms.internal.ads;

import com.google.android.gms.internal.ads.zzbbo;
import java.util.Arrays;

/* JADX INFO: loaded from: classes.dex */
public final class zzbef {
    private static final zzbef zzdyx = new zzbef(0, new int[0], new Object[0], false);
    private int count;
    private boolean zzdpi;
    private int zzdtu;
    private Object[] zzdwh;
    private int[] zzdyy;

    private zzbef() {
        this(0, new int[8], new Object[8], true);
    }

    private zzbef(int i, int[] iArr, Object[] objArr, boolean z) {
        this.zzdtu = -1;
        this.count = i;
        this.zzdyy = iArr;
        this.zzdwh = objArr;
        this.zzdpi = z;
    }

    static zzbef zza(zzbef zzbefVar, zzbef zzbefVar2) {
        int i = zzbefVar.count + zzbefVar2.count;
        int[] iArrCopyOf = Arrays.copyOf(zzbefVar.zzdyy, i);
        System.arraycopy(zzbefVar2.zzdyy, 0, iArrCopyOf, zzbefVar.count, zzbefVar2.count);
        Object[] objArrCopyOf = Arrays.copyOf(zzbefVar.zzdwh, i);
        System.arraycopy(zzbefVar2.zzdwh, 0, objArrCopyOf, zzbefVar.count, zzbefVar2.count);
        return new zzbef(i, iArrCopyOf, objArrCopyOf, true);
    }

    public static zzbef zzagc() {
        return zzdyx;
    }

    static zzbef zzagd() {
        return new zzbef();
    }

    private static void zzb(int i, Object obj, zzbey zzbeyVar) {
        int i2 = i >>> 3;
        int i3 = i & 7;
        if (i3 == 5) {
            zzbeyVar.zzp(i2, ((Integer) obj).intValue());
            return;
        }
        switch (i3) {
            case 0:
                zzbeyVar.zzi(i2, ((Long) obj).longValue());
                return;
            case 1:
                zzbeyVar.zzc(i2, ((Long) obj).longValue());
                return;
            case 2:
                zzbeyVar.zza(i2, (zzbah) obj);
                return;
            case 3:
                if (zzbeyVar.zzacn() == zzbbo.zze.zzdul) {
                    zzbeyVar.zzcm(i2);
                    ((zzbef) obj).zzb(zzbeyVar);
                    zzbeyVar.zzcn(i2);
                    return;
                } else {
                    zzbeyVar.zzcn(i2);
                    ((zzbef) obj).zzb(zzbeyVar);
                    zzbeyVar.zzcm(i2);
                    return;
                }
            default:
                throw new RuntimeException(zzbbu.zzadq());
        }
    }

    public final boolean equals(Object obj) {
        boolean z;
        boolean z2;
        if (this == obj) {
            return true;
        }
        if (obj == null || !(obj instanceof zzbef)) {
            return false;
        }
        zzbef zzbefVar = (zzbef) obj;
        if (this.count == zzbefVar.count) {
            int[] iArr = this.zzdyy;
            int[] iArr2 = zzbefVar.zzdyy;
            int i = this.count;
            int i2 = 0;
            while (true) {
                if (i2 >= i) {
                    z = true;
                    break;
                }
                if (iArr[i2] != iArr2[i2]) {
                    z = false;
                    break;
                }
                i2++;
            }
            if (z) {
                Object[] objArr = this.zzdwh;
                Object[] objArr2 = zzbefVar.zzdwh;
                int i3 = this.count;
                int i4 = 0;
                while (true) {
                    if (i4 >= i3) {
                        z2 = true;
                        break;
                    }
                    if (!objArr[i4].equals(objArr2[i4])) {
                        z2 = false;
                        break;
                    }
                    i4++;
                }
                return z2;
            }
        }
        return false;
    }

    public final int hashCode() {
        int i = (this.count + 527) * 31;
        int[] iArr = this.zzdyy;
        int i2 = this.count;
        int iHashCode = 17;
        int i3 = 17;
        for (int i4 = 0; i4 < i2; i4++) {
            i3 = (i3 * 31) + iArr[i4];
        }
        int i5 = (i + i3) * 31;
        Object[] objArr = this.zzdwh;
        int i6 = this.count;
        for (int i7 = 0; i7 < i6; i7++) {
            iHashCode = (iHashCode * 31) + objArr[i7].hashCode();
        }
        return i5 + iHashCode;
    }

    final void zza(zzbey zzbeyVar) {
        if (zzbeyVar.zzacn() == zzbbo.zze.zzdum) {
            for (int i = this.count - 1; i >= 0; i--) {
                zzbeyVar.zza(this.zzdyy[i] >>> 3, this.zzdwh[i]);
            }
            return;
        }
        for (int i2 = 0; i2 < this.count; i2++) {
            zzbeyVar.zza(this.zzdyy[i2] >>> 3, this.zzdwh[i2]);
        }
    }

    final void zza(StringBuilder sb, int i) {
        for (int i2 = 0; i2 < this.count; i2++) {
            zzbcx.zza(sb, i, String.valueOf(this.zzdyy[i2] >>> 3), this.zzdwh[i2]);
        }
    }

    public final void zzaaz() {
        this.zzdpi = false;
    }

    public final int zzacw() {
        int iZzt;
        int i = this.zzdtu;
        if (i != -1) {
            return i;
        }
        int i2 = 0;
        for (int i3 = 0; i3 < this.count; i3++) {
            int i4 = this.zzdyy[i3];
            int i5 = i4 >>> 3;
            int i6 = i4 & 7;
            if (i6 != 5) {
                switch (i6) {
                    case 0:
                        iZzt = zzbav.zze(i5, ((Long) this.zzdwh[i3]).longValue());
                        break;
                    case 1:
                        iZzt = zzbav.zzg(i5, ((Long) this.zzdwh[i3]).longValue());
                        break;
                    case 2:
                        iZzt = zzbav.zzc(i5, (zzbah) this.zzdwh[i3]);
                        break;
                    case 3:
                        iZzt = (zzbav.zzcd(i5) << 1) + ((zzbef) this.zzdwh[i3]).zzacw();
                        break;
                    default:
                        throw new IllegalStateException(zzbbu.zzadq());
                }
            } else {
                iZzt = zzbav.zzt(i5, ((Integer) this.zzdwh[i3]).intValue());
            }
            i2 += iZzt;
        }
        this.zzdtu = i2;
        return i2;
    }

    public final int zzage() {
        int i = this.zzdtu;
        if (i != -1) {
            return i;
        }
        int iZzd = 0;
        for (int i2 = 0; i2 < this.count; i2++) {
            iZzd += zzbav.zzd(this.zzdyy[i2] >>> 3, (zzbah) this.zzdwh[i2]);
        }
        this.zzdtu = iZzd;
        return iZzd;
    }

    final void zzb(int i, Object obj) {
        if (!this.zzdpi) {
            throw new UnsupportedOperationException();
        }
        if (this.count == this.zzdyy.length) {
            int i2 = this.count + (this.count < 4 ? 8 : this.count >> 1);
            this.zzdyy = Arrays.copyOf(this.zzdyy, i2);
            this.zzdwh = Arrays.copyOf(this.zzdwh, i2);
        }
        this.zzdyy[this.count] = i;
        this.zzdwh[this.count] = obj;
        this.count++;
    }

    public final void zzb(zzbey zzbeyVar) {
        if (this.count == 0) {
            return;
        }
        if (zzbeyVar.zzacn() == zzbbo.zze.zzdul) {
            for (int i = 0; i < this.count; i++) {
                zzb(this.zzdyy[i], this.zzdwh[i], zzbeyVar);
            }
            return;
        }
        for (int i2 = this.count - 1; i2 >= 0; i2--) {
            zzb(this.zzdyy[i2], this.zzdwh[i2], zzbeyVar);
        }
    }
}
