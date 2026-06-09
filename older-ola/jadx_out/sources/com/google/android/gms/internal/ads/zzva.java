package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
final class zzva implements Runnable {
    private final /* synthetic */ String zzbpt;
    private final /* synthetic */ zzuw zzbpu;

    zzva(zzuw zzuwVar, String str) {
        this.zzbpu = zzuwVar;
        this.zzbpt = str;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzbpu.zzbnd.loadData(this.zzbpt, "text/html", "UTF-8");
    }
}
