package com.google.firebase.auth;

import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes2.dex */
final class zzo implements com.google.firebase.auth.internal.zzv {
    private final /* synthetic */ FirebaseAuth zzeo;
    private final /* synthetic */ FirebaseUser zzes;

    zzo(FirebaseAuth firebaseAuth, FirebaseUser firebaseUser) {
        this.zzeo = firebaseAuth;
        this.zzes = firebaseUser;
    }

    @Override // com.google.firebase.auth.internal.zzw
    public final void zza(Status status) {
        if (status.getStatusCode() == 17011 || status.getStatusCode() == 17021 || status.getStatusCode() == 17005) {
            this.zzeo.signOut();
        }
    }

    @Override // com.google.firebase.auth.internal.zzv
    public final void zzm() {
        if (this.zzeo.zzeg.getUid().equalsIgnoreCase(this.zzes.getUid())) {
            this.zzeo.zzk();
        }
    }
}
