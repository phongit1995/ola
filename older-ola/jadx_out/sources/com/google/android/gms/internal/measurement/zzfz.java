package com.google.android.gms.internal.measurement;

import android.content.ComponentName;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.annotation.WorkerThread;
import com.google.android.gms.common.stats.ConnectionTracker;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.common.wrappers.PackageManagerWrapper;
import com.google.android.gms.common.wrappers.Wrappers;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfz {
    private final zzgn zzacv;

    @VisibleForTesting
    volatile zzr zzamv;

    @VisibleForTesting
    private ServiceConnection zzamw;

    zzfz(zzgn zzgnVar) {
        this.zzacv = zzgnVar;
    }

    @VisibleForTesting
    private final boolean zzjs() {
        try {
            PackageManagerWrapper packageManagerWrapperPackageManager = Wrappers.packageManager(this.zzacv.getContext());
            if (packageManagerWrapperPackageManager != null) {
                return packageManagerWrapperPackageManager.getPackageInfo("com.android.vending", 128).versionCode >= 80837300;
            }
            this.zzacv.zzgi().zzja().log("Failed to retrieve Package Manager to check Play Store compatibility");
            return false;
        } catch (Exception e) {
            this.zzacv.zzgi().zzja().zzg("Failed to retrieve Play Store version", e);
            return false;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:37:0x00ca  */
    /* JADX WARN: Removed duplicated region for block: B:38:0x00d8  */
    @android.support.annotation.WorkerThread
    @com.google.android.gms.common.util.VisibleForTesting
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    final void zzc(android.os.Bundle r11) {
        /*
            Method dump skipped, instruction units count: 281
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzfz.zzc(android.os.Bundle):void");
    }

    @WorkerThread
    protected final void zzjr() {
        this.zzacv.zzgl();
        this.zzacv.zzgh().zzab();
        zzga zzgaVar = null;
        if (!zzjs()) {
            this.zzacv.zzgi().zzja().log("Install Referrer Reporter is not available");
            this.zzamw = null;
            return;
        }
        this.zzamw = new zzgb(this);
        this.zzacv.zzgi().zzja().log("Install Referrer Reporter is initializing");
        this.zzacv.zzgh().zzab();
        Intent intent = new Intent("com.google.android.finsky.BIND_GET_INSTALL_REFERRER_SERVICE");
        intent.setComponent(new ComponentName("com.android.vending", "com.google.android.finsky.externalreferrer.GetInstallReferrerService"));
        PackageManager packageManager = this.zzacv.getContext().getPackageManager();
        if (packageManager == null) {
            this.zzacv.zzgi().zziy().log("Failed to obtain Package Manager to verify binding conditions");
            return;
        }
        List<ResolveInfo> listQueryIntentServices = packageManager.queryIntentServices(intent, 0);
        if (listQueryIntentServices == null || listQueryIntentServices.isEmpty()) {
            this.zzacv.zzgi().zzja().log("Play Service for fetching Install Referrer is unavailable on device");
            return;
        }
        ResolveInfo resolveInfo = listQueryIntentServices.get(0);
        if (resolveInfo.serviceInfo != null) {
            String str = resolveInfo.serviceInfo.packageName;
            if (resolveInfo.serviceInfo.name == null || this.zzamw == null || !"com.android.vending".equals(str) || !zzjs()) {
                this.zzacv.zzgi().zzja().log("Play Store missing or incompatible. Version 8.3.73 or later required");
                return;
            }
            try {
                this.zzacv.zzgi().zzja().zzg("Install Referrer Service is", ConnectionTracker.getInstance().bindService(this.zzacv.getContext(), new Intent(intent), this.zzamw, 1) ? "available" : "not available");
            } catch (Exception e) {
                this.zzacv.zzgi().zziv().zzg("Exception occurred while binding to Install Referrer Service", e.getMessage());
            }
        }
    }

    @WorkerThread
    @VisibleForTesting
    @Nullable
    final Bundle zzjt() {
        this.zzacv.zzgh().zzab();
        if (this.zzamv == null) {
            this.zzacv.zzgi().zziy().log("Attempting to use Install Referrer Service while it is not initialized");
            return null;
        }
        Bundle bundle = new Bundle();
        bundle.putString("package_name", this.zzacv.getContext().getPackageName());
        try {
            Bundle bundleZza = this.zzamv.zza(bundle);
            if (bundleZza != null) {
                return bundleZza;
            }
            this.zzacv.zzgi().zziv().log("Install Referrer Service returned a null response");
            return null;
        } catch (Exception e) {
            this.zzacv.zzgi().zziv().zzg("Exception occurred while retrieving the Install Referrer", e.getMessage());
            return null;
        }
    }
}
