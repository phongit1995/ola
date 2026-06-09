package com.google.android.gms.internal.measurement;

import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
final class zzjw implements zzfo {
    private final /* synthetic */ zzjt zzasn;

    zzjw(zzjt zzjtVar) {
        this.zzasn = zzjtVar;
    }

    @Override // com.google.android.gms.internal.measurement.zzfo
    public final void zza(String str, int i, Throwable th, byte[] bArr, Map<String, List<String>> map) {
        this.zzasn.zzb(str, i, th, bArr, map);
    }
}
