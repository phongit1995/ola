package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzbfo extends zzbfc<zzbfo> {
    private static volatile zzbfo[] zzecw;
    public byte[] zzecx = null;
    public byte[] zzecy = null;

    public zzbfo() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    public static zzbfo[] zzagt() {
        if (zzecw == null) {
            synchronized (zzbfg.zzebs) {
                if (zzecw == null) {
                    zzecw = new zzbfo[0];
                }
            }
        }
        return zzecw;
    }

    @Override // com.google.android.gms.internal.ads.zzbfi
    public final /* synthetic */ zzbfi zza(zzbez zzbezVar) throws zzbfh {
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk == 10) {
                this.zzecx = zzbezVar.readBytes();
            } else if (iZzabk == 18) {
                this.zzecy = zzbezVar.readBytes();
            } else if (!super.zza(zzbezVar, iZzabk)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        zzbfaVar.zza(1, this.zzecx);
        if (this.zzecy != null) {
            zzbfaVar.zza(2, this.zzecy);
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr() + zzbfa.zzb(1, this.zzecx);
        return this.zzecy != null ? iZzr + zzbfa.zzb(2, this.zzecy) : iZzr;
    }
}
