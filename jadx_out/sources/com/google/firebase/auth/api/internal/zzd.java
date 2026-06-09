package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
final class zzd implements zzdk<com.google.android.gms.internal.firebase_auth.zzbm> {
    private final /* synthetic */ zzcb zzfl;
    private final /* synthetic */ zza zzfm;

    zzd(zza zzaVar, zzcb zzcbVar) {
        this.zzfm = zzaVar;
        this.zzfl = zzcbVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzbm zzbmVar) {
        com.google.android.gms.internal.firebase_auth.zzbm zzbmVar2 = zzbmVar;
        this.zzfm.zza(new com.google.android.gms.internal.firebase_auth.zzao(zzbmVar2.zzap(), zzbmVar2.getIdToken(), Long.valueOf(zzbmVar2.zzaq()), "Bearer"), null, null, false, null, this.zzfl, this);
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}
