package com.google.android.gms.auth.api.accounttransfer;

import com.google.android.gms.auth.api.accounttransfer.AccountTransferClient;

/* JADX INFO: loaded from: classes.dex */
final class zzk extends AccountTransferClient.zzd<DeviceMetaData> {
    private final /* synthetic */ zzj zzbd;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzk(zzj zzjVar, AccountTransferClient.zze zzeVar) {
        super(zzeVar);
        this.zzbd = zzjVar;
    }

    @Override // com.google.android.gms.internal.auth.zzv, com.google.android.gms.internal.auth.zzaa
    public final void zzd(DeviceMetaData deviceMetaData) {
        this.zzbd.setResult(deviceMetaData);
    }
}
