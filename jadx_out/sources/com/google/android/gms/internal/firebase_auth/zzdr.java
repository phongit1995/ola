package com.google.android.gms.internal.firebase_auth;

import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
abstract class zzdr {
    private static final zzdr zzst;
    private static final zzdr zzsu;

    static {
        zzds zzdsVar = null;
        zzst = new zzdt();
        zzsu = new zzdu();
    }

    private zzdr() {
    }

    static zzdr zzeq() {
        return zzst;
    }

    static zzdr zzer() {
        return zzsu;
    }

    abstract <L> List<L> zza(Object obj, long j);

    abstract <L> void zza(Object obj, Object obj2, long j);

    abstract void zzb(Object obj, long j);
}
