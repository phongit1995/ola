package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzho implements Runnable {
    private final /* synthetic */ String val$name;
    private final /* synthetic */ String zzadn;
    private final /* synthetic */ zzhm zzaps;
    private final /* synthetic */ Object zzapt;
    private final /* synthetic */ long zzapu;

    zzho(zzhm zzhmVar, String str, String str2, Object obj, long j) {
        this.zzaps = zzhmVar;
        this.zzadn = str;
        this.val$name = str2;
        this.zzapt = obj;
        this.zzapu = j;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzaps.zza(this.zzadn, this.val$name, this.zzapt, this.zzapu);
    }
}
