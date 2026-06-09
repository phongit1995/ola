package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.auth.ActionCodeSettings;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzbk extends zzcy<Void, com.google.firebase.auth.internal.zza> {

    @NonNull
    private String zzdh;

    @Nullable
    private ActionCodeSettings zzhb;

    public zzbk(@NonNull String str, @Nullable ActionCodeSettings actionCodeSettings) {
        super(6);
        this.zzdh = Preconditions.checkNotEmpty(str, "token cannot be null or empty");
        this.zzhb = actionCodeSettings;
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zzb(this.zzdh, this.zzhb, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        zzb(null);
    }
}
