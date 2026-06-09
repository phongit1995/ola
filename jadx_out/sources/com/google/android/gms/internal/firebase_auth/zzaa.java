package com.google.android.gms.internal.firebase_auth;

import android.net.Uri;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.logging.Logger;
import com.google.firebase.auth.EmailAuthCredential;
import java.util.Set;

/* JADX INFO: loaded from: classes2.dex */
public final class zzaa implements com.google.firebase.auth.api.internal.zzdp<zzj> {
    private static final Logger zzdx = new Logger("EmailLinkSignInRequest", new String[0]);
    private final String zzaf;
    private final String zzah;
    private final String zzdy;

    public zzaa(@NonNull EmailAuthCredential emailAuthCredential, @Nullable String str) {
        this.zzah = Preconditions.checkNotEmpty(emailAuthCredential.getEmail());
        this.zzdy = Preconditions.checkNotEmpty(emailAuthCredential.zzg());
        this.zzaf = str;
    }

    private static String zzi(String str) {
        Uri uri = Uri.parse(str);
        try {
            Set<String> queryParameterNames = uri.getQueryParameterNames();
            if (queryParameterNames.contains("oobCode")) {
                return uri.getQueryParameter("oobCode");
            }
            if (queryParameterNames.contains("link")) {
                return Uri.parse(uri.getQueryParameter("link")).getQueryParameter("oobCode");
            }
            return null;
        } catch (UnsupportedOperationException e) {
            Logger logger = zzdx;
            Object[] objArr = new Object[1];
            String strValueOf = String.valueOf(e.getMessage());
            objArr[0] = strValueOf.length() != 0 ? "No oobCode in signInLink: ".concat(strValueOf) : new String("No oobCode in signInLink: ");
            logger.v("EmailLinkSignInRequest", objArr);
            return null;
        }
    }

    @Override // com.google.firebase.auth.api.internal.zzdp
    public final /* synthetic */ zzgt zzao() {
        zzj zzjVar = new zzj();
        zzjVar.zzah = this.zzah;
        zzjVar.zzag = zzi(this.zzdy);
        zzjVar.zzaf = this.zzaf;
        return zzjVar;
    }
}
