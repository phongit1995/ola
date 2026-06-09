package com.google.android.gms.internal.measurement;

import java.io.PrintStream;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
final class zzxm extends zzxj {
    private final zzxk zzbqg = new zzxk();

    zzxm() {
    }

    @Override // com.google.android.gms.internal.measurement.zzxj
    public final void zza(Throwable th, PrintStream printStream) {
        th.printStackTrace(printStream);
        List<Throwable> listZza = this.zzbqg.zza(th, false);
        if (listZza == null) {
            return;
        }
        synchronized (listZza) {
            for (Throwable th2 : listZza) {
                printStream.print("Suppressed: ");
                th2.printStackTrace(printStream);
            }
        }
    }
}
