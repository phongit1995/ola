package com.google.android.gms.internal.ads;

import android.content.Context;
import android.net.Uri;
import android.os.Build;
import android.os.Looper;
import android.text.TextUtils;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.common.wrappers.Wrappers;
import com.google.android.gms.dynamite.ProviderConstants;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.WeakHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import javax.annotation.ParametersAreNonnullByDefault;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
public final class zzadb implements zzadf {
    private static final Object sLock = new Object();

    @VisibleForTesting
    private static zzadf zzcbw;

    @VisibleForTesting
    private static zzadf zzcbx;
    private final Context zzatx;
    private final Object zzcby;
    private final WeakHashMap<Thread, Boolean> zzcbz;
    private final ExecutorService zzru;
    private final zzang zzzw;

    private zzadb(Context context) {
        this(context, zzang.zzsl());
    }

    private zzadb(Context context, zzang zzangVar) {
        this.zzcby = new Object();
        this.zzcbz = new WeakHashMap<>();
        this.zzru = Executors.newCachedThreadPool();
        this.zzatx = context.getApplicationContext() != null ? context.getApplicationContext() : context;
        this.zzzw = zzangVar;
    }

    @VisibleForTesting
    private final Uri.Builder zza(String str, String str2, String str3, int i) {
        boolean zIsCallerInstantApp;
        try {
            zIsCallerInstantApp = Wrappers.packageManager(this.zzatx).isCallerInstantApp();
        } catch (Throwable th) {
            zzane.zzb("Error fetching instant app info", th);
            zIsCallerInstantApp = false;
        }
        String packageName = "unknown";
        try {
            packageName = this.zzatx.getPackageName();
        } catch (Throwable unused) {
            zzane.zzdk("Cannot obtain package name, proceeding.");
        }
        Uri.Builder builderAppendQueryParameter = new Uri.Builder().scheme("https").path("//pagead2.googlesyndication.com/pagead/gen_204").appendQueryParameter("is_aia", Boolean.toString(zIsCallerInstantApp)).appendQueryParameter("id", "gmob-apps-report-exception").appendQueryParameter("os", Build.VERSION.RELEASE).appendQueryParameter(ProviderConstants.API_PATH, String.valueOf(Build.VERSION.SDK_INT));
        String str4 = Build.MANUFACTURER;
        String string = Build.MODEL;
        if (!string.startsWith(str4)) {
            StringBuilder sb = new StringBuilder(String.valueOf(str4).length() + 1 + String.valueOf(string).length());
            sb.append(str4);
            sb.append(" ");
            sb.append(string);
            string = sb.toString();
        }
        return builderAppendQueryParameter.appendQueryParameter("device", string).appendQueryParameter("js", this.zzzw.zzcw).appendQueryParameter("appid", packageName).appendQueryParameter("exceptiontype", str).appendQueryParameter("stacktrace", str2).appendQueryParameter("eids", TextUtils.join(",", zznk.zzjb())).appendQueryParameter("exceptionkey", str3).appendQueryParameter("cl", "193400285").appendQueryParameter("rc", "dev").appendQueryParameter("session_id", zzkb.zzih()).appendQueryParameter("sampling_rate", Integer.toString(i)).appendQueryParameter("pb_tm", String.valueOf(zzkb.zzik().zzd(zznk.zzbfo)));
    }

    public static zzadf zzc(Context context, zzang zzangVar) {
        synchronized (sLock) {
            if (zzcbx == null) {
                if (((Boolean) zzkb.zzik().zzd(zznk.zzauh)).booleanValue()) {
                    zzadb zzadbVar = new zzadb(context, zzangVar);
                    Thread thread = Looper.getMainLooper().getThread();
                    if (thread != null) {
                        synchronized (zzadbVar.zzcby) {
                            zzadbVar.zzcbz.put(thread, true);
                        }
                        thread.setUncaughtExceptionHandler(new zzadd(zzadbVar, thread.getUncaughtExceptionHandler()));
                    }
                    Thread.setDefaultUncaughtExceptionHandler(new zzadc(zzadbVar, Thread.getDefaultUncaughtExceptionHandler()));
                    zzcbx = zzadbVar;
                } else {
                    zzcbx = new zzadg();
                }
            }
        }
        return zzcbx;
    }

    public static zzadf zzl(Context context) {
        synchronized (sLock) {
            if (zzcbw == null) {
                if (((Boolean) zzkb.zzik().zzd(zznk.zzauh)).booleanValue()) {
                    zzcbw = new zzadb(context);
                } else {
                    zzcbw = new zzadg();
                }
            }
        }
        return zzcbw;
    }

    /* JADX WARN: Removed duplicated region for block: B:19:0x0042  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected final void zza(java.lang.Thread r10, java.lang.Throwable r11) {
        /*
            r9 = this;
            r10 = 1
            r0 = 0
            if (r11 == 0) goto L42
            r1 = r11
            r2 = 0
            r3 = 0
        L7:
            if (r1 == 0) goto L3d
            java.lang.StackTraceElement[] r4 = r1.getStackTrace()
            int r5 = r4.length
            r6 = r3
            r3 = r2
            r2 = 0
        L11:
            if (r2 >= r5) goto L36
            r7 = r4[r2]
            java.lang.String r8 = r7.getClassName()
            boolean r8 = com.google.android.gms.internal.ads.zzamu.zzdf(r8)
            if (r8 == 0) goto L20
            r3 = 1
        L20:
            java.lang.Class r8 = r9.getClass()
            java.lang.String r8 = r8.getName()
            java.lang.String r7 = r7.getClassName()
            boolean r7 = r8.equals(r7)
            if (r7 == 0) goto L33
            r6 = 1
        L33:
            int r2 = r2 + 1
            goto L11
        L36:
            java.lang.Throwable r1 = r1.getCause()
            r2 = r3
            r3 = r6
            goto L7
        L3d:
            if (r2 == 0) goto L42
            if (r3 != 0) goto L42
            goto L43
        L42:
            r10 = 0
        L43:
            if (r10 == 0) goto L4c
            java.lang.String r10 = ""
            r0 = 1065353216(0x3f800000, float:1.0)
            r9.zza(r11, r10, r0)
        L4c:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzadb.zza(java.lang.Thread, java.lang.Throwable):void");
    }

    @Override // com.google.android.gms.internal.ads.zzadf
    public final void zza(Throwable th, String str) {
        zza(th, str, 1.0f);
    }

    @Override // com.google.android.gms.internal.ads.zzadf
    public final void zza(Throwable th, String str, float f) {
        if (zzamu.zzc(th) == null) {
            return;
        }
        String name = th.getClass().getName();
        StringWriter stringWriter = new StringWriter();
        zzazr.zza(th, new PrintWriter(stringWriter));
        String string = stringWriter.toString();
        int i = 0;
        boolean z = Math.random() < ((double) f);
        int i2 = f > 0.0f ? (int) (1.0f / f) : 1;
        if (z) {
            ArrayList arrayList = new ArrayList();
            arrayList.add(zza(name, string, str, i2).toString());
            ArrayList arrayList2 = arrayList;
            int size = arrayList2.size();
            while (i < size) {
                Object obj = arrayList2.get(i);
                i++;
                this.zzru.submit(new zzade(this, new zzanf(), (String) obj));
            }
        }
    }
}
