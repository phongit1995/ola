package com.google.android.gms.internal.measurement;

import android.os.RemoteException;
import android.text.TextUtils;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
final class zziu implements Runnable {
    private final /* synthetic */ String zzadn;
    private final /* synthetic */ String zzadu;
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ String zzapg;
    private final /* synthetic */ zzik zzaqv;
    private final /* synthetic */ AtomicReference zzaqw;

    zziu(zzik zzikVar, AtomicReference atomicReference, String str, String str2, String str3, zzeb zzebVar) {
        this.zzaqv = zzikVar;
        this.zzaqw = atomicReference;
        this.zzapg = str;
        this.zzadn = str2;
        this.zzadu = str3;
        this.zzapd = zzebVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        AtomicReference atomicReference;
        zzfa zzfaVar;
        AtomicReference atomicReference2;
        List<zzef> listZze;
        synchronized (this.zzaqw) {
            try {
                try {
                    zzfaVar = this.zzaqv.zzaqp;
                } catch (RemoteException e) {
                    this.zzaqv.zzgi().zziv().zzd("Failed to get conditional properties", zzfi.zzbp(this.zzapg), this.zzadn, e);
                    this.zzaqw.set(Collections.emptyList());
                    atomicReference = this.zzaqw;
                }
                if (zzfaVar == null) {
                    this.zzaqv.zzgi().zziv().zzd("Failed to get conditional properties", zzfi.zzbp(this.zzapg), this.zzadn, this.zzadu);
                    this.zzaqw.set(Collections.emptyList());
                    return;
                }
                if (TextUtils.isEmpty(this.zzapg)) {
                    atomicReference2 = this.zzaqw;
                    listZze = zzfaVar.zza(this.zzadn, this.zzadu, this.zzapd);
                } else {
                    atomicReference2 = this.zzaqw;
                    listZze = zzfaVar.zze(this.zzapg, this.zzadn, this.zzadu);
                }
                atomicReference2.set(listZze);
                this.zzaqv.zzcu();
                atomicReference = this.zzaqw;
                atomicReference.notify();
            } finally {
                this.zzaqw.notify();
            }
        }
    }
}
