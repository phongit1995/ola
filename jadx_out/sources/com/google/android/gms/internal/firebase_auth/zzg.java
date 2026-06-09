package com.google.android.gms.internal.firebase_auth;

import android.support.v7.widget.helper.ItemTouchHelper;

/* JADX INFO: loaded from: classes2.dex */
public final class zzg {

    public static final class zza extends zzgn<zza> {
        private String zzw = "";
        public String zzx = "";
        public String[] zzy = zzgw.EMPTY_STRING_ARRAY;
        public boolean zzz = false;
        public String zzj = "";
        public boolean zzaa = false;
        private boolean zzab = false;
        private String zzr = "";
        public String[] zzac = zzgw.EMPTY_STRING_ARRAY;

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
                    this.zzw = zzgkVar.readString();
                } else if (iZzcc == 18) {
                    this.zzx = zzgkVar.readString();
                } else if (iZzcc == 26) {
                    int iZzb = zzgw.zzb(zzgkVar, 26);
                    int length = this.zzy == null ? 0 : this.zzy.length;
                    String[] strArr = new String[iZzb + length];
                    if (length != 0) {
                        System.arraycopy(this.zzy, 0, strArr, 0, length);
                    }
                    while (length < strArr.length - 1) {
                        strArr[length] = zzgkVar.readString();
                        zzgkVar.zzcc();
                        length++;
                    }
                    strArr[length] = zzgkVar.readString();
                    this.zzy = strArr;
                } else if (iZzcc == 32) {
                    this.zzz = zzgkVar.zzci();
                } else if (iZzcc == 42) {
                    this.zzj = zzgkVar.readString();
                } else if (iZzcc == 48) {
                    this.zzaa = zzgkVar.zzci();
                } else if (iZzcc == 56) {
                    this.zzab = zzgkVar.zzci();
                } else if (iZzcc == 66) {
                    this.zzr = zzgkVar.readString();
                } else if (iZzcc == 74) {
                    int iZzb2 = zzgw.zzb(zzgkVar, 74);
                    int length2 = this.zzac == null ? 0 : this.zzac.length;
                    String[] strArr2 = new String[iZzb2 + length2];
                    if (length2 != 0) {
                        System.arraycopy(this.zzac, 0, strArr2, 0, length2);
                    }
                    while (length2 < strArr2.length - 1) {
                        strArr2[length2] = zzgkVar.readString();
                        zzgkVar.zzcc();
                        length2++;
                    }
                    strArr2[length2] = zzgkVar.readString();
                    this.zzac = strArr2;
                } else if (!super.zza(zzgkVar, iZzcc)) {
                    return this;
                }
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        public final void zza(zzgl zzglVar) throws zzgm {
            zzglVar.zza(1, this.zzw);
            if (this.zzx != null && !this.zzx.equals("")) {
                zzglVar.zza(2, this.zzx);
            }
            if (this.zzy != null && this.zzy.length > 0) {
                for (int i = 0; i < this.zzy.length; i++) {
                    String str = this.zzy[i];
                    if (str != null) {
                        zzglVar.zza(3, str);
                    }
                }
            }
            if (this.zzz) {
                zzglVar.zzb(4, this.zzz);
            }
            if (this.zzj != null && !this.zzj.equals("")) {
                zzglVar.zza(5, this.zzj);
            }
            if (this.zzaa) {
                zzglVar.zzb(6, this.zzaa);
            }
            if (this.zzab) {
                zzglVar.zzb(7, this.zzab);
            }
            if (this.zzr != null && !this.zzr.equals("")) {
                zzglVar.zza(8, this.zzr);
            }
            if (this.zzac != null && this.zzac.length > 0) {
                for (int i2 = 0; i2 < this.zzac.length; i2++) {
                    String str2 = this.zzac[i2];
                    if (str2 != null) {
                        zzglVar.zza(9, str2);
                    }
                }
            }
            super.zza(zzglVar);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        protected final int zzb() {
            int iZzb = super.zzb() + zzgl.zzb(1, this.zzw);
            if (this.zzx != null && !this.zzx.equals("")) {
                iZzb += zzgl.zzb(2, this.zzx);
            }
            if (this.zzy != null && this.zzy.length > 0) {
                int iZzam = 0;
                int i = 0;
                for (int i2 = 0; i2 < this.zzy.length; i2++) {
                    String str = this.zzy[i2];
                    if (str != null) {
                        i++;
                        iZzam += zzgl.zzam(str);
                    }
                }
                iZzb = iZzb + iZzam + (i * 1);
            }
            if (this.zzz) {
                iZzb += zzgl.zzaa(4) + 1;
            }
            if (this.zzj != null && !this.zzj.equals("")) {
                iZzb += zzgl.zzb(5, this.zzj);
            }
            if (this.zzaa) {
                iZzb += zzgl.zzaa(6) + 1;
            }
            if (this.zzab) {
                iZzb += zzgl.zzaa(7) + 1;
            }
            if (this.zzr != null && !this.zzr.equals("")) {
                iZzb += zzgl.zzb(8, this.zzr);
            }
            if (this.zzac == null || this.zzac.length <= 0) {
                return iZzb;
            }
            int iZzam2 = 0;
            int i3 = 0;
            for (int i4 = 0; i4 < this.zzac.length; i4++) {
                String str2 = this.zzac[i4];
                if (str2 != null) {
                    i3++;
                    iZzam2 += zzgl.zzam(str2);
                }
            }
            return iZzb + iZzam2 + (i3 * 1);
        }
    }

