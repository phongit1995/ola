package com.google.android.gms.internal.measurement;

import java.util.Arrays;

/* JADX INFO: loaded from: classes2.dex */
final class zzacl {
    final int tag;
    final byte[] zzbtj;

    zzacl(int i, byte[] bArr) {
        this.tag = i;
        this.zzbtj = bArr;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzacl)) {
            return false;
        }
        zzacl zzaclVar = (zzacl) obj;
        return this.tag == zzaclVar.tag && Arrays.equals(this.zzbtj, zzaclVar.zzbtj);
    }

    public final int hashCode() {
        return ((this.tag + 527) * 31) + Arrays.hashCode(this.zzbtj);
    }
}
