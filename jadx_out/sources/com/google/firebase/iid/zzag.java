package com.google.firebase.iid;

import android.os.Bundle;

/* JADX INFO: loaded from: classes2.dex */
final class zzag extends zzae<Bundle> {
    zzag(int i, int i2, Bundle bundle) {
        super(i, 1, bundle);
    }

    @Override // com.google.firebase.iid.zzae
    final void zzb(Bundle bundle) {
        Bundle bundle2 = bundle.getBundle("data");
        if (bundle2 == null) {
            bundle2 = Bundle.EMPTY;
        }
        finish(bundle2);
    }

    @Override // com.google.firebase.iid.zzae
    final boolean zzv() {
        return false;
    }
}
