package com.google.firebase.auth;

import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes2.dex */
public interface AuthResult extends SafeParcelable {
    AdditionalUserInfo getAdditionalUserInfo();

    FirebaseUser getUser();
}
