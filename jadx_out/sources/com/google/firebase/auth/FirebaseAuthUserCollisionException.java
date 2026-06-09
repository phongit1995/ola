package com.google.firebase.auth;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
public final class FirebaseAuthUserCollisionException extends FirebaseAuthException {
    private AuthCredential zzeu;

    public FirebaseAuthUserCollisionException(@NonNull String str, @NonNull String str2) {
        super(str, str2);
        this.zzeu = null;
    }

    public FirebaseAuthUserCollisionException(@NonNull String str, @NonNull String str2, @NonNull AuthCredential authCredential) {
        super(str, str2);
        this.zzeu = authCredential;
    }

    @Nullable
    public final AuthCredential getUpdatedCredential() {
        return this.zzeu;
    }
}
