package com.google.firebase.auth.api.internal;

import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.auth.PhoneAuthProvider;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzca extends zzcy<Void, PhoneAuthProvider.OnVerificationStateChangedCallbacks> {
    private final com.google.android.gms.internal.firebase_auth.zzax zzhg;

    public zzca(com.google.android.gms.internal.firebase_auth.zzax zzaxVar) {
        super(8);
        this.zzhg = (com.google.android.gms.internal.firebase_auth.zzax) Preconditions.checkNotNull(zzaxVar);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zza(this.zzhg, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
    }
}
