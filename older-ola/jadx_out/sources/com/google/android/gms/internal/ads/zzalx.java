package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
final class zzalx implements zzy {
    private final /* synthetic */ String zzcce;
    private final /* synthetic */ zzama zzctj;

    zzalx(zzalt zzaltVar, String str, zzama zzamaVar) {
        this.zzcce = str;
        this.zzctj = zzamaVar;
    }

    @Override // com.google.android.gms.internal.ads.zzy
    public final void zzd(zzae zzaeVar) {
        String str = this.zzcce;
        String string = zzaeVar.toString();
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 21 + String.valueOf(string).length());
        sb.append("Failed to load URL: ");
        sb.append(str);
        sb.append("\n");
        sb.append(string);
        zzakb.zzdk(sb.toString());
        this.zzctj.zzb(null);
    }
}
