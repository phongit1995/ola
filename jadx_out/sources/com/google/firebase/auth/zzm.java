package com.google.firebase.auth;

import android.support.annotation.NonNull;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.internal.firebase_auth.zzao;

/* JADX INFO: loaded from: classes2.dex */
final class zzm implements com.google.firebase.auth.internal.zza, com.google.firebase.auth.internal.zzw {
    private final /* synthetic */ FirebaseAuth zzeo;

    zzm(FirebaseAuth firebaseAuth) {
        this.zzeo = firebaseAuth;
    }

    @Override // com.google.firebase.auth.internal.zzw
    public final void zza(Status status) {
        int statusCode = status.getStatusCode();
        if (statusCode == 17011 || statusCode == 17021 || statusCode == 17005) {
            this.zzeo.signOut();
        }
    }

    @Override // com.google.firebase.auth.internal.zza
    public final void zza(@NonNull zzao zzaoVar, @NonNull FirebaseUser firebaseUser) {
        this.zzeo.zza(firebaseUser, zzaoVar, true);
    }
}
