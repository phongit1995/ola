package com.google.android.gms.auth.api.accounttransfer;

import com.google.android.gms.auth.api.accounttransfer.AccountTransferClient;
import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
final class zzn extends com.google.android.gms.internal.auth.zzv {
    private final /* synthetic */ AccountTransferClient.zzf zzbj;

    zzn(AccountTransferClient.zzf zzfVar) {
        this.zzbj = zzfVar;
    }

    @Override // com.google.android.gms.internal.auth.zzv, com.google.android.gms.internal.auth.zzaa
    public final void onFailure(Status status) {
        this.zzbj.zzd(status);
    }

    @Override // com.google.android.gms.internal.auth.zzv, com.google.android.gms.internal.auth.zzaa
    public final void zzi() {
        this.zzbj.setResult(null);
    }
}
