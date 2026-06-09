package com.google.android.gms.internal.ads;

import android.content.Context;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.internal.ads.zzhu;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzadk extends zzajx implements zzadx {
    private final Context mContext;

    @VisibleForTesting
    private zzwy zzbtj;

    @VisibleForTesting
    private zzaef zzbuc;

    @VisibleForTesting
    private zzaej zzbzf;
    private Runnable zzbzg;
    private final Object zzbzh = new Object();
    private final zzadj zzccf;
    private final zzaeg zzccg;
    private final zzhs zzcch;
    private final zzhx zzcci;

    @VisibleForTesting
    @GuardedBy("mCancelLock")
    zzalc zzccj;

    public zzadk(Context context, zzaeg zzaegVar, zzadj zzadjVar, zzhx zzhxVar) {
        zzhs zzhsVar;
        zzht zzhtVar;
        this.zzccf = zzadjVar;
        this.mContext = context;
        this.zzccg = zzaegVar;
        this.zzcci = zzhxVar;
        this.zzcch = new zzhs(this.zzcci);
        this.zzcch.zza(new zzht(this) { // from class: com.google.android.gms.internal.ads.zzadl
            private final zzadk zzcck;

            {
                this.zzcck = this;
            }

            @Override // com.google.android.gms.internal.ads.zzht
            public final void zza(zzii zziiVar) {
                this.zzcck.zzc(zziiVar);
            }
        });
        final zzit zzitVar = new zzit();
        zzitVar.zzaot = Integer.valueOf(this.zzccg.zzacr.zzcve);
        zzitVar.zzaou = Integer.valueOf(this.zzccg.zzacr.zzcvf);
        zzitVar.zzaov = Integer.valueOf(this.zzccg.zzacr.zzcvg ? 0 : 2);
        this.zzcch.zza(new zzht(zzitVar) { // from class: com.google.android.gms.internal.ads.zzadm
            private final zzit zzccl;

            {
                this.zzccl = zzitVar;
            }

            @Override // com.google.android.gms.internal.ads.zzht
            public final void zza(zzii zziiVar) {
                zziiVar.zzanm.zzamx = this.zzccl;
            }
        });
        if (this.zzccg.zzccw != null) {
            this.zzcch.zza(new zzht(this) { // from class: com.google.android.gms.internal.ads.zzadn
                private final zzadk zzcck;

                {
                    this.zzcck = this;
                }

                @Override // com.google.android.gms.internal.ads.zzht
                public final void zza(zzii zziiVar) {
                    this.zzcck.zzb(zziiVar);
                }
            });
        }
        zzjn zzjnVar = this.zzccg.zzacv;
        if (zzjnVar.zzarc && "interstitial_mb".equals(zzjnVar.zzarb)) {
            zzhsVar = this.zzcch;
            zzhtVar = zzado.zzccm;
        } else if (zzjnVar.zzarc && "reward_mb".equals(zzjnVar.zzarb)) {
            zzhsVar = this.zzcch;
            zzhtVar = zzadp.zzccm;
        } else if (zzjnVar.zzare || zzjnVar.zzarc) {
            zzhsVar = this.zzcch;
            zzhtVar = zzadr.zzccm;
        } else {
            zzhsVar = this.zzcch;
            zzhtVar = zzadq.zzccm;
        }
        zzhsVar.zza(zzhtVar);
        this.zzcch.zza(zzhu.zza.zzb.AD_REQUEST);
    }

    @VisibleForTesting
    private final zzjn zza(zzaef zzaefVar) throws zzadu {
        if (((this.zzbuc == null || this.zzbuc.zzadn == null || this.zzbuc.zzadn.size() <= 1) ? false : true) && this.zzbtj != null && !this.zzbtj.zzbte) {
            return null;
        }
        if (this.zzbzf.zzarf) {
            for (zzjn zzjnVar : zzaefVar.zzacv.zzard) {
                if (zzjnVar.zzarf) {
                    return new zzjn(zzjnVar, zzaefVar.zzacv.zzard);
                }
            }
        }
        if (this.zzbzf.zzcet == null) {
            throw new zzadu("The ad response must specify one of the supported ad sizes.", 0);
        }
        String[] strArrSplit = this.zzbzf.zzcet.split("x");
        if (strArrSplit.length != 2) {
            String strValueOf = String.valueOf(this.zzbzf.zzcet);
            throw new zzadu(strValueOf.length() != 0 ? "Invalid ad size format from the ad response: ".concat(strValueOf) : new String("Invalid ad size format from the ad response: "), 0);
        }
        try {
            int i = Integer.parseInt(strArrSplit[0]);
            int i2 = Integer.parseInt(strArrSplit[1]);
            for (zzjn zzjnVar2 : zzaefVar.zzacv.zzard) {
                float f = this.mContext.getResources().getDisplayMetrics().density;
                int i3 = zzjnVar2.width == -1 ? (int) (zzjnVar2.widthPixels / f) : zzjnVar2.width;
                int i4 = zzjnVar2.height == -2 ? (int) (zzjnVar2.heightPixels / f) : zzjnVar2.height;
                if (i == i3 && i2 == i4 && !zzjnVar2.zzarf) {
                    return new zzjn(zzjnVar2, zzaefVar.zzacv.zzard);
                }
            }
            String strValueOf2 = String.valueOf(this.zzbzf.zzcet);
            throw new zzadu(strValueOf2.length() != 0 ? "The ad size from the ad response was not one of the requested sizes: ".concat(strValueOf2) : new String("The ad size from the ad response was not one of the requested sizes: "), 0);
        } catch (NumberFormatException unused) {
            String strValueOf3 = String.valueOf(this.zzbzf.zzcet);
            throw new zzadu(strValueOf3.length() != 0 ? "Invalid ad size number from the ad response: ".concat(strValueOf3) : new String("Invalid ad size number from the ad response: "), 0);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzc(int i, String str) {
        if (i == 3 || i == -1) {
            zzakb.zzdj(str);
        } else {
            zzakb.zzdk(str);
        }
        this.zzbzf = this.zzbzf == null ? new zzaej(i) : new zzaej(i, this.zzbzf.zzbsu);
        this.zzccf.zza(new zzaji(this.zzbuc != null ? this.zzbuc : new zzaef(this.zzccg, -1L, null, null, null), this.zzbzf, this.zzbtj, null, i, -1L, this.zzbzf.zzceu, null, this.zzcch, null));
    }

    @Override // com.google.android.gms.internal.ads.zzajx
    public final void onStop() {
        synchronized (this.zzbzh) {
            if (this.zzccj != null) {
                this.zzccj.cancel();
            }
        }
    }

    @VisibleForTesting
    final zzalc zza(zzang zzangVar, zzaol<zzaef> zzaolVar) {
        Context context = this.mContext;
        if (new zzadw(context).zza(zzangVar)) {
            zzakb.zzck("Fetching ad response from local ad request service.");
            zzaec zzaecVar = new zzaec(context, zzaolVar, this);
            zzaecVar.zznt();
            return zzaecVar;
        }
        zzakb.zzck("Fetching ad response from remote ad request service.");
        zzkb.zzif();
        if (zzamu.zzbe(context)) {
            return new zzaed(context, zzangVar, zzaolVar, this);
        }
        zzakb.zzdk("Failed to connect to remote ad request service.");
        return null;
    }

    /* JADX WARN: Removed duplicated region for block: B:58:0x018c  */
    /* JADX WARN: Removed duplicated region for block: B:69:0x01d1  */
    /* JADX WARN: Removed duplicated region for block: B:72:0x01db  */
    /* JADX WARN: Removed duplicated region for block: B:73:0x01e9  */
    @Override // com.google.android.gms.internal.ads.zzadx
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zza(@android.support.annotation.NonNull com.google.android.gms.internal.ads.zzaej r14) {
        /*
            Method dump skipped, instruction units count: 538
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzadk.zza(com.google.android.gms.internal.ads.zzaej):void");
    }

    final /* synthetic */ void zzb(zzii zziiVar) {
        zziiVar.zzanm.zzamu = this.zzccg.zzccw.packageName;
    }

    final /* synthetic */ void zzc(zzii zziiVar) {
        zziiVar.zzanh = this.zzccg.zzcdi;
    }

    @Override // com.google.android.gms.internal.ads.zzajx
    public final void zzdn() {
        String string;
        zzakb.zzck("AdLoaderBackgroundTask started.");
        this.zzbzg = new zzads(this);
        zzakk.zzcrm.postDelayed(this.zzbzg, ((Long) zzkb.zzik().zzd(zznk.zzban)).longValue());
        long jElapsedRealtime = com.google.android.gms.ads.internal.zzbv.zzer().elapsedRealtime();
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbak)).booleanValue() && this.zzccg.zzccv.extras != null && (string = this.zzccg.zzccv.extras.getString("_ad")) != null) {
            this.zzbuc = new zzaef(this.zzccg, jElapsedRealtime, null, null, null);
            zza(zzafs.zza(this.mContext, this.zzbuc, string));
            return;
        }
        zzaop zzaopVar = new zzaop();
        zzaki.zzb(new zzadt(this, zzaopVar));
        String strZzz = com.google.android.gms.ads.internal.zzbv.zzfh().zzz(this.mContext);
        String strZzaa = com.google.android.gms.ads.internal.zzbv.zzfh().zzaa(this.mContext);
        String strZzab = com.google.android.gms.ads.internal.zzbv.zzfh().zzab(this.mContext);
        com.google.android.gms.ads.internal.zzbv.zzfh().zzg(this.mContext, strZzab);
        this.zzbuc = new zzaef(this.zzccg, jElapsedRealtime, strZzz, strZzaa, strZzab);
        zzaopVar.zzk(this.zzbuc);
    }
}
