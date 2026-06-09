package com.google.firebase.auth.internal;

import com.google.firebase.auth.SignInMethodQueryResult;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public final class zzr implements SignInMethodQueryResult {
    private final List<String> zzjh;

    public zzr(List<String> list) {
        this.zzjh = list;
    }

    @Override // com.google.firebase.auth.SignInMethodQueryResult
    public final List<String> getSignInMethods() {
        return this.zzjh;
    }
}
