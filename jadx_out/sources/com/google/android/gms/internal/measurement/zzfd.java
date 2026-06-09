package com.google.android.gms.internal.measurement;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.support.annotation.WorkerThread;
import android.text.TextUtils;
import com.facebook.internal.AnalyticsEvents;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.GoogleServices;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.wrappers.InstantApps;
import com.google.firebase.iid.FirebaseInstanceId;
import java.math.BigInteger;
import java.util.Locale;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfd extends zzdz {
    private String zzafa;
    private String zzafh;
    private long zzafl;
    private int zzagb;
    private int zzakd;
    private long zzake;
    private String zztf;
    private String zztg;
    private String zzth;

    zzfd(zzgn zzgnVar) {
        super(zzgnVar);
    }

    @WorkerThread
    private final String zzgr() {
        zzab();
        zzfv();
        if (zzgk().zzbb(this.zzth) && !this.zzacv.isEnabled()) {
            return null;
        }
        try {
            return FirebaseInstanceId.getInstance().getId();
        } catch (IllegalStateException unused) {
            zzgi().zziy().log("Failed to retrieve Firebase Instance Id");
            return null;
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
    }

    final String getGmpAppId() {
        zzch();
        return this.zzafa;
    }

    @Override // com.google.android.gms.internal.measurement.zzdy, com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzab() {
        super.zzab();
    }

    final String zzah() {
        zzch();
        return this.zzth;
    }

    @WorkerThread
    final zzeb zzbl(String str) {
        zzab();
        zzfv();
        String strZzah = zzah();
        String gmpAppId = getGmpAppId();
        zzch();
        String str2 = this.zztg;
        long jZzis = zzis();
        zzch();
        String str3 = this.zzafh;
        long jZzgw = zzgk().zzgw();
        zzch();
        zzab();
        if (this.zzake == 0) {
            this.zzake = this.zzacv.zzgg().zzd(getContext(), getContext().getPackageName());
        }
        long j = this.zzake;
        boolean zIsEnabled = this.zzacv.isEnabled();
        boolean z = !zzgj().zzamm;
        String strZzgr = zzgr();
        zzch();
        long j2 = this.zzafl;
        long jZzke = this.zzacv.zzke();
        int iZzit = zzit();
        zzeh zzehVarZzgk = zzgk();
        zzehVarZzgk.zzfv();
        Boolean boolZzat = zzehVarZzgk.zzat("google_analytics_adid_collection_enabled");
        boolean zBooleanValue = Boolean.valueOf(boolZzat == null || boolZzat.booleanValue()).booleanValue();
        zzeh zzehVarZzgk2 = zzgk();
        zzehVarZzgk2.zzfv();
        Boolean boolZzat2 = zzehVarZzgk2.zzat("google_analytics_ssaid_collection_enabled");
        return new zzeb(strZzah, gmpAppId, str2, jZzis, str3, jZzgw, j, str, zIsEnabled, z, strZzgr, j2, jZzke, iZzit, zBooleanValue, Boolean.valueOf(boolZzat2 == null || boolZzat2.booleanValue()).booleanValue(), zzgj().zzjo());
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Clock zzbt() {
        return super.zzbt();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy, com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfu() {
        super.zzfu();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy, com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfv() {
        super.zzfv();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy, com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfw() {
        super.zzfw();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzdu zzfx() {
        return super.zzfx();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzhm zzfy() {
        return super.zzfy();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzfd zzfz() {
        return super.zzfz();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzik zzga() {
        return super.zzga();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzih zzgb() {
        return super.zzgb();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzfe zzgc() {
        return super.zzgc();
    }

    @Override // com.google.android.gms.internal.measurement.zzdy
    public final /* bridge */ /* synthetic */ zzjj zzgd() {
        return super.zzgd();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzer zzge() {
        return super.zzge();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzfg zzgf() {
        return super.zzgf();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzkd zzgg() {
        return super.zzgg();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ zzgi zzgh() {
        return super.zzgh();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ zzfi zzgi() {
        return super.zzgi();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzft zzgj() {
        return super.zzgj();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzeh zzgk() {
        return super.zzgk();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ zzee zzgl() {
        return super.zzgl();
    }

    @Override // com.google.android.gms.internal.measurement.zzdz
    protected final boolean zzgn() {
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzdz
    protected final void zzgo() {
        zzfk zzfkVarZzja;
        String str;
        String installerPackageName = "unknown";
        String str2 = AnalyticsEvents.PARAMETER_DIALOG_OUTCOME_VALUE_UNKNOWN;
        String string = AnalyticsEvents.PARAMETER_DIALOG_OUTCOME_VALUE_UNKNOWN;
        String packageName = getContext().getPackageName();
        PackageManager packageManager = getContext().getPackageManager();
        int i = Integer.MIN_VALUE;
        if (packageManager == null) {
            zzgi().zziv().zzg("PackageManager is null, app identity information might be inaccurate. appId", zzfi.zzbp(packageName));
        } else {
            try {
                installerPackageName = packageManager.getInstallerPackageName(packageName);
            } catch (IllegalArgumentException unused) {
                zzgi().zziv().zzg("Error retrieving app installer package name. appId", zzfi.zzbp(packageName));
            }
            if (installerPackageName == null) {
                installerPackageName = "manual_install";
            } else if ("com.android.vending".equals(installerPackageName)) {
                installerPackageName = "";
            }
            try {
                PackageInfo packageInfo = packageManager.getPackageInfo(getContext().getPackageName(), 0);
                if (packageInfo != null) {
                    CharSequence applicationLabel = packageManager.getApplicationLabel(packageInfo.applicationInfo);
                    if (!TextUtils.isEmpty(applicationLabel)) {
                        string = applicationLabel.toString();
                    }
                    String str3 = packageInfo.versionName;
                    try {
                        i = packageInfo.versionCode;
                        str2 = str3;
                    } catch (PackageManager.NameNotFoundException unused2) {
                        str2 = str3;
                        zzgi().zziv().zze("Error retrieving package info. appId, appName", zzfi.zzbp(packageName), string);
                    }
                }
            } catch (PackageManager.NameNotFoundException unused3) {
            }
        }
        this.zzth = packageName;
        this.zzafh = installerPackageName;
        this.zztg = str2;
        this.zzakd = i;
        this.zztf = string;
        this.zzake = 0L;
        zzgl();
        Status statusInitialize = GoogleServices.initialize(getContext());
        boolean z = true;
        boolean z2 = statusInitialize != null && statusInitialize.isSuccess();
        if (!z2) {
            if (statusInitialize == null) {
                zzgi().zziv().log("GoogleService failed to initialize (no status)");
            } else {
                zzgi().zziv().zze("GoogleService failed to initialize, status", Integer.valueOf(statusInitialize.getStatusCode()), statusInitialize.getStatusMessage());
            }
        }
        if (z2) {
            Boolean boolZzhp = zzgk().zzhp();
            if (zzgk().zzho()) {
                zzfkVarZzja = zzgi().zzja();
                str = "Collection disabled with firebase_analytics_collection_deactivated=1";
            } else if (boolZzhp != null && !boolZzhp.booleanValue()) {
                zzfkVarZzja = zzgi().zzja();
                str = "Collection disabled with firebase_analytics_collection_enabled=0";
            } else if (boolZzhp == null && GoogleServices.isMeasurementExplicitlyDisabled()) {
                zzfkVarZzja = zzgi().zzja();
                str = "Collection disabled with google_app_measurement_enable=0";
            } else {
                zzgi().zzjc().log("Collection enabled");
            }
            zzfkVarZzja.log(str);
            z = false;
        } else {
            z = false;
        }
        this.zzafa = "";
        this.zzafl = 0L;
        zzgl();
        if (this.zzacv.zzkd() != null) {
            this.zzafa = this.zzacv.zzkd();
        } else {
            try {
                String googleAppId = GoogleServices.getGoogleAppId();
                if (TextUtils.isEmpty(googleAppId)) {
                    googleAppId = "";
                }
                this.zzafa = googleAppId;
                if (z) {
                    zzgi().zzjc().zze("App package, google app id", this.zzth, this.zzafa);
                }
            } catch (IllegalStateException e) {
                zzgi().zziv().zze("getGoogleAppId or isMeasurementEnabled failed with exception. appId", zzfi.zzbp(packageName), e);
            }
        }
        if (Build.VERSION.SDK_INT >= 16) {
            this.zzagb = InstantApps.isInstantApp(getContext()) ? 1 : 0;
        } else {
            this.zzagb = 0;
        }
    }

    @WorkerThread
    final String zzir() {
        byte[] bArr = new byte[16];
        zzgg().zzlo().nextBytes(bArr);
        return String.format(Locale.US, "%032x", new BigInteger(1, bArr));
    }

    final int zzis() {
        zzch();
        return this.zzakd;
    }

    final int zzit() {
        zzch();
        return this.zzagb;
    }
}
