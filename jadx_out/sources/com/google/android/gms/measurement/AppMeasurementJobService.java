package com.google.android.gms.measurement;

import android.annotation.TargetApi;
import android.app.job.JobParameters;
import android.app.job.JobService;
import android.content.Intent;
import android.support.annotation.MainThread;
import com.google.android.gms.internal.measurement.zzje;
import com.google.android.gms.internal.measurement.zzji;

/* JADX INFO: loaded from: classes2.dex */
@TargetApi(24)
public final class AppMeasurementJobService extends JobService implements zzji {
    private zzje<AppMeasurementJobService> zzadd;

    private final zzje<AppMeasurementJobService> zzfq() {
        if (this.zzadd == null) {
            this.zzadd = new zzje<>(this);
        }
        return this.zzadd;
    }

    @Override // com.google.android.gms.internal.measurement.zzji
    public final boolean callServiceStopSelfResult(int i) {
        throw new UnsupportedOperationException();
    }

    @Override // android.app.Service
    @MainThread
    public final void onCreate() {
        super.onCreate();
        zzfq().onCreate();
    }

    @Override // android.app.Service
    @MainThread
    public final void onDestroy() {
        zzfq().onDestroy();
        super.onDestroy();
    }

    @Override // android.app.Service
    @MainThread
    public final void onRebind(Intent intent) {
        zzfq().onRebind(intent);
    }

    @Override // android.app.job.JobService
    public final boolean onStartJob(JobParameters jobParameters) {
        return zzfq().onStartJob(jobParameters);
    }

    @Override // android.app.job.JobService
    public final boolean onStopJob(JobParameters jobParameters) {
        return false;
    }

    @Override // android.app.Service
    @MainThread
    public final boolean onUnbind(Intent intent) {
        return zzfq().onUnbind(intent);
    }

    @Override // com.google.android.gms.internal.measurement.zzji
    @TargetApi(24)
    public final void zza(JobParameters jobParameters, boolean z) {
        jobFinished(jobParameters, false);
    }

    @Override // com.google.android.gms.internal.measurement.zzji
    public final void zzb(Intent intent) {
    }
}
