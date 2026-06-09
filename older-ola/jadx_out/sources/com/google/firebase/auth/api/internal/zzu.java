package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
final class zzu implements zzdk<com.google.android.gms.internal.firebase_auth.zzah> {
    private final /* synthetic */ zzdk zzga;
    private final /* synthetic */ com.google.android.gms.internal.firebase_auth.zzao zzgd;
    private final /* synthetic */ zzt zzge;

    zzu(zzt zztVar, zzdk zzdkVar, com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        this.zzge = zztVar;
        this.zzga = zzdkVar;
        this.zzgd = zzaoVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzah zzahVar) {
        List<com.google.android.gms.internal.firebase_auth.zzaj> listZzas = zzahVar.zzas();
        if (listZzas == null || listZzas.isEmpty()) {
            this.zzga.zzc("No users.");
            return;
        }
        com.google.android.gms.internal.firebase_auth.zzaj zzajVar = listZzas.get(0);
        com.google.android.gms.internal.firebase_auth.zzaz zzazVar = new com.google.android.gms.internal.firebase_auth.zzaz();
        zzazVar.zzv(this.zzgd.zzaw()).zzaa(this.zzge.zzgc);
        this.zzge.zzfm.zza(this.zzge.zzfl, this.zzgd, zzajVar, zzazVar, this.zzga);
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzge.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}
