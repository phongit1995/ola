package com.google.android.gms.internal.ads;

import android.os.Handler;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@zzadh
final class zzst {
    private final List<zzts> zzxo = new ArrayList();

    zzst() {
    }

    final void zza(zztt zzttVar) {
        Handler handler = zzakk.zzcrm;
        Iterator<zzts> it2 = this.zzxo.iterator();
        while (it2.hasNext()) {
            handler.post(new zztr(this, it2.next(), zzttVar));
        }
        this.zzxo.clear();
    }
}
