package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
final class zzfr extends zzfp<zzfq, zzfq> {
    zzfr() {
    }

    private static void zza(Object obj, zzfq zzfqVar) {
        ((zzdb) obj).zzqx = zzfqVar;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ void zza(zzfq zzfqVar, int i, long j) {
        zzfqVar.zzb(i << 3, Long.valueOf(j));
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ void zza(zzfq zzfqVar, int i, zzbu zzbuVar) {
        zzfqVar.zzb((i << 3) | 2, zzbuVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ void zza(zzfq zzfqVar, int i, zzfq zzfqVar2) {
        zzfqVar.zzb((i << 3) | 3, zzfqVar2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ void zza(zzfq zzfqVar, zzgj zzgjVar) {
        zzfqVar.zzb(zzgjVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final boolean zza(zzeu zzeuVar) {
        return false;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ void zzb(zzfq zzfqVar, int i, long j) {
        zzfqVar.zzb((i << 3) | 1, Long.valueOf(j));
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ void zzc(zzfq zzfqVar, int i, int i2) {
        zzfqVar.zzb((i << 3) | 5, Integer.valueOf(i2));
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ void zzc(zzfq zzfqVar, zzgj zzgjVar) {
        zzfqVar.zza(zzgjVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final void zze(Object obj) {
        ((zzdb) obj).zzqx.zzbs();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ void zze(Object obj, zzfq zzfqVar) {
        zza(obj, zzfqVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ void zzf(Object obj, zzfq zzfqVar) {
        zza(obj, zzfqVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ zzfq zzfy() {
        return zzfq.zzga();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ zzfq zzg(zzfq zzfqVar, zzfq zzfqVar2) {
        zzfq zzfqVar3 = zzfqVar;
        zzfq zzfqVar4 = zzfqVar2;
        return zzfqVar4.equals(zzfq.zzfz()) ? zzfqVar3 : zzfq.zza(zzfqVar3, zzfqVar4);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ zzfq zzl(zzfq zzfqVar) {
        zzfq zzfqVar2 = zzfqVar;
        zzfqVar2.zzbs();
        return zzfqVar2;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ int zzo(zzfq zzfqVar) {
        return zzfqVar.zzdq();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ zzfq zzr(Object obj) {
        return ((zzdb) obj).zzqx;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ zzfq zzs(Object obj) {
        zzfq zzfqVar = ((zzdb) obj).zzqx;
        if (zzfqVar != zzfq.zzfz()) {
            return zzfqVar;
        }
        zzfq zzfqVarZzga = zzfq.zzga();
        zza(obj, zzfqVarZzga);
        return zzfqVarZzga;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzfp
    final /* synthetic */ int zzt(zzfq zzfqVar) {
        return zzfqVar.zzgb();
    }
}
