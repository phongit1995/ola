package com.google.firebase.auth.api.internal;

import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzbm extends zzcy<Void, com.google.firebase.auth.internal.zza> {
    private String zzhc;

    public zzbm(String str) {
        super(9);
        this.zzhc = str;
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzaa() {
        this.zzid.zzk(this.zzhc, this.zzib);
    }

    @Override // com.google.firebase.auth.api.internal.zzcy
    public final void zzab() {
        zzb(null);
    }
}
