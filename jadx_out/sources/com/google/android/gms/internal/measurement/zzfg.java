package com.google.android.gms.internal.measurement;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.measurement.AppMeasurement;
import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfg extends zzhj {
    private static final AtomicReference<String[]> zzaki = new AtomicReference<>();
    private static final AtomicReference<String[]> zzakj = new AtomicReference<>();
    private static final AtomicReference<String[]> zzakk = new AtomicReference<>();

    zzfg(zzgn zzgnVar) {
        super(zzgnVar);
    }

    @Nullable
    private static String zza(String str, String[] strArr, String[] strArr2, AtomicReference<String[]> atomicReference) {
        String str2;
        Preconditions.checkNotNull(strArr);
        Preconditions.checkNotNull(strArr2);
        Preconditions.checkNotNull(atomicReference);
        Preconditions.checkArgument(strArr.length == strArr2.length);
        for (int i = 0; i < strArr.length; i++) {
            if (zzkd.zzs(str, strArr[i])) {
                synchronized (atomicReference) {
                    String[] strArr3 = atomicReference.get();
                    if (strArr3 == null) {
                        strArr3 = new String[strArr2.length];
                        atomicReference.set(strArr3);
                    }
                    if (strArr3[i] == null) {
                        strArr3[i] = strArr2[i] + "(" + strArr[i] + ")";
                    }
                    str2 = strArr3[i];
                }
                return str2;
            }
        }
        return str;
    }

    @Nullable
    private final String zzb(zzeu zzeuVar) {
        if (zzeuVar == null) {
            return null;
        }
        return !zziu() ? zzeuVar.toString() : zzb(zzeuVar.zzin());
    }

    private final boolean zziu() {
        return this.zzacv.zzgi().isLoggable(3);
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
    }

    @Nullable
    protected final String zza(zzes zzesVar) {
        if (zzesVar == null) {
            return null;
        }
        if (!zziu()) {
            return zzesVar.toString();
        }
        return "Event{appId='" + zzesVar.zzth + "', name='" + zzbm(zzesVar.name) + "', params=" + zzb(zzesVar.zzahg) + "}";
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzab() {
        super.zzab();
    }

    @Nullable
    protected final String zzb(Bundle bundle) {
        if (bundle == null) {
            return null;
        }
        if (!zziu()) {
            return bundle.toString();
        }
        StringBuilder sb = new StringBuilder();
        for (String str : bundle.keySet()) {
            sb.append(sb.length() != 0 ? ", " : "Bundle[{");
            sb.append(zzbn(str));
            sb.append("=");
            sb.append(bundle.get(str));
        }
        sb.append("}]");
        return sb.toString();
    }

    @Nullable
    protected final String zzb(zzex zzexVar) {
        if (zzexVar == null) {
            return null;
        }
        if (!zziu()) {
            return zzexVar.toString();
        }
        return "origin=" + zzexVar.origin + ",name=" + zzbm(zzexVar.name) + ",params=" + zzb(zzexVar.zzahg);
    }

    @Nullable
    protected final String zzbm(String str) {
        if (str == null) {
            return null;
        }
        return !zziu() ? str : zza(str, AppMeasurement.Event.zzacx, AppMeasurement.Event.zzacw, zzaki);
    }

    @Nullable
    protected final String zzbn(String str) {
        if (str == null) {
            return null;
        }
        return !zziu() ? str : zza(str, AppMeasurement.Param.zzacz, AppMeasurement.Param.zzacy, zzakj);
    }

    @Nullable
    protected final String zzbo(String str) {
        if (str == null) {
            return null;
        }
        if (!zziu()) {
            return str;
        }
        if (!str.startsWith("_exp_")) {
            return zza(str, AppMeasurement.UserProperty.zzadb, AppMeasurement.UserProperty.zzada, zzakk);
        }
        return "experiment_id(" + str + ")";
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Clock zzbt() {
        return super.zzbt();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfu() {
        super.zzfu();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfv() {
        super.zzfv();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfw() {
        super.zzfw();
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

    @Override // com.google.android.gms.internal.measurement.zzhj
    protected final boolean zzgn() {
        return false;
    }
}
