package com.google.firebase.auth.api.internal;

import com.google.android.gms.common.api.Status;
import com.google.firebase.auth.PhoneAuthProvider;

/* JADX INFO: loaded from: classes2.dex */
final class zzdf implements zzdh {
    private final /* synthetic */ Status zziz;

    zzdf(zzdb zzdbVar, Status status) {
        this.zziz = status;
    }

    @Override // com.google.firebase.auth.api.internal.zzdh
    public final void zza(PhoneAuthProvider.OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks, Object... objArr) {
        onVerificationStateChangedCallbacks.onVerificationFailed(zzce.zzb(this.zziz));
    }
}
