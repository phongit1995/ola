package com.google.android.gms.internal.firebase_auth;

import java.util.Arrays;

/* JADX INFO: loaded from: classes2.dex */
final class zzgv {
    final int tag;
    final byte[] zzmp;

    zzgv(int i, byte[] bArr) {
        this.tag = i;
        this.zzmp = bArr;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzgv)) {
            return false;
        }
        zzgv zzgvVar = (zzgv) obj;
        return this.tag == zzgvVar.tag && Arrays.equals(this.zzmp, zzgvVar.zzmp);
    }

    public final int hashCode() {
        return ((this.tag + 527) * 31) + Arrays.hashCode(this.zzmp);
    }
}
