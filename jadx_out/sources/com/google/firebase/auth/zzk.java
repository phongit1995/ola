package com.google.firebase.auth;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.internal.IdTokenListener;
import com.google.firebase.internal.InternalTokenResult;
import java.util.Iterator;

/* JADX INFO: loaded from: classes2.dex */
final class zzk implements Runnable {
    private final /* synthetic */ FirebaseAuth zzeo;
    private final /* synthetic */ InternalTokenResult zzeq;

    zzk(FirebaseAuth firebaseAuth, InternalTokenResult internalTokenResult) {
        this.zzeo = firebaseAuth;
        this.zzeq = internalTokenResult;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzeo.zzeb.notifyIdTokenListeners(this.zzeq);
        Iterator it2 = this.zzeo.zzed.iterator();
        while (it2.hasNext()) {
            ((IdTokenListener) it2.next()).onIdTokenChanged(this.zzeq);
        }
        Iterator it3 = this.zzeo.zzec.iterator();
        while (it3.hasNext()) {
            ((FirebaseAuth.IdTokenListener) it3.next()).onIdTokenChanged(this.zzeo);
        }
    }
}
