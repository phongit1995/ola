package com.google.android.gms.internal.measurement;

import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.MainThread;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgd {
    private final zzgg zzamz;

    public zzgd(zzgg zzggVar) {
        Preconditions.checkNotNull(zzggVar);
        this.zzamz = zzggVar;
    }

    public static boolean zza(Context context) {
        ActivityInfo receiverInfo;
        Preconditions.checkNotNull(context);
        try {
            PackageManager packageManager = context.getPackageManager();
            if (packageManager != null && (receiverInfo = packageManager.getReceiverInfo(new ComponentName(context, "com.google.android.gms.measurement.AppMeasurementReceiver"), 0)) != null) {
                if (receiverInfo.enabled) {
                    return true;
                }
            }
        } catch (PackageManager.NameNotFoundException unused) {
        }
        return false;
    }

    @MainThread
    public final void onReceive(Context context, Intent intent) {
        zzgn zzgnVarZza = zzgn.zza(context, null, null);
        zzfi zzfiVarZzgi = zzgnVarZza.zzgi();
        if (intent == null) {
            zzfiVarZzgi.zziy().log("Receiver called with null intent");
            return;
        }
        zzgnVarZza.zzgl();
        String action = intent.getAction();
        zzfiVarZzgi.zzjc().zzg("Local receiver got", action);
        if ("com.google.android.gms.measurement.UPLOAD".equals(action)) {
            Intent className = new Intent().setClassName(context, "com.google.android.gms.measurement.AppMeasurementService");
            className.setAction("com.google.android.gms.measurement.UPLOAD");
            zzfiVarZzgi.zzjc().log("Starting wakeful intent.");
            this.zzamz.doStartService(context, className);
            return;
        }
        if ("com.android.vending.INSTALL_REFERRER".equals(action)) {
            try {
                zzgnVarZza.zzgh().zzc(new zzge(this, zzgnVarZza, zzfiVarZzgi));
            } catch (Exception e) {
                zzfiVarZzgi.zziy().zzg("Install Referrer Reporter encountered a problem", e);
            }
            BroadcastReceiver.PendingResult pendingResultDoGoAsync = this.zzamz.doGoAsync();
            String stringExtra = intent.getStringExtra("referrer");
            if (stringExtra == null) {
                zzfiVarZzgi.zzjc().log("Install referrer extras are null");
                if (pendingResultDoGoAsync != null) {
                    pendingResultDoGoAsync.finish();
                    return;
                }
                return;
            }
            zzfiVarZzgi.zzja().zzg("Install referrer extras are", stringExtra);
            if (!stringExtra.contains("?")) {
                String strValueOf = String.valueOf(stringExtra);
                stringExtra = strValueOf.length() != 0 ? "?".concat(strValueOf) : new String("?");
            }
            Bundle bundleZza = zzgnVarZza.zzgg().zza(Uri.parse(stringExtra));
            if (bundleZza == null) {
                zzfiVarZzgi.zzjc().log("No campaign defined in install referrer broadcast");
                if (pendingResultDoGoAsync != null) {
                    pendingResultDoGoAsync.finish();
                    return;
                }
                return;
            }
            long longExtra = intent.getLongExtra("referrer_timestamp_seconds", 0L) * 1000;
            if (longExtra == 0) {
                zzfiVarZzgi.zziy().log("Install referrer is missing timestamp");
            }
            zzgnVarZza.zzgh().zzc(new zzgf(this, zzgnVarZza, longExtra, bundleZza, context, zzfiVarZzgi, pendingResultDoGoAsync));
        }
    }
}
