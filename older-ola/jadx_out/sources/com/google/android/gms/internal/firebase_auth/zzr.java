package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzr extends zzgn<zzr> {
    public String zzdh = "";
    private String zzbq = "";
    public boolean zzbt = false;
    private long zzae = 0;

    public zzr() {
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
                this.zzdh = zzgkVar.readString();
            } else if (iZzcc == 18) {
                this.zzbq = zzgkVar.readString();
            } else if (iZzcc == 24) {
                this.zzbt = zzgkVar.zzci();
            } else if (iZzcc == 32) {
                this.zzae = zzgkVar.zzcv();
            } else if (!super.zza(zzgkVar, iZzcc)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    public final void zza(zzgl zzglVar) throws zzgm {
        if (this.zzdh != null && !this.zzdh.equals("")) {
            zzglVar.zza(1, this.zzdh);
        }
        if (this.zzbq != null && !this.zzbq.equals("")) {
            zzglVar.zza(2, this.zzbq);
        }
        if (this.zzbt) {
            zzglVar.zzb(3, this.zzbt);
        }
        if (this.zzae != 0) {
            zzglVar.zzi(4, this.zzae);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzdh != null && !this.zzdh.equals("")) {
            iZzb += zzgl.zzb(1, this.zzdh);
        }
        if (this.zzbq != null && !this.zzbq.equals("")) {
            iZzb += zzgl.zzb(2, this.zzbq);
        }
        if (this.zzbt) {
            iZzb += zzgl.zzaa(3) + 1;
        }
        return this.zzae != 0 ? iZzb + zzgl.zzd(4, this.zzae) : iZzb;
    }
}
