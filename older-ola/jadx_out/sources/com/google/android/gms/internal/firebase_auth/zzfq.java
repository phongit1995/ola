package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.internal.firebase_auth.zzdb;
import java.util.Arrays;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfq {
    private static final zzfq zzvd = new zzfq(0, new int[0], new Object[0], false);
    private int count;
    private boolean zzmd;
    private int zzqy;
    private Object[] zztl;
    private int[] zzve;

    private zzfq() {
        this(0, new int[8], new Object[8], true);
    }

    private zzfq(int i, int[] iArr, Object[] objArr, boolean z) {
        this.zzqy = -1;
        this.count = i;
        this.zzve = iArr;
        this.zztl = objArr;
        this.zzmd = z;
    }

    static zzfq zza(zzfq zzfqVar, zzfq zzfqVar2) {
        int i = zzfqVar.count + zzfqVar2.count;
        int[] iArrCopyOf = Arrays.copyOf(zzfqVar.zzve, i);
        System.arraycopy(zzfqVar2.zzve, 0, iArrCopyOf, zzfqVar.count, zzfqVar2.count);
        Object[] objArrCopyOf = Arrays.copyOf(zzfqVar.zztl, i);
        System.arraycopy(zzfqVar2.zztl, 0, objArrCopyOf, zzfqVar.count, zzfqVar2.count);
        return new zzfq(i, iArrCopyOf, objArrCopyOf, true);
    }

    private static void zzb(int i, Object obj, zzgj zzgjVar) {
        int i2 = i >>> 3;
        int i3 = i & 7;
        if (i3 == 5) {
            zzgjVar.zzf(i2, ((Integer) obj).intValue());
            return;
        }
        switch (i3) {
            case 0:
                zzgjVar.zzi(i2, ((Long) obj).longValue());
                return;
            case 1:
                zzgjVar.zzc(i2, ((Long) obj).longValue());
                return;
            case 2:
                zzgjVar.zza(i2, (zzbu) obj);
                return;
            case 3:
                if (zzgjVar.zzdf() == zzdb.zze.zzrp) {
                    zzgjVar.zzaj(i2);
                    ((zzfq) obj).zzb(zzgjVar);
                    zzgjVar.zzak(i2);
                    return;
                } else {
                    zzgjVar.zzak(i2);
                    ((zzfq) obj).zzb(zzgjVar);
                    zzgjVar.zzaj(i2);
                    return;
                }
            default:
                throw new RuntimeException(zzdh.zzei());
        }
    }

    public static zzfq zzfz() {
        return zzvd;
    }

    static zzfq zzga() {
        return new zzfq();
    }

    public final boolean equals(Object obj) {
        boolean z;
        boolean z2;
        if (this == obj) {
            return true;
        }
        if (obj == null || !(obj instanceof zzfq)) {
            return false;
        }
        zzfq zzfqVar = (zzfq) obj;
        if (this.count == zzfqVar.count) {
            int[] iArr = this.zzve;
            int[] iArr2 = zzfqVar.zzve;
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
                Object[] objArr = this.zztl;
                Object[] objArr2 = zzfqVar.zztl;
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
        int[] iArr = this.zzve;
        int i2 = this.count;
        int iHashCode = 17;
        int i3 = 17;
        for (int i4 = 0; i4 < i2; i4++) {
            i3 = (i3 * 31) + iArr[i4];
        }
        int i5 = (i + i3) * 31;
        Object[] objArr = this.zztl;
        int i6 = this.count;
        for (int i7 = 0; i7 < i6; i7++) {
            iHashCode = (iHashCode * 31) + objArr[i7].hashCode();
        }
        return i5 + iHashCode;
    }

    final void zza(zzgj zzgjVar) {
        if (zzgjVar.zzdf() == zzdb.zze.zzrq) {
            for (int i = this.count - 1; i >= 0; i--) {
                zzgjVar.zza(this.zzve[i] >>> 3, this.zztl[i]);
            }
            return;
        }
        for (int i2 = 0; i2 < this.count; i2++) {
            zzgjVar.zza(this.zzve[i2] >>> 3, this.zztl[i2]);
        }
    }

    final void zza(StringBuilder sb, int i) {
        for (int i2 = 0; i2 < this.count; i2++) {
            zzek.zza(sb, i, String.valueOf(this.zzve[i2] >>> 3), this.zztl[i2]);
        }
    }

    final void zzb(int i, Object obj) {
        if (!this.zzmd) {
            throw new UnsupportedOperationException();
        }
        if (this.count == this.zzve.length) {
            int i2 = this.count + (this.count < 4 ? 8 : this.count >> 1);
            this.zzve = Arrays.copyOf(this.zzve, i2);
            this.zztl = Arrays.copyOf(this.zztl, i2);
        }
        this.zzve[this.count] = i;
        this.zztl[this.count] = obj;
        this.count++;
    }

    public final void zzb(zzgj zzgjVar) {
        if (this.count == 0) {
            return;
        }
        if (zzgjVar.zzdf() == zzdb.zze.zzrp) {
            for (int i = 0; i < this.count; i++) {
                zzb(this.zzve[i], this.zztl[i], zzgjVar);
            }
            return;
        }
        for (int i2 = this.count - 1; i2 >= 0; i2--) {
            zzb(this.zzve[i2], this.zztl[i2], zzgjVar);
        }
    }

    public final void zzbs() {
        this.zzmd = false;
    }

    public final int zzdq() {
        int iZzj;
        int i = this.zzqy;
        if (i != -1) {
            return i;
        }
        int i2 = 0;
        for (int i3 = 0; i3 < this.count; i3++) {
            int i4 = this.zzve[i3];
            int i5 = i4 >>> 3;
            int i6 = i4 & 7;
            if (i6 != 5) {
                switch (i6) {
                    case 0:
                        iZzj = zzci.zze(i5, ((Long) this.zztl[i3]).longValue());
                        break;
                    case 1:
                        iZzj = zzci.zzg(i5, ((Long) this.zztl[i3]).longValue());
                        break;
                    case 2:
                        iZzj = zzci.zzc(i5, (zzbu) this.zztl[i3]);
                        break;
                    case 3:
                        iZzj = (zzci.zzaa(i5) << 1) + ((zzfq) this.zztl[i3]).zzdq();
                        break;
                    default:
                        throw new IllegalStateException(zzdh.zzei());
                }
            } else {
                iZzj = zzci.zzj(i5, ((Integer) this.zztl[i3]).intValue());
            }
            i2 += iZzj;
        }
        this.zzqy = i2;
        return i2;
    }

    public final int zzgb() {
        int i = this.zzqy;
        if (i != -1) {
            return i;
        }
        int iZzd = 0;
        for (int i2 = 0; i2 < this.count; i2++) {
            iZzd += zzci.zzd(this.zzve[i2] >>> 3, (zzbu) this.zztl[i2]);
        }
        this.zzqy = iZzd;
        return iZzd;
    }
}
