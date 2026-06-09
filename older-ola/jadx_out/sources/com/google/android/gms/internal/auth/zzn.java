package com.google.android.gms.internal.auth;

import android.accounts.Account;
import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
final class zzn extends zzq {
    private final /* synthetic */ zzm zzah;

    zzn(zzm zzmVar) {
        this.zzah = zzmVar;
    }

    @Override // com.google.android.gms.internal.auth.zzq, com.google.android.gms.auth.account.zzd
    public final void zzf(Account account) {
        this.zzah.setResult(new zzr(account != null ? Status.RESULT_SUCCESS : zzk.zzaf, account));
    }
}
