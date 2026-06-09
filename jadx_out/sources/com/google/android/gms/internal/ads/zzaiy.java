package com.google.android.gms.internal.ads;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.measurement.AppMeasurement;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.lang.reflect.Method;
import java.util.concurrent.Callable;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.Future;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzaiy {
    private final AtomicReference<ThreadPoolExecutor> zzcnp = new AtomicReference<>(null);
    private final Object zzcnq = new Object();

    @GuardedBy("mGmpAppIdLock")
    @Nullable
    private String zzcnr = null;

    @VisibleForTesting
    private final AtomicBoolean zzcns = new AtomicBoolean(false);

    @VisibleForTesting
    private final AtomicInteger zzcnt = new AtomicInteger(-1);
    private final AtomicReference<Object> zzcnu = new AtomicReference<>(null);
    private final AtomicReference<Object> zzcnv = new AtomicReference<>(null);
    private ConcurrentMap<String, Method> zzcnw = new ConcurrentHashMap(9);

    private static Bundle zza(Context context, String str, boolean z) {
        Bundle bundle = new Bundle();
        try {
            bundle.putLong("_aeid", Long.parseLong(str));
        } catch (NullPointerException | NumberFormatException e) {
            String strValueOf = String.valueOf(str);
            zzakb.zzb(strValueOf.length() != 0 ? "Invalid event ID: ".concat(strValueOf) : new String("Invalid event ID: "), e);
        }
        if (z) {
            bundle.putInt("_r", 1);
        }
        return bundle;
    }

    private final Object zza(String str, Context context) {
        if (!zza(context, "com.google.android.gms.measurement.AppMeasurement", this.zzcnu, true)) {
            return null;
        }
        try {
            return zzi(context, str).invoke(this.zzcnu.get(), new Object[0]);
        } catch (Exception e) {
            zza(e, str, true);
            return null;
        }
    }

    private final void zza(Context context, String str, Bundle bundle) {
        if (zzs(context) && zza(context, "com.google.android.gms.measurement.AppMeasurement", this.zzcnu, true)) {
            try {
                zzac(context).invoke(this.zzcnu.get(), "am", str, bundle);
            } catch (Exception e) {
                zza(e, "logEventInternal", true);
            }
        }
    }

    private final void zza(Exception exc, String str, boolean z) {
        if (this.zzcns.get()) {
            return;
        }
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 30);
        sb.append("Invoke Firebase method ");
        sb.append(str);
        sb.append(" error.");
        zzakb.zzdk(sb.toString());
        if (z) {
            zzakb.zzdk("The Google Mobile Ads SDK will not integrate with Firebase. Admob/Firebase integration requires the latest Firebase SDK jar, but Firebase SDK is either missing or out of date");
            this.zzcns.set(true);
        }
    }

    private final boolean zza(Context context, String str, AtomicReference<Object> atomicReference, boolean z) {
        if (atomicReference.get() != null) {
            return true;
        }
        try {
            atomicReference.compareAndSet(null, context.getClassLoader().loadClass(str).getDeclaredMethod("getInstance", Context.class).invoke(null, context));
            return true;
        } catch (Exception e) {
            zza(e, "getInstance", z);
            return false;
        }
    }

    private final Method zzac(Context context) {
        Method method = this.zzcnw.get("logEventInternal");
        if (method != null) {
            return method;
        }
        try {
            Method declaredMethod = context.getClassLoader().loadClass("com.google.android.gms.measurement.AppMeasurement").getDeclaredMethod("logEventInternal", String.class, String.class, Bundle.class);
            this.zzcnw.put("logEventInternal", declaredMethod);
            return declaredMethod;
        } catch (Exception e) {
            zza(e, "logEventInternal", true);
            return null;
        }
    }

    private final void zzb(Context context, String str, String str2) {
        if (zza(context, "com.google.android.gms.measurement.AppMeasurement", this.zzcnu, true)) {
            try {
                zzh(context, str2).invoke(this.zzcnu.get(), str);
                StringBuilder sb = new StringBuilder(String.valueOf(str2).length() + 37 + String.valueOf(str).length());
                sb.append("Invoke Firebase method ");
                sb.append(str2);
                sb.append(", Ad Unit Id: ");
                sb.append(str);
                zzakb.v(sb.toString());
            } catch (Exception e) {
                zza(e, str2, false);
            }
        }
    }

    private final Method zzh(Context context, String str) {
        Method method = this.zzcnw.get(str);
        if (method != null) {
            return method;
        }
        try {
            Method declaredMethod = context.getClassLoader().loadClass("com.google.android.gms.measurement.AppMeasurement").getDeclaredMethod(str, String.class);
            this.zzcnw.put(str, declaredMethod);
            return declaredMethod;
        } catch (Exception e) {
            zza(e, str, false);
            return null;
        }
    }

    private final Method zzi(Context context, String str) {
        Method method = this.zzcnw.get(str);
        if (method != null) {
            return method;
        }
        try {
            Method declaredMethod = context.getClassLoader().loadClass("com.google.android.gms.measurement.AppMeasurement").getDeclaredMethod(str, new Class[0]);
            this.zzcnw.put(str, declaredMethod);
            return declaredMethod;
        } catch (Exception e) {
            zza(e, str, false);
            return null;
        }
    }

    private final Method zzj(Context context, String str) {
        Method method = this.zzcnw.get(str);
        if (method != null) {
            return method;
        }
        try {
            Method declaredMethod = context.getClassLoader().loadClass("com.google.firebase.analytics.FirebaseAnalytics").getDeclaredMethod(str, Activity.class, String.class, String.class);
            this.zzcnw.put(str, declaredMethod);
            return declaredMethod;
        } catch (Exception e) {
            zza(e, str, false);
            return null;
        }
    }

    public final void zza(Context context, String str, String str2) {
        if (zzs(context)) {
            zza(context, str, zza(context, str2, "_ac".equals(str)));
        }
    }

    public final void zza(Context context, String str, String str2, String str3, int i) {
        if (zzs(context)) {
            Bundle bundleZza = zza(context, str, false);
            bundleZza.putString("_ai", str2);
            bundleZza.putString("type", str3);
            bundleZza.putInt(FirebaseAnalytics.Param.VALUE, i);
            zza(context, AppMeasurement.Event.AD_REWARD, bundleZza);
            StringBuilder sb = new StringBuilder(String.valueOf(str3).length() + 75);
            sb.append("Log a Firebase reward video event, reward type: ");
            sb.append(str3);
            sb.append(", reward value: ");
            sb.append(i);
            zzakb.v(sb.toString());
        }
    }

    @Nullable
    public final String zzaa(final Context context) {
        if (!zzs(context)) {
            return null;
        }
        long jLongValue = ((Long) zzkb.zzik().zzd(zznk.zzaxt)).longValue();
        if (jLongValue < 0) {
            return (String) zza("getAppInstanceId", context);
        }
        if (this.zzcnp.get() == null) {
            this.zzcnp.compareAndSet(null, new ThreadPoolExecutor(((Integer) zzkb.zzik().zzd(zznk.zzaxu)).intValue(), ((Integer) zzkb.zzik().zzd(zznk.zzaxu)).intValue(), 1L, TimeUnit.MINUTES, new LinkedBlockingQueue(), new zzaja(this)));
        }
        Future futureSubmit = this.zzcnp.get().submit(new Callable(this, context) { // from class: com.google.android.gms.internal.ads.zzaiz
            private final zzaiy zzcnx;
            private final Context zzcny;

            {
                this.zzcnx = this;
                this.zzcny = context;
            }

            @Override // java.util.concurrent.Callable
            public final Object call() {
                return this.zzcnx.zzad(this.zzcny);
            }
        });
        try {
            return (String) futureSubmit.get(jLongValue, TimeUnit.MILLISECONDS);
        } catch (Exception e) {
            futureSubmit.cancel(true);
            if (e instanceof TimeoutException) {
                return "TIME_OUT";
            }
            return null;
        }
    }

    @Nullable
    public final String zzab(Context context) {
        Object objZza;
        if (zzs(context) && (objZza = zza("generateEventId", context)) != null) {
            return objZza.toString();
        }
        return null;
    }

    final /* synthetic */ String zzad(Context context) {
        return (String) zza("getAppInstanceId", context);
    }

    public final void zzb(Context context, String str) {
        if (zzs(context)) {
            zzb(context, str, "beginAdUnitExposure");
        }
    }

    public final void zzc(Context context, String str) {
        if (zzs(context)) {
            zzb(context, str, "endAdUnitExposure");
        }
    }

    public final void zzd(Context context, String str) {
        if (zzs(context) && (context instanceof Activity) && zza(context, "com.google.firebase.analytics.FirebaseAnalytics", this.zzcnv, false)) {
            try {
                zzj(context, "setCurrentScreen").invoke(this.zzcnv.get(), (Activity) context, str, context.getPackageName());
            } catch (Exception e) {
                zza(e, "setCurrentScreen", false);
            }
        }
    }

    public final void zze(Context context, String str) {
        zza(context, "_ac", str);
    }

    public final void zzf(Context context, String str) {
        zza(context, "_ai", str);
    }

    public final void zzg(Context context, String str) {
        zza(context, "_aq", str);
    }

    /* JADX WARN: Removed duplicated region for block: B:14:0x0043  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean zzs(android.content.Context r5) {
        /*
            r4 = this;
            com.google.android.gms.internal.ads.zzna<java.lang.Boolean> r0 = com.google.android.gms.internal.ads.zznk.zzaxj
            com.google.android.gms.internal.ads.zzni r1 = com.google.android.gms.internal.ads.zzkb.zzik()
            java.lang.Object r0 = r1.zzd(r0)
            java.lang.Boolean r0 = (java.lang.Boolean) r0
            boolean r0 = r0.booleanValue()
            r1 = 0
            if (r0 == 0) goto L51
            java.util.concurrent.atomic.AtomicBoolean r0 = r4.zzcns
            boolean r0 = r0.get()
            if (r0 == 0) goto L1c
            return r1
        L1c:
            java.util.concurrent.atomic.AtomicInteger r0 = r4.zzcnt
            int r0 = r0.get()
            r2 = -1
            r3 = 1
            if (r0 != r2) goto L48
            com.google.android.gms.internal.ads.zzkb.zzif()
            boolean r0 = com.google.android.gms.internal.ads.zzamu.zzbe(r5)
            if (r0 != 0) goto L43
            com.google.android.gms.internal.ads.zzkb.zzif()
            boolean r5 = com.google.android.gms.internal.ads.zzamu.zzbh(r5)
            if (r5 == 0) goto L43
            java.lang.String r5 = "Google Play Service is out of date, the Google Mobile Ads SDK will not integrate with Firebase. Admob/Firebase integration requires updated Google Play Service."
            com.google.android.gms.internal.ads.zzakb.zzdk(r5)
            java.util.concurrent.atomic.AtomicInteger r5 = r4.zzcnt
            r5.set(r1)
            goto L48
        L43:
            java.util.concurrent.atomic.AtomicInteger r5 = r4.zzcnt
            r5.set(r3)
        L48:
            java.util.concurrent.atomic.AtomicInteger r5 = r4.zzcnt
            int r5 = r5.get()
            if (r5 != r3) goto L51
            return r3
        L51:
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzaiy.zzs(android.content.Context):boolean");
    }

    public final boolean zzt(Context context) {
        return ((Boolean) zzkb.zzik().zzd(zznk.zzaxk)).booleanValue() && zzs(context);
    }

    public final boolean zzu(Context context) {
        return ((Boolean) zzkb.zzik().zzd(zznk.zzaxl)).booleanValue() && zzs(context);
    }

    public final boolean zzv(Context context) {
        return ((Boolean) zzkb.zzik().zzd(zznk.zzaxm)).booleanValue() && zzs(context);
    }

    public final boolean zzw(Context context) {
        return ((Boolean) zzkb.zzik().zzd(zznk.zzaxn)).booleanValue() && zzs(context);
    }

    public final boolean zzx(Context context) {
        return ((Boolean) zzkb.zzik().zzd(zznk.zzaxq)).booleanValue() && zzs(context);
    }

    public final String zzy(Context context) {
        if (!zzs(context) || !zza(context, "com.google.android.gms.measurement.AppMeasurement", this.zzcnu, true)) {
            return "";
        }
        try {
            String str = (String) zzi(context, "getCurrentScreenName").invoke(this.zzcnu.get(), new Object[0]);
            if (str == null) {
                str = (String) zzi(context, "getCurrentScreenClass").invoke(this.zzcnu.get(), new Object[0]);
            }
            return str != null ? str : "";
        } catch (Exception e) {
            zza(e, "getCurrentScreenName", false);
            return "";
        }
    }

    @Nullable
    public final String zzz(Context context) {
        if (!zzs(context)) {
            return null;
        }
        synchronized (this.zzcnq) {
            if (this.zzcnr != null) {
                return this.zzcnr;
            }
            this.zzcnr = (String) zza("getGmpAppId", context);
            return this.zzcnr;
        }
    }
}
