package com.google.android.gms.internal.ads;

import android.app.Activity;
import android.content.Context;
import android.net.Uri;
import android.text.TextUtils;
import com.facebook.appevents.AppEventsConstants;
import com.google.android.gms.common.util.VisibleForTesting;
import javax.annotation.Nullable;
import javax.annotation.concurrent.GuardedBy;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzalk {
    private final Object mLock = new Object();

    @GuardedBy("mLock")
    private String zzcsm = "";

    @GuardedBy("mLock")
    private String zzcsn = "";

    @GuardedBy("mLock")
    private boolean zzcso = false;

    @VisibleForTesting
    private String zzcsp = "";

    @VisibleForTesting
    private final void zza(Context context, String str, boolean z, boolean z2) {
        if (context instanceof Activity) {
            zzakk.zzcrm.post(new zzall(this, context, str, z, z2));
        } else {
            zzakb.zzdj("Can not create dialog without Activity Context");
        }
    }

    private final String zzaz(Context context) {
        String str;
        synchronized (this.mLock) {
            if (TextUtils.isEmpty(this.zzcsm)) {
                com.google.android.gms.ads.internal.zzbv.zzek();
                this.zzcsm = zzakk.zzn(context, "debug_signals_id.txt");
                if (TextUtils.isEmpty(this.zzcsm)) {
                    com.google.android.gms.ads.internal.zzbv.zzek();
                    this.zzcsm = zzakk.zzrh();
                    com.google.android.gms.ads.internal.zzbv.zzek();
                    zzakk.zze(context, "debug_signals_id.txt", this.zzcsm);
                }
            }
            str = this.zzcsm;
        }
        return str;
    }

    private final Uri zzc(Context context, String str, String str2, String str3) {
        Uri.Builder builderBuildUpon = Uri.parse(str).buildUpon();
        builderBuildUpon.appendQueryParameter("linkedDeviceId", zzaz(context));
        builderBuildUpon.appendQueryParameter("adSlotPath", str2);
        builderBuildUpon.appendQueryParameter("afmaVersion", str3);
        return builderBuildUpon.build();
    }

    @VisibleForTesting
    private final boolean zzh(Context context, String str, String str2) {
        String strZzj = zzj(context, zzc(context, (String) zzkb.zzik().zzd(zznk.zzbeg), str, str2).toString(), str2);
        if (TextUtils.isEmpty(strZzj)) {
            zzakb.zzck("Not linked for in app preview.");
            return false;
        }
        try {
            JSONObject jSONObject = new JSONObject(strZzj.trim());
            String strOptString = jSONObject.optString("gct");
            this.zzcsp = jSONObject.optString("status");
            synchronized (this.mLock) {
                this.zzcsn = strOptString;
            }
            return true;
        } catch (JSONException e) {
            zzakb.zzc("Fail to get in app preview response json.", e);
            return false;
        }
    }

    @VisibleForTesting
    private final boolean zzi(Context context, String str, String str2) {
        String strZzj = zzj(context, zzc(context, (String) zzkb.zzik().zzd(zznk.zzbeh), str, str2).toString(), str2);
        if (TextUtils.isEmpty(strZzj)) {
            zzakb.zzck("Not linked for debug signals.");
            return false;
        }
        try {
            boolean zEquals = "1".equals(new JSONObject(strZzj.trim()).optString("debug_mode"));
            synchronized (this.mLock) {
                this.zzcso = zEquals;
            }
            return zEquals;
        } catch (JSONException e) {
            zzakb.zzc("Fail to get debug mode response json.", e);
            return false;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:19:0x0072 A[PHI: r0 r1 r4
      0x0072: PHI (r0v3 'e' java.lang.Throwable) = (r0v2 'e' java.lang.Throwable), (r0v5 'e' java.lang.Throwable) binds: [B:18:0x0070, B:13:0x005c] A[DONT_GENERATE, DONT_INLINE]
      0x0072: PHI (r1v2 java.lang.String) = (r1v1 java.lang.String), (r1v3 java.lang.String) binds: [B:18:0x0070, B:13:0x005c] A[DONT_GENERATE, DONT_INLINE]
      0x0072: PHI (r4v7 java.lang.String) = (r4v5 java.lang.String), (r4v10 java.lang.String) binds: [B:18:0x0070, B:13:0x005c] A[DONT_GENERATE, DONT_INLINE]] */
    @com.google.android.gms.common.util.VisibleForTesting
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static java.lang.String zzj(android.content.Context r3, java.lang.String r4, java.lang.String r5) {
        /*
            java.util.HashMap r0 = new java.util.HashMap
            r0.<init>()
            java.lang.String r1 = "User-Agent"
            com.google.android.gms.internal.ads.zzakk r2 = com.google.android.gms.ads.internal.zzbv.zzek()
            java.lang.String r5 = r2.zzm(r3, r5)
            r0.put(r1, r5)
            com.google.android.gms.internal.ads.zzalt r5 = new com.google.android.gms.internal.ads.zzalt
            r5.<init>(r3)
            com.google.android.gms.internal.ads.zzanz r3 = r5.zzc(r4, r0)
            r5 = 1
            com.google.android.gms.internal.ads.zzna<java.lang.Integer> r0 = com.google.android.gms.internal.ads.zznk.zzbej     // Catch: java.lang.Exception -> L36 java.lang.InterruptedException -> L51 java.util.concurrent.TimeoutException -> L65
            com.google.android.gms.internal.ads.zzni r1 = com.google.android.gms.internal.ads.zzkb.zzik()     // Catch: java.lang.Exception -> L36 java.lang.InterruptedException -> L51 java.util.concurrent.TimeoutException -> L65
            java.lang.Object r0 = r1.zzd(r0)     // Catch: java.lang.Exception -> L36 java.lang.InterruptedException -> L51 java.util.concurrent.TimeoutException -> L65
            java.lang.Integer r0 = (java.lang.Integer) r0     // Catch: java.lang.Exception -> L36 java.lang.InterruptedException -> L51 java.util.concurrent.TimeoutException -> L65
            int r0 = r0.intValue()     // Catch: java.lang.Exception -> L36 java.lang.InterruptedException -> L51 java.util.concurrent.TimeoutException -> L65
            long r0 = (long) r0     // Catch: java.lang.Exception -> L36 java.lang.InterruptedException -> L51 java.util.concurrent.TimeoutException -> L65
            java.util.concurrent.TimeUnit r2 = java.util.concurrent.TimeUnit.MILLISECONDS     // Catch: java.lang.Exception -> L36 java.lang.InterruptedException -> L51 java.util.concurrent.TimeoutException -> L65
            java.lang.Object r0 = r3.get(r0, r2)     // Catch: java.lang.Exception -> L36 java.lang.InterruptedException -> L51 java.util.concurrent.TimeoutException -> L65
            java.lang.String r0 = (java.lang.String) r0     // Catch: java.lang.Exception -> L36 java.lang.InterruptedException -> L51 java.util.concurrent.TimeoutException -> L65
            return r0
        L36:
            r3 = move-exception
            java.lang.String r5 = "Error retriving a response from: "
            java.lang.String r4 = java.lang.String.valueOf(r4)
            int r0 = r4.length()
            if (r0 == 0) goto L48
            java.lang.String r4 = r5.concat(r4)
            goto L4d
        L48:
            java.lang.String r4 = new java.lang.String
            r4.<init>(r5)
        L4d:
            com.google.android.gms.internal.ads.zzakb.zzb(r4, r3)
            goto L82
        L51:
            r0 = move-exception
            java.lang.String r1 = "Interrupted while retriving a response from: "
            java.lang.String r4 = java.lang.String.valueOf(r4)
            int r2 = r4.length()
            if (r2 == 0) goto L5f
            goto L72
        L5f:
            java.lang.String r4 = new java.lang.String
            r4.<init>(r1)
            goto L7c
        L65:
            r0 = move-exception
            java.lang.String r1 = "Timeout while retriving a response from: "
            java.lang.String r4 = java.lang.String.valueOf(r4)
            int r2 = r4.length()
            if (r2 == 0) goto L77
        L72:
            java.lang.String r4 = r1.concat(r4)
            goto L7c
        L77:
            java.lang.String r4 = new java.lang.String
            r4.<init>(r1)
        L7c:
            com.google.android.gms.internal.ads.zzakb.zzb(r4, r0)
            r3.cancel(r5)
        L82:
            r3 = 0
            return r3
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzalk.zzj(android.content.Context, java.lang.String, java.lang.String):java.lang.String");
    }

    private final void zzk(Context context, String str, String str2) {
        com.google.android.gms.ads.internal.zzbv.zzek();
        zzakk.zza(context, zzc(context, (String) zzkb.zzik().zzd(zznk.zzbef), str, str2));
    }

    public final void zza(Context context, String str, String str2, @Nullable String str3) {
        boolean zZzrx = zzrx();
        if (!zzi(context, str, str2)) {
            zzk(context, str, str2);
            return;
        }
        if (!zZzrx && !TextUtils.isEmpty(str3)) {
            zzb(context, str2, str3, str);
        }
        zzakb.zzck("Device is linked for debug signals.");
        zza(context, "The device is successfully linked for troubleshooting.", false, true);
    }

    public final void zzb(Context context, String str, String str2, String str3) {
        Uri.Builder builderBuildUpon = zzc(context, (String) zzkb.zzik().zzd(zznk.zzbei), str3, str).buildUpon();
        builderBuildUpon.appendQueryParameter("debugData", str2);
        com.google.android.gms.ads.internal.zzbv.zzek();
        zzakk.zzd(context, str, builderBuildUpon.build().toString());
    }

    public final void zzg(Context context, String str, String str2) {
        if (!zzh(context, str, str2)) {
            zza(context, "In-app preview failed to load because of a system error. Please try again later.", true, true);
            return;
        }
        if ("2".equals(this.zzcsp)) {
            zzakb.zzck("Creative is not pushed for this device.");
            zza(context, "There was no creative pushed from DFP to the device.", false, false);
        } else if ("1".equals(this.zzcsp)) {
            zzakb.zzck("The app is not linked for creative preview.");
            zzk(context, str, str2);
        } else if (AppEventsConstants.EVENT_PARAM_VALUE_NO.equals(this.zzcsp)) {
            zzakb.zzck("Device is linked for in app preview.");
            zza(context, "The device is successfully linked for creative preview.", false, true);
        }
    }

    public final String zzrw() {
        String str;
        synchronized (this.mLock) {
            str = this.zzcsn;
        }
        return str;
    }

    public final boolean zzrx() {
        boolean z;
        synchronized (this.mLock) {
            z = this.zzcso;
        }
        return z;
    }
}
