package com.google.firebase.auth;

import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;

/* JADX INFO: loaded from: classes2.dex */
public abstract class AuthCredential extends AbstractSafeParcelable {
    AuthCredential() {
    }

    public abstract String getProvider();

    public abstract String getSignInMethod();
}
