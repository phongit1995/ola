package com.google.android.gms.internal.measurement;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.WorkerThread;
import android.support.v4.util.ArrayMap;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Clock;
import java.util.Iterator;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
public final class zzdu extends zzdy {
    private final Map<String, Long> zzaeu;
    private final Map<String, Integer> zzaev;
    private long zzaew;

    public zzdu(zzgn zzgnVar) {
        super(zzgnVar);
        this.zzaev = new ArrayMap();
        this.zzaeu = new ArrayMap();
    }

    @WorkerThread
    private final void zza(long j, zzig zzigVar) {
        if (zzigVar == null) {
            zzgi().zzjc().log("Not logging ad exposure. No active activity");
            return;
        }
        if (j < 1000) {
            zzgi().zzjc().zzg("Not logging ad exposure. Less than 1000 ms. exposure", Long.valueOf(j));
            return;
        }
        Bundle bundle = new Bundle();
        bundle.putLong("_xt", j);
        zzih.zza(zzigVar, bundle, true);
        zzfy().logEvent("am", "_xa", bundle);
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zza(String str, long j) {
        zzfv();
        zzab();
        Preconditions.checkNotEmpty(str);
        if (this.zzaev.isEmpty()) {
            this.zzaew = j;
        }
        Integer num = this.zzaev.get(str);
        if (num != null) {
            this.zzaev.put(str, Integer.valueOf(num.intValue() + 1));
        } else if (this.zzaev.size() >= 100) {
            zzgi().zziy().log("Too many ads visible");
        } else {
            this.zzaev.put(str, 1);
            this.zzaeu.put(str, Long.valueOf(j));
        }
    }

    @WorkerThread
    private final void zza(String str, long j, zzig zzigVar) {
        if (zzigVar == null) {
            zzgi().zzjc().log("Not logging ad unit exposure. No active activity");
            return;
        }
        if (j < 1000) {
            zzgi().zzjc().zzg("Not logging ad unit exposure. Less than 1000 ms. exposure", Long.valueOf(j));
            return;
        }
        Bundle bundle = new Bundle();
        bundle.putString("_ai", str);
        bundle.putLong("_xt", j);
        zzih.zza(zzigVar, bundle, true);
        zzfy().logEvent("am", "_xu", bundle);
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zzb(String str, long j) {
        zzfv();
        zzab();
        Preconditions.checkNotEmpty(str);
        Integer num = this.zzaev.get(str);
        if (num == null) {
            zzgi().zziv().zzg("Call to endAdUnitExposure for unknown ad unit id", str);
            return;
        }
        zzig zzigVarZzkn = zzgb().zzkn();
        int iIntValue = num.intValue() - 1;
        if (iIntValue != 0) {
            this.zzaev.put(str, Integer.valueOf(iIntValue));
            return;
        }
        this.zzaev.remove(str);
        Long l = this.zzaeu.get(str);
        if (l == null) {
            zzgi().zziv().log("First ad unit exposure time was never set");
        } else {
            long jLongValue = j - l.longValue();
            this.zzaeu.remove(str);
            zza(str, jLongValue, zzigVarZzkn);
        }
        if (this.zzaev.isEmpty()) {
            if (this.zzaew == 0) {
                zzgi().zziv().log("First ad exposure time was never set");
            } else {
                zza(j - this.zzaew, zzigVarZzkn);
                this.zzaew = 0L;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zzq(long j) {
        Iterator<String> it2 = this.zzaeu.keySet().iterator();
        while (it2.hasNext()) {
            this.zzaeu.put(it2.next(), Long.valueOf(j));
        }
        if (this.zzaeu.isEmpty()) {
            return;
        }
        this.zzaew = j;
    }

    public final void beginAdUnitExposure(String str) {
        if (str == null || str.length() == 0) {
            zzgi().zziv().log("Ad unit id must be a non-empty string");
        } else {
            zzgh().zzc(new zzdv(this, str, zzbt().elapsedRealtime()));
        }
    }

    public final void endAdUnitExposure(String str) {
        if (str == null || str.length() == 0) {
            zzgi().zziv().log("Ad unit id must be a non-empty string");
        } else {
            zzgh().zzc(new zzdw(this, str, zzbt().elapsedRealtime()));
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
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

    @WorkerThread
    public final void zzp(long j) {
        zzig zzigVarZzkn = zzgb().zzkn();
        for (String str : this.zzaeu.keySet()) {
            zza(str, j - this.zzaeu.get(str).longValue(), zzigVarZzkn);
        }
        if (!this.zzaeu.isEmpty()) {
            zza(j - this.zzaew, zzigVarZzkn);
        }
        zzq(j);
    }
}
