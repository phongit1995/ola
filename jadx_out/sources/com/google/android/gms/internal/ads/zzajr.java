package com.google.android.gms.internal.ads;

import android.content.ComponentName;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Bundle;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.facebook.internal.AnalyticsEvents;
import com.google.android.gms.ads.AdActivity;
import com.google.android.gms.common.util.VisibleForTesting;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzajr {

    @VisibleForTesting
    private final String zzasc;

    @VisibleForTesting
    private long zzcqd = -1;

    @VisibleForTesting
    private long zzcqe = -1;

    @VisibleForTesting
    @GuardedBy("mLock")
    private int zzcqf = -1;

    @VisibleForTesting
    int zzcqg = -1;

    @VisibleForTesting
    private long zzcqh = 0;
    private final Object mLock = new Object();

    @VisibleForTesting
    @GuardedBy("mLock")
    private int zzcqi = 0;

    @VisibleForTesting
    @GuardedBy("mLock")
    private int zzcqj = 0;

    public zzajr(String str) {
        this.zzasc = str;
    }

    private static boolean zzah(Context context) {
        int identifier = context.getResources().getIdentifier("Theme.Translucent", AnalyticsEvents.PARAMETER_LIKE_VIEW_STYLE, AccountKitGraphConstants.SDK_TYPE_ANDROID);
        if (identifier != 0) {
            try {
                if (identifier == context.getPackageManager().getActivityInfo(new ComponentName(context.getPackageName(), AdActivity.CLASS_NAME), 0).theme) {
                    return true;
                }
                zzakb.zzdj("Please set theme of AdActivity to @android:style/Theme.Translucent to enable transparent background interstitial ad.");
                return false;
            } catch (PackageManager.NameNotFoundException unused) {
                zzakb.zzdk("Fail to fetch AdActivity theme");
            }
        }
        zzakb.zzdj("Please set theme of AdActivity to @android:style/Theme.Translucent to enable transparent background interstitial ad.");
        return false;
    }

    public final void zzb(zzjj zzjjVar, long j) {
        synchronized (this.mLock) {
            long jZzrb = com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzrb();
            long jCurrentTimeMillis = com.google.android.gms.ads.internal.zzbv.zzer().currentTimeMillis();
            if (this.zzcqe == -1) {
                if (jCurrentTimeMillis - jZzrb > ((Long) zzkb.zzik().zzd(zznk.zzayi)).longValue()) {
                    this.zzcqg = -1;
                } else {
                    this.zzcqg = com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzrc();
                }
                this.zzcqe = j;
                j = this.zzcqe;
            }
            this.zzcqd = j;
            if (zzjjVar == null || zzjjVar.extras == null || zzjjVar.extras.getInt("gw", 2) != 1) {
                this.zzcqf++;
                this.zzcqg++;
                if (this.zzcqg == 0) {
                    this.zzcqh = 0L;
                    com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzk(jCurrentTimeMillis);
                } else {
                    this.zzcqh = jCurrentTimeMillis - com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzrd();
                }
            }
        }
    }

    public final Bundle zzk(Context context, String str) {
        Bundle bundle;
        synchronized (this.mLock) {
            bundle = new Bundle();
            bundle.putString("session_id", this.zzasc);
            bundle.putLong("basets", this.zzcqe);
            bundle.putLong("currts", this.zzcqd);
            bundle.putString("seq_num", str);
            bundle.putInt("preqs", this.zzcqf);
            bundle.putInt("preqs_in_session", this.zzcqg);
            bundle.putLong("time_in_session", this.zzcqh);
            bundle.putInt("pclick", this.zzcqi);
            bundle.putInt("pimp", this.zzcqj);
            bundle.putBoolean("support_transparent_background", zzah(context));
        }
        return bundle;
    }

    public final void zzpm() {
        synchronized (this.mLock) {
            this.zzcqj++;
        }
    }

    public final void zzpn() {
        synchronized (this.mLock) {
            this.zzcqi++;
        }
    }
}
