package com.google.android.gms.auth.api.accounttransfer;

import com.google.android.gms.auth.api.accounttransfer.AccountTransferClient;
import com.google.android.gms.internal.auth.zzac;

/* JADX INFO: loaded from: classes.dex */
final class zzj extends AccountTransferClient.zze<DeviceMetaData> {
    private final /* synthetic */ com.google.android.gms.internal.auth.zzy zzbc;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzj(AccountTransferClient accountTransferClient, com.google.android.gms.internal.auth.zzy zzyVar) {
        super(null);
        this.zzbc = zzyVar;
    }

    @Override // com.google.android.gms.auth.api.accounttransfer.AccountTransferClient.zze
    protected final void zzd(zzac zzacVar) {
        zzacVar.zzd(new zzk(this, this), this.zzbc);
    }
}
