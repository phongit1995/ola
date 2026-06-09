package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zziu extends zzbfc<zziu> {
    private static volatile zziu[] zzaow;
    private zziy zzaox = null;
    private zzja zzaoy = null;
    private zzjb zzaoz = null;
    private zzjc zzapa = null;
    private zziv zzapb = null;
    private zziz zzapc = null;
    private zzix zzapd = null;
    private Integer zzape = null;
    private Integer zzapf = null;
    private zzis zzapg = null;
    private Integer zzaph = null;
    private Integer zzapi = null;
    private Integer zzapj = null;
    private Integer zzapk = null;
    private Integer zzapl = null;
    private Long zzapm = null;

    public zziu() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    public static zziu[] zzhu() {
        if (zzaow == null) {
            synchronized (zzbfg.zzebs) {
                if (zzaow == null) {
                    zzaow = new zziu[0];
                }
            }
        }
        return zzaow;
    }

    @Override // com.google.android.gms.internal.ads.zzbfi
    public final /* synthetic */ zzbfi zza(zzbez zzbezVar) throws zzbfh {
        zzbfi zzbfiVar;
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            switch (iZzabk) {
                case 0:
                    return this;
                case 42:
                    if (this.zzaox == null) {
                        this.zzaox = new zziy();
                    }
                    zzbfiVar = this.zzaox;
                    break;
                case 50:
                    if (this.zzaoy == null) {
                        this.zzaoy = new zzja();
                    }
                    zzbfiVar = this.zzaoy;
                    break;
                case 58:
                    if (this.zzaoz == null) {
                        this.zzaoz = new zzjb();
                    }
                    zzbfiVar = this.zzaoz;
                    break;
                case 66:
                    if (this.zzapa == null) {
                        this.zzapa = new zzjc();
                    }
                    zzbfiVar = this.zzapa;
                    break;
                case 74:
                    if (this.zzapb == null) {
                        this.zzapb = new zziv();
                    }
                    zzbfiVar = this.zzapb;
                    break;
                case 82:
                    if (this.zzapc == null) {
                        this.zzapc = new zziz();
                    }
                    zzbfiVar = this.zzapc;
                    break;
                case 90:
                    if (this.zzapd == null) {
                        this.zzapd = new zzix();
                    }
                    zzbfiVar = this.zzapd;
                    break;
                case 96:
                    this.zzape = Integer.valueOf(zzbezVar.zzacc());
                    continue;
                case 104:
                    this.zzapf = Integer.valueOf(zzbezVar.zzacc());
                    continue;
                case 114:
                    if (this.zzapg == null) {
                        this.zzapg = new zzis();
                    }
                    zzbfiVar = this.zzapg;
                    break;
                case 120:
                    this.zzaph = Integer.valueOf(zzbezVar.zzacc());
                    continue;
                case 128:
                    this.zzapi = Integer.valueOf(zzbezVar.zzacc());
                    continue;
                case 136:
                    this.zzapj = Integer.valueOf(zzbezVar.zzacc());
                    continue;
                case 144:
                    this.zzapk = Integer.valueOf(zzbezVar.zzacc());
                    continue;
                case 152:
                    this.zzapl = Integer.valueOf(zzbezVar.zzacc());
                    continue;
                case 160:
                    this.zzapm = Long.valueOf(zzbezVar.zzacd());
                    continue;
                default:
                    if (!super.zza(zzbezVar, iZzabk)) {
                        return this;
                    }
                    continue;
                    break;
            }
            zzbezVar.zza(zzbfiVar);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzaox != null) {
            zzbfaVar.zza(5, this.zzaox);
        }
        if (this.zzaoy != null) {
            zzbfaVar.zza(6, this.zzaoy);
        }
        if (this.zzaoz != null) {
            zzbfaVar.zza(7, this.zzaoz);
        }
        if (this.zzapa != null) {
            zzbfaVar.zza(8, this.zzapa);
        }
        if (this.zzapb != null) {
            zzbfaVar.zza(9, this.zzapb);
        }
        if (this.zzapc != null) {
            zzbfaVar.zza(10, this.zzapc);
        }
        if (this.zzapd != null) {
            zzbfaVar.zza(11, this.zzapd);
        }
        if (this.zzape != null) {
            zzbfaVar.zzm(12, this.zzape.intValue());
        }
        if (this.zzapf != null) {
            zzbfaVar.zzm(13, this.zzapf.intValue());
        }
        if (this.zzapg != null) {
            zzbfaVar.zza(14, this.zzapg);
        }
        if (this.zzaph != null) {
            zzbfaVar.zzm(15, this.zzaph.intValue());
        }
        if (this.zzapi != null) {
            zzbfaVar.zzm(16, this.zzapi.intValue());
        }
        if (this.zzapj != null) {
            zzbfaVar.zzm(17, this.zzapj.intValue());
        }
        if (this.zzapk != null) {
            zzbfaVar.zzm(18, this.zzapk.intValue());
        }
        if (this.zzapl != null) {
            zzbfaVar.zzm(19, this.zzapl.intValue());
        }
        if (this.zzapm != null) {
            zzbfaVar.zza(20, this.zzapm.longValue());
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzaox != null) {
            iZzr += zzbfa.zzb(5, this.zzaox);
        }
        if (this.zzaoy != null) {
            iZzr += zzbfa.zzb(6, this.zzaoy);
        }
        if (this.zzaoz != null) {
            iZzr += zzbfa.zzb(7, this.zzaoz);
        }
        if (this.zzapa != null) {
            iZzr += zzbfa.zzb(8, this.zzapa);
        }
        if (this.zzapb != null) {
            iZzr += zzbfa.zzb(9, this.zzapb);
        }
        if (this.zzapc != null) {
            iZzr += zzbfa.zzb(10, this.zzapc);
        }
        if (this.zzapd != null) {
            iZzr += zzbfa.zzb(11, this.zzapd);
        }
        if (this.zzape != null) {
            iZzr += zzbfa.zzq(12, this.zzape.intValue());
        }
        if (this.zzapf != null) {
            iZzr += zzbfa.zzq(13, this.zzapf.intValue());
        }
        if (this.zzapg != null) {
            iZzr += zzbfa.zzb(14, this.zzapg);
        }
        if (this.zzaph != null) {
            iZzr += zzbfa.zzq(15, this.zzaph.intValue());
        }
        if (this.zzapi != null) {
            iZzr += zzbfa.zzq(16, this.zzapi.intValue());
        }
        if (this.zzapj != null) {
            iZzr += zzbfa.zzq(17, this.zzapj.intValue());
        }
        if (this.zzapk != null) {
            iZzr += zzbfa.zzq(18, this.zzapk.intValue());
        }
        if (this.zzapl != null) {
            iZzr += zzbfa.zzq(19, this.zzapl.intValue());
        }
        return this.zzapm != null ? iZzr + zzbfa.zze(20, this.zzapm.longValue()) : iZzr;
    }
}
