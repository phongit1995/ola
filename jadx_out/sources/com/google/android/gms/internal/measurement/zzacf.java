package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzacf implements Cloneable {
    private static final zzacg zzbzh = new zzacg();
    private int mSize;
    private boolean zzbzi;
    private int[] zzbzj;
    private zzacg[] zzbzk;

    zzacf() {
        this(10);
    }

    private zzacf(int i) {
        this.zzbzi = false;
        int iIdealIntArraySize = idealIntArraySize(i);
        this.zzbzj = new int[iIdealIntArraySize];
        this.zzbzk = new zzacg[iIdealIntArraySize];
        this.mSize = 0;
    }

    private static int idealIntArraySize(int i) {
        int i2 = i << 2;
        int i3 = 4;
        while (true) {
            if (i3 >= 32) {
                break;
            }
            int i4 = (1 << i3) - 12;
            if (i2 <= i4) {
                i2 = i4;
                break;
            }
            i3++;
        }
        return i2 / 4;
    }

    private final int zzav(int i) {
        int i2 = this.mSize - 1;
        int i3 = 0;
        while (i3 <= i2) {
            int i4 = (i3 + i2) >>> 1;
            int i5 = this.zzbzj[i4];
            if (i5 < i) {
                i3 = i4 + 1;
            } else {
                if (i5 <= i) {
                    return i4;
                }
                i2 = i4 - 1;
            }
        }
        return i3 ^ (-1);
    }

    public final /* synthetic */ Object clone() {
        int i = this.mSize;
        zzacf zzacfVar = new zzacf(i);
        System.arraycopy(this.zzbzj, 0, zzacfVar.zzbzj, 0, i);
        for (int i2 = 0; i2 < i; i2++) {
            if (this.zzbzk[i2] != null) {
                zzacfVar.zzbzk[i2] = (zzacg) this.zzbzk[i2].clone();
            }
        }
        zzacfVar.mSize = i;
        return zzacfVar;
    }

    public final boolean equals(Object obj) {
        boolean z;
        boolean z2;
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzacf)) {
            return false;
        }
        zzacf zzacfVar = (zzacf) obj;
        if (this.mSize != zzacfVar.mSize) {
            return false;
        }
        int[] iArr = this.zzbzj;
        int[] iArr2 = zzacfVar.zzbzj;
        int i = this.mSize;
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
            zzacg[] zzacgVarArr = this.zzbzk;
            zzacg[] zzacgVarArr2 = zzacfVar.zzbzk;
            int i3 = this.mSize;
            int i4 = 0;
            while (true) {
                if (i4 >= i3) {
                    z2 = true;
                    break;
                }
                if (!zzacgVarArr[i4].equals(zzacgVarArr2[i4])) {
                    z2 = false;
                    break;
                }
                i4++;
            }
            if (z2) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        int iHashCode = 17;
        for (int i = 0; i < this.mSize; i++) {
            iHashCode = (((iHashCode * 31) + this.zzbzj[i]) * 31) + this.zzbzk[i].hashCode();
        }
        return iHashCode;
    }

    public final boolean isEmpty() {
        return this.mSize == 0;
    }

    final int size() {
        return this.mSize;
    }

    final void zza(int i, zzacg zzacgVar) {
        int iZzav = zzav(i);
        if (iZzav >= 0) {
            this.zzbzk[iZzav] = zzacgVar;
            return;
        }
        int i2 = iZzav ^ (-1);
        if (i2 < this.mSize && this.zzbzk[i2] == zzbzh) {
            this.zzbzj[i2] = i;
            this.zzbzk[i2] = zzacgVar;
            return;
        }
        if (this.mSize >= this.zzbzj.length) {
            int iIdealIntArraySize = idealIntArraySize(this.mSize + 1);
            int[] iArr = new int[iIdealIntArraySize];
            zzacg[] zzacgVarArr = new zzacg[iIdealIntArraySize];
            System.arraycopy(this.zzbzj, 0, iArr, 0, this.zzbzj.length);
            System.arraycopy(this.zzbzk, 0, zzacgVarArr, 0, this.zzbzk.length);
            this.zzbzj = iArr;
            this.zzbzk = zzacgVarArr;
        }
        if (this.mSize - i2 != 0) {
            int i3 = i2 + 1;
            System.arraycopy(this.zzbzj, i2, this.zzbzj, i3, this.mSize - i2);
            System.arraycopy(this.zzbzk, i2, this.zzbzk, i3, this.mSize - i2);
        }
        this.zzbzj[i2] = i;
        this.zzbzk[i2] = zzacgVar;
        this.mSize++;
    }

    final zzacg zzat(int i) {
        int iZzav = zzav(i);
        if (iZzav < 0 || this.zzbzk[iZzav] == zzbzh) {
            return null;
        }
        return this.zzbzk[iZzav];
    }

    final zzacg zzau(int i) {
        return this.zzbzk[i];
    }
}
