package com.google.android.gms.auth.api.accounttransfer;

import com.google.android.gms.auth.api.accounttransfer.AccountTransferClient;

/* JADX INFO: loaded from: classes.dex */
final class zzi extends AccountTransferClient.zzd<byte[]> {
    private final /* synthetic */ zzh zzbb;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzi(zzh zzhVar, AccountTransferClient.zze zzeVar) {
        super(zzeVar);
        this.zzbb = zzhVar;
    }

    @Override // com.google.android.gms.internal.auth.zzv, com.google.android.gms.internal.auth.zzaa
    public final void zzd(byte[] bArr) {
        this.zzbb.setResult(bArr);
    }
}
