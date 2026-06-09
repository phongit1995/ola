package com.google.firebase.auth;

import android.support.annotation.NonNull;
import com.google.android.gms.tasks.Continuation;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes2.dex */
final class zzq implements Continuation<GetTokenResult, Task<Void>> {
    private final /* synthetic */ FirebaseUser zzew;

    zzq(FirebaseUser firebaseUser) {
        this.zzew = firebaseUser;
    }

    @Override // com.google.android.gms.tasks.Continuation
    public final /* synthetic */ Task<Void> then(@NonNull Task<GetTokenResult> task) {
        return FirebaseAuth.getInstance(this.zzew.zzo()).zza((ActionCodeSettings) null, task.getResult().getToken());
    }
}
