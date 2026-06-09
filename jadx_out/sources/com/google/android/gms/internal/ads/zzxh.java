package com.google.android.gms.internal.ads;

import android.content.Context;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzxh implements zzww {
    private final Context mContext;
    private final long mStartTime;
    private final boolean zzael;
    private final zzwy zzbtj;
    private final boolean zzbtn;
    private final boolean zzbto;
    private final zzaef zzbuc;
    private final long zzbud;
    private final String zzbuh;
    private final zzxn zzwh;
    private final Object mLock = new Object();
    private boolean zzbuf = false;
    private final Map<zzanz<zzxe>, zzxb> zzbug = new HashMap();
    private List<zzxe> zzbui = new ArrayList();
    private final int zzbue = 2;

    public zzxh(Context context, zzaef zzaefVar, zzxn zzxnVar, zzwy zzwyVar, boolean z, boolean z2, String str, long j, long j2, int i, boolean z3) {
        this.mContext = context;
        this.zzbuc = zzaefVar;
        this.zzwh = zzxnVar;
        this.zzbtj = zzwyVar;
        this.zzael = z;
        this.zzbtn = z2;
        this.zzbuh = str;
        this.mStartTime = j;
        this.zzbud = j2;
        this.zzbto = z3;
    }

    private final void zza(zzanz<zzxe> zzanzVar) {
        zzakk.zzcrm.post(new zzxj(this, zzanzVar));
    }

    private final zzxe zzi(List<zzanz<zzxe>> list) {
        synchronized (this.mLock) {
            if (this.zzbuf) {
                return new zzxe(-1);
            }
            for (zzanz<zzxe> zzanzVar : list) {
                try {
                    zzxe zzxeVar = zzanzVar.get();
                    this.zzbui.add(zzxeVar);
                    if (zzxeVar != null && zzxeVar.zzbtv == 0) {
                        zza(zzanzVar);
                        return zzxeVar;
                    }
                } catch (InterruptedException | ExecutionException e) {
                    zzakb.zzc("Exception while processing an adapter; continuing with other adapters", e);
                }
            }
            zza((zzanz<zzxe>) null);
            return new zzxe(1);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:27:0x0054 A[Catch: all -> 0x0050, RemoteException | InterruptedException | ExecutionException | TimeoutException -> 0x0052, TryCatch #1 {RemoteException | InterruptedException | ExecutionException | TimeoutException -> 0x0052, blocks: (B:19:0x0043, B:21:0x0049, B:22:0x004d, B:28:0x005b, B:30:0x0062, B:32:0x0066, B:34:0x006a, B:36:0x0070, B:27:0x0054), top: B:50:0x0043, outer: #0 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final com.google.android.gms.internal.ads.zzxe zzj(java.util.List<com.google.android.gms.internal.ads.zzanz<com.google.android.gms.internal.ads.zzxe>> r15) {
        /*
            r14 = this;
            java.lang.Object r0 = r14.mLock
            monitor-enter(r0)
            boolean r1 = r14.zzbuf     // Catch: java.lang.Throwable -> Lab
            r2 = -1
            if (r1 == 0) goto Lf
            com.google.android.gms.internal.ads.zzxe r15 = new com.google.android.gms.internal.ads.zzxe     // Catch: java.lang.Throwable -> Lab
            r15.<init>(r2)     // Catch: java.lang.Throwable -> Lab
            monitor-exit(r0)     // Catch: java.lang.Throwable -> Lab
            return r15
        Lf:
            monitor-exit(r0)     // Catch: java.lang.Throwable -> Lab
            com.google.android.gms.internal.ads.zzwy r0 = r14.zzbtj
            long r0 = r0.zzbsy
            r3 = -1
            int r5 = (r0 > r3 ? 1 : (r0 == r3 ? 0 : -1))
            if (r5 == 0) goto L1f
            com.google.android.gms.internal.ads.zzwy r0 = r14.zzbtj
            long r0 = r0.zzbsy
            goto L21
        L1f:
            r0 = 10000(0x2710, double:4.9407E-320)
        L21:
            java.util.Iterator r15 = r15.iterator()
            r3 = 0
            r1 = r0
            r0 = r3
            r4 = -1
        L29:
            boolean r5 = r15.hasNext()
            if (r5 == 0) goto L9e
            java.lang.Object r5 = r15.next()
            com.google.android.gms.internal.ads.zzanz r5 = (com.google.android.gms.internal.ads.zzanz) r5
            com.google.android.gms.common.util.Clock r6 = com.google.android.gms.ads.internal.zzbv.zzer()
            long r6 = r6.currentTimeMillis()
            r8 = 0
            int r10 = (r1 > r8 ? 1 : (r1 == r8 ? 0 : -1))
            if (r10 != 0) goto L54
            boolean r10 = r5.isDone()     // Catch: java.lang.Throwable -> L50 java.lang.Throwable -> L52
            if (r10 == 0) goto L54
            java.lang.Object r10 = r5.get()     // Catch: java.lang.Throwable -> L50 java.lang.Throwable -> L52
        L4d:
            com.google.android.gms.internal.ads.zzxe r10 = (com.google.android.gms.internal.ads.zzxe) r10     // Catch: java.lang.Throwable -> L50 java.lang.Throwable -> L52
            goto L5b
        L50:
            r15 = move-exception
            goto L8e
        L52:
            r5 = move-exception
            goto L78
        L54:
            java.util.concurrent.TimeUnit r10 = java.util.concurrent.TimeUnit.MILLISECONDS     // Catch: java.lang.Throwable -> L50 java.lang.Throwable -> L52
            java.lang.Object r10 = r5.get(r1, r10)     // Catch: java.lang.Throwable -> L50 java.lang.Throwable -> L52
            goto L4d
        L5b:
            java.util.List<com.google.android.gms.internal.ads.zzxe> r11 = r14.zzbui     // Catch: java.lang.Throwable -> L50 java.lang.Throwable -> L52
            r11.add(r10)     // Catch: java.lang.Throwable -> L50 java.lang.Throwable -> L52
            if (r10 == 0) goto L7d
            int r11 = r10.zzbtv     // Catch: java.lang.Throwable -> L50 java.lang.Throwable -> L52
            if (r11 != 0) goto L7d
            com.google.android.gms.internal.ads.zzxw r11 = r10.zzbua     // Catch: java.lang.Throwable -> L50 java.lang.Throwable -> L52
            if (r11 == 0) goto L7d
            int r12 = r11.zzmm()     // Catch: java.lang.Throwable -> L50 java.lang.Throwable -> L52
            if (r12 <= r4) goto L7d
            int r11 = r11.zzmm()     // Catch: java.lang.Throwable -> L50 java.lang.Throwable -> L52
            r3 = r5
            r0 = r10
            r4 = r11
            goto L7d
        L78:
            java.lang.String r10 = "Exception while processing an adapter; continuing with other adapters"
            com.google.android.gms.internal.ads.zzakb.zzc(r10, r5)     // Catch: java.lang.Throwable -> L50
        L7d:
            com.google.android.gms.common.util.Clock r5 = com.google.android.gms.ads.internal.zzbv.zzer()
            long r10 = r5.currentTimeMillis()
            long r12 = r10 - r6
            long r5 = r1 - r12
            long r1 = java.lang.Math.max(r5, r8)
            goto L29
        L8e:
            com.google.android.gms.common.util.Clock r0 = com.google.android.gms.ads.internal.zzbv.zzer()
            long r3 = r0.currentTimeMillis()
            long r10 = r3 - r6
            long r3 = r1 - r10
            java.lang.Math.max(r3, r8)
            throw r15
        L9e:
            r14.zza(r3)
            if (r0 != 0) goto Laa
            com.google.android.gms.internal.ads.zzxe r15 = new com.google.android.gms.internal.ads.zzxe
            r0 = 1
            r15.<init>(r0)
            return r15
        Laa:
            return r0
        Lab:
            r15 = move-exception
            monitor-exit(r0)     // Catch: java.lang.Throwable -> Lab
            throw r15
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzxh.zzj(java.util.List):com.google.android.gms.internal.ads.zzxe");
    }

    @Override // com.google.android.gms.internal.ads.zzww
    public final void cancel() {
        synchronized (this.mLock) {
            this.zzbuf = true;
            Iterator<zzxb> it2 = this.zzbug.values().iterator();
            while (it2.hasNext()) {
                it2.next().cancel();
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzww
    public final zzxe zzh(List<zzwx> list) {
        zzakb.zzck("Starting mediation.");
        ArrayList arrayList = new ArrayList();
        zzjn zzjnVar = this.zzbuc.zzacv;
        int[] iArr = new int[2];
        if (zzjnVar.zzard != null) {
            com.google.android.gms.ads.internal.zzbv.zzfd();
            if (zzxg.zza(this.zzbuh, iArr)) {
                int i = 0;
                int i2 = iArr[0];
                int i3 = iArr[1];
                zzjn[] zzjnVarArr = zzjnVar.zzard;
                int length = zzjnVarArr.length;
                while (true) {
                    if (i >= length) {
                        break;
                    }
                    zzjn zzjnVar2 = zzjnVarArr[i];
                    if (i2 == zzjnVar2.width && i3 == zzjnVar2.height) {
                        zzjnVar = zzjnVar2;
                        break;
                    }
                    i++;
                }
            }
        }
        Iterator<zzwx> it2 = list.iterator();
        while (it2.hasNext()) {
            zzwx next = it2.next();
            String strValueOf = String.valueOf(next.zzbrs);
            zzakb.zzdj(strValueOf.length() != 0 ? "Trying mediation network: ".concat(strValueOf) : new String("Trying mediation network: "));
            for (Iterator<String> it3 = next.zzbrt.iterator(); it3.hasNext(); it3 = it3) {
                ArrayList arrayList2 = arrayList;
                zzxb zzxbVar = new zzxb(this.mContext, it3.next(), this.zzwh, this.zzbtj, next, this.zzbuc.zzccv, zzjnVar, this.zzbuc.zzacr, this.zzael, this.zzbtn, this.zzbuc.zzadj, this.zzbuc.zzads, this.zzbuc.zzcdk, this.zzbuc.zzcef, this.zzbto);
                zzanz<zzxe> zzanzVarZza = zzaki.zza(new zzxi(this, zzxbVar));
                this.zzbug.put(zzanzVarZza, zzxbVar);
                arrayList2.add(zzanzVarZza);
                arrayList = arrayList2;
                it2 = it2;
            }
        }
        ArrayList arrayList3 = arrayList;
        return this.zzbue != 2 ? zzi(arrayList3) : zzj(arrayList3);
    }

    @Override // com.google.android.gms.internal.ads.zzww
    public final List<zzxe> zzme() {
        return this.zzbui;
    }
}
