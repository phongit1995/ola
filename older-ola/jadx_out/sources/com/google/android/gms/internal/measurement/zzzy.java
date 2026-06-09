package com.google.android.gms.internal.measurement;

import java.io.IOException;

/* JADX INFO: loaded from: classes2.dex */
public final class zzzy extends IOException {
    private zzaaq zzbva;

    public zzzy(String str) {
        super(str);
        this.zzbva = null;
    }

    static zzzy zzub() {
        return new zzzy("While parsing a protocol message, the input ended unexpectedly in the middle of a field.  This could mean either that the input has been truncated or that an embedded message misreported its own length.");
    }

    static zzzy zzuc() {
        return new zzzy("CodedInputStream encountered an embedded string or message which claimed to have negative size.");
    }
}
