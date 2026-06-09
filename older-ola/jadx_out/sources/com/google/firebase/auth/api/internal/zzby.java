package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.auth.UserProfileChangeRequest;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzby extends zzcy<Void, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final UserProfileChangeRequest zzhf;

    public zzby(UserProfileChangeRequest userProfileChangeRequest) {
        super(2);
        this.zzhf = (UserProfileChangeRequest) Preconditions.checkNotNull(userProfileChangeRequest, "request cannot be null");
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zza(this.zzic.zzq(), this.zzhf, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        ((com.google.firebase.auth.internal.zza) this.zzie).zza(this.zzil, zzao.zza(this.zzeb, this.zzim));
        zzb(null);
    }
}
