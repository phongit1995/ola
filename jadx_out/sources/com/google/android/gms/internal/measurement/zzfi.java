package com.google.android.gms.internal.measurement;

import android.content.Context;
import android.support.annotation.GuardedBy;
import android.text.TextUtils;
import android.util.Log;
import android.util.Pair;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.measurement.AppMeasurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfi extends zzhj {
    private long zzafi;
    private char zzakl;

    @GuardedBy("this")
    private String zzakm;
    private final zzfk zzakn;
    private final zzfk zzako;
    private final zzfk zzakp;
    private final zzfk zzakq;
    private final zzfk zzakr;
    private final zzfk zzaks;
    private final zzfk zzakt;
    private final zzfk zzaku;
    private final zzfk zzakv;

    zzfi(zzgn zzgnVar) {
        super(zzgnVar);
        this.zzakl = (char) 0;
        this.zzafi = -1L;
        this.zzakn = new zzfk(this, 6, false, false);
        this.zzako = new zzfk(this, 6, true, false);
        this.zzakp = new zzfk(this, 6, false, true);
        this.zzakq = new zzfk(this, 5, false, false);
        this.zzakr = new zzfk(this, 5, true, false);
        this.zzaks = new zzfk(this, 5, false, true);
        this.zzakt = new zzfk(this, 4, false, false);
        this.zzaku = new zzfk(this, 3, false, false);
        this.zzakv = new zzfk(this, 2, false, false);
    }

    @VisibleForTesting
    private static String zza(boolean z, Object obj) {
        String className;
        if (obj == null) {
            return "";
        }
        if (obj instanceof Integer) {
            obj = Long.valueOf(((Integer) obj).intValue());
        }
        if (obj instanceof Long) {
            if (!z) {
                return String.valueOf(obj);
            }
            Long l = (Long) obj;
            if (Math.abs(l.longValue()) < 100) {
                return String.valueOf(obj);
            }
            String str = String.valueOf(obj).charAt(0) == '-' ? "-" : "";
            String strValueOf = String.valueOf(Math.abs(l.longValue()));
            long jRound = Math.round(Math.pow(10.0d, strValueOf.length() - 1));
            long jRound2 = Math.round(Math.pow(10.0d, strValueOf.length()) - 1.0d);
            StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 43 + String.valueOf(str).length());
            sb.append(str);
            sb.append(jRound);
            sb.append("...");
            sb.append(str);
            sb.append(jRound2);
            return sb.toString();
        }
        if (obj instanceof Boolean) {
            return String.valueOf(obj);
        }
        if (!(obj instanceof Throwable)) {
            return obj instanceof zzfl ? ((zzfl) obj).zzale : z ? "-" : String.valueOf(obj);
        }
        Throwable th = (Throwable) obj;
        StringBuilder sb2 = new StringBuilder(z ? th.getClass().getName() : th.toString());
        String strZzbq = zzbq(AppMeasurement.class.getCanonicalName());
        String strZzbq2 = zzbq(zzgn.class.getCanonicalName());
        for (StackTraceElement stackTraceElement : th.getStackTrace()) {
            if (!stackTraceElement.isNativeMethod() && (className = stackTraceElement.getClassName()) != null) {
                String strZzbq3 = zzbq(className);
                if (strZzbq3.equals(strZzbq) || strZzbq3.equals(strZzbq2)) {
                    sb2.append(": ");
                    sb2.append(stackTraceElement);
                    break;
                }
            }
        }
        return sb2.toString();
    }

    static String zza(boolean z, String str, Object obj, Object obj2, Object obj3) {
        if (str == null) {
            str = "";
        }
        String strZza = zza(z, obj);
        String strZza2 = zza(z, obj2);
        String strZza3 = zza(z, obj3);
        StringBuilder sb = new StringBuilder();
        String str2 = "";
        if (!TextUtils.isEmpty(str)) {
            sb.append(str);
            str2 = ": ";
        }
        if (!TextUtils.isEmpty(strZza)) {
            sb.append(str2);
            sb.append(strZza);
            str2 = ", ";
        }
        if (!TextUtils.isEmpty(strZza2)) {
            sb.append(str2);
            sb.append(strZza2);
            str2 = ", ";
        }
        if (!TextUtils.isEmpty(strZza3)) {
            sb.append(str2);
            sb.append(strZza3);
        }
        return sb.toString();
    }

    protected static Object zzbp(String str) {
        if (str == null) {
            return null;
        }
        return new zzfl(str);
    }

    private static String zzbq(String str) {
        if (TextUtils.isEmpty(str)) {
            return "";
        }
        int iLastIndexOf = str.lastIndexOf(46);
        return iLastIndexOf == -1 ? str : str.substring(0, iLastIndexOf);
    }

    private final String zzjd() {
        String str;
        synchronized (this) {
            if (this.zzakm == null) {
                this.zzakm = zzeh.zzhn();
            }
            str = this.zzakm;
        }
        return str;
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
    }

    @VisibleForTesting
    protected final boolean isLoggable(int i) {
        return Log.isLoggable(zzjd(), i);
    }

    @VisibleForTesting
    protected final void zza(int i, String str) {
        Log.println(i, zzjd(), str);
    }

    protected final void zza(int i, boolean z, boolean z2, String str, Object obj, Object obj2, Object obj3) {
        String str2;
        if (!z && isLoggable(i)) {
            zza(i, zza(false, str, obj, obj2, obj3));
        }
        if (z2 || i < 5) {
            return;
        }
        Preconditions.checkNotNull(str);
        zzgi zzgiVarZzka = this.zzacv.zzka();
        if (zzgiVarZzka == null) {
            str2 = "Scheduler not set. Not logging error/warn";
        } else {
            if (zzgiVarZzka.isInitialized()) {
                if (i < 0) {
                    i = 0;
                }
                zzgiVarZzka.zzc(new zzfj(this, i >= 9 ? 8 : i, str, obj, obj2, obj3));
                return;
            }
            str2 = "Scheduler not initialized. Not logging error/warn";
        }
        zza(6, str2);
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzab() {
        super.zzab();
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

    public final zzfk zziv() {
        return this.zzakn;
    }

    public final zzfk zziw() {
        return this.zzako;
    }

    public final zzfk zzix() {
        return this.zzakp;
    }

    public final zzfk zziy() {
        return this.zzakq;
    }

    public final zzfk zziz() {
        return this.zzaks;
    }

    public final zzfk zzja() {
        return this.zzakt;
    }

    public final zzfk zzjb() {
        return this.zzaku;
    }

    public final zzfk zzjc() {
        return this.zzakv;
    }

    public final String zzje() {
        Pair<String, Long> pairZzfi = zzgj().zzals.zzfi();
        if (pairZzfi == null || pairZzfi == zzft.zzalr) {
            return null;
        }
        String strValueOf = String.valueOf(pairZzfi.second);
        String str = (String) pairZzfi.first;
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 1 + String.valueOf(str).length());
        sb.append(strValueOf);
        sb.append(":");
        sb.append(str);
        return sb.toString();
    }
}
