package com.google.android.gms.auth.api.accounttransfer;

import com.google.android.gms.auth.api.accounttransfer.AccountTransferClient;
import com.google.android.gms.internal.auth.zzac;
import com.google.android.gms.internal.auth.zzag;

/* JADX INFO: loaded from: classes.dex */
final class zzh extends AccountTransferClient.zze<byte[]> {
    private final /* synthetic */ zzag zzba;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzh(AccountTransferClient accountTransferClient, zzag zzagVar) {
        super(null);
        this.zzba = zzagVar;
    }

    @Override // com.google.android.gms.auth.api.accounttransfer.AccountTransferClient.zze
    protected final void zzd(zzac zzacVar) {
        zzacVar.zzd(new zzi(this, this), this.zzba);
    }
}
