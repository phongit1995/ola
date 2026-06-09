package com.google.android.gms.internal.measurement;

import android.annotation.TargetApi;
import android.app.job.JobParameters;
import android.content.Context;
import android.content.Intent;
import android.os.IBinder;
import android.support.annotation.MainThread;
import com.facebook.internal.NativeProtocol;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.internal.measurement.zzji;

/* JADX INFO: loaded from: classes2.dex */
public final class zzje<T extends Context & zzji> {
    private final T zzabl;

    public zzje(T t) {
        Preconditions.checkNotNull(t);
        this.zzabl = t;
    }

    private final void zzb(Runnable runnable) {
        zzjt zzjtVarZzg = zzjt.zzg(this.zzabl);
        zzjtVarZzg.zzgh().zzc(new zzjh(this, zzjtVarZzg, runnable));
    }

    private final zzfi zzgi() {
        return zzgn.zza(this.zzabl, null, null).zzgi();
    }

    @MainThread
    public final IBinder onBind(Intent intent) {
        if (intent == null) {
            zzgi().zziv().log("onBind called with null intent");
            return null;
        }
        String action = intent.getAction();
        if ("com.google.android.gms.measurement.START".equals(action)) {
            return new zzgp(zzjt.zzg(this.zzabl));
        }
        zzgi().zziy().zzg("onBind received unknown action", action);
        return null;
    }

    @MainThread
    public final void onCreate() {
        zzgn zzgnVarZza = zzgn.zza(this.zzabl, null, null);
        zzfi zzfiVarZzgi = zzgnVarZza.zzgi();
        zzgnVarZza.zzgl();
        zzfiVarZzgi.zzjc().log("Local AppMeasurementService is starting up");
    }

    @MainThread
    public final void onDestroy() {
        zzgn zzgnVarZza = zzgn.zza(this.zzabl, null, null);
        zzfi zzfiVarZzgi = zzgnVarZza.zzgi();
        zzgnVarZza.zzgl();
        zzfiVarZzgi.zzjc().log("Local AppMeasurementService is shutting down");
    }

    @MainThread
    public final void onRebind(Intent intent) {
        if (intent == null) {
            zzgi().zziv().log("onRebind called with null intent");
        } else {
            zzgi().zzjc().zzg("onRebind called. action", intent.getAction());
        }
    }

    @MainThread
    public final int onStartCommand(final Intent intent, int i, final int i2) {
        zzgn zzgnVarZza = zzgn.zza(this.zzabl, null, null);
        final zzfi zzfiVarZzgi = zzgnVarZza.zzgi();
        if (intent == null) {
            zzfiVarZzgi.zziy().log("AppMeasurementService started with null intent");
            return 2;
        }
        String action = intent.getAction();
        zzgnVarZza.zzgl();
        zzfiVarZzgi.zzjc().zze("Local AppMeasurementService called. startId, action", Integer.valueOf(i2), action);
        if ("com.google.android.gms.measurement.UPLOAD".equals(action)) {
            zzb(new Runnable(this, i2, zzfiVarZzgi, intent) { // from class: com.google.android.gms.internal.measurement.zzjf
                private final int zzabo;
                private final zzje zzarg;
                private final zzfi zzarh;
                private final Intent zzari;

                {
                    this.zzarg = this;
                    this.zzabo = i2;
                    this.zzarh = zzfiVarZzgi;
                    this.zzari = intent;
                }

                @Override // java.lang.Runnable
                public final void run() {
                    this.zzarg.zza(this.zzabo, this.zzarh, this.zzari);
                }
            });
        }
        return 2;
    }

    @TargetApi(24)
    @MainThread
    public final boolean onStartJob(final JobParameters jobParameters) {
        zzgn zzgnVarZza = zzgn.zza(this.zzabl, null, null);
        final zzfi zzfiVarZzgi = zzgnVarZza.zzgi();
        String string = jobParameters.getExtras().getString(NativeProtocol.WEB_DIALOG_ACTION);
        zzgnVarZza.zzgl();
        zzfiVarZzgi.zzjc().zzg("Local AppMeasurementJobService called. action", string);
        if (!"com.google.android.gms.measurement.UPLOAD".equals(string)) {
            return true;
        }
        zzb(new Runnable(this, zzfiVarZzgi, jobParameters) { // from class: com.google.android.gms.internal.measurement.zzjg
            private final JobParameters zzabr;
            private final zzje zzarg;
            private final zzfi zzarj;

            {
                this.zzarg = this;
                this.zzarj = zzfiVarZzgi;
                this.zzabr = jobParameters;
            }

            @Override // java.lang.Runnable
            public final void run() {
                this.zzarg.zza(this.zzarj, this.zzabr);
            }
        });
        return true;
    }

    @MainThread
    public final boolean onUnbind(Intent intent) {
        if (intent == null) {
            zzgi().zziv().log("onUnbind called with null intent");
            return true;
        }
        zzgi().zzjc().zzg("onUnbind called for intent. action", intent.getAction());
        return true;
    }

    final /* synthetic */ void zza(int i, zzfi zzfiVar, Intent intent) {
        if (this.zzabl.callServiceStopSelfResult(i)) {
            zzfiVar.zzjc().zzg("Local AppMeasurementService processed last upload request. StartId", Integer.valueOf(i));
            zzgi().zzjc().log("Completed wakeful intent.");
            this.zzabl.zzb(intent);
        }
    }

    final /* synthetic */ void zza(zzfi zzfiVar, JobParameters jobParameters) {
        zzfiVar.zzjc().log("AppMeasurementJobService processed last upload request.");
        this.zzabl.zza(jobParameters, false);
    }
}
