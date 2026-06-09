package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzbfn extends zzbfc<zzbfn> {
    public String zzcnd = null;

    public zzbfn() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    @Override // com.google.android.gms.internal.ads.zzbfi
    public final /* synthetic */ zzbfi zza(zzbez zzbezVar) throws zzbfh {
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk == 10) {
                this.zzcnd = zzbezVar.readString();
            } else if (!super.zza(zzbezVar, iZzabk)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzcnd != null) {
            zzbfaVar.zzf(1, this.zzcnd);
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        return this.zzcnd != null ? iZzr + zzbfa.zzg(1, this.zzcnd) : iZzr;
    }
}
