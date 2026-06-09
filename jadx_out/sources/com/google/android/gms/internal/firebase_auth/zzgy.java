package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgy {

    public static final class zza extends zzgn<zza> {
        public String zzdv = "";
        public long zzaj = 0;
        public String zzjy = "";
        public String zzai = "";
        private String zzaf = "";
        private String zzkv = "";
        private long zzym = 0;

        public zza() {
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
                    this.zzdv = zzgkVar.readString();
                } else if (iZzcc == 16) {
                    this.zzaj = zzgkVar.zzce();
                } else if (iZzcc == 26) {
                    this.zzjy = zzgkVar.readString();
                } else if (iZzcc == 34) {
                    this.zzai = zzgkVar.readString();
                } else if (iZzcc == 42) {
                    this.zzaf = zzgkVar.readString();
                } else if (iZzcc == 50) {
                    this.zzkv = zzgkVar.readString();
                } else if (iZzcc == 56) {
                    this.zzym = zzgkVar.zzce();
                } else if (!super.zza(zzgkVar, iZzcc)) {
                    return this;
                }
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        public final void zza(zzgl zzglVar) throws zzgm {
            if (this.zzdv != null && !this.zzdv.equals("")) {
                zzglVar.zza(1, this.zzdv);
            }
            if (this.zzaj != 0) {
                zzglVar.zzi(2, this.zzaj);
            }
            if (this.zzjy != null && !this.zzjy.equals("")) {
                zzglVar.zza(3, this.zzjy);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                zzglVar.zza(4, this.zzai);
            }
            if (this.zzaf != null && !this.zzaf.equals("")) {
                zzglVar.zza(5, this.zzaf);
            }
            if (this.zzkv != null && !this.zzkv.equals("")) {
                zzglVar.zza(6, this.zzkv);
            }
            if (this.zzym != 0) {
                zzglVar.zzi(7, this.zzym);
            }
            super.zza(zzglVar);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        protected final int zzb() {
            int iZzb = super.zzb();
            if (this.zzdv != null && !this.zzdv.equals("")) {
                iZzb += zzgl.zzb(1, this.zzdv);
            }
            if (this.zzaj != 0) {
                iZzb += zzgl.zzd(2, this.zzaj);
            }
            if (this.zzjy != null && !this.zzjy.equals("")) {
                iZzb += zzgl.zzb(3, this.zzjy);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                iZzb += zzgl.zzb(4, this.zzai);
            }
            if (this.zzaf != null && !this.zzaf.equals("")) {
                iZzb += zzgl.zzb(5, this.zzaf);
            }
            if (this.zzkv != null && !this.zzkv.equals("")) {
                iZzb += zzgl.zzb(6, this.zzkv);
            }
            return this.zzym != 0 ? iZzb + zzgl.zzd(7, this.zzym) : iZzb;
        }
    }
}
