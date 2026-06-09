package com.google.android.gms.internal.ads;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.Nullable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes.dex */
@TargetApi(14)
final class zzgh implements Application.ActivityLifecycleCallbacks {

    @Nullable
    private Activity mActivity;
    private Context mContext;
    private Runnable zzahv;
    private long zzahw;
    private final Object mLock = new Object();
    private boolean zzahr = true;
    private boolean zzahs = false;

    @GuardedBy("mLock")
    private final List<zzgj> zzaht = new ArrayList();

    @GuardedBy("mLock")
    private final List<zzgw> zzahu = new ArrayList();
    private boolean zzzv = false;

    zzgh() {
    }

    private final void setActivity(Activity activity) {
        synchronized (this.mLock) {
            if (!activity.getClass().getName().startsWith("com.google.android.gms.ads")) {
                this.mActivity = activity;
            }
        }
    }

    static /* synthetic */ boolean zza(zzgh zzghVar, boolean z) {
        zzghVar.zzahr = false;
        return false;
    }

    @Nullable
    public final Activity getActivity() {
        return this.mActivity;
    }

    @Nullable
    public final Context getContext() {
        return this.mContext;
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivityCreated(Activity activity, Bundle bundle) {
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivityDestroyed(Activity activity) {
        synchronized (this.mLock) {
            if (this.mActivity == null) {
                return;
            }
            if (this.mActivity.equals(activity)) {
                this.mActivity = null;
            }
            Iterator<zzgw> it2 = this.zzahu.iterator();
            while (it2.hasNext()) {
                try {
                    if (it2.next().zza(activity)) {
                        it2.remove();
                    }
                } catch (Exception e) {
                    com.google.android.gms.ads.internal.zzbv.zzeo().zza(e, "AppActivityTracker.ActivityListener.onActivityDestroyed");
                    zzane.zzb("", e);
                }
            }
        }
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivityPaused(Activity activity) {
        setActivity(activity);
        synchronized (this.mLock) {
            Iterator<zzgw> it2 = this.zzahu.iterator();
            while (it2.hasNext()) {
                try {
                    it2.next().onActivityPaused(activity);
                } catch (Exception e) {
                    com.google.android.gms.ads.internal.zzbv.zzeo().zza(e, "AppActivityTracker.ActivityListener.onActivityPaused");
                    zzane.zzb("", e);
                }
            }
        }
        this.zzahs = true;
        if (this.zzahv != null) {
            zzakk.zzcrm.removeCallbacks(this.zzahv);
        }
        Handler handler = zzakk.zzcrm;
        zzgi zzgiVar = new zzgi(this);
        this.zzahv = zzgiVar;
        handler.postDelayed(zzgiVar, this.zzahw);
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivityResumed(Activity activity) {
        setActivity(activity);
        this.zzahs = false;
        boolean z = !this.zzahr;
        this.zzahr = true;
        if (this.zzahv != null) {
            zzakk.zzcrm.removeCallbacks(this.zzahv);
        }
        synchronized (this.mLock) {
            Iterator<zzgw> it2 = this.zzahu.iterator();
            while (it2.hasNext()) {
                try {
                    it2.next().onActivityResumed(activity);
                } catch (Exception e) {
                    com.google.android.gms.ads.internal.zzbv.zzeo().zza(e, "AppActivityTracker.ActivityListener.onActivityResumed");
                    zzane.zzb("", e);
                }
            }
            if (z) {
                Iterator<zzgj> it3 = this.zzaht.iterator();
                while (it3.hasNext()) {
                    try {
                        it3.next().zzh(true);
                    } catch (Exception e2) {
                        zzane.zzb("", e2);
                    }
                }
            } else {
                zzakb.zzck("App is still foreground.");
            }
        }
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivitySaveInstanceState(Activity activity, Bundle bundle) {
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivityStarted(Activity activity) {
        setActivity(activity);
    }

    @Override // android.app.Application.ActivityLifecycleCallbacks
    public final void onActivityStopped(Activity activity) {
    }

    public final void zza(Application application, Context context) {
        if (this.zzzv) {
            return;
        }
        application.registerActivityLifecycleCallbacks(this);
        if (context instanceof Activity) {
            setActivity((Activity) context);
        }
        this.mContext = application;
        this.zzahw = ((Long) zzkb.zzik().zzd(zznk.zzayh)).longValue();
        this.zzzv = true;
    }

    public final void zza(zzgj zzgjVar) {
        synchronized (this.mLock) {
            this.zzaht.add(zzgjVar);
        }
    }
}
