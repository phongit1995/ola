package com.google.android.gms.auth;

import android.accounts.Account;
import android.os.Bundle;
import android.os.IBinder;

/* JADX INFO: loaded from: classes.dex */
final class zzk implements zzm<Bundle> {
    private final /* synthetic */ Account zzr;

    zzk(Account account) {
        this.zzr = account;
    }

    @Override // com.google.android.gms.auth.zzm
    public final /* synthetic */ Bundle zze(IBinder iBinder) {
        return (Bundle) zzg.zzd(com.google.android.gms.internal.auth.zzi.zzd(iBinder).zzd(this.zzr));
    }
}
