package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzfj implements Runnable {
    private final /* synthetic */ int zzakw;
    private final /* synthetic */ String zzakx;
    private final /* synthetic */ Object zzaky;
    private final /* synthetic */ Object zzakz;
    private final /* synthetic */ Object zzala;
    private final /* synthetic */ zzfi zzalb;

    zzfj(zzfi zzfiVar, int i, String str, Object obj, Object obj2, Object obj3) {
        this.zzalb = zzfiVar;
        this.zzakw = i;
        this.zzakx = str;
        this.zzaky = obj;
        this.zzakz = obj2;
        this.zzala = obj3;
    }

    @Override // java.lang.Runnable
    public final void run() {
        zzfi zzfiVar;
        char c;
        zzft zzftVarZzgj = this.zzalb.zzacv.zzgj();
        if (!zzftVarZzgj.isInitialized()) {
            this.zzalb.zza(6, "Persisted config not initialized. Not logging error/warn");
            return;
        }
        if (this.zzalb.zzakl == 0) {
            if (this.zzalb.zzgk().zzds()) {
                zzfiVar = this.zzalb;
                this.zzalb.zzgl();
                c = 'C';
            } else {
                zzfiVar = this.zzalb;
                this.zzalb.zzgl();
                c = 'c';
            }
            zzfiVar.zzakl = c;
        }
        if (this.zzalb.zzafi < 0) {
            this.zzalb.zzafi = this.zzalb.zzgk().zzgw();
        }
        char cCharAt = "01VDIWEA?".charAt(this.zzakw);
        char c2 = this.zzalb.zzakl;
        long j = this.zzalb.zzafi;
        String strZza = zzfi.zza(true, this.zzakx, this.zzaky, this.zzakz, this.zzala);
        StringBuilder sb = new StringBuilder(String.valueOf(strZza).length() + 24);
        sb.append("2");
        sb.append(cCharAt);
        sb.append(c2);
        sb.append(j);
        sb.append(":");
        sb.append(strZza);
        String string = sb.toString();
        if (string.length() > 1024) {
            string = this.zzakx.substring(0, 1024);
        }
        zzftVarZzgj.zzals.zzc(string, 1L);
    }
}
