package com.google.firebase.iid;

import android.os.Bundle;

/* JADX INFO: loaded from: classes2.dex */
final class zzad extends zzae<Void> {
    zzad(int i, int i2, Bundle bundle) {
        super(i, 2, bundle);
    }

    @Override // com.google.firebase.iid.zzae
    final void zzb(Bundle bundle) {
        if (bundle.getBoolean("ack", false)) {
            finish(null);
        } else {
            zza(new zzaf(4, "Invalid response to one way request"));
        }
    }

    @Override // com.google.firebase.iid.zzae
    final boolean zzv() {
        return true;
    }
}
