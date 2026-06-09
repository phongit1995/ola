package com.google.android.gms.internal.ads;

import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;
import java.util.Iterator;
import java.util.LinkedList;
import javax.annotation.ParametersAreNonnullByDefault;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
final class zzty {
    private final LinkedList<zztz> zzbon;
    private zzjj zzboo;
    private final int zzbop;
    private boolean zzboq;
    private final String zzye;

    zzty(zzjj zzjjVar, String str, int i) {
        Preconditions.checkNotNull(zzjjVar);
        Preconditions.checkNotNull(str);
        this.zzbon = new LinkedList<>();
        this.zzboo = zzjjVar;
        this.zzye = str;
        this.zzbop = i;
    }

    final String getAdUnitId() {
        return this.zzye;
    }

    final int getNetworkType() {
        return this.zzbop;
    }

    final int size() {
        return this.zzbon.size();
    }

    final void zza(zzss zzssVar, zzjj zzjjVar) {
        this.zzbon.add(new zztz(this, zzssVar, zzjjVar));
    }

    final boolean zzb(zzss zzssVar) {
        zztz zztzVar = new zztz(this, zzssVar);
        this.zzbon.add(zztzVar);
        return zztzVar.load();
    }

    final zztz zzl(@Nullable zzjj zzjjVar) {
        if (zzjjVar != null) {
            this.zzboo = zzjjVar;
        }
        return this.zzbon.remove();
    }

    final zzjj zzlf() {
        return this.zzboo;
    }

    final int zzlg() {
        Iterator<zztz> it2 = this.zzbon.iterator();
        int i = 0;
        while (it2.hasNext()) {
            if (it2.next().zzwa) {
                i++;
            }
        }
        return i;
    }

    final int zzlh() {
        Iterator<zztz> it2 = this.zzbon.iterator();
        int i = 0;
        while (it2.hasNext()) {
            if (it2.next().load()) {
                i++;
            }
        }
        return i;
    }

    final void zzli() {
        this.zzboq = true;
    }

    final boolean zzlj() {
        return this.zzboq;
    }
}
