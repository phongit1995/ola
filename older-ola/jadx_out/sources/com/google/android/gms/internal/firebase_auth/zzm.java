package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzm extends zzgn<zzm> {
    public String zzag = "";
    public String zzba = "";
    private String zzbb = "";
    private String zzah = "";

    public zzm() {
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
                this.zzba = zzgkVar.readString();
            } else if (iZzcc == 26) {
                this.zzbb = zzgkVar.readString();
            } else if (iZzcc == 34) {
                this.zzah = zzgkVar.readString();
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
        if (this.zzba != null && !this.zzba.equals("")) {
            zzglVar.zza(2, this.zzba);
        }
        if (this.zzbb != null && !this.zzbb.equals("")) {
            zzglVar.zza(3, this.zzbb);
        }
        if (this.zzah != null && !this.zzah.equals("")) {
            zzglVar.zza(4, this.zzah);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzag != null && !this.zzag.equals("")) {
            iZzb += zzgl.zzb(1, this.zzag);
        }
        if (this.zzba != null && !this.zzba.equals("")) {
            iZzb += zzgl.zzb(2, this.zzba);
        }
        if (this.zzbb != null && !this.zzbb.equals("")) {
            iZzb += zzgl.zzb(3, this.zzbb);
        }
        return (this.zzah == null || this.zzah.equals("")) ? iZzb : iZzb + zzgl.zzb(4, this.zzah);
    }
}
