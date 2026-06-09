package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.internal.firebase_auth.zzdb;

/* JADX INFO: loaded from: classes2.dex */
final class zzet implements zzef {
    private final int flags;
    private final String info;
    private final Object[] zztl;
    private final zzeh zzto;

    zzet(zzeh zzehVar, String str, Object[] objArr) {
        this.zzto = zzehVar;
        this.info = str;
        this.zztl = objArr;
        char cCharAt = str.charAt(0);
        if (cCharAt < 55296) {
            this.flags = cCharAt;
            return;
        }
        int i = cCharAt & 8191;
        int i2 = 13;
        int i3 = 1;
        while (true) {
            int i4 = i3 + 1;
            char cCharAt2 = str.charAt(i3);
            if (cCharAt2 < 55296) {
                this.flags = i | (cCharAt2 << i2);
                return;
            } else {
                i |= (cCharAt2 & 8191) << i2;
                i2 += 13;
                i3 = i4;
            }
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzef
    public final int zzez() {
        return (this.flags & 1) == 1 ? zzdb.zze.zzrm : zzdb.zze.zzrn;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzef
    public final boolean zzfa() {
        return (this.flags & 2) == 2;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzef
    public final zzeh zzfb() {
        return this.zzto;
    }

    final String zzfh() {
        return this.info;
    }

    final Object[] zzfi() {
        return this.zztl;
    }
}
