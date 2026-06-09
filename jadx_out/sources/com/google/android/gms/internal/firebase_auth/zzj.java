package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzj extends zzgn<zzj> {
    public String zzag = "";
    public String zzah = "";
    public String zzaf = "";
    private String zzu = "";
    private long zzv = 0;

    public zzj() {
        this.zzya = -1;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    public final /* synthetic */ zzgt zza(zzgk zzgkVar) throws zzgs {
        while (true) {
            int iZzcc = zzgkVar.zzcc();
            if (iZzcc == 0) {
                return this;
            }
            if (iZzcc == 10) {
                this.zzag = zzgkVar.readString();
            } else if (iZzcc == 18) {
                this.zzah = zzgkVar.readString();
            } else if (iZzcc == 26) {
                this.zzaf = zzgkVar.readString();
            } else if (iZzcc == 50) {
                this.zzu = zzgkVar.readString();
            } else if (iZzcc == 56) {
                this.zzv = zzgkVar.zzcv();
            } else if (!super.zza(zzgkVar, iZzcc)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    public final void zza(zzgl zzglVar) throws zzgm {
        if (this.zzag != null && !this.zzag.equals("")) {
            zzglVar.zza(1, this.zzag);
        }
        if (this.zzah != null && !this.zzah.equals("")) {
            zzglVar.zza(2, this.zzah);
        }
        if (this.zzaf != null && !this.zzaf.equals("")) {
            zzglVar.zza(3, this.zzaf);
        }
        if (this.zzu != null && !this.zzu.equals("")) {
            zzglVar.zza(6, this.zzu);
        }
        if (this.zzv != 0) {
            zzglVar.zza(7, this.zzv);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzag != null && !this.zzag.equals("")) {
            iZzb += zzgl.zzb(1, this.zzag);
        }
        if (this.zzah != null && !this.zzah.equals("")) {
            iZzb += zzgl.zzb(2, this.zzah);
        }
        if (this.zzaf != null && !this.zzaf.equals("")) {
            iZzb += zzgl.zzb(3, this.zzaf);
        }
        if (this.zzu != null && !this.zzu.equals("")) {
            iZzb += zzgl.zzb(6, this.zzu);
        }
        return this.zzv != 0 ? iZzb + zzgl.zze(7, this.zzv) : iZzb;
    }
}