    public static final class zzb extends zzgn<zzb> {
        private String zzw = "";
        public String zzaf = "";
        public String zzah = "";
        public String zzai = "";
        public long zzaj = 0;
        public String zzad = "";
        public boolean zzak = false;

        public zzb() {
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
                    this.zzw = zzgkVar.readString();
                } else if (iZzcc == 18) {
                    this.zzaf = zzgkVar.readString();
                } else if (iZzcc == 26) {
                    this.zzah = zzgkVar.readString();
                } else if (iZzcc == 34) {
                    this.zzai = zzgkVar.readString();
                } else if (iZzcc == 40) {
                    this.zzaj = zzgkVar.zzcv();
                } else if (iZzcc == 50) {
                    this.zzad = zzgkVar.readString();
                } else if (iZzcc == 56) {
                    this.zzak = zzgkVar.zzci();
                } else if (!super.zza(zzgkVar, iZzcc)) {
                    return this;
                }
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        public final void zza(zzgl zzglVar) throws zzgm {
            zzglVar.zza(1, this.zzw);
            if (this.zzaf != null && !this.zzaf.equals("")) {
                zzglVar.zza(2, this.zzaf);
            }
            if (this.zzah != null && !this.zzah.equals("")) {
                zzglVar.zza(3, this.zzah);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                zzglVar.zza(4, this.zzai);
            }
            if (this.zzaj != 0) {
                zzglVar.zzi(5, this.zzaj);
            }
            if (this.zzad != null && !this.zzad.equals("")) {
                zzglVar.zza(6, this.zzad);
            }
            if (this.zzak) {
                zzglVar.zzb(7, this.zzak);
            }
            super.zza(zzglVar);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        protected final int zzb() {
            int iZzb = super.zzb() + zzgl.zzb(1, this.zzw);
            if (this.zzaf != null && !this.zzaf.equals("")) {
                iZzb += zzgl.zzb(2, this.zzaf);
            }
            if (this.zzah != null && !this.zzah.equals("")) {
                iZzb += zzgl.zzb(3, this.zzah);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                iZzb += zzgl.zzb(4, this.zzai);
            }
            if (this.zzaj != 0) {
                iZzb += zzgl.zzd(5, this.zzaj);
            }
            if (this.zzad != null && !this.zzad.equals("")) {
                iZzb += zzgl.zzb(6, this.zzad);
            }
            return this.zzak ? iZzb + zzgl.zzaa(7) + 1 : iZzb;
        }
    }

    public static final class zzc extends zzgn<zzc> {
        private String zzw = "";
        public zzu[] zzan = zzu.zzd();

        public zzc() {
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
                    this.zzw = zzgkVar.readString();
                } else if (iZzcc == 18) {
                    int iZzb = zzgw.zzb(zzgkVar, 18);
                    int length = this.zzan == null ? 0 : this.zzan.length;
                    zzu[] zzuVarArr = new zzu[iZzb + length];
                    if (length != 0) {
                        System.arraycopy(this.zzan, 0, zzuVarArr, 0, length);
                    }
                    while (length < zzuVarArr.length - 1) {
                        zzuVarArr[length] = new zzu();
                        zzgkVar.zzb(zzuVarArr[length]);
                        zzgkVar.zzcc();
                        length++;
                    }
                    zzuVarArr[length] = new zzu();
                    zzgkVar.zzb(zzuVarArr[length]);
                    this.zzan = zzuVarArr;
                } else if (!super.zza(zzgkVar, iZzcc)) {
                    return this;
                }
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        public final void zza(zzgl zzglVar) throws zzgm {
            zzglVar.zza(1, this.zzw);
            if (this.zzan != null && this.zzan.length > 0) {
                for (int i = 0; i < this.zzan.length; i++) {
                    zzu zzuVar = this.zzan[i];
                    if (zzuVar != null) {
                        zzglVar.zza(2, zzuVar);
                    }
                }
            }
            super.zza(zzglVar);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        protected final int zzb() {
            int iZzb = super.zzb() + zzgl.zzb(1, this.zzw);
            if (this.zzan != null && this.zzan.length > 0) {
                for (int i = 0; i < this.zzan.length; i++) {
                    zzu zzuVar = this.zzan[i];
                    if (zzuVar != null) {
                        iZzb += zzgl.zzb(2, zzuVar);
                    }
                }
            }
            return iZzb;
        }
    }

    public static final class zzd extends zzgn<zzd> {
        private String zzw = "";
        public String zzah = "";
        public String zzas = "";
        public int zzbc = 0;

        public zzd() {
            this.zzya = -1;
        }

