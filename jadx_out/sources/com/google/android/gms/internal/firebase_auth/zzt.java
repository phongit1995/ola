package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzt extends zzgn<zzt> {
    private static volatile zzt[] zzdj;
    public String zzj = "";
    public String zzbh = "";
    public String zzbr = "";
    public String zzcg = "";
    public String zzah = "";
    private String zzdk = "";
    private String zzde = "";
    public String zzbd = "";

    public zzt() {
        this.zzya = -1;
    }

    public static zzt[] zzc() {
        if (zzdj == null) {
            synchronized (zzgr.zzxz) {
                if (zzdj == null) {
                    zzdj = new zzt[0];
                }
            }
        }
        return zzdj;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    public final /* synthetic */ zzgt zza(zzgk zzgkVar) throws zzgs {
        while (true) {
            int iZzcc = zzgkVar.zzcc();
            if (iZzcc == 0) {
                return this;
            }
            if (iZzcc == 10) {
                this.zzj = zzgkVar.readString();
            } else if (iZzcc == 18) {
                this.zzbh = zzgkVar.readString();
            } else if (iZzcc == 26) {
                this.zzbr = zzgkVar.readString();
            } else if (iZzcc == 34) {
                this.zzcg = zzgkVar.readString();
            } else if (iZzcc == 42) {
                this.zzah = zzgkVar.readString();
            } else if (iZzcc == 50) {
                this.zzdk = zzgkVar.readString();
            } else if (iZzcc == 58) {
                this.zzde = zzgkVar.readString();
            } else if (iZzcc == 74) {
                this.zzbd = zzgkVar.readString();
            } else if (!super.zza(zzgkVar, iZzcc)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    public final void zza(zzgl zzglVar) throws zzgm {
        if (this.zzj != null && !this.zzj.equals("")) {
            zzglVar.zza(1, this.zzj);
        }
        if (this.zzbh != null && !this.zzbh.equals("")) {
            zzglVar.zza(2, this.zzbh);
        }
        if (this.zzbr != null && !this.zzbr.equals("")) {
            zzglVar.zza(3, this.zzbr);
        }
        if (this.zzcg != null && !this.zzcg.equals("")) {
            zzglVar.zza(4, this.zzcg);
        }
        if (this.zzah != null && !this.zzah.equals("")) {
            zzglVar.zza(5, this.zzah);
        }
        if (this.zzdk != null && !this.zzdk.equals("")) {
            zzglVar.zza(6, this.zzdk);
        }
        if (this.zzde != null && !this.zzde.equals("")) {
            zzglVar.zza(7, this.zzde);
        }
        if (this.zzbd != null && !this.zzbd.equals("")) {
            zzglVar.zza(9, this.zzbd);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzj != null && !this.zzj.equals("")) {
            iZzb += zzgl.zzb(1, this.zzj);
        }
        if (this.zzbh != null && !this.zzbh.equals("")) {
            iZzb += zzgl.zzb(2, this.zzbh);
        }
        if (this.zzbr != null && !this.zzbr.equals("")) {
            iZzb += zzgl.zzb(3, this.zzbr);
        }
        if (this.zzcg != null && !this.zzcg.equals("")) {
            iZzb += zzgl.zzb(4, this.zzcg);
        }
        if (this.zzah != null && !this.zzah.equals("")) {
            iZzb += zzgl.zzb(5, this.zzah);
        }
        if (this.zzdk != null && !this.zzdk.equals("")) {
            iZzb += zzgl.zzb(6, this.zzdk);
        }
        if (this.zzde != null && !this.zzde.equals("")) {
            iZzb += zzgl.zzb(7, this.zzde);
        }
        return (this.zzbd == null || this.zzbd.equals("")) ? iZzb : iZzb + zzgl.zzb(9, this.zzbd);
    }
}
