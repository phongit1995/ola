package com.google.android.gms.internal.ads;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
final class zzbch extends zzbce {
    private zzbch() {
        super();
    }

    private static <E> zzbbt<E> zzd(Object obj, long j) {
        return (zzbbt) zzbek.zzp(obj, j);
    }

    @Override // com.google.android.gms.internal.ads.zzbce
    final <L> List<L> zza(Object obj, long j) {
        zzbbt zzbbtVarZzd = zzd(obj, j);
        if (zzbbtVarZzd.zzaay()) {
            return zzbbtVarZzd;
        }
        int size = zzbbtVarZzd.size();
        zzbbt zzbbtVarZzbm = zzbbtVarZzd.zzbm(size == 0 ? 10 : size << 1);
        zzbek.zza(obj, j, zzbbtVarZzbm);
        return zzbbtVarZzbm;
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v1 */
    /* JADX WARN: Type inference failed for: r0v2, types: [com.google.android.gms.internal.ads.zzbbt] */
    /* JADX WARN: Type inference failed for: r0v4 */
    /* JADX WARN: Type inference failed for: r0v5 */
    /* JADX WARN: Type inference failed for: r0v6 */
    /* JADX WARN: Type inference failed for: r0v7 */
    /* JADX WARN: Type inference failed for: r0v8 */
    /* JADX WARN: Type inference failed for: r6v1, types: [com.google.android.gms.internal.ads.zzbbt, java.util.Collection] */
    /* JADX WARN: Type inference failed for: r6v2, types: [java.lang.Object] */
    /* JADX WARN: Type inference failed for: r6v3 */
    @Override // com.google.android.gms.internal.ads.zzbce
    final <E> void zza(Object obj, Object obj2, long j) {
        zzbbt zzbbtVarZzd = zzd(obj, j);
        ?? Zzd = zzd(obj2, j);
        int size = zzbbtVarZzd.size();
        int size2 = Zzd.size();
        ?? r0 = zzbbtVarZzd;
        r0 = zzbbtVarZzd;
        if (size > 0 && size2 > 0) {
            boolean zZzaay = zzbbtVarZzd.zzaay();
            ?? Zzbm = zzbbtVarZzd;
            if (!zZzaay) {
                Zzbm = zzbbtVarZzd.zzbm(size2 + size);
            }
            Zzbm.addAll(Zzd);
            r0 = Zzbm;
        }
        if (size > 0) {
            Zzd = r0;
        }
        zzbek.zza(obj, j, (Object) Zzd);
    }

    @Override // com.google.android.gms.internal.ads.zzbce
    final void zzb(Object obj, long j) {
        zzd(obj, j).zzaaz();
    }
}
