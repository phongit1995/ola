package com.google.firebase.auth.api.internal;

import com.google.firebase.auth.PhoneAuthProvider;

/* JADX INFO: loaded from: classes2.dex */
final class zzdc implements zzdh {
    private final /* synthetic */ String zzix;

    zzdc(zzdb zzdbVar, String str) {
        this.zzix = str;
    }

    @Override // com.google.firebase.auth.api.internal.zzdh
    public final void zza(PhoneAuthProvider.OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks, Object... objArr) {
        onVerificationStateChangedCallbacks.onCodeSent(this.zzix, PhoneAuthProvider.ForceResendingToken.zzs());
    }
}
