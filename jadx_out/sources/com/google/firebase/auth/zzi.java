package com.google.firebase.auth;

import com.google.firebase.auth.FirebaseAuth;

/* JADX INFO: loaded from: classes2.dex */
final class zzi implements Runnable {
    private final /* synthetic */ FirebaseAuth.IdTokenListener zzen;
    private final /* synthetic */ FirebaseAuth zzeo;

    zzi(FirebaseAuth firebaseAuth, FirebaseAuth.IdTokenListener idTokenListener) {
        this.zzeo = firebaseAuth;
        this.zzen = idTokenListener;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzen.onIdTokenChanged(this.zzeo);
    }
}
