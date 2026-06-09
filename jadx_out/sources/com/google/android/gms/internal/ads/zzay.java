package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzay extends zzbfc<zzay> {
    public String zzcx;
    private String zzcy;
    private String zzcz;
    private String zzda;
    private String zzdb;

    @Override // com.google.android.gms.internal.ads.zzbfi
    public final /* synthetic */ zzbfi zza(zzbez zzbezVar) throws zzbfh {
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk == 10) {
                this.zzcx = zzbezVar.readString();
            } else if (iZzabk == 18) {
                this.zzcy = zzbezVar.readString();
            } else if (iZzabk == 26) {
                this.zzcz = zzbezVar.readString();
            } else if (iZzabk == 34) {
                this.zzda = zzbezVar.readString();
            } else if (iZzabk == 42) {
                this.zzdb = zzbezVar.readString();
            } else if (!super.zza(zzbezVar, iZzabk)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzcx != null) {
            zzbfaVar.zzf(1, this.zzcx);
        }
        if (this.zzcy != null) {
            zzbfaVar.zzf(2, this.zzcy);
        }
        if (this.zzcz != null) {
            zzbfaVar.zzf(3, this.zzcz);
        }
        if (this.zzda != null) {
            zzbfaVar.zzf(4, this.zzda);
        }
        if (this.zzdb != null) {
            zzbfaVar.zzf(5, this.zzdb);
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzcx != null) {
            iZzr += zzbfa.zzg(1, this.zzcx);
        }
        if (this.zzcy != null) {
            iZzr += zzbfa.zzg(2, this.zzcy);
        }
        if (this.zzcz != null) {
            iZzr += zzbfa.zzg(3, this.zzcz);
        }
        if (this.zzda != null) {
            iZzr += zzbfa.zzg(4, this.zzda);
        }
        return this.zzdb != null ? iZzr + zzbfa.zzg(5, this.zzdb) : iZzr;
    }
}
