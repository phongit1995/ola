package com.google.android.gms.internal.measurement;

import java.util.List;
import java.util.concurrent.Callable;

/* JADX INFO: loaded from: classes2.dex */
final class zzgy implements Callable<List<zzef>> {
    private final /* synthetic */ String zzadn;
    private final /* synthetic */ String zzadu;
    private final /* synthetic */ zzgp zzape;
    private final /* synthetic */ String zzapg;

    zzgy(zzgp zzgpVar, String str, String str2, String str3) {
        this.zzape = zzgpVar;
        this.zzapg = str;
        this.zzadn = str2;
        this.zzadu = str3;
    }

    @Override // java.util.concurrent.Callable
    public final /* synthetic */ List<zzef> call() {
        this.zzape.zzalo.zzlj();
        return this.zzape.zzalo.zzjh().zzc(this.zzapg, this.zzadn, this.zzadu);
    }
}
