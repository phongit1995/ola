package com.google.android.gms.internal.ads;

import android.content.Context;
import android.text.TextUtils;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzxk implements zzww {
    private final Context mContext;
    private final long mStartTime;
    private final boolean zzael;
    private final zzwy zzbtj;
    private final boolean zzbtn;
    private final boolean zzbto;
    private final zzaef zzbuc;
    private final long zzbud;
    private final String zzbuh;
    private zzxb zzbum;
    private final zznx zzvr;
    private final zzxn zzwh;
    private final Object mLock = new Object();
    private boolean zzbuf = false;
    private List<zzxe> zzbui = new ArrayList();

    public zzxk(Context context, zzaef zzaefVar, zzxn zzxnVar, zzwy zzwyVar, boolean z, boolean z2, String str, long j, long j2, zznx zznxVar, boolean z3) {
        this.mContext = context;
        this.zzbuc = zzaefVar;
        this.zzwh = zzxnVar;
        this.zzbtj = zzwyVar;
        this.zzael = z;
        this.zzbtn = z2;
        this.zzbuh = str;
        this.mStartTime = j;
        this.zzbud = j2;
        this.zzvr = zznxVar;
        this.zzbto = z3;
    }

    @Override // com.google.android.gms.internal.ads.zzww
    public final void cancel() {
        synchronized (this.mLock) {
            this.zzbuf = true;
            if (this.zzbum != null) {
                this.zzbum.cancel();
            }
        }
    }

    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:65:? -> B:53:0x017f). Please report as a decompilation issue!!! */
    @Override // com.google.android.gms.internal.ads.zzww
    public final zzxe zzh(List<zzwx> list) throws Throwable {
        Object obj;
        Throwable th;
        zzxe zzxeVar;
        zzakb.zzck("Starting mediation.");
        ArrayList arrayList = new ArrayList();
        zznv zznvVarZzjj = this.zzvr.zzjj();
        zzjn zzjnVar = this.zzbuc.zzacv;
        int[] iArr = new int[2];
        if (zzjnVar.zzard != null) {
            com.google.android.gms.ads.internal.zzbv.zzfd();
            if (zzxg.zza(this.zzbuh, iArr)) {
                int i = iArr[0];
                int i2 = iArr[1];
                zzjn[] zzjnVarArr = zzjnVar.zzard;
                int length = zzjnVarArr.length;
                int i3 = 0;
                while (true) {
                    if (i3 >= length) {
                        break;
                    }
                    zzjn zzjnVar2 = zzjnVarArr[i3];
                    if (i == zzjnVar2.width && i2 == zzjnVar2.height) {
                        zzjnVar = zzjnVar2;
                        break;
                    }
                    i3++;
                }
            }
        }
        Iterator<zzwx> it2 = list.iterator();
        while (it2.hasNext()) {
            zzwx next = it2.next();
            String strValueOf = String.valueOf(next.zzbrs);
            zzakb.zzdj(strValueOf.length() != 0 ? "Trying mediation network: ".concat(strValueOf) : new String("Trying mediation network: "));
            Iterator<String> it3 = next.zzbrt.iterator();
            while (it3.hasNext()) {
                String next2 = it3.next();
                zznv zznvVarZzjj2 = this.zzvr.zzjj();
                Object obj2 = this.mLock;
                synchronized (obj2) {
                    try {
                        if (this.zzbuf) {
                            try {
                                zzxeVar = new zzxe(-1);
                            } catch (Throwable th2) {
                                th = th2;
                                obj = obj2;
                                throw th;
                            }
                        } else {
                            Iterator<zzwx> it4 = it2;
                            Iterator<String> it5 = it3;
                            zznv zznvVar = zznvVarZzjj;
                            ArrayList arrayList2 = arrayList;
                            obj = obj2;
                            try {
                                this.zzbum = new zzxb(this.mContext, next2, this.zzwh, this.zzbtj, next, this.zzbuc.zzccv, zzjnVar, this.zzbuc.zzacr, this.zzael, this.zzbtn, this.zzbuc.zzadj, this.zzbuc.zzads, this.zzbuc.zzcdk, this.zzbuc.zzcef, this.zzbto);
                                zzxe zzxeVarZza = this.zzbum.zza(this.mStartTime, this.zzbud);
                                this.zzbui.add(zzxeVarZza);
                                if (zzxeVarZza.zzbtv == 0) {
                                    zzakb.zzck("Adapter succeeded.");
                                    this.zzvr.zze("mediation_network_succeed", next2);
                                    if (!arrayList2.isEmpty()) {
                                        this.zzvr.zze("mediation_networks_fail", TextUtils.join(",", arrayList2));
                                    }
                                    this.zzvr.zza(zznvVarZzjj2, "mls");
                                    this.zzvr.zza(zznvVar, "ttm");
                                    return zzxeVarZza;
                                }
                                arrayList2.add(next2);
                                this.zzvr.zza(zznvVarZzjj2, "mlf");
                                if (zzxeVarZza.zzbtx != null) {
                                    zzakk.zzcrm.post(new zzxl(this, zzxeVarZza));
                                }
                                arrayList = arrayList2;
                                zznvVarZzjj = zznvVar;
                                it2 = it4;
                                it3 = it5;
                            } catch (Throwable th3) {
                                th = th3;
                                th = th;
                                throw th;
                            }
                        }
                    } catch (Throwable th4) {
                        th = th4;
                        obj = obj2;
                        th = th;
                        throw th;
                    }
                }
                return zzxeVar;
            }
        }
        ArrayList arrayList3 = arrayList;
        if (!arrayList3.isEmpty()) {
            this.zzvr.zze("mediation_networks_fail", TextUtils.join(",", arrayList3));
        }
        return new zzxe(1);
    }

    @Override // com.google.android.gms.internal.ads.zzww
    public final List<zzxe> zzme() {
        return this.zzbui;
    }
}
