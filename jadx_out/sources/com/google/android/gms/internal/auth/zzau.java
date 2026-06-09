package com.google.android.gms.internal.auth;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;

/* JADX INFO: loaded from: classes.dex */
final class zzau extends zzam {
    private BaseImplementation.ResultHolder<Status> zzdu;

    zzau(BaseImplementation.ResultHolder<Status> resultHolder) {
        this.zzdu = resultHolder;
    }

    @Override // com.google.android.gms.internal.auth.zzam, com.google.android.gms.internal.auth.zzba
    public final void zze(Status status) {
        this.zzdu.setResult(status);
    }
}
