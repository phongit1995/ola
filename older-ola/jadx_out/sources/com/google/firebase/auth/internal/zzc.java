package com.google.firebase.auth.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.internal.firebase_auth.zzav;
import com.google.firebase.auth.ActionCodeResult;

/* JADX INFO: loaded from: classes2.dex */
public final class zzc implements ActionCodeResult {
    private final String zzah;
    private final int zzkp;
    private final String zzkq;

    public zzc(@NonNull zzav zzavVar) {
        int i;
        this.zzah = TextUtils.isEmpty(zzavVar.zzba()) ? zzavVar.getEmail() : zzavVar.zzba();
        this.zzkq = zzavVar.getEmail();
        if (TextUtils.isEmpty(zzavVar.zzbb())) {
            this.zzkp = 3;
            return;
        }
        if (zzavVar.zzbb().equals("PASSWORD_RESET")) {
            i = 0;
        } else if (zzavVar.zzbb().equals("VERIFY_EMAIL")) {
            i = 1;
        } else if (zzavVar.zzbb().equals("RECOVER_EMAIL")) {
            i = 2;
        } else {
            if (!zzavVar.zzbb().equals("EMAIL_SIGNIN")) {
                this.zzkp = 3;
                return;
            }
            i = 4;
        }
        this.zzkp = i;
    }

    @Override // com.google.firebase.auth.ActionCodeResult
    @Nullable
    public final String getData(int i) {
        switch (i) {
            case 0:
                if (this.zzkp == 4) {
                    return null;
                }
                return this.zzah;
            case 1:
                return this.zzkq;
            default:
                return null;
        }
    }

    @Override // com.google.firebase.auth.ActionCodeResult
    public final int getOperation() {
        return this.zzkp;
    }
}
