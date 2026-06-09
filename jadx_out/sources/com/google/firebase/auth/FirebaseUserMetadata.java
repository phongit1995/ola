package com.google.firebase.auth;

import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes2.dex */
public interface FirebaseUserMetadata extends SafeParcelable {
    long getCreationTimestamp();

    long getLastSignInTimestamp();
}
