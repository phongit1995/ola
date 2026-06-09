package com.google.firebase.auth.internal;

import android.support.annotation.Nullable;
import com.google.firebase.auth.FirebaseAuthSettings;

/* JADX INFO: loaded from: classes2.dex */
public final class zzk extends FirebaseAuthSettings {
    private String zzbd;
    private String zzez;

    @Nullable
    public final String getPhoneNumber() {
        return this.zzbd;
    }

    @Nullable
    public final String getSmsCode() {
        return this.zzez;
    }

    @Override // com.google.firebase.auth.FirebaseAuthSettings
    public final void setAutoRetrievedSmsCodeForPhoneNumber(@Nullable String str, @Nullable String str2) {
        this.zzbd = str;
        this.zzez = str2;
    }

    public final boolean zzbf() {
        return (this.zzbd == null || this.zzez == null) ? false : true;
    }
}
