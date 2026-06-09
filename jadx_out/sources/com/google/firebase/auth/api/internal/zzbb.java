package com.google.firebase.auth.api.internal;

import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.tasks.TaskCompletionSource;
import com.google.firebase.auth.PhoneAuthCredential;

/* JADX INFO: loaded from: classes2.dex */
final class zzbb<ResultT, CallbackT> extends zzam<zzcc, ResultT> implements zzcx<ResultT> {
    private final String zzgy;
    private zzcy<ResultT, CallbackT> zzgz;
    private TaskCompletionSource<ResultT> zzha;

    public zzbb(zzcy<ResultT, CallbackT> zzcyVar, String str) {
        this.zzgz = zzcyVar;
        this.zzgz.zzig = this;
        this.zzgy = str;
    }

    @Override // com.google.android.gms.common.api.internal.TaskApiCall
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient, TaskCompletionSource taskCompletionSource) {
        this.zzha = taskCompletionSource;
        zzcy<ResultT, CallbackT> zzcyVar = this.zzgz;
        zzcyVar.zzid = ((zzcc) anyClient).zzaf();
        zzcyVar.zzaa();
    }

    @Override // com.google.firebase.auth.api.internal.zzcx
    public final void zza(ResultT resultt, Status status) {
        Preconditions.checkNotNull(this.zzha, "doExecute must be called before onComplete");
        if (status == null) {
            this.zzha.setResult(resultt);
        } else if (this.zzgz.zziq == null) {
            this.zzha.setException(zzce.zzb(status));
        } else {
            this.zzha.setException(zzce.zzb(status, (PhoneAuthCredential) this.zzgz.zziq.clone()));
            this.zzgz.zziq = null;
        }
    }

    @Override // com.google.firebase.auth.api.internal.zzam
    final String zzz() {
        return this.zzgy;
    }
}
