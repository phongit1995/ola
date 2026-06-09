package com.google.firebase.auth.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.GetTokenResult;
import com.google.firebase.internal.InternalTokenProvider;

/* JADX INFO: loaded from: classes2.dex */
@KeepForSdk
public interface InternalAuthProvider extends InternalTokenProvider {
    @KeepForSdk
    void addIdTokenListener(@NonNull IdTokenListener idTokenListener);

    @Override // com.google.firebase.internal.InternalTokenProvider
    @KeepForSdk
    Task<GetTokenResult> getAccessToken(boolean z);

    @Override // com.google.firebase.internal.InternalTokenProvider
    @KeepForSdk
    @Nullable
    String getUid();

    @KeepForSdk
    void removeIdTokenListener(@NonNull IdTokenListener idTokenListener);
}
