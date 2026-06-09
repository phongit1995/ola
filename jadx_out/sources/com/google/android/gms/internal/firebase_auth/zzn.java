package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzn extends zzgn<zzn> {
    public String zzbd = "";
    private String zzbe = "";
    private String zzbf = "";
    private String zzbg = "";

    public zzn() {
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
                this.zzbd = zzgkVar.readString();
            } else if (iZzcc == 18) {
                this.zzbe = zzgkVar.readString();
            } else if (iZzcc == 26) {
                this.zzbf = zzgkVar.readString();
            } else if (iZzcc == 34) {
                this.zzbg = zzgkVar.readString();
            } else if (!super.zza(zzgkVar, iZzcc)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    public final void zza(zzgl zzglVar) throws zzgm {
        if (this.zzbd != null && !this.zzbd.equals("")) {
            zzglVar.zza(1, this.zzbd);
        }
        if (this.zzbe != null && !this.zzbe.equals("")) {
            zzglVar.zza(2, this.zzbe);
        }
        if (this.zzbf != null && !this.zzbf.equals("")) {
            zzglVar.zza(3, this.zzbf);
        }
        if (this.zzbg != null && !this.zzbg.equals("")) {
            zzglVar.zza(4, this.zzbg);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzbd != null && !this.zzbd.equals("")) {
            iZzb += zzgl.zzb(1, this.zzbd);
        }
        if (this.zzbe != null && !this.zzbe.equals("")) {
            iZzb += zzgl.zzb(2, this.zzbe);
        }
        if (this.zzbf != null && !this.zzbf.equals("")) {
            iZzb += zzgl.zzb(3, this.zzbf);
        }
        return (this.zzbg == null || this.zzbg.equals("")) ? iZzb : iZzb + zzgl.zzb(4, this.zzbg);
    }
}
