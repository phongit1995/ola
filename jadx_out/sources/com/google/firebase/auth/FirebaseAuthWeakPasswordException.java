package com.google.firebase.auth;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
public final class FirebaseAuthWeakPasswordException extends FirebaseAuthInvalidCredentialsException {
    private final String zzev;

    public FirebaseAuthWeakPasswordException(@NonNull String str, @NonNull String str2, @Nullable String str3) {
        super(str, str2);
        this.zzev = str3;
    }

    @Nullable
    public final String getReason() {
        return this.zzev;
    }
}
