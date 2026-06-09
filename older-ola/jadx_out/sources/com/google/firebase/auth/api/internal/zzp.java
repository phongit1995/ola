package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
final class zzp implements zzdk<com.google.android.gms.internal.firebase_auth.zzao> {
    private final /* synthetic */ zzcb zzfl;
    private final /* synthetic */ zza zzfm;
    private final /* synthetic */ String zzfx;
    private final /* synthetic */ String zzfy;

    zzp(zza zzaVar, String str, String str2, zzcb zzcbVar) {
        this.zzfm = zzaVar;
        this.zzfx = str;
        this.zzfy = str2;
        this.zzfl = zzcbVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        com.google.android.gms.internal.firebase_auth.zzao zzaoVar2 = zzaoVar;
        com.google.android.gms.internal.firebase_auth.zzaz zzazVar = new com.google.android.gms.internal.firebase_auth.zzaz();
        zzazVar.zzv(zzaoVar2.zzaw()).zzw(this.zzfx).zzx(this.zzfy);
        this.zzfm.zza(this.zzfl, zzaoVar2, zzazVar, this);
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}
