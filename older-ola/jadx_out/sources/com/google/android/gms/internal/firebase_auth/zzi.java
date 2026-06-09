package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzi extends zzgn<zzi> {
    private String zzad = "";
    private long zzae = 0;
    public String zzaf = "";

    public zzi() {
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
                this.zzad = zzgkVar.readString();
            } else if (iZzcc == 16) {
                this.zzae = zzgkVar.zzcv();
            } else if (iZzcc == 26) {
                this.zzaf = zzgkVar.readString();
            } else if (!super.zza(zzgkVar, iZzcc)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    public final void zza(zzgl zzglVar) throws zzgm {
        if (this.zzad != null && !this.zzad.equals("")) {
            zzglVar.zza(1, this.zzad);
        }
        if (this.zzae != 0) {
            zzglVar.zzi(2, this.zzae);
        }
        if (this.zzaf != null && !this.zzaf.equals("")) {
            zzglVar.zza(3, this.zzaf);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzad != null && !this.zzad.equals("")) {
            iZzb += zzgl.zzb(1, this.zzad);
        }
        if (this.zzae != 0) {
            iZzb += zzgl.zzd(2, this.zzae);
        }
        return (this.zzaf == null || this.zzaf.equals("")) ? iZzb : iZzb + zzgl.zzb(3, this.zzaf);
    }
}