        /* JADX INFO: Access modifiers changed from: private */
        @Override // com.google.android.gms.internal.firebase_auth.zzgt
        /* JADX INFO: renamed from: zzc, reason: merged with bridge method [inline-methods] */
        public final zzd zza(zzgk zzgkVar) throws zzgs {
            while (true) {
                int iZzcc = zzgkVar.zzcc();
                if (iZzcc == 0) {
                    return this;
                }
                if (iZzcc == 10) {
                    this.zzw = zzgkVar.readString();
                } else if (iZzcc == 18) {
                    this.zzah = zzgkVar.readString();
                } else if (iZzcc == 26) {
                    this.zzas = zzgkVar.readString();
                } else if (iZzcc == 32) {
                    int position = zzgkVar.getPosition();
                    try {
                        this.zzbc = zzgx.zzbe(zzgkVar.zzcu());
                    } catch (IllegalArgumentException unused) {
                        zzgkVar.zzay(position);
                        zza(zzgkVar, iZzcc);
                    }
                } else if (!super.zza(zzgkVar, iZzcc)) {
                    return this;
                }
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        public final void zza(zzgl zzglVar) throws zzgm {
            zzglVar.zza(1, this.zzw);
            if (this.zzah != null && !this.zzah.equals("")) {
                zzglVar.zza(2, this.zzah);
            }
            if (this.zzas != null && !this.zzas.equals("")) {
                zzglVar.zza(3, this.zzas);
            }
            if (this.zzbc != 0) {
                zzglVar.zzc(4, this.zzbc);
            }
            super.zza(zzglVar);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        protected final int zzb() {
            int iZzb = super.zzb() + zzgl.zzb(1, this.zzw);
            if (this.zzah != null && !this.zzah.equals("")) {
                iZzb += zzgl.zzb(2, this.zzah);
            }
            if (this.zzas != null && !this.zzas.equals("")) {
                iZzb += zzgl.zzb(3, this.zzas);
            }
            return this.zzbc != 0 ? iZzb + zzgl.zzg(4, this.zzbc) : iZzb;
        }
    }

    public static final class zze extends zzgn<zze> {
        private String zzw = "";
        private String zzad = "";
        public String zzah = "";
        public String zzbh = "";
        private String[] zzbj = zzgw.EMPTY_STRING_ARRAY;
        public String zzaf = "";
        public zzt[] zzbx = zzt.zzc();
        private String zzas = "";
        public String zzbr = "";
        public String zzai = "";
        public long zzaj = 0;
        public String zzby = "";
        public boolean zzbk = false;

        public zze() {
            this.zzya = -1;
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgt
        public final /* synthetic */ zzgt zza(zzgk zzgkVar) throws zzgs {
            while (true) {
                int iZzcc = zzgkVar.zzcc();
                switch (iZzcc) {
                    case 0:
                        return this;
                    case 10:
                        this.zzw = zzgkVar.readString();
                        break;
                    case 18:
                        this.zzad = zzgkVar.readString();
                        break;
                    case 26:
                        this.zzah = zzgkVar.readString();
                        break;
                    case 34:
                        this.zzbh = zzgkVar.readString();
                        break;
                    case 42:
                        int iZzb = zzgw.zzb(zzgkVar, 42);
                        int length = this.zzbj == null ? 0 : this.zzbj.length;
                        String[] strArr = new String[iZzb + length];
                        if (length != 0) {
                            System.arraycopy(this.zzbj, 0, strArr, 0, length);
                        }
                        while (length < strArr.length - 1) {
                            strArr[length] = zzgkVar.readString();
                            zzgkVar.zzcc();
                            length++;
                        }
                        strArr[length] = zzgkVar.readString();
                        this.zzbj = strArr;
                        break;
                    case 50:
                        this.zzaf = zzgkVar.readString();
                        break;
                    case 58:
                        int iZzb2 = zzgw.zzb(zzgkVar, 58);
                        int length2 = this.zzbx == null ? 0 : this.zzbx.length;
                        zzt[] zztVarArr = new zzt[iZzb2 + length2];
                        if (length2 != 0) {
                            System.arraycopy(this.zzbx, 0, zztVarArr, 0, length2);
                        }
                        while (length2 < zztVarArr.length - 1) {
                            zztVarArr[length2] = new zzt();
                            zzgkVar.zzb(zztVarArr[length2]);
                            zzgkVar.zzcc();
                            length2++;
                        }
                        zztVarArr[length2] = new zzt();
                        zzgkVar.zzb(zztVarArr[length2]);
                        this.zzbx = zztVarArr;
                        break;
                    case 66:
                        this.zzas = zzgkVar.readString();
                        break;
                    case 74:
                        this.zzbr = zzgkVar.readString();
                        break;
                    case 82:
                        this.zzai = zzgkVar.readString();
                        break;
                    case 88:
                        this.zzaj = zzgkVar.zzcv();
                        break;
                    case 98:
                        this.zzby = zzgkVar.readString();
                        break;
                    case 104:
                        this.zzbk = zzgkVar.zzci();
                        break;
                    default:
                        if (!super.zza(zzgkVar, iZzcc)) {
                            return this;
                        }
                        break;
                        break;
                }
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        public final void zza(zzgl zzglVar) throws zzgm {
            zzglVar.zza(1, this.zzw);
            if (this.zzad != null && !this.zzad.equals("")) {
                zzglVar.zza(2, this.zzad);
            }
            if (this.zzah != null && !this.zzah.equals("")) {
                zzglVar.zza(3, this.zzah);
            }
            if (this.zzbh != null && !this.zzbh.equals("")) {
                zzglVar.zza(4, this.zzbh);
            }
            if (this.zzbj != null && this.zzbj.length > 0) {
                for (int i = 0; i < this.zzbj.length; i++) {
                    String str = this.zzbj[i];
                    if (str != null) {
                        zzglVar.zza(5, str);
                    }
                }
            }
            if (this.zzaf != null && !this.zzaf.equals("")) {
                zzglVar.zza(6, this.zzaf);
            }
            if (this.zzbx != null && this.zzbx.length > 0) {
                for (int i2 = 0; i2 < this.zzbx.length; i2++) {
                    zzt zztVar = this.zzbx[i2];
                    if (zztVar != null) {
                        zzglVar.zza(7, zztVar);
                    }
                }
            }
            if (this.zzas != null && !this.zzas.equals("")) {
                zzglVar.zza(8, this.zzas);
            }
            if (this.zzbr != null && !this.zzbr.equals("")) {
                zzglVar.zza(9, this.zzbr);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                zzglVar.zza(10, this.zzai);
            }
            if (this.zzaj != 0) {
                zzglVar.zzi(11, this.zzaj);
            }
            if (this.zzby != null && !this.zzby.equals("")) {
                zzglVar.zza(12, this.zzby);
            }
            if (this.zzbk) {
                zzglVar.zzb(13, this.zzbk);
            }
            super.zza(zzglVar);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        protected final int zzb() {
            int iZzb = super.zzb() + zzgl.zzb(1, this.zzw);
            if (this.zzad != null && !this.zzad.equals("")) {
                iZzb += zzgl.zzb(2, this.zzad);
            }
            if (this.zzah != null && !this.zzah.equals("")) {
                iZzb += zzgl.zzb(3, this.zzah);
            }
            if (this.zzbh != null && !this.zzbh.equals("")) {
                iZzb += zzgl.zzb(4, this.zzbh);
            }
            if (this.zzbj != null && this.zzbj.length > 0) {
                int iZzam = 0;
                int i = 0;
                for (int i2 = 0; i2 < this.zzbj.length; i2++) {
                    String str = this.zzbj[i2];
                    if (str != null) {
                        i++;
                        iZzam += zzgl.zzam(str);
                    }
                }
                iZzb = iZzb + iZzam + (i * 1);
            }
            if (this.zzaf != null && !this.zzaf.equals("")) {
                iZzb += zzgl.zzb(6, this.zzaf);
            }
            if (this.zzbx != null && this.zzbx.length > 0) {
                for (int i3 = 0; i3 < this.zzbx.length; i3++) {
                    zzt zztVar = this.zzbx[i3];
                    if (zztVar != null) {
                        iZzb += zzgl.zzb(7, zztVar);
                    }
                }
            }
            if (this.zzas != null && !this.zzas.equals("")) {
                iZzb += zzgl.zzb(8, this.zzas);
            }
            if (this.zzbr != null && !this.zzbr.equals("")) {
                iZzb += zzgl.zzb(9, this.zzbr);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                iZzb += zzgl.zzb(10, this.zzai);
            }
            if (this.zzaj != 0) {
                iZzb += zzgl.zzd(11, this.zzaj);
            }
            if (this.zzby != null && !this.zzby.equals("")) {
                iZzb += zzgl.zzb(12, this.zzby);
            }
            return this.zzbk ? iZzb + zzgl.zzaa(13) + 1 : iZzb;
        }
    }

    public static final class zzf extends zzgn<zzf> {
        private String zzw = "";
        public String zzaf = "";
        public String zzbh = "";
        public String zzah = "";
        public String zzai = "";
        public long zzaj = 0;
        private String zzad = "";

        public zzf() {
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
                    this.zzw = zzgkVar.readString();
                } else if (iZzcc == 18) {
                    this.zzaf = zzgkVar.readString();
                } else if (iZzcc == 34) {
                    this.zzbh = zzgkVar.readString();
                } else if (iZzcc == 42) {
                    this.zzah = zzgkVar.readString();
                } else if (iZzcc == 50) {
                    this.zzai = zzgkVar.readString();
                } else if (iZzcc == 56) {
                    this.zzaj = zzgkVar.zzcv();
                } else if (iZzcc == 66) {
                    this.zzad = zzgkVar.readString();
                } else if (!super.zza(zzgkVar, iZzcc)) {
                    return this;
                }
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        public final void zza(zzgl zzglVar) throws zzgm {
            zzglVar.zza(1, this.zzw);
            if (this.zzaf != null && !this.zzaf.equals("")) {
                zzglVar.zza(2, this.zzaf);
            }
            if (this.zzbh != null && !this.zzbh.equals("")) {
                zzglVar.zza(4, this.zzbh);
            }
            if (this.zzah != null && !this.zzah.equals("")) {
                zzglVar.zza(5, this.zzah);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                zzglVar.zza(6, this.zzai);
            }
            if (this.zzaj != 0) {
                zzglVar.zzi(7, this.zzaj);
            }
            if (this.zzad != null && !this.zzad.equals("")) {
                zzglVar.zza(8, this.zzad);
            }
            super.zza(zzglVar);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        protected final int zzb() {
            int iZzb = super.zzb() + zzgl.zzb(1, this.zzw);
            if (this.zzaf != null && !this.zzaf.equals("")) {
                iZzb += zzgl.zzb(2, this.zzaf);
            }
            if (this.zzbh != null && !this.zzbh.equals("")) {
                iZzb += zzgl.zzb(4, this.zzbh);
            }
            if (this.zzah != null && !this.zzah.equals("")) {
                iZzb += zzgl.zzb(5, this.zzah);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                iZzb += zzgl.zzb(6, this.zzai);
            }
            if (this.zzaj != 0) {
                iZzb += zzgl.zzd(7, this.zzaj);
            }
            return (this.zzad == null || this.zzad.equals("")) ? iZzb : iZzb + zzgl.zzb(8, this.zzad);
        }
    }

    /* JADX INFO: renamed from: com.google.android.gms.internal.firebase_auth.zzg$zzg, reason: collision with other inner class name */
    public static final class C0067zzg extends zzgn<C0067zzg> {
        private String zzcg = "";
        public String zzj = "";
        public String zzah = "";
        private boolean zzbk = false;
        private String zzch = "";
        private String zzci = "";
        private String zzcj = "";
        private String zzck = "";
        private String zzcl = "";
        private String zzcm = "";
        public String zzbr = "";
        private String zzcn = "";
        private String zzco = "";
        private String zzl = "";
        private String zzcp = "";
        private String zzcq = "";
        public String zzad = "";
        private boolean zzcr = false;
        public String zzbh = "";
        public String zzaf = "";
        private String zzcs = "";
        private String zzn = "";
        private String[] zzct = zzgw.EMPTY_STRING_ARRAY;
        public boolean zzcu = false;
        private String zzcv = "";
        private String zzcw = "";
        public String zzcx = "";
        private String zzcy = "";
        private long zzcz = 0;
        private String zzda = "";
        public boolean zzdb = false;
        private String zzdc = "";
        public String zzai = "";
        public long zzaj = 0;
        public String zzdd = "";
        private String zzde = "";
        public String zzdf = "";
        private String zzdg = "";
        public boolean zzak = false;

        public C0067zzg() {
            this.zzya = -1;
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgt
        public final /* synthetic */ zzgt zza(zzgk zzgkVar) throws zzgs {
            while (true) {
                int iZzcc = zzgkVar.zzcc();
                switch (iZzcc) {
                    case 0:
                        return this;
                    case 10:
                        this.zzcg = zzgkVar.readString();
                        break;
                    case 18:
                        this.zzj = zzgkVar.readString();
                        break;
                    case 26:
                        this.zzah = zzgkVar.readString();
                        break;
                    case 32:
                        this.zzbk = zzgkVar.zzci();
                        break;
                    case 42:
                        this.zzch = zzgkVar.readString();
                        break;
                    case 50:
                        this.zzci = zzgkVar.readString();
                        break;
                    case 58:
                        this.zzcj = zzgkVar.readString();
                        break;
                    case 66:
                        this.zzck = zzgkVar.readString();
                        break;
                    case 74:
                        this.zzcl = zzgkVar.readString();
                        break;
                    case 82:
                        this.zzcm = zzgkVar.readString();
                        break;
                    case 90:
                        this.zzbr = zzgkVar.readString();
                        break;
                    case 98:
                        this.zzcn = zzgkVar.readString();
                        break;
                    case 106:
                        this.zzco = zzgkVar.readString();
                        break;
                    case 114:
                        this.zzl = zzgkVar.readString();
                        break;
                    case 122:
                        this.zzcp = zzgkVar.readString();
                        break;
                    case 130:
                        this.zzcq = zzgkVar.readString();
                        break;
                    case 138:
                        this.zzad = zzgkVar.readString();
                        break;
                    case 144:
                        this.zzcr = zzgkVar.zzci();
                        break;
                    case 154:
                        this.zzbh = zzgkVar.readString();
                        break;
                    case 162:
                        this.zzaf = zzgkVar.readString();
                        break;
                    case 170:
                        this.zzcs = zzgkVar.readString();
                        break;
                    case 186:
                        this.zzn = zzgkVar.readString();
                        break;
                    case 194:
                        int iZzb = zzgw.zzb(zzgkVar, 194);
                        int length = this.zzct == null ? 0 : this.zzct.length;
                        String[] strArr = new String[iZzb + length];
                        if (length != 0) {
                            System.arraycopy(this.zzct, 0, strArr, 0, length);
                        }
                        while (length < strArr.length - 1) {
                            strArr[length] = zzgkVar.readString();
                            zzgkVar.zzcc();
                            length++;
                        }
                        strArr[length] = zzgkVar.readString();
                        this.zzct = strArr;
                        break;
                    case ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION /* 200 */:
                        this.zzcu = zzgkVar.zzci();
                        break;
                    case 210:
                        this.zzcv = zzgkVar.readString();
                        break;
                    case 218:
                        this.zzcw = zzgkVar.readString();
                        break;
                    case 226:
                        this.zzcx = zzgkVar.readString();
                        break;
                    case 234:
                        this.zzcy = zzgkVar.readString();
                        break;
                    case 240:
                        this.zzcz = zzgkVar.zzcv();
                        break;
                    case ItemTouchHelper.Callback.DEFAULT_SWIPE_ANIMATION_DURATION /* 250 */:
                        this.zzda = zzgkVar.readString();
                        break;
                    case 256:
                        this.zzdb = zzgkVar.zzci();
                        break;
                    case 266:
                        this.zzdc = zzgkVar.readString();
                        break;
                    case 274:
                        this.zzai = zzgkVar.readString();
                        break;
                    case 280:
                        this.zzaj = zzgkVar.zzcv();
                        break;
                    case 290:
                        this.zzdd = zzgkVar.readString();
                        break;
                    case 298:
                        this.zzde = zzgkVar.readString();
                        break;
                    case 306:
                        this.zzdf = zzgkVar.readString();
                        break;
                    case 314:
                        this.zzdg = zzgkVar.readString();
                        break;
                    case 320:
                        this.zzak = zzgkVar.zzci();
                        break;
                    default:
                        if (!super.zza(zzgkVar, iZzcc)) {
                            return this;
                        }
                        break;
                        break;
                }
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        public final void zza(zzgl zzglVar) throws zzgm {
            if (this.zzcg != null && !this.zzcg.equals("")) {
                zzglVar.zza(1, this.zzcg);
            }
            if (this.zzj != null && !this.zzj.equals("")) {
                zzglVar.zza(2, this.zzj);
            }
            if (this.zzah != null && !this.zzah.equals("")) {
                zzglVar.zza(3, this.zzah);
            }
            if (this.zzbk) {
                zzglVar.zzb(4, this.zzbk);
            }
            if (this.zzch != null && !this.zzch.equals("")) {
                zzglVar.zza(5, this.zzch);
            }
            if (this.zzci != null && !this.zzci.equals("")) {
                zzglVar.zza(6, this.zzci);
            }
            if (this.zzcj != null && !this.zzcj.equals("")) {
                zzglVar.zza(7, this.zzcj);
            }
            if (this.zzck != null && !this.zzck.equals("")) {
                zzglVar.zza(8, this.zzck);
            }
            if (this.zzcl != null && !this.zzcl.equals("")) {
                zzglVar.zza(9, this.zzcl);
            }
            if (this.zzcm != null && !this.zzcm.equals("")) {
                zzglVar.zza(10, this.zzcm);
            }
            if (this.zzbr != null && !this.zzbr.equals("")) {
                zzglVar.zza(11, this.zzbr);
            }
            if (this.zzcn != null && !this.zzcn.equals("")) {
                zzglVar.zza(12, this.zzcn);
            }
            if (this.zzco != null && !this.zzco.equals("")) {
                zzglVar.zza(13, this.zzco);
            }
            if (this.zzl != null && !this.zzl.equals("")) {
                zzglVar.zza(14, this.zzl);
            }
            if (this.zzcp != null && !this.zzcp.equals("")) {
                zzglVar.zza(15, this.zzcp);
            }
            if (this.zzcq != null && !this.zzcq.equals("")) {
                zzglVar.zza(16, this.zzcq);
            }
            if (this.zzad != null && !this.zzad.equals("")) {
                zzglVar.zza(17, this.zzad);
            }
            if (this.zzcr) {
                zzglVar.zzb(18, this.zzcr);
            }
            if (this.zzbh != null && !this.zzbh.equals("")) {
                zzglVar.zza(19, this.zzbh);
            }
            if (this.zzaf != null && !this.zzaf.equals("")) {
                zzglVar.zza(20, this.zzaf);
            }
            if (this.zzcs != null && !this.zzcs.equals("")) {
                zzglVar.zza(21, this.zzcs);
            }
            if (this.zzn != null && !this.zzn.equals("")) {
                zzglVar.zza(23, this.zzn);
            }
            if (this.zzct != null && this.zzct.length > 0) {
                for (int i = 0; i < this.zzct.length; i++) {
                    String str = this.zzct[i];
                    if (str != null) {
                        zzglVar.zza(24, str);
                    }
                }
            }
            if (this.zzcu) {
                zzglVar.zzb(25, this.zzcu);
            }
            if (this.zzcv != null && !this.zzcv.equals("")) {
                zzglVar.zza(26, this.zzcv);
            }
            if (this.zzcw != null && !this.zzcw.equals("")) {
                zzglVar.zza(27, this.zzcw);
            }
            if (this.zzcx != null && !this.zzcx.equals("")) {
                zzglVar.zza(28, this.zzcx);
            }
            if (this.zzcy != null && !this.zzcy.equals("")) {
                zzglVar.zza(29, this.zzcy);
            }
            if (this.zzcz != 0) {
                zzglVar.zzi(30, this.zzcz);
            }
            if (this.zzda != null && !this.zzda.equals("")) {
                zzglVar.zza(31, this.zzda);
            }
            if (this.zzdb) {
                zzglVar.zzb(32, this.zzdb);
            }
            if (this.zzdc != null && !this.zzdc.equals("")) {
                zzglVar.zza(33, this.zzdc);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                zzglVar.zza(34, this.zzai);
            }
            if (this.zzaj != 0) {
                zzglVar.zzi(35, this.zzaj);
            }
            if (this.zzdd != null && !this.zzdd.equals("")) {
                zzglVar.zza(36, this.zzdd);
            }
            if (this.zzde != null && !this.zzde.equals("")) {
                zzglVar.zza(37, this.zzde);
            }
            if (this.zzdf != null && !this.zzdf.equals("")) {
                zzglVar.zza(38, this.zzdf);
            }
            if (this.zzdg != null && !this.zzdg.equals("")) {
                zzglVar.zza(39, this.zzdg);
            }
            if (this.zzak) {
                zzglVar.zzb(40, this.zzak);
            }
            super.zza(zzglVar);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        protected final int zzb() {
            int iZzb = super.zzb();
            if (this.zzcg != null && !this.zzcg.equals("")) {
                iZzb += zzgl.zzb(1, this.zzcg);
            }
            if (this.zzj != null && !this.zzj.equals("")) {
                iZzb += zzgl.zzb(2, this.zzj);
            }
            if (this.zzah != null && !this.zzah.equals("")) {
                iZzb += zzgl.zzb(3, this.zzah);
            }
            if (this.zzbk) {
                iZzb += zzgl.zzaa(4) + 1;
            }
            if (this.zzch != null && !this.zzch.equals("")) {
                iZzb += zzgl.zzb(5, this.zzch);
            }
            if (this.zzci != null && !this.zzci.equals("")) {
                iZzb += zzgl.zzb(6, this.zzci);
            }
            if (this.zzcj != null && !this.zzcj.equals("")) {
                iZzb += zzgl.zzb(7, this.zzcj);
            }
            if (this.zzck != null && !this.zzck.equals("")) {
                iZzb += zzgl.zzb(8, this.zzck);
            }
            if (this.zzcl != null && !this.zzcl.equals("")) {
                iZzb += zzgl.zzb(9, this.zzcl);
            }
            if (this.zzcm != null && !this.zzcm.equals("")) {
                iZzb += zzgl.zzb(10, this.zzcm);
            }
            if (this.zzbr != null && !this.zzbr.equals("")) {
                iZzb += zzgl.zzb(11, this.zzbr);
            }
            if (this.zzcn != null && !this.zzcn.equals("")) {
                iZzb += zzgl.zzb(12, this.zzcn);
            }
            if (this.zzco != null && !this.zzco.equals("")) {
                iZzb += zzgl.zzb(13, this.zzco);
            }
            if (this.zzl != null && !this.zzl.equals("")) {
                iZzb += zzgl.zzb(14, this.zzl);
            }
            if (this.zzcp != null && !this.zzcp.equals("")) {
                iZzb += zzgl.zzb(15, this.zzcp);
            }
            if (this.zzcq != null && !this.zzcq.equals("")) {
                iZzb += zzgl.zzb(16, this.zzcq);
            }
            if (this.zzad != null && !this.zzad.equals("")) {
                iZzb += zzgl.zzb(17, this.zzad);
            }
            if (this.zzcr) {
                iZzb += zzgl.zzaa(18) + 1;
            }
            if (this.zzbh != null && !this.zzbh.equals("")) {
                iZzb += zzgl.zzb(19, this.zzbh);
            }
            if (this.zzaf != null && !this.zzaf.equals("")) {
                iZzb += zzgl.zzb(20, this.zzaf);
            }
            if (this.zzcs != null && !this.zzcs.equals("")) {
                iZzb += zzgl.zzb(21, this.zzcs);
            }
            if (this.zzn != null && !this.zzn.equals("")) {
                iZzb += zzgl.zzb(23, this.zzn);
            }
            if (this.zzct != null && this.zzct.length > 0) {
                int iZzam = 0;
                int i = 0;
                for (int i2 = 0; i2 < this.zzct.length; i2++) {
                    String str = this.zzct[i2];
                    if (str != null) {
                        i++;
                        iZzam += zzgl.zzam(str);
                    }
                }
                iZzb = iZzb + iZzam + (i * 2);
            }
            if (this.zzcu) {
                iZzb += zzgl.zzaa(25) + 1;
            }
            if (this.zzcv != null && !this.zzcv.equals("")) {
                iZzb += zzgl.zzb(26, this.zzcv);
            }
            if (this.zzcw != null && !this.zzcw.equals("")) {
                iZzb += zzgl.zzb(27, this.zzcw);
            }
            if (this.zzcx != null && !this.zzcx.equals("")) {
                iZzb += zzgl.zzb(28, this.zzcx);
            }
            if (this.zzcy != null && !this.zzcy.equals("")) {
                iZzb += zzgl.zzb(29, this.zzcy);
            }
            if (this.zzcz != 0) {
                iZzb += zzgl.zzd(30, this.zzcz);
            }
            if (this.zzda != null && !this.zzda.equals("")) {
                iZzb += zzgl.zzb(31, this.zzda);
            }
            if (this.zzdb) {
                iZzb += zzgl.zzaa(32) + 1;
            }
            if (this.zzdc != null && !this.zzdc.equals("")) {
                iZzb += zzgl.zzb(33, this.zzdc);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                iZzb += zzgl.zzb(34, this.zzai);
            }
            if (this.zzaj != 0) {
                iZzb += zzgl.zzd(35, this.zzaj);
            }
            if (this.zzdd != null && !this.zzdd.equals("")) {
                iZzb += zzgl.zzb(36, this.zzdd);
            }
            if (this.zzde != null && !this.zzde.equals("")) {
                iZzb += zzgl.zzb(37, this.zzde);
            }
            if (this.zzdf != null && !this.zzdf.equals("")) {
                iZzb += zzgl.zzb(38, this.zzdf);
            }
            if (this.zzdg != null && !this.zzdg.equals("")) {
                iZzb += zzgl.zzb(39, this.zzdg);
            }
            return this.zzak ? iZzb + zzgl.zzaa(40) + 1 : iZzb;
        }
    }

    public static final class zzh extends zzgn<zzh> {
        private String zzw = "";
        public String zzaf = "";
        public String zzai = "";
        public long zzaj = 0;
        public boolean zzak = false;

        public zzh() {
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
                    this.zzw = zzgkVar.readString();
                } else if (iZzcc == 18) {
                    this.zzaf = zzgkVar.readString();
                } else if (iZzcc == 26) {
                    this.zzai = zzgkVar.readString();
                } else if (iZzcc == 32) {
                    this.zzaj = zzgkVar.zzcv();
                } else if (iZzcc == 40) {
                    this.zzak = zzgkVar.zzci();
                } else if (!super.zza(zzgkVar, iZzcc)) {
                    return this;
                }
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        public final void zza(zzgl zzglVar) throws zzgm {
            zzglVar.zza(1, this.zzw);
            if (this.zzaf != null && !this.zzaf.equals("")) {
                zzglVar.zza(2, this.zzaf);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                zzglVar.zza(3, this.zzai);
            }
            if (this.zzaj != 0) {
                zzglVar.zzi(4, this.zzaj);
            }
            if (this.zzak) {
                zzglVar.zzb(5, this.zzak);
            }
            super.zza(zzglVar);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        protected final int zzb() {
            int iZzb = super.zzb() + zzgl.zzb(1, this.zzw);
            if (this.zzaf != null && !this.zzaf.equals("")) {
                iZzb += zzgl.zzb(2, this.zzaf);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                iZzb += zzgl.zzb(3, this.zzai);
            }
            if (this.zzaj != 0) {
                iZzb += zzgl.zzd(4, this.zzaj);
            }
            return this.zzak ? iZzb + zzgl.zzaa(5) + 1 : iZzb;
        }
    }

    public static final class zzi extends zzgn<zzi> {
        private String zzw = "";
        public String zzad = "";
        public String zzah = "";
        public String zzbh = "";
        public String zzaf = "";
        private boolean zzz = false;
        public String zzbr = "";
        private String zzcx = "";
        private long zzcz = 0;
        private String zzda = "";
        public String zzai = "";
        public long zzaj = 0;

        public zzi() {
            this.zzya = -1;
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgt
        public final /* synthetic */ zzgt zza(zzgk zzgkVar) throws zzgs {
            while (true) {
                int iZzcc = zzgkVar.zzcc();
                switch (iZzcc) {
                    case 0:
                        return this;
                    case 10:
                        this.zzw = zzgkVar.readString();
                        break;
                    case 18:
                        this.zzad = zzgkVar.readString();
                        break;
                    case 26:
                        this.zzah = zzgkVar.readString();
                        break;
                    case 34:
                        this.zzbh = zzgkVar.readString();
                        break;
                    case 42:
                        this.zzaf = zzgkVar.readString();
                        break;
                    case 48:
                        this.zzz = zzgkVar.zzci();
                        break;
                    case 58:
                        this.zzbr = zzgkVar.readString();
                        break;
                    case 66:
                        this.zzcx = zzgkVar.readString();
                        break;
                    case 72:
                        this.zzcz = zzgkVar.zzcv();
                        break;
                    case 82:
                        this.zzda = zzgkVar.readString();
                        break;
                    case 90:
                        this.zzai = zzgkVar.readString();
                        break;
                    case 96:
                        this.zzaj = zzgkVar.zzcv();
                        break;
                    default:
                        if (!super.zza(zzgkVar, iZzcc)) {
                            return this;
                        }
                        break;
                        break;
                }
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        public final void zza(zzgl zzglVar) throws zzgm {
            zzglVar.zza(1, this.zzw);
            if (this.zzad != null && !this.zzad.equals("")) {
                zzglVar.zza(2, this.zzad);
            }
            if (this.zzah != null && !this.zzah.equals("")) {
                zzglVar.zza(3, this.zzah);
            }
            if (this.zzbh != null && !this.zzbh.equals("")) {
                zzglVar.zza(4, this.zzbh);
            }
            if (this.zzaf != null && !this.zzaf.equals("")) {
                zzglVar.zza(5, this.zzaf);
            }
            if (this.zzz) {
                zzglVar.zzb(6, this.zzz);
            }
            if (this.zzbr != null && !this.zzbr.equals("")) {
                zzglVar.zza(7, this.zzbr);
            }
            if (this.zzcx != null && !this.zzcx.equals("")) {
                zzglVar.zza(8, this.zzcx);
            }
            if (this.zzcz != 0) {
                zzglVar.zzi(9, this.zzcz);
            }
            if (this.zzda != null && !this.zzda.equals("")) {
                zzglVar.zza(10, this.zzda);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                zzglVar.zza(11, this.zzai);
            }
            if (this.zzaj != 0) {
                zzglVar.zzi(12, this.zzaj);
            }
            super.zza(zzglVar);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
        protected final int zzb() {
            int iZzb = super.zzb() + zzgl.zzb(1, this.zzw);
            if (this.zzad != null && !this.zzad.equals("")) {
                iZzb += zzgl.zzb(2, this.zzad);
            }
            if (this.zzah != null && !this.zzah.equals("")) {
                iZzb += zzgl.zzb(3, this.zzah);
            }
            if (this.zzbh != null && !this.zzbh.equals("")) {
                iZzb += zzgl.zzb(4, this.zzbh);
            }
            if (this.zzaf != null && !this.zzaf.equals("")) {
                iZzb += zzgl.zzb(5, this.zzaf);
            }
            if (this.zzz) {
                iZzb += zzgl.zzaa(6) + 1;
            }
            if (this.zzbr != null && !this.zzbr.equals("")) {
                iZzb += zzgl.zzb(7, this.zzbr);
            }
            if (this.zzcx != null && !this.zzcx.equals("")) {
                iZzb += zzgl.zzb(8, this.zzcx);
            }
            if (this.zzcz != 0) {
                iZzb += zzgl.zzd(9, this.zzcz);
            }
            if (this.zzda != null && !this.zzda.equals("")) {
                iZzb += zzgl.zzb(10, this.zzda);
            }
            if (this.zzai != null && !this.zzai.equals("")) {
                iZzb += zzgl.zzb(11, this.zzai);
            }
            return this.zzaj != 0 ? iZzb + zzgl.zzd(12, this.zzaj) : iZzb;
        }
    }
}
