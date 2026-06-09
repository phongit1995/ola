package com.google.android.gms.internal.measurement;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import android.support.annotation.WorkerThread;
import android.support.v4.util.ArrayMap;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.measurement.AppMeasurement;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.Tasks;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
public final class zzhm extends zzdz {

    @VisibleForTesting
    protected zzif zzapl;
    private AppMeasurement.EventInterceptor zzapm;
    private final Set<AppMeasurement.OnEventListener> zzapn;
    private boolean zzapo;
    private final AtomicReference<String> zzapp;

    @VisibleForTesting
    protected boolean zzapq;

    protected zzhm(zzgn zzgnVar) {
        super(zzgnVar);
        this.zzapn = new CopyOnWriteArraySet();
        this.zzapq = true;
        this.zzapp = new AtomicReference<>();
    }

    private final void zza(AppMeasurement.ConditionalUserProperty conditionalUserProperty) {
        long jCurrentTimeMillis = zzbt().currentTimeMillis();
        Preconditions.checkNotNull(conditionalUserProperty);
        Preconditions.checkNotEmpty(conditionalUserProperty.mName);
        Preconditions.checkNotEmpty(conditionalUserProperty.mOrigin);
        Preconditions.checkNotNull(conditionalUserProperty.mValue);
        conditionalUserProperty.mCreationTimestamp = jCurrentTimeMillis;
        String str = conditionalUserProperty.mName;
        Object obj = conditionalUserProperty.mValue;
        if (zzgg().zzcj(str) != 0) {
            zzgi().zziv().zzg("Invalid conditional user property name", zzgf().zzbo(str));
            return;
        }
        if (zzgg().zzi(str, obj) != 0) {
            zzgi().zziv().zze("Invalid conditional user property value", zzgf().zzbo(str), obj);
            return;
        }
        Object objZzj = zzgg().zzj(str, obj);
        if (objZzj == null) {
            zzgi().zziv().zze("Unable to normalize conditional user property value", zzgf().zzbo(str), obj);
            return;
        }
        conditionalUserProperty.mValue = objZzj;
        long j = conditionalUserProperty.mTriggerTimeout;
        if (!TextUtils.isEmpty(conditionalUserProperty.mTriggerEventName) && (j > 15552000000L || j < 1)) {
            zzgi().zziv().zze("Invalid conditional user property timeout", zzgf().zzbo(str), Long.valueOf(j));
            return;
        }
        long j2 = conditionalUserProperty.mTimeToLive;
        if (j2 > 15552000000L || j2 < 1) {
            zzgi().zziv().zze("Invalid conditional user property time to live", zzgf().zzbo(str), Long.valueOf(j2));
        } else {
            zzgh().zzc(new zzht(this, conditionalUserProperty));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:23:0x0090  */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zza(java.lang.String r32, java.lang.String r33, long r34, android.os.Bundle r36, boolean r37, boolean r38, boolean r39, java.lang.String r40) {
        /*
            Method dump skipped, instruction units count: 905
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzhm.zza(java.lang.String, java.lang.String, long, android.os.Bundle, boolean, boolean, boolean, java.lang.String):void");
    }

    private final void zza(String str, String str2, long j, Object obj) {
        zzgh().zzc(new zzho(this, str, str2, obj, j));
    }

    private final void zza(String str, String str2, Bundle bundle, boolean z, boolean z2, boolean z3, String str3) {
        zzb(str, str2, zzbt().currentTimeMillis(), bundle, z, z2, z3, str3);
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zza(String str, String str2, Object obj, long j) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        zzab();
        zzfv();
        zzch();
        if (!this.zzacv.isEnabled()) {
            zzgi().zzjb().log("User property not set since app measurement is disabled");
        } else if (this.zzacv.zzkg()) {
            zzgi().zzjb().zze("Setting user property (FE)", zzgf().zzbm(str2), obj);
            zzga().zzb(new zzka(str2, j, obj, str));
        }
    }

    private final void zza(String str, String str2, String str3, Bundle bundle) {
        long jCurrentTimeMillis = zzbt().currentTimeMillis();
        Preconditions.checkNotEmpty(str2);
        AppMeasurement.ConditionalUserProperty conditionalUserProperty = new AppMeasurement.ConditionalUserProperty();
        conditionalUserProperty.mAppId = str;
        conditionalUserProperty.mName = str2;
        conditionalUserProperty.mCreationTimestamp = jCurrentTimeMillis;
        if (str3 != null) {
            conditionalUserProperty.mExpiredEventName = str3;
            conditionalUserProperty.mExpiredEventParams = bundle;
        }
        zzgh().zzc(new zzhu(this, conditionalUserProperty));
    }

    @VisibleForTesting
    private final Map<String, Object> zzb(String str, String str2, String str3, boolean z) {
        zzfk zzfkVarZziy;
        String str4;
        if (zzgh().zzju()) {
            zzfkVarZziy = zzgi().zziv();
            str4 = "Cannot get user properties from analytics worker thread";
        } else if (zzee.isMainThread()) {
            zzfkVarZziy = zzgi().zziv();
            str4 = "Cannot get user properties from main thread";
        } else {
            AtomicReference atomicReference = new AtomicReference();
            synchronized (atomicReference) {
                this.zzacv.zzgh().zzc(new zzhw(this, atomicReference, str, str2, str3, z));
                try {
                    atomicReference.wait(5000L);
                } catch (InterruptedException e) {
                    zzgi().zziy().zzg("Interrupted waiting for get user properties", e);
                }
            }
            List<zzka> list = (List) atomicReference.get();
            if (list != null) {
                ArrayMap arrayMap = new ArrayMap(list.size());
                for (zzka zzkaVar : list) {
                    arrayMap.put(zzkaVar.name, zzkaVar.getValue());
                }
                return arrayMap;
            }
            zzfkVarZziy = zzgi().zziy();
            str4 = "Timed out waiting for get user properties";
        }
        zzfkVarZziy.log(str4);
        return Collections.emptyMap();
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zzb(AppMeasurement.ConditionalUserProperty conditionalUserProperty) {
        zzab();
        zzch();
        Preconditions.checkNotNull(conditionalUserProperty);
        Preconditions.checkNotEmpty(conditionalUserProperty.mName);
        Preconditions.checkNotEmpty(conditionalUserProperty.mOrigin);
        Preconditions.checkNotNull(conditionalUserProperty.mValue);
        if (!this.zzacv.isEnabled()) {
            zzgi().zzjb().log("Conditional property not sent since Firebase Analytics is disabled");
            return;
        }
        zzka zzkaVar = new zzka(conditionalUserProperty.mName, conditionalUserProperty.mTriggeredTimestamp, conditionalUserProperty.mValue, conditionalUserProperty.mOrigin);
        try {
            zzex zzexVarZza = zzgg().zza(conditionalUserProperty.mAppId, conditionalUserProperty.mTriggeredEventName, conditionalUserProperty.mTriggeredEventParams, conditionalUserProperty.mOrigin, 0L, true, false);
            zzga().zzd(new zzef(conditionalUserProperty.mAppId, conditionalUserProperty.mOrigin, zzkaVar, conditionalUserProperty.mCreationTimestamp, false, conditionalUserProperty.mTriggerEventName, zzgg().zza(conditionalUserProperty.mAppId, conditionalUserProperty.mTimedOutEventName, conditionalUserProperty.mTimedOutEventParams, conditionalUserProperty.mOrigin, 0L, true, false), conditionalUserProperty.mTriggerTimeout, zzexVarZza, conditionalUserProperty.mTimeToLive, zzgg().zza(conditionalUserProperty.mAppId, conditionalUserProperty.mExpiredEventName, conditionalUserProperty.mExpiredEventParams, conditionalUserProperty.mOrigin, 0L, true, false)));
        } catch (IllegalArgumentException unused) {
        }
    }

    private final void zzb(String str, String str2, long j, Bundle bundle, boolean z, boolean z2, boolean z3, String str3) {
        Bundle bundle2;
        if (bundle == null) {
            bundle2 = new Bundle();
        } else {
            Bundle bundle3 = new Bundle(bundle);
            for (String str4 : bundle3.keySet()) {
                Object obj = bundle3.get(str4);
                if (obj instanceof Bundle) {
                    bundle3.putBundle(str4, new Bundle((Bundle) obj));
                } else {
                    int i = 0;
                    if (obj instanceof Parcelable[]) {
                        Parcelable[] parcelableArr = (Parcelable[]) obj;
                        while (i < parcelableArr.length) {
                            if (parcelableArr[i] instanceof Bundle) {
                                parcelableArr[i] = new Bundle((Bundle) parcelableArr[i]);
                            }
                            i++;
                        }
                    } else if (obj instanceof ArrayList) {
                        ArrayList arrayList = (ArrayList) obj;
                        while (i < arrayList.size()) {
                            Object obj2 = arrayList.get(i);
                            if (obj2 instanceof Bundle) {
                                arrayList.set(i, new Bundle((Bundle) obj2));
                            }
                            i++;
                        }
                    }
                }
            }
            bundle2 = bundle3;
        }
        zzgh().zzc(new zzie(this, str, str2, j, bundle2, z, z2, z3, str3));
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zzc(AppMeasurement.ConditionalUserProperty conditionalUserProperty) {
        zzab();
        zzch();
        Preconditions.checkNotNull(conditionalUserProperty);
        Preconditions.checkNotEmpty(conditionalUserProperty.mName);
        if (!this.zzacv.isEnabled()) {
            zzgi().zzjb().log("Conditional property not cleared since Firebase Analytics is disabled");
            return;
        }
        try {
            zzga().zzd(new zzef(conditionalUserProperty.mAppId, conditionalUserProperty.mOrigin, new zzka(conditionalUserProperty.mName, 0L, null, null), conditionalUserProperty.mCreationTimestamp, conditionalUserProperty.mActive, conditionalUserProperty.mTriggerEventName, null, conditionalUserProperty.mTriggerTimeout, null, conditionalUserProperty.mTimeToLive, zzgg().zza(conditionalUserProperty.mAppId, conditionalUserProperty.mExpiredEventName, conditionalUserProperty.mExpiredEventParams, conditionalUserProperty.mOrigin, conditionalUserProperty.mCreationTimestamp, true, false)));
        } catch (IllegalArgumentException unused) {
        }
    }

    @VisibleForTesting
    private final List<AppMeasurement.ConditionalUserProperty> zzf(String str, String str2, String str3) {
        zzfk zzfkVarZziv;
        String str4;
        if (zzgh().zzju()) {
            zzfkVarZziv = zzgi().zziv();
            str4 = "Cannot get conditional user properties from analytics worker thread";
        } else {
            if (!zzee.isMainThread()) {
                AtomicReference atomicReference = new AtomicReference();
                synchronized (atomicReference) {
                    this.zzacv.zzgh().zzc(new zzhv(this, atomicReference, str, str2, str3));
                    try {
                        atomicReference.wait(5000L);
                    } catch (InterruptedException e) {
                        zzgi().zziy().zze("Interrupted waiting for get conditional user properties", str, e);
                    }
                }
                List<zzef> list = (List) atomicReference.get();
                if (list == null) {
                    zzgi().zziy().zzg("Timed out waiting for get conditional user properties", str);
                    return Collections.emptyList();
                }
                ArrayList arrayList = new ArrayList(list.size());
                for (zzef zzefVar : list) {
                    AppMeasurement.ConditionalUserProperty conditionalUserProperty = new AppMeasurement.ConditionalUserProperty();
                    conditionalUserProperty.mAppId = zzefVar.packageName;
                    conditionalUserProperty.mOrigin = zzefVar.origin;
                    conditionalUserProperty.mCreationTimestamp = zzefVar.creationTimestamp;
                    conditionalUserProperty.mName = zzefVar.zzage.name;
                    conditionalUserProperty.mValue = zzefVar.zzage.getValue();
                    conditionalUserProperty.mActive = zzefVar.active;
                    conditionalUserProperty.mTriggerEventName = zzefVar.triggerEventName;
                    if (zzefVar.zzagf != null) {
                        conditionalUserProperty.mTimedOutEventName = zzefVar.zzagf.name;
                        if (zzefVar.zzagf.zzahg != null) {
                            conditionalUserProperty.mTimedOutEventParams = zzefVar.zzagf.zzahg.zzin();
                        }
                    }
                    conditionalUserProperty.mTriggerTimeout = zzefVar.triggerTimeout;
                    if (zzefVar.zzagg != null) {
                        conditionalUserProperty.mTriggeredEventName = zzefVar.zzagg.name;
                        if (zzefVar.zzagg.zzahg != null) {
                            conditionalUserProperty.mTriggeredEventParams = zzefVar.zzagg.zzahg.zzin();
                        }
                    }
                    conditionalUserProperty.mTriggeredTimestamp = zzefVar.zzage.zzast;
                    conditionalUserProperty.mTimeToLive = zzefVar.timeToLive;
                    if (zzefVar.zzagh != null) {
                        conditionalUserProperty.mExpiredEventName = zzefVar.zzagh.name;
                        if (zzefVar.zzagh.zzahg != null) {
                            conditionalUserProperty.mExpiredEventParams = zzefVar.zzagh.zzahg.zzin();
                        }
                    }
                    arrayList.add(conditionalUserProperty);
                }
                return arrayList;
            }
            zzfkVarZziv = zzgi().zziv();
            str4 = "Cannot get conditional user properties from main thread";
        }
        zzfkVarZziv.log(str4);
        return Collections.emptyList();
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zzi(boolean z) {
        zzab();
        zzfv();
        zzch();
        zzgi().zzjb().zzg("Setting app measurement enabled (FE)", Boolean.valueOf(z));
        zzgj().setMeasurementEnabled(z);
        if (!zzgk().zzbc(zzfz().zzah())) {
            zzga().zzkp();
        } else if (!this.zzacv.isEnabled() || !this.zzapq) {
            zzga().zzkp();
        } else {
            zzgi().zzjb().log("Recording app launch after enabling measurement for the first time (FE)");
            zzkm();
        }
    }

    public final void clearConditionalUserProperty(String str, String str2, Bundle bundle) {
        zzfv();
        zza((String) null, str, str2, bundle);
    }

    public final void clearConditionalUserPropertyAs(String str, String str2, String str3, Bundle bundle) {
        Preconditions.checkNotEmpty(str);
        zzfu();
        zza(str, str2, str3, bundle);
    }

    public final Task<String> getAppInstanceId() {
        try {
            String strZzjk = zzgj().zzjk();
            return strZzjk != null ? Tasks.forResult(strZzjk) : Tasks.call(zzgh().zzjv(), new zzhq(this));
        } catch (Exception e) {
            zzgi().zziy().log("Failed to schedule task for getAppInstanceId");
            return Tasks.forException(e);
        }
    }

    public final List<AppMeasurement.ConditionalUserProperty> getConditionalUserProperties(String str, String str2) {
        zzfv();
        return zzf(null, str, str2);
    }

    public final List<AppMeasurement.ConditionalUserProperty> getConditionalUserPropertiesAs(String str, String str2, String str3) {
        Preconditions.checkNotEmpty(str);
        zzfu();
        return zzf(str, str2, str3);
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
    }

    public final Map<String, Object> getUserProperties(String str, String str2, boolean z) {
        zzfv();
        return zzb(null, str, str2, z);
    }

    public final Map<String, Object> getUserPropertiesAs(String str, String str2, String str3, boolean z) {
        Preconditions.checkNotEmpty(str);
        zzfu();
        return zzb(str, str2, str3, z);
    }

    public final void logEvent(String str, String str2, Bundle bundle) {
        zzfv();
        zza(str, str2, bundle, true, this.zzapm == null || zzkd.zzcm(str2), false, null);
    }

    public final void logEventNoInterceptor(String str, String str2, Bundle bundle, long j) {
        zzfv();
        zzb(str, str2, j, bundle, false, true, true, null);
    }

    public final void registerOnMeasurementEventListener(AppMeasurement.OnEventListener onEventListener) {
        zzfv();
        zzch();
        Preconditions.checkNotNull(onEventListener);
        if (this.zzapn.add(onEventListener)) {
            return;
        }
        zzgi().zziy().log("OnEventListener already registered");
    }

    public final void resetAnalyticsData() {
        zzgh().zzc(new zzhs(this, zzbt().currentTimeMillis()));
    }

    public final void setConditionalUserProperty(AppMeasurement.ConditionalUserProperty conditionalUserProperty) {
        Preconditions.checkNotNull(conditionalUserProperty);
        zzfv();
        AppMeasurement.ConditionalUserProperty conditionalUserProperty2 = new AppMeasurement.ConditionalUserProperty(conditionalUserProperty);
        if (!TextUtils.isEmpty(conditionalUserProperty2.mAppId)) {
            zzgi().zziy().log("Package name should be null when calling setConditionalUserProperty");
        }
        conditionalUserProperty2.mAppId = null;
        zza(conditionalUserProperty2);
    }

    public final void setConditionalUserPropertyAs(AppMeasurement.ConditionalUserProperty conditionalUserProperty) {
        Preconditions.checkNotNull(conditionalUserProperty);
        Preconditions.checkNotEmpty(conditionalUserProperty.mAppId);
        zzfu();
        zza(new AppMeasurement.ConditionalUserProperty(conditionalUserProperty));
    }

    @WorkerThread
    public final void setEventInterceptor(AppMeasurement.EventInterceptor eventInterceptor) {
        zzab();
        zzfv();
        zzch();
        if (eventInterceptor != null && eventInterceptor != this.zzapm) {
            Preconditions.checkState(this.zzapm == null, "EventInterceptor already set.");
        }
        this.zzapm = eventInterceptor;
    }

    public final void setMeasurementEnabled(boolean z) {
        zzch();
        zzfv();
        zzgh().zzc(new zzib(this, z));
    }

    public final void setMinimumSessionDuration(long j) {
        zzfv();
        zzgh().zzc(new zzic(this, j));
    }

    public final void setSessionTimeoutDuration(long j) {
        zzfv();
        zzgh().zzc(new zzid(this, j));
    }

    public final void setUserProperty(String str, String str2, Object obj) {
        Preconditions.checkNotEmpty(str);
        long jCurrentTimeMillis = zzbt().currentTimeMillis();
        int iZzcj = zzgg().zzcj(str2);
        if (iZzcj != 0) {
            zzgg();
            this.zzacv.zzgg().zza(iZzcj, "_ev", zzkd.zza(str2, 24, true), str2 != null ? str2.length() : 0);
            return;
        }
        if (obj == null) {
            zza(str, str2, jCurrentTimeMillis, (Object) null);
            return;
        }
        int iZzi = zzgg().zzi(str2, obj);
        if (iZzi != 0) {
            zzgg();
            this.zzacv.zzgg().zza(iZzi, "_ev", zzkd.zza(str2, 24, true), ((obj instanceof String) || (obj instanceof CharSequence)) ? String.valueOf(obj).length() : 0);
        } else {
            Object objZzj = zzgg().zzj(str2, obj);
            if (objZzj != null) {
                zza(str, str2, jCurrentTimeMillis, objZzj);
            }
        }
    }

    public final void unregisterOnMeasurementEventListener(AppMeasurement.OnEventListener onEventListener) {
        zzfv();
        zzch();
        Preconditions.checkNotNull(onEventListener);
        if (this.zzapn.remove(onEventListener)) {
            return;
        }
        zzgi().zziy().log("OnEventListener had not been registered");
    }

    @WorkerThread
    final void zza(String str, String str2, Bundle bundle) {
        zzfv();
        zzab();
        zza(str, str2, zzbt().currentTimeMillis(), bundle, true, this.zzapm == null || zzkd.zzcm(str2), false, null);
    }

    public final void zza(String str, String str2, Bundle bundle, boolean z) {
        zzfv();
        zza(str, str2, bundle, true, this.zzapm == null || zzkd.zzcm(str2), true, null);
    }

    @Override // com.google.android.gms.internal.measurement.zzdy, com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzab() {
        super.zzab();
    }

    @Nullable
    final String zzaj(long j) {
        AtomicReference atomicReference = new AtomicReference();
        synchronized (atomicReference) {
            zzgh().zzc(new zzhr(this, atomicReference));
            try {
                atomicReference.wait(j);
            } catch (InterruptedException unused) {
                zzgi().zziy().log("Interrupted waiting for app instance id");
                return null;
            }
        }
        return (String) atomicReference.get();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Clock zzbt() {
        return super.zzbt();
    }

    final void zzbu(@Nullable String str) {
        this.zzapp.set(str);
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

    public final List<zzka> zzj(boolean z) {
        zzfk zzfkVarZziy;
        String str;
        zzfv();
        zzch();
        zzgi().zzjb().log("Fetching user attributes (FE)");
        if (zzgh().zzju()) {
            zzfkVarZziy = zzgi().zziv();
            str = "Cannot get all user properties from analytics worker thread";
        } else if (zzee.isMainThread()) {
            zzfkVarZziy = zzgi().zziv();
            str = "Cannot get all user properties from main thread";
        } else {
            AtomicReference atomicReference = new AtomicReference();
            synchronized (atomicReference) {
                this.zzacv.zzgh().zzc(new zzhp(this, atomicReference, z));
                try {
                    atomicReference.wait(5000L);
                } catch (InterruptedException e) {
                    zzgi().zziy().zzg("Interrupted waiting for get user properties", e);
                }
            }
            List<zzka> list = (List) atomicReference.get();
            if (list != null) {
                return list;
            }
            zzfkVarZziy = zzgi().zziy();
            str = "Timed out waiting for get user properties";
        }
        zzfkVarZziy.log(str);
        return Collections.emptyList();
    }

    @Nullable
    public final String zzjk() {
        zzfv();
        return this.zzapp.get();
    }

    public final Boolean zzkh() {
        AtomicReference atomicReference = new AtomicReference();
        return (Boolean) zzgh().zza(atomicReference, 15000L, "boolean test flag value", new zzhn(this, atomicReference));
    }

    public final String zzki() {
        AtomicReference atomicReference = new AtomicReference();
        return (String) zzgh().zza(atomicReference, 15000L, "String test flag value", new zzhx(this, atomicReference));
    }

    public final Long zzkj() {
        AtomicReference atomicReference = new AtomicReference();
        return (Long) zzgh().zza(atomicReference, 15000L, "long test flag value", new zzhy(this, atomicReference));
    }

    public final Integer zzkk() {
        AtomicReference atomicReference = new AtomicReference();
        return (Integer) zzgh().zza(atomicReference, 15000L, "int test flag value", new zzhz(this, atomicReference));
    }

    public final Double zzkl() {
        AtomicReference atomicReference = new AtomicReference();
        return (Double) zzgh().zza(atomicReference, 15000L, "double test flag value", new zzia(this, atomicReference));
    }

    @WorkerThread
    public final void zzkm() {
        zzab();
        zzfv();
        zzch();
        if (this.zzacv.zzkg()) {
            zzga().zzkm();
            this.zzapq = false;
            String strZzjn = zzgj().zzjn();
            if (TextUtils.isEmpty(strZzjn)) {
                return;
            }
            zzge().zzch();
            if (strZzjn.equals(Build.VERSION.RELEASE)) {
                return;
            }
            Bundle bundle = new Bundle();
            bundle.putString("_po", strZzjn);
            logEvent("auto", "_ou", bundle);
        }
    }
}
