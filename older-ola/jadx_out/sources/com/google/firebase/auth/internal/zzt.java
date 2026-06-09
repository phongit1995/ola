package com.google.firebase.auth.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.tasks.Task;
import com.google.firebase.FirebaseApp;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.GetTokenResult;

/* JADX INFO: loaded from: classes2.dex */
final class zzt implements Runnable {
    private final String zzky;
    final /* synthetic */ zzs zzlm;

    zzt(zzs zzsVar, @NonNull String str) {
        this.zzlm = zzsVar;
        this.zzky = Preconditions.checkNotEmpty(str);
    }

    @Override // java.lang.Runnable
    public final void run() {
        FirebaseApp firebaseApp = FirebaseApp.getInstance(this.zzky);
        FirebaseAuth firebaseAuth = FirebaseAuth.getInstance(firebaseApp);
        zzx.initialize(firebaseApp.getApplicationContext());
        if (firebaseAuth.getCurrentUser() == null || !zzx.zzlq.get().booleanValue()) {
            return;
        }
        Task<GetTokenResult> accessToken = firebaseAuth.getAccessToken(true);
        zzs.zzdx.v("Token refreshing started", new Object[0]);
        accessToken.addOnFailureListener(new zzu(this));
    }
}
