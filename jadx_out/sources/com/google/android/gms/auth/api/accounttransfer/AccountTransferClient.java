package com.google.android.gms.auth.api.accounttransfer;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Context;
import android.support.annotation.NonNull;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApi;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.ApiExceptionMapper;
import com.google.android.gms.common.api.internal.TaskApiCall;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.internal.auth.zzab;
import com.google.android.gms.internal.auth.zzac;
import com.google.android.gms.internal.auth.zzae;
import com.google.android.gms.internal.auth.zzag;
import com.google.android.gms.internal.auth.zzai;
import com.google.android.gms.internal.auth.zzak;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
public class AccountTransferClient extends GoogleApi<zzq> {
    private static final Api.ClientKey<com.google.android.gms.internal.auth.zzx> zzau = new Api.ClientKey<>();
    private static final Api.AbstractClientBuilder<com.google.android.gms.internal.auth.zzx, zzq> zzav = new com.google.android.gms.auth.api.accounttransfer.zzf();
    private static final Api<zzq> zzaw = new Api<>("AccountTransfer.ACCOUNT_TRANSFER_API", zzav, zzau);

    /* JADX INFO: Access modifiers changed from: private */
    static class zzd<T> extends com.google.android.gms.internal.auth.zzv {
        private zze<T> zzbg;

        public zzd(zze<T> zzeVar) {
            this.zzbg = zzeVar;
        }

        @Override // com.google.android.gms.internal.auth.zzv, com.google.android.gms.internal.auth.zzaa
        public final void onFailure(Status status) {
            this.zzbg.zzd(status);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static abstract class zze<T> extends TaskApiCall<com.google.android.gms.internal.auth.zzx, T> {
        private TaskCompletionSource<T> zzbh;

        private zze() {
        }

        /* synthetic */ zze(com.google.android.gms.auth.api.accounttransfer.zzf zzfVar) {
            this();
        }

        @Override // com.google.android.gms.common.api.internal.TaskApiCall
        protected /* synthetic */ void doExecute(Api.AnyClient anyClient, TaskCompletionSource taskCompletionSource) {
            this.zzbh = taskCompletionSource;
            zzd((zzac) ((com.google.android.gms.internal.auth.zzx) anyClient).getService());
        }

        protected final void setResult(T t) {
            this.zzbh.setResult(t);
        }

        protected final void zzd(Status status) {
            AccountTransferClient.zzd(this.zzbh, status);
        }

        protected abstract void zzd(zzac zzacVar);
    }

    /* JADX INFO: Access modifiers changed from: private */
    static abstract class zzf extends zze<Void> {
        zzab zzbi;

        private zzf() {
            super(null);
            this.zzbi = new zzn(this);
        }

        /* synthetic */ zzf(com.google.android.gms.auth.api.accounttransfer.zzf zzfVar) {
            this();
        }
    }

    AccountTransferClient(@NonNull Activity activity) {
        super(activity, (Api<Api.ApiOptions>) zzaw, (Api.ApiOptions) null, new GoogleApi.Settings.Builder().setMapper(new ApiExceptionMapper()).build());
    }

    AccountTransferClient(@NonNull Context context) {
        super(context, zzaw, (Api.ApiOptions) null, new GoogleApi.Settings.Builder().setMapper(new ApiExceptionMapper()).build());
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void zzd(TaskCompletionSource taskCompletionSource, Status status) {
        taskCompletionSource.setException(new AccountTransferException(status));
    }

    public Task<DeviceMetaData> getDeviceMetaData(String str) {
        Preconditions.checkNotNull(str);
        return doRead(new zzj(this, new com.google.android.gms.internal.auth.zzy(str)));
    }

    public Task<Void> notifyCompletion(String str, int i) {
        Preconditions.checkNotNull(str);
        return doWrite(new zzm(this, new zzae(str, i)));
    }

    public Task<byte[]> retrieveData(String str) {
        Preconditions.checkNotNull(str);
        return doRead(new zzh(this, new zzag(str)));
    }

    public Task<Void> sendData(String str, byte[] bArr) {
        Preconditions.checkNotNull(str);
        Preconditions.checkNotNull(bArr);
        return doWrite(new zzg(this, new zzai(str, bArr)));
    }

    public Task<Void> showUserChallenge(String str, PendingIntent pendingIntent) {
        Preconditions.checkNotNull(str);
        Preconditions.checkNotNull(pendingIntent);
        return doWrite(new zzl(this, new zzak(str, pendingIntent)));
    }
}
