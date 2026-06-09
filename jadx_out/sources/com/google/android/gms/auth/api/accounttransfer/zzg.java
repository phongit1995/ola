package com.google.android.gms.auth.api.accounttransfer;

import com.google.android.gms.auth.api.accounttransfer.AccountTransferClient;
import com.google.android.gms.internal.auth.zzac;
import com.google.android.gms.internal.auth.zzai;

/* JADX INFO: loaded from: classes.dex */
final class zzg extends AccountTransferClient.zzf {
    private final /* synthetic */ zzai zzaz;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzg(AccountTransferClient accountTransferClient, zzai zzaiVar) {
        super(null);
        this.zzaz = zzaiVar;
    }

    @Override // com.google.android.gms.auth.api.accounttransfer.AccountTransferClient.zze
    protected final void zzd(zzac zzacVar) {
        zzacVar.zzd(this.zzbi, this.zzaz);
    }
}
