package com.google.android.gms.auth;

import android.os.Bundle;
import android.os.IBinder;

/* JADX INFO: loaded from: classes.dex */
final class zzi implements zzm<Void> {
    private final /* synthetic */ Bundle val$extras;
    private final /* synthetic */ String zzt;

    zzi(String str, Bundle bundle) {
        this.zzt = str;
        this.val$extras = bundle;
    }

    @Override // com.google.android.gms.auth.zzm
    public final /* synthetic */ Void zze(IBinder iBinder) throws GoogleAuthException {
        Bundle bundle = (Bundle) zzg.zzd(com.google.android.gms.internal.auth.zzi.zzd(iBinder).zzd(this.zzt, this.val$extras));
        String string = bundle.getString("Error");
        if (bundle.getBoolean("booleanResult")) {
            return null;
        }
        throw new GoogleAuthException(string);
    }
}
