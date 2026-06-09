package com.google.android.gms.internal.measurement;

import android.content.ContentValues;
import android.content.Context;
import android.database.sqlite.SQLiteException;
import android.support.annotation.WorkerThread;
import android.support.v4.util.ArrayMap;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.measurement.AppMeasurement;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.io.IOException;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgh extends zzjs implements zzej {

    @VisibleForTesting
    private static int zzane = 65535;

    @VisibleForTesting
    private static int zzanf = 2;
    private final Map<String, Map<String, String>> zzang;
    private final Map<String, Map<String, Boolean>> zzanh;
    private final Map<String, Map<String, Boolean>> zzani;
    private final Map<String, zzkn> zzanj;
    private final Map<String, Map<String, Integer>> zzank;
    private final Map<String, String> zzanl;

    zzgh(zzjt zzjtVar) {
        super(zzjtVar);
        this.zzang = new ArrayMap();
        this.zzanh = new ArrayMap();
        this.zzani = new ArrayMap();
        this.zzanj = new ArrayMap();
        this.zzanl = new ArrayMap();
        this.zzank = new ArrayMap();
    }

    @WorkerThread
    private final zzkn zza(String str, byte[] bArr) {
        if (bArr == null) {
            return new zzkn();
        }
        zzaca zzacaVarZza = zzaca.zza(bArr, 0, bArr.length);
        zzkn zzknVar = new zzkn();
        try {
            zzknVar.zzb(zzacaVarZza);
            zzgi().zzjc().zze("Parsed config. version, gmp_app_id", zzknVar.zzaum, zzknVar.zzafa);
            return zzknVar;
        } catch (IOException e) {
            zzgi().zziy().zze("Unable to merge remote config. appId", zzfi.zzbp(str), e);
            return new zzkn();
        }
    }

    private static Map<String, String> zza(zzkn zzknVar) {
        ArrayMap arrayMap = new ArrayMap();
        if (zzknVar != null && zzknVar.zzauo != null) {
            for (zzko zzkoVar : zzknVar.zzauo) {
                if (zzkoVar != null) {
                    arrayMap.put(zzkoVar.zzny, zzkoVar.value);
                }
            }
        }
        return arrayMap;
    }

    private final void zza(String str, zzkn zzknVar) {
        ArrayMap arrayMap = new ArrayMap();
        ArrayMap arrayMap2 = new ArrayMap();
        ArrayMap arrayMap3 = new ArrayMap();
        if (zzknVar != null && zzknVar.zzaup != null) {
            for (zzkm zzkmVar : zzknVar.zzaup) {
                if (TextUtils.isEmpty(zzkmVar.name)) {
                    zzgi().zziy().log("EventConfig contained null event name");
                } else {
                    String strZzal = AppMeasurement.Event.zzal(zzkmVar.name);
                    if (!TextUtils.isEmpty(strZzal)) {
                        zzkmVar.name = strZzal;
                    }
                    arrayMap.put(zzkmVar.name, zzkmVar.zzauj);
                    arrayMap2.put(zzkmVar.name, zzkmVar.zzauk);
                    if (zzkmVar.zzaul != null) {
                        if (zzkmVar.zzaul.intValue() < zzanf || zzkmVar.zzaul.intValue() > zzane) {
                            zzgi().zziy().zze("Invalid sampling rate. Event name, sample rate", zzkmVar.name, zzkmVar.zzaul);
                        } else {
                            arrayMap3.put(zzkmVar.name, zzkmVar.zzaul);
                        }
                    }
                }
            }
        }
        this.zzanh.put(str, arrayMap);
        this.zzani.put(str, arrayMap2);
        this.zzank.put(str, arrayMap3);
    }

    @WorkerThread
    private final void zzbw(String str) throws Throwable {
        zzch();
        zzab();
        Preconditions.checkNotEmpty(str);
        if (this.zzanj.get(str) == null) {
            byte[] bArrZzbh = zzjh().zzbh(str);
            if (bArrZzbh != null) {
                zzkn zzknVarZza = zza(str, bArrZzbh);
                this.zzang.put(str, zza(zzknVarZza));
                zza(str, zzknVarZza);
                this.zzanj.put(str, zzknVarZza);
                this.zzanl.put(str, null);
                return;
            }
            this.zzang.put(str, null);
            this.zzanh.put(str, null);
            this.zzani.put(str, null);
            this.zzanj.put(str, null);
            this.zzanl.put(str, null);
            this.zzank.put(str, null);
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
    }

    @WorkerThread
    protected final boolean zza(String str, byte[] bArr, String str2) {
        zzch();
        zzab();
        Preconditions.checkNotEmpty(str);
        zzkn zzknVarZza = zza(str, bArr);
        if (zzknVarZza == null) {
            return false;
        }
        zza(str, zzknVarZza);
        this.zzanj.put(str, zzknVarZza);
        this.zzanl.put(str, str2);
        this.zzang.put(str, zza(zzknVarZza));
        zzjg().zza(str, zzknVarZza.zzauq);
        try {
            zzknVarZza.zzauq = null;
            byte[] bArr2 = new byte[zzknVarZza.zzwb()];
            zzknVarZza.zza(zzacb.zzb(bArr2, 0, bArr2.length));
            bArr = bArr2;
        } catch (IOException e) {
            zzgi().zziy().zze("Unable to serialize reduced-size config. Storing full config instead. appId", zzfi.zzbp(str), e);
        }
        zzek zzekVarZzjh = zzjh();
        Preconditions.checkNotEmpty(str);
        zzekVarZzjh.zzab();
        zzekVarZzjh.zzch();
        new ContentValues().put("remote_config", bArr);
        try {
            if (zzekVarZzjh.getWritableDatabase().update("apps", r0, "app_id = ?", new String[]{str}) == 0) {
                zzekVarZzjh.zzgi().zziv().zzg("Failed to update remote config (got 0). appId", zzfi.zzbp(str));
                return true;
            }
        } catch (SQLiteException e2) {
            zzekVarZzjh.zzgi().zziv().zze("Error storing remote config. appId", zzfi.zzbp(str), e2);
        }
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzab() {
        super.zzab();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Clock zzbt() {
        return super.zzbt();
    }

    @WorkerThread
    protected final zzkn zzbx(String str) {
        zzch();
        zzab();
        Preconditions.checkNotEmpty(str);
        zzbw(str);
        return this.zzanj.get(str);
    }

    @WorkerThread
    protected final String zzby(String str) {
        zzab();
        return this.zzanl.get(str);
    }

    @WorkerThread
    protected final void zzbz(String str) {
        zzab();
        this.zzanl.put(str, null);
    }

    @WorkerThread
    final void zzca(String str) {
        zzab();
        this.zzanj.remove(str);
    }

    final boolean zzcb(String str) {
        return "1".equals(zze(str, "measurement.upload.blacklist_internal"));
    }

    final boolean zzcc(String str) {
        return "1".equals(zze(str, "measurement.upload.blacklist_public"));
    }

    @Override // com.google.android.gms.internal.measurement.zzej
    @WorkerThread
    public final String zze(String str, String str2) throws Throwable {
        zzab();
        zzbw(str);
        Map<String, String> map = this.zzang.get(str);
        if (map != null) {
            return map.get(str2);
        }
        return null;
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

    @Override // com.google.android.gms.internal.measurement.zzjs
    protected final boolean zzgn() {
        return false;
    }

    @Override // com.google.android.gms.internal.measurement.zzjr
    public final /* bridge */ /* synthetic */ zzjz zzjf() {
        return super.zzjf();
    }

    @Override // com.google.android.gms.internal.measurement.zzjr
    public final /* bridge */ /* synthetic */ zzed zzjg() {
        return super.zzjg();
    }

    @Override // com.google.android.gms.internal.measurement.zzjr
    public final /* bridge */ /* synthetic */ zzek zzjh() {
        return super.zzjh();
    }

    @WorkerThread
    final boolean zzn(String str, String str2) throws Throwable {
        Boolean bool;
        zzab();
        zzbw(str);
        if (zzcb(str) && zzkd.zzcm(str2)) {
            return true;
        }
        if (zzcc(str) && zzkd.zzcg(str2)) {
            return true;
        }
        Map<String, Boolean> map = this.zzanh.get(str);
        if (map == null || (bool = map.get(str2)) == null) {
            return false;
        }
        return bool.booleanValue();
    }

    @WorkerThread
    final boolean zzo(String str, String str2) throws Throwable {
        Boolean bool;
        zzab();
        zzbw(str);
        if (FirebaseAnalytics.Event.ECOMMERCE_PURCHASE.equals(str2)) {
            return true;
        }
        Map<String, Boolean> map = this.zzani.get(str);
        if (map == null || (bool = map.get(str2)) == null) {
            return false;
        }
        return bool.booleanValue();
    }

    @WorkerThread
    final int zzp(String str, String str2) throws Throwable {
        Integer num;
        zzab();
        zzbw(str);
        Map<String, Integer> map = this.zzank.get(str);
        if (map == null || (num = map.get(str2)) == null) {
            return 1;
        }
        return num.intValue();
    }
}
