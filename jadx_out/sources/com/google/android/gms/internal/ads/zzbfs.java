package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzbfs extends zzbfc<zzbfs> {
    private Integer zzedj = null;
    private byte[] zzedk = null;
    private byte[] zzedg = null;

    public zzbfs() {
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
            if (iZzabk == 8) {
                this.zzedj = Integer.valueOf(zzbezVar.zzabn());
            } else if (iZzabk == 18) {
                this.zzedk = zzbezVar.readBytes();
            } else if (iZzabk == 26) {
                this.zzedg = zzbezVar.readBytes();
            } else if (!super.zza(zzbezVar, iZzabk)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzedj != null) {
            zzbfaVar.zzm(1, this.zzedj.intValue());
        }
        if (this.zzedk != null) {
            zzbfaVar.zza(2, this.zzedk);
        }
        if (this.zzedg != null) {
            zzbfaVar.zza(3, this.zzedg);
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzedj != null) {
            iZzr += zzbfa.zzq(1, this.zzedj.intValue());
        }
        if (this.zzedk != null) {
            iZzr += zzbfa.zzb(2, this.zzedk);
        }
        return this.zzedg != null ? iZzr + zzbfa.zzb(3, this.zzedg) : iZzr;
    }
}
