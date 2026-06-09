package com.google.firebase.auth;

import com.google.firebase.auth.FirebaseAuth;

/* JADX INFO: loaded from: classes2.dex */
final class zzj implements Runnable {
    private final /* synthetic */ FirebaseAuth zzeo;
    private final /* synthetic */ FirebaseAuth.AuthStateListener zzep;

    zzj(FirebaseAuth firebaseAuth, FirebaseAuth.AuthStateListener authStateListener) {
        this.zzeo = firebaseAuth;
        this.zzep = authStateListener;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzep.onAuthStateChanged(this.zzeo);
    }
}
