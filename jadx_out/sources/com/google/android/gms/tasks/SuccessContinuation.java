package com.google.android.gms.tasks;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes2.dex */
public interface SuccessContinuation<TResult, TContinuationResult> {
    @NonNull
    Task<TContinuationResult> then(@Nullable TResult tresult);
}
