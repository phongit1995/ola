package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.api.Status;
import com.google.firebase.FirebaseError;

/* JADX INFO: loaded from: classes2.dex */
final class zzr implements zzdk<com.google.android.gms.internal.firebase_auth.zzbh> {
    private final /* synthetic */ zzdk zzga;
    private final /* synthetic */ zzq zzgb;

    zzr(zzq zzqVar, zzdk zzdkVar) {
        this.zzgb = zzqVar;
        this.zzga = zzdkVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzbh zzbhVar) {
        com.google.android.gms.internal.firebase_auth.zzbh zzbhVar2 = zzbhVar;
        if (zzbhVar2.zzbe()) {
            this.zzgb.zzfl.onFailure(new Status(FirebaseError.ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL));
        } else {
            this.zzgb.zzfm.zza(new com.google.android.gms.internal.firebase_auth.zzao(zzbhVar2.zzap(), zzbhVar2.getIdToken(), Long.valueOf(zzbhVar2.zzaq()), "Bearer"), zzbhVar2.getRawUserInfo(), zzbhVar2.getProviderId(), Boolean.valueOf(zzbhVar2.isNewUser()), zzbhVar2.zzav(), this.zzgb.zzfl, this.zzga);
        }
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzga.zzc(str);
    }
}
