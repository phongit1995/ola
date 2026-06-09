package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgz extends zzgn<zzgz> {
    public String zzjm = "";
    private String zzgu = "";
    public String zzai = "";
    public String zzjo = "";
    private String zzyl = "";

    public zzgz() {
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
                this.zzjm = zzgkVar.readString();
            } else if (iZzcc == 18) {
                this.zzgu = zzgkVar.readString();
            } else if (iZzcc == 26) {
                this.zzai = zzgkVar.readString();
            } else if (iZzcc == 34) {
                this.zzjo = zzgkVar.readString();
            } else if (iZzcc == 42) {
                this.zzyl = zzgkVar.readString();
            } else if (!super.zza(zzgkVar, iZzcc)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    public final void zza(zzgl zzglVar) throws zzgm {
        if (this.zzjm != null && !this.zzjm.equals("")) {
            zzglVar.zza(1, this.zzjm);
        }
        if (this.zzgu != null && !this.zzgu.equals("")) {
            zzglVar.zza(2, this.zzgu);
        }
        if (this.zzai != null && !this.zzai.equals("")) {
            zzglVar.zza(3, this.zzai);
        }
        if (this.zzjo != null && !this.zzjo.equals("")) {
            zzglVar.zza(4, this.zzjo);
        }
        if (this.zzyl != null && !this.zzyl.equals("")) {
            zzglVar.zza(5, this.zzyl);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzjm != null && !this.zzjm.equals("")) {
            iZzb += zzgl.zzb(1, this.zzjm);
        }
        if (this.zzgu != null && !this.zzgu.equals("")) {
            iZzb += zzgl.zzb(2, this.zzgu);
        }
        if (this.zzai != null && !this.zzai.equals("")) {
            iZzb += zzgl.zzb(3, this.zzai);
        }
        if (this.zzjo != null && !this.zzjo.equals("")) {
            iZzb += zzgl.zzb(4, this.zzjo);
        }
        return (this.zzyl == null || this.zzyl.equals("")) ? iZzb : iZzb + zzgl.zzb(5, this.zzyl);
    }
}
