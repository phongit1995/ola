package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzf extends zzgn<zzf> {
    private static volatile zzf[] zze;
    private String zzf = "";
    private String value = "";

    public zzf() {
        this.zzya = -1;
    }

    public static zzf[] zza() {
        if (zze == null) {
            synchronized (zzgr.zzxz) {
                if (zze == null) {
                    zze = new zzf[0];
                }
            }
        }
        return zze;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    public final /* synthetic */ zzgt zza(zzgk zzgkVar) throws zzgs {
        while (true) {
            int iZzcc = zzgkVar.zzcc();
            if (iZzcc == 0) {
                return this;
            }
            if (iZzcc == 10) {
                this.zzf = zzgkVar.readString();
            } else if (iZzcc == 18) {
                this.value = zzgkVar.readString();
            } else if (!super.zza(zzgkVar, iZzcc)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    public final void zza(zzgl zzglVar) throws zzgm {
        if (this.zzf != null && !this.zzf.equals("")) {
            zzglVar.zza(1, this.zzf);
        }
        if (this.value != null && !this.value.equals("")) {
            zzglVar.zza(2, this.value);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzf != null && !this.zzf.equals("")) {
            iZzb += zzgl.zzb(1, this.zzf);
        }
        return (this.value == null || this.value.equals("")) ? iZzb : iZzb + zzgl.zzb(2, this.value);
    }
}
