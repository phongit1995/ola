package com.google.android.gms.auth.api.accounttransfer;

import com.google.android.gms.auth.api.accounttransfer.AccountTransferClient;
import com.google.android.gms.internal.auth.zzac;
import com.google.android.gms.internal.auth.zzae;

/* JADX INFO: loaded from: classes.dex */
final class zzm extends AccountTransferClient.zzf {
    private final /* synthetic */ zzae zzbf;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzm(AccountTransferClient accountTransferClient, zzae zzaeVar) {
        super(null);
        this.zzbf = zzaeVar;
    }

    @Override // com.google.android.gms.auth.api.accounttransfer.AccountTransferClient.zze
    protected final void zzd(zzac zzacVar) {
        zzacVar.zzd(this.zzbi, this.zzbf);
    }
}
