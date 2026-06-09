package com.google.firebase.auth;

import android.support.annotation.NonNull;
import com.google.android.gms.tasks.Continuation;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes2.dex */
final class zzr implements Continuation<GetTokenResult, Task<Void>> {
    private final /* synthetic */ FirebaseUser zzew;
    private final /* synthetic */ ActionCodeSettings zzex;

    zzr(FirebaseUser firebaseUser, ActionCodeSettings actionCodeSettings) {
        this.zzew = firebaseUser;
        this.zzex = actionCodeSettings;
    }

    @Override // com.google.android.gms.tasks.Continuation
    public final /* synthetic */ Task<Void> then(@NonNull Task<GetTokenResult> task) {
        return FirebaseAuth.getInstance(this.zzew.zzo()).zza(this.zzex, task.getResult().getToken());
    }
}
