package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
final class zzq implements zzdk<com.google.android.gms.internal.firebase_auth.zzao> {
    final /* synthetic */ zzcb zzfl;
    final /* synthetic */ zza zzfm;
    private final /* synthetic */ com.google.android.gms.internal.firebase_auth.zzbf zzfz;

    zzq(zza zzaVar, com.google.android.gms.internal.firebase_auth.zzbf zzbfVar, zzcb zzcbVar) {
        this.zzfm = zzaVar;
        this.zzfz = zzbfVar;
        this.zzfl = zzcbVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        this.zzfz.zzac(zzaoVar.zzaw());
        this.zzfm.zzfk.zza(this.zzfz, new zzr(this, this));
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}
