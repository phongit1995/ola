package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
final class zzw implements zzdk<com.google.android.gms.internal.firebase_auth.zzah> {
    private final /* synthetic */ zzdk zzga;
    private final /* synthetic */ com.google.android.gms.internal.firebase_auth.zzao zzgd;
    private final /* synthetic */ zzv zzgf;

    zzw(zzv zzvVar, zzdk zzdkVar, com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        this.zzgf = zzvVar;
        this.zzga = zzdkVar;
        this.zzgd = zzaoVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzah zzahVar) {
        List<com.google.android.gms.internal.firebase_auth.zzaj> listZzas = zzahVar.zzas();
        if (listZzas == null || listZzas.isEmpty()) {
            this.zzga.zzc("No users");
        } else {
            this.zzgf.zzfl.zza(this.zzgd, listZzas.get(0));
        }
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzga.zzc(str);
    }
}
