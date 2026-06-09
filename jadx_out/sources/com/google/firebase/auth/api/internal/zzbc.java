package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.FirebaseError;
import com.google.firebase.auth.AuthCredential;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzbc extends zzcy<Void, com.google.firebase.auth.internal.zza> {

    @NonNull
    private final com.google.android.gms.internal.firebase_auth.zzbf zzgw;

    public zzbc(@NonNull AuthCredential authCredential) {
        super(2);
        Preconditions.checkNotNull(authCredential, "credential cannot be null");
        this.zzgw = com.google.firebase.auth.internal.zzb.zza(authCredential).zzd(false);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zza(this.zzgw, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        com.google.firebase.auth.internal.zzl zzlVarZza = zzao.zza(this.zzeb, this.zzim);
        if (!this.zzic.getUid().equalsIgnoreCase(zzlVarZza.getUid())) {
            zzc(new Status(FirebaseError.ERROR_USER_MISMATCH));
        } else {
            ((com.google.firebase.auth.internal.zza) this.zzie).zza(this.zzil, zzlVarZza);
            zzb(null);
        }
    }
}
