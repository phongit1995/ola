package com.google.android.gms.internal.firebase_auth;

import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
final class zzdu extends zzdr {
    private zzdu() {
        super();
    }

    private static <E> zzdg<E> zzd(Object obj, long j) {
        return (zzdg) zzfv.zzp(obj, j);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdr
    final <L> List<L> zza(Object obj, long j) {
        zzdg zzdgVarZzd = zzd(obj, j);
        if (zzdgVarZzd.zzbr()) {
            return zzdgVarZzd;
        }
        int size = zzdgVarZzd.size();
        zzdg zzdgVarZzj = zzdgVarZzd.zzj(size == 0 ? 10 : size << 1);
        zzfv.zza(obj, j, zzdgVarZzj);
        return zzdgVarZzj;
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v1 */
    /* JADX WARN: Type inference failed for: r0v2, types: [com.google.android.gms.internal.firebase_auth.zzdg] */
    /* JADX WARN: Type inference failed for: r0v4 */
    /* JADX WARN: Type inference failed for: r0v5 */
    /* JADX WARN: Type inference failed for: r0v6 */
    /* JADX WARN: Type inference failed for: r0v7 */
    /* JADX WARN: Type inference failed for: r0v8 */
    /* JADX WARN: Type inference failed for: r6v1, types: [com.google.android.gms.internal.firebase_auth.zzdg, java.util.Collection] */
    /* JADX WARN: Type inference failed for: r6v2, types: [java.lang.Object] */
    /* JADX WARN: Type inference failed for: r6v3 */
    @Override // com.google.android.gms.internal.firebase_auth.zzdr
    final <E> void zza(Object obj, Object obj2, long j) {
        zzdg zzdgVarZzd = zzd(obj, j);
        ?? Zzd = zzd(obj2, j);
        int size = zzdgVarZzd.size();
        int size2 = Zzd.size();
        ?? r0 = zzdgVarZzd;
        r0 = zzdgVarZzd;
        if (size > 0 && size2 > 0) {
            boolean zZzbr = zzdgVarZzd.zzbr();
            ?? Zzj = zzdgVarZzd;
            if (!zZzbr) {
                Zzj = zzdgVarZzd.zzj(size2 + size);
            }
            Zzj.addAll(Zzd);
            r0 = Zzj;
        }
        if (size > 0) {
            Zzd = r0;
        }
        zzfv.zza(obj, j, (Object) Zzd);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdr
    final void zzb(Object obj, long j) {
        zzd(obj, j).zzbs();
    }
}
