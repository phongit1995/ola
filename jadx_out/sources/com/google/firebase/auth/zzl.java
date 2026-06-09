package com.google.firebase.auth;

import com.google.firebase.auth.FirebaseAuth;
import java.util.Iterator;

/* JADX INFO: loaded from: classes2.dex */
final class zzl implements Runnable {
    private final /* synthetic */ FirebaseAuth zzeo;

    zzl(FirebaseAuth firebaseAuth) {
        this.zzeo = firebaseAuth;
    }

    @Override // java.lang.Runnable
    public final void run() {
        Iterator it2 = this.zzeo.zzee.iterator();
        while (it2.hasNext()) {
            ((FirebaseAuth.AuthStateListener) it2.next()).onAuthStateChanged(this.zzeo);
        }
    }
}
