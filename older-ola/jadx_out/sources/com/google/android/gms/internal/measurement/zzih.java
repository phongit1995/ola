package com.google.android.gms.internal.measurement;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.MainThread;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.Size;
import android.support.annotation.WorkerThread;
import android.support.v4.util.ArrayMap;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.util.VisibleForTesting;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
public final class zzih extends zzdz {

    @VisibleForTesting
    protected zzig zzaqd;
    private volatile zzig zzaqe;
    private zzig zzaqf;
    private final Map<Activity, zzig> zzaqg;
    private zzig zzaqh;
    private String zzaqi;

    public zzih(zzgn zzgnVar) {
        super(zzgnVar);
        this.zzaqg = new ArrayMap();
    }

    @MainThread
    private final void zza(Activity activity, zzig zzigVar, boolean z) {
        zzig zzigVar2 = this.zzaqe == null ? this.zzaqf : this.zzaqe;
        if (zzigVar.zzaqa == null) {
            zzigVar = new zzig(zzigVar.zzuk, zzcd(activity.getClass().getCanonicalName()), zzigVar.zzaqb);
        }
        this.zzaqf = this.zzaqe;
        this.zzaqe = zzigVar;
        zzgh().zzc(new zzii(this, z, zzigVar2, zzigVar));
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zza(@NonNull zzig zzigVar) {
        zzfx().zzp(zzbt().elapsedRealtime());
        if (zzgd().zzl(zzigVar.zzaqc)) {
            zzigVar.zzaqc = false;
        }
    }

    public static void zza(zzig zzigVar, Bundle bundle, boolean z) {
        if (bundle != null && zzigVar != null && (!bundle.containsKey("_sc") || z)) {
            if (zzigVar.zzuk != null) {
                bundle.putString("_sn", zzigVar.zzuk);
            } else {
                bundle.remove("_sn");
            }
            bundle.putString("_sc", zzigVar.zzaqa);
            bundle.putLong("_si", zzigVar.zzaqb);
            return;
        }
        if (bundle != null && zzigVar == null && z) {
            bundle.remove("_sn");
            bundle.remove("_sc");
            bundle.remove("_si");
        }
    }

    @VisibleForTesting
    private static String zzcd(String str) {
        String[] strArrSplit = str.split("\\.");
        String str2 = strArrSplit.length > 0 ? strArrSplit[strArrSplit.length - 1] : "";
        return str2.length() > 100 ? str2.substring(0, 100) : str2;
    }

    @MainThread
    private final zzig zze(@NonNull Activity activity) {
        Preconditions.checkNotNull(activity);
        zzig zzigVar = this.zzaqg.get(activity);
        if (zzigVar != null) {
            return zzigVar;
        }
        zzig zzigVar2 = new zzig(null, zzcd(activity.getClass().getCanonicalName()), zzgg().zzln());
        this.zzaqg.put(activity, zzigVar2);
        return zzigVar2;
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
    }

    @MainThread
    public final void onActivityCreated(Activity activity, Bundle bundle) {
        Bundle bundle2;
        if (bundle == null || (bundle2 = bundle.getBundle("com.google.firebase.analytics.screen_service")) == null) {
            return;
        }
        this.zzaqg.put(activity, new zzig(bundle2.getString("name"), bundle2.getString("referrer_name"), bundle2.getLong("id")));
    }

    @MainThread
    public final void onActivityDestroyed(Activity activity) {
        this.zzaqg.remove(activity);
    }

    @MainThread
    public final void onActivityPaused(Activity activity) {
        zzig zzigVarZze = zze(activity);
        this.zzaqf = this.zzaqe;
        this.zzaqe = null;
        zzgh().zzc(new zzij(this, zzigVarZze));
    }

    @MainThread
    public final void onActivityResumed(Activity activity) {
        zza(activity, zze(activity), false);
        zzdu zzduVarZzfx = zzfx();
        zzduVarZzfx.zzgh().zzc(new zzdx(zzduVarZzfx, zzduVarZzfx.zzbt().elapsedRealtime()));
    }

    @MainThread
    public final void onActivitySaveInstanceState(Activity activity, Bundle bundle) {
        zzig zzigVar;
        if (bundle == null || (zzigVar = this.zzaqg.get(activity)) == null) {
            return;
        }
        Bundle bundle2 = new Bundle();
        bundle2.putLong("id", zzigVar.zzaqb);
        bundle2.putString("name", zzigVar.zzuk);
        bundle2.putString("referrer_name", zzigVar.zzaqa);
        bundle.putBundle("com.google.firebase.analytics.screen_service", bundle2);
    }

    @MainThread
    public final void setCurrentScreen(@NonNull Activity activity, @Size(max = 36, min = 1) @Nullable String str, @Size(max = 36, min = 1) @Nullable String str2) {
        if (!zzee.isMainThread()) {
            zzgi().zziy().log("setCurrentScreen must be called from the main thread");
            return;
        }
        if (this.zzaqe == null) {
            zzgi().zziy().log("setCurrentScreen cannot be called while no activity active");
            return;
        }
        if (this.zzaqg.get(activity) == null) {
            zzgi().zziy().log("setCurrentScreen must be called with an activity in the activity lifecycle");
            return;
        }
        if (str2 == null) {
            str2 = zzcd(activity.getClass().getCanonicalName());
        }
        boolean zEquals = this.zzaqe.zzaqa.equals(str2);
        boolean zZzs = zzkd.zzs(this.zzaqe.zzuk, str);
        if (zEquals && zZzs) {
            zzgi().zziz().log("setCurrentScreen cannot be called with the same class and name");
            return;
        }
        if (str != null && (str.length() <= 0 || str.length() > 100)) {
            zzgi().zziy().zzg("Invalid screen name length in setCurrentScreen. Length", Integer.valueOf(str.length()));
            return;
        }
        if (str2 != null && (str2.length() <= 0 || str2.length() > 100)) {
            zzgi().zziy().zzg("Invalid class name length in setCurrentScreen. Length", Integer.valueOf(str2.length()));
            return;
        }
        zzgi().zzjc().zze("Setting current screen to name, class", str == null ? "null" : str, str2);
        zzig zzigVar = new zzig(str, str2, zzgg().zzln());
        this.zzaqg.put(activity, zzigVar);
        zza(activity, zzigVar, true);
    }

    @WorkerThread
    public final void zza(String str, zzig zzigVar) {
        zzab();
        synchronized (this) {
            if (this.zzaqi == null || this.zzaqi.equals(str) || zzigVar != null) {
                this.zzaqi = str;
                this.zzaqh = zzigVar;
            }
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzdy, com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzab() {
        super.zzab();
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
        return false;
    }

    @WorkerThread
    public final zzig zzkn() {
        zzch();
        zzab();
        return this.zzaqd;
    }

    public final zzig zzko() {
        zzfv();
        return this.zzaqe;
    }
}
