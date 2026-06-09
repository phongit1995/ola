package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.firebase.auth.UserProfileChangeRequest;

/* JADX INFO: loaded from: classes2.dex */
final class zzac implements zzdk<com.google.android.gms.internal.firebase_auth.zzao> {
    private final /* synthetic */ zzcb zzfl;
    private final /* synthetic */ zza zzfm;
    private final /* synthetic */ UserProfileChangeRequest zzgh;

    zzac(zza zzaVar, UserProfileChangeRequest userProfileChangeRequest, zzcb zzcbVar) {
        this.zzfm = zzaVar;
        this.zzgh = userProfileChangeRequest;
        this.zzfl = zzcbVar;
    }

    @Override // com.google.firebase.auth.api.internal.zzdk
    public final /* synthetic */ void onSuccess(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar) {
        com.google.android.gms.internal.firebase_auth.zzao zzaoVar2 = zzaoVar;
        com.google.android.gms.internal.firebase_auth.zzaz zzazVar = new com.google.android.gms.internal.firebase_auth.zzaz();
        zzazVar.zzv(zzaoVar2.zzaw());
        if (this.zzgh.zzu() || this.zzgh.getDisplayName() != null) {
            zzazVar.zzy(this.zzgh.getDisplayName());
        }
        if (this.zzgh.zzv() || this.zzgh.getPhotoUri() != null) {
            zzazVar.zzz(this.zzgh.zzt());
        }
        this.zzfm.zza(this.zzfl, zzaoVar2, zzazVar, this);
    }

    @Override // com.google.firebase.auth.api.internal.zzdj
    public final void zzc(@Nullable String str) {
        this.zzfl.onFailure(com.google.firebase.auth.internal.zzq.zzaf(str));
    }
}
