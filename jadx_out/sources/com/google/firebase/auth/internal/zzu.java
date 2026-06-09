package com.google.firebase.auth.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.firebase.FirebaseNetworkException;

/* JADX INFO: loaded from: classes2.dex */
final class zzu implements OnFailureListener {
    private final /* synthetic */ zzt zzln;

    zzu(zzt zztVar) {
        this.zzln = zztVar;
    }

    @Override // com.google.android.gms.tasks.OnFailureListener
    public final void onFailure(@NonNull Exception exc) {
        if (exc instanceof FirebaseNetworkException) {
            zzs.zzdx.v("Failure to refresh token; scheduling refresh after failure", new Object[0]);
            this.zzln.zzlm.zzbj();
        }
    }
}
