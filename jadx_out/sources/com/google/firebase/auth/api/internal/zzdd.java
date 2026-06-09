package com.google.firebase.auth.api.internal;

import com.google.firebase.auth.PhoneAuthCredential;
import com.google.firebase.auth.PhoneAuthProvider;

/* JADX INFO: loaded from: classes2.dex */
final class zzdd implements zzdh {
    private final /* synthetic */ PhoneAuthCredential zziy;

    zzdd(zzdb zzdbVar, PhoneAuthCredential phoneAuthCredential) {
        this.zziy = phoneAuthCredential;
    }

    @Override // com.google.firebase.auth.api.internal.zzdh
    public final void zza(PhoneAuthProvider.OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks, Object... objArr) {
        onVerificationStateChangedCallbacks.onVerificationCompleted(this.zziy);
    }
}
