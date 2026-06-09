package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgp implements Cloneable {
    private static final zzgq zzxt = new zzgq();
    private int mSize;
    private boolean zzxu;
    private int[] zzxv;
    private zzgq[] zzxw;

    zzgp() {
        this(10);
    }

    private zzgp(int i) {
        this.zzxu = false;
        int iIdealIntArraySize = idealIntArraySize(i);
        this.zzxv = new int[iIdealIntArraySize];
        this.zzxw = new zzgq[iIdealIntArraySize];
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

    private final int zzbd(int i) {
        int i2 = this.mSize - 1;
        int i3 = 0;
        while (i3 <= i2) {
            int i4 = (i3 + i2) >>> 1;
            int i5 = this.zzxv[i4];
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
        zzgp zzgpVar = new zzgp(i);
        System.arraycopy(this.zzxv, 0, zzgpVar.zzxv, 0, i);
        for (int i2 = 0; i2 < i; i2++) {
            if (this.zzxw[i2] != null) {
                zzgpVar.zzxw[i2] = (zzgq) this.zzxw[i2].clone();
            }
        }
        zzgpVar.mSize = i;
        return zzgpVar;
    }

    public final boolean equals(Object obj) {
        boolean z;
        boolean z2;
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzgp)) {
            return false;
        }
        zzgp zzgpVar = (zzgp) obj;
        if (this.mSize != zzgpVar.mSize) {
            return false;
        }
        int[] iArr = this.zzxv;
        int[] iArr2 = zzgpVar.zzxv;
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
            zzgq[] zzgqVarArr = this.zzxw;
            zzgq[] zzgqVarArr2 = zzgpVar.zzxw;
            int i3 = this.mSize;
            int i4 = 0;
            while (true) {
                if (i4 >= i3) {
                    z2 = true;
                    break;
                }
                if (!zzgqVarArr[i4].equals(zzgqVarArr2[i4])) {
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
            iHashCode = (((iHashCode * 31) + this.zzxv[i]) * 31) + this.zzxw[i].hashCode();
        }
        return iHashCode;
    }

    final int size() {
        return this.mSize;
    }

    final void zza(int i, zzgq zzgqVar) {
        int iZzbd = zzbd(i);
        if (iZzbd >= 0) {
            this.zzxw[iZzbd] = zzgqVar;
            return;
        }
        int i2 = iZzbd ^ (-1);
        if (i2 < this.mSize && this.zzxw[i2] == zzxt) {
            this.zzxv[i2] = i;
            this.zzxw[i2] = zzgqVar;
            return;
        }
        if (this.mSize >= this.zzxv.length) {
            int iIdealIntArraySize = idealIntArraySize(this.mSize + 1);
            int[] iArr = new int[iIdealIntArraySize];
            zzgq[] zzgqVarArr = new zzgq[iIdealIntArraySize];
            System.arraycopy(this.zzxv, 0, iArr, 0, this.zzxv.length);
            System.arraycopy(this.zzxw, 0, zzgqVarArr, 0, this.zzxw.length);
            this.zzxv = iArr;
            this.zzxw = zzgqVarArr;
        }
        if (this.mSize - i2 != 0) {
            int i3 = i2 + 1;
            System.arraycopy(this.zzxv, i2, this.zzxv, i3, this.mSize - i2);
            System.arraycopy(this.zzxw, i2, this.zzxw, i3, this.mSize - i2);
        }
        this.zzxv[i2] = i;
        this.zzxw[i2] = zzgqVar;
        this.mSize++;
    }

    final zzgq zzbb(int i) {
        int iZzbd = zzbd(i);
        if (iZzbd < 0 || this.zzxw[iZzbd] == zzxt) {
            return null;
        }
        return this.zzxw[iZzbd];
    }

    final zzgq zzbc(int i) {
        return this.zzxw[i];
    }
}
