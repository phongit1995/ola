package com.google.android.gms.auth.api.accounttransfer;

import com.google.android.gms.auth.api.accounttransfer.AccountTransferClient;
import com.google.android.gms.internal.auth.zzac;
import com.google.android.gms.internal.auth.zzak;

/* JADX INFO: loaded from: classes.dex */
final class zzl extends AccountTransferClient.zzf {
    private final /* synthetic */ zzak zzbe;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzl(AccountTransferClient accountTransferClient, zzak zzakVar) {
        super(null);
        this.zzbe = zzakVar;
    }

    @Override // com.google.android.gms.auth.api.accounttransfer.AccountTransferClient.zze
    protected final void zzd(zzac zzacVar) {
        zzacVar.zzd(this.zzbi, this.zzbe);
    }
}
