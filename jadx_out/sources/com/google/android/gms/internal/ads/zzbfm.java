package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzbfm extends zzbfc<zzbfm> {
    public Integer zzamf = null;
    private Integer zzecg = null;
    public String url = null;
    public String zzech = null;
    private String zzeci = null;
    public zzbfn zzecj = null;
    public zzbfu[] zzeck = zzbfu.zzagu();
    public String zzecl = null;
    public zzbft zzecm = null;
    private Boolean zzecn = null;
    private String[] zzeco = zzbfl.zzecd;
    private String zzecp = null;
    private Boolean zzecq = null;
    private Boolean zzecr = null;
    private byte[] zzecs = null;
    public zzbfv zzect = null;
    public String[] zzecu = zzbfl.zzecd;
    public String[] zzecv = zzbfl.zzecd;

    public zzbfm() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Code restructure failed: missing block: B:50:0x00c8, code lost:
    
        r5 = new java.lang.StringBuilder(39);
        r5.append(r2);
        r5.append(" is not a valid enum Verdict");
     */
    /* JADX WARN: Code restructure failed: missing block: B:51:0x00e0, code lost:
    
        throw new java.lang.IllegalArgumentException(r5.toString());
     */
    @Override // com.google.android.gms.internal.ads.zzbfi
    /* JADX INFO: renamed from: zzaa, reason: merged with bridge method [inline-methods] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final com.google.android.gms.internal.ads.zzbfm zza(com.google.android.gms.internal.ads.zzbez r7) throws com.google.android.gms.internal.ads.zzbfh {
        /*
            Method dump skipped, instruction units count: 544
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbfm.zza(com.google.android.gms.internal.ads.zzbez):com.google.android.gms.internal.ads.zzbfm");
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.url != null) {
            zzbfaVar.zzf(1, this.url);
        }
        if (this.zzech != null) {
            zzbfaVar.zzf(2, this.zzech);
        }
        if (this.zzeci != null) {
            zzbfaVar.zzf(3, this.zzeci);
        }
        if (this.zzeck != null && this.zzeck.length > 0) {
            for (int i = 0; i < this.zzeck.length; i++) {
                zzbfu zzbfuVar = this.zzeck[i];
                if (zzbfuVar != null) {
                    zzbfaVar.zza(4, zzbfuVar);
                }
            }
        }
        if (this.zzecn != null) {
            zzbfaVar.zzf(5, this.zzecn.booleanValue());
        }
        if (this.zzeco != null && this.zzeco.length > 0) {
            for (int i2 = 0; i2 < this.zzeco.length; i2++) {
                String str = this.zzeco[i2];
                if (str != null) {
                    zzbfaVar.zzf(6, str);
                }
            }
        }
        if (this.zzecp != null) {
            zzbfaVar.zzf(7, this.zzecp);
        }
        if (this.zzecq != null) {
            zzbfaVar.zzf(8, this.zzecq.booleanValue());
        }
        if (this.zzecr != null) {
            zzbfaVar.zzf(9, this.zzecr.booleanValue());
        }
        if (this.zzamf != null) {
            zzbfaVar.zzm(10, this.zzamf.intValue());
        }
        if (this.zzecg != null) {
            zzbfaVar.zzm(11, this.zzecg.intValue());
        }
        if (this.zzecj != null) {
            zzbfaVar.zza(12, this.zzecj);
        }
        if (this.zzecl != null) {
            zzbfaVar.zzf(13, this.zzecl);
        }
        if (this.zzecm != null) {
            zzbfaVar.zza(14, this.zzecm);
        }
        if (this.zzecs != null) {
            zzbfaVar.zza(15, this.zzecs);
        }
        if (this.zzect != null) {
            zzbfaVar.zza(17, this.zzect);
        }
        if (this.zzecu != null && this.zzecu.length > 0) {
            for (int i3 = 0; i3 < this.zzecu.length; i3++) {
                String str2 = this.zzecu[i3];
                if (str2 != null) {
                    zzbfaVar.zzf(20, str2);
                }
            }
        }
        if (this.zzecv != null && this.zzecv.length > 0) {
            for (int i4 = 0; i4 < this.zzecv.length; i4++) {
                String str3 = this.zzecv[i4];
                if (str3 != null) {
                    zzbfaVar.zzf(21, str3);
                }
            }
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.url != null) {
            iZzr += zzbfa.zzg(1, this.url);
        }
        if (this.zzech != null) {
            iZzr += zzbfa.zzg(2, this.zzech);
        }
        if (this.zzeci != null) {
            iZzr += zzbfa.zzg(3, this.zzeci);
        }
        if (this.zzeck != null && this.zzeck.length > 0) {
            int iZzb = iZzr;
            for (int i = 0; i < this.zzeck.length; i++) {
                zzbfu zzbfuVar = this.zzeck[i];
                if (zzbfuVar != null) {
                    iZzb += zzbfa.zzb(4, zzbfuVar);
                }
            }
            iZzr = iZzb;
        }
        if (this.zzecn != null) {
            this.zzecn.booleanValue();
            iZzr += zzbfa.zzcd(5) + 1;
        }
        if (this.zzeco != null && this.zzeco.length > 0) {
            int iZzeo = 0;
            int i2 = 0;
            for (int i3 = 0; i3 < this.zzeco.length; i3++) {
                String str = this.zzeco[i3];
                if (str != null) {
                    i2++;
                    iZzeo += zzbfa.zzeo(str);
                }
            }
            iZzr = iZzr + iZzeo + (i2 * 1);
        }
        if (this.zzecp != null) {
            iZzr += zzbfa.zzg(7, this.zzecp);
        }
        if (this.zzecq != null) {
            this.zzecq.booleanValue();
            iZzr += zzbfa.zzcd(8) + 1;
        }
        if (this.zzecr != null) {
            this.zzecr.booleanValue();
            iZzr += zzbfa.zzcd(9) + 1;
        }
        if (this.zzamf != null) {
            iZzr += zzbfa.zzq(10, this.zzamf.intValue());
        }
        if (this.zzecg != null) {
            iZzr += zzbfa.zzq(11, this.zzecg.intValue());
        }
        if (this.zzecj != null) {
            iZzr += zzbfa.zzb(12, this.zzecj);
        }
        if (this.zzecl != null) {
            iZzr += zzbfa.zzg(13, this.zzecl);
        }
        if (this.zzecm != null) {
            iZzr += zzbfa.zzb(14, this.zzecm);
        }
        if (this.zzecs != null) {
            iZzr += zzbfa.zzb(15, this.zzecs);
        }
        if (this.zzect != null) {
            iZzr += zzbfa.zzb(17, this.zzect);
        }
        if (this.zzecu != null && this.zzecu.length > 0) {
            int iZzeo2 = 0;
            int i4 = 0;
            for (int i5 = 0; i5 < this.zzecu.length; i5++) {
                String str2 = this.zzecu[i5];
                if (str2 != null) {
                    i4++;
                    iZzeo2 += zzbfa.zzeo(str2);
                }
            }
            iZzr = iZzr + iZzeo2 + (i4 * 2);
        }
        if (this.zzecv == null || this.zzecv.length <= 0) {
            return iZzr;
        }
        int iZzeo3 = 0;
        int i6 = 0;
        for (int i7 = 0; i7 < this.zzecv.length; i7++) {
            String str3 = this.zzecv[i7];
            if (str3 != null) {
                i6++;
                iZzeo3 += zzbfa.zzeo(str3);
            }
        }
        return iZzr + iZzeo3 + (i6 * 2);
    }
}
