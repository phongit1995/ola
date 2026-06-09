package com.google.android.gms.internal.measurement;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.MainThread;
import android.text.TextUtils;

/* JADX INFO: loaded from: classes2.dex */
@TargetApi(14)
@MainThread
final class zzif implements Application.ActivityLifecycleCallbacks {
    private final /* synthetic */ zzhm zzaps;

    private zzif(zzhm zzhmVar) {
        this.zzaps = zzhmVar;
    }

    /* synthetic */ zzif(zzhm zzhmVar, zzhn zzhnVar) {
        this(zzhmVar);
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivityCreated(Activity activity, Bundle bundle) {
        Uri data;
        try {
            this.zzaps.zzgi().zzjc().log("onActivityCreated");
            Intent intent = activity.getIntent();
            if (intent != null && (data = intent.getData()) != null && data.isHierarchical()) {
                if (bundle == null) {
                    Bundle bundleZza = this.zzaps.zzgg().zza(data);
                    this.zzaps.zzgg();
                    String str = zzkd.zzd(intent) ? "gs" : "auto";
                    if (bundleZza != null) {
                        this.zzaps.logEvent(str, "_cmp", bundleZza);
                    }
                }
                String queryParameter = data.getQueryParameter("referrer");
                if (TextUtils.isEmpty(queryParameter)) {
                    return;
                }
                if (!(queryParameter.contains("gclid") && (queryParameter.contains("utm_campaign") || queryParameter.contains("utm_source") || queryParameter.contains("utm_medium") || queryParameter.contains("utm_term") || queryParameter.contains("utm_content")))) {
                    this.zzaps.zzgi().zzjb().log("Activity created with data 'referrer' param without gclid and at least one utm field");
                    return;
                } else {
                    this.zzaps.zzgi().zzjb().zzg("Activity created with referrer", queryParameter);
                    if (!TextUtils.isEmpty(queryParameter)) {
                        this.zzaps.setUserProperty("auto", "_ldl", queryParameter);
                    }
                }
            }
        } catch (Exception e) {
            this.zzaps.zzgi().zziv().zzg("Throwable caught in onActivityCreated", e);
        }
        this.zzaps.zzgb().onActivityCreated(activity, bundle);
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivityDestroyed(Activity activity) {
        this.zzaps.zzgb().onActivityDestroyed(activity);
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    @MainThread
    public final void onActivityPaused(Activity activity) {
        this.zzaps.zzgb().onActivityPaused(activity);
        zzjj zzjjVarZzgd = this.zzaps.zzgd();
        zzjjVarZzgd.zzgh().zzc(new zzjn(zzjjVarZzgd, zzjjVarZzgd.zzbt().elapsedRealtime()));
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    @MainThread
    public final void onActivityResumed(Activity activity) {
        this.zzaps.zzgb().onActivityResumed(activity);
        zzjj zzjjVarZzgd = this.zzaps.zzgd();
        zzjjVarZzgd.zzgh().zzc(new zzjm(zzjjVarZzgd, zzjjVarZzgd.zzbt().elapsedRealtime()));
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivitySaveInstanceState(Activity activity, Bundle bundle) {
        this.zzaps.zzgb().onActivitySaveInstanceState(activity, bundle);
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivityStarted(Activity activity) {
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivityStopped(Activity activity) {
    }
}
