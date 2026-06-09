package com.google.firebase.auth;

import com.google.firebase.FirebaseApp;
import com.google.firebase.components.ComponentContainer;
import com.google.firebase.components.ComponentFactory;

/* JADX INFO: loaded from: classes2.dex */
final /* synthetic */ class zzp implements ComponentFactory {
    static final ComponentFactory zzet = new zzp();

    private zzp() {
    }

    @Override // com.google.firebase.components.ComponentFactory
    public final Object create(ComponentContainer componentContainer) {
        FirebaseApp firebaseApp = (FirebaseApp) componentContainer.get(FirebaseApp.class);
        com.google.firebase.auth.internal.zzj zzjVar = new com.google.firebase.auth.internal.zzj(firebaseApp);
        firebaseApp.setTokenProvider(zzjVar);
        return zzjVar;
    }
}
