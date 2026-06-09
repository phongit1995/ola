package com.google.android.gms.auth;

import android.accounts.Account;
import android.content.Intent;
import android.os.Bundle;
import android.os.IBinder;
import com.google.android.gms.common.logging.Logger;
import com.google.android.gms.internal.auth.zzbr;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
final class zzh implements zzm<TokenData> {
    private final /* synthetic */ Bundle val$options;
    private final /* synthetic */ Account zzr;
    private final /* synthetic */ String zzs;

    zzh(Account account, String str, Bundle bundle) {
        this.zzr = account;
        this.zzs = str;
        this.val$options = bundle;
    }

    @Override // com.google.android.gms.auth.zzm
    public final /* synthetic */ TokenData zze(IBinder iBinder) throws IOException, GoogleAuthException {
        Bundle bundle = (Bundle) zzg.zzd(com.google.android.gms.internal.auth.zzi.zzd(iBinder).zzd(this.zzr, this.zzs, this.val$options));
        TokenData tokenDataZzd = TokenData.zzd(bundle, "tokenDetails");
        if (tokenDataZzd != null) {
            return tokenDataZzd;
        }
        String string = bundle.getString("Error");
        Intent intent = (Intent) bundle.getParcelable("userRecoveryIntent");
        zzbr zzbrVarZzh = zzbr.zzh(string);
        if (!zzbr.zzd(zzbrVarZzh)) {
            if (zzbr.NETWORK_ERROR.equals(zzbrVarZzh) || zzbr.SERVICE_UNAVAILABLE.equals(zzbrVarZzh)) {
                throw new IOException(string);
            }
            throw new GoogleAuthException(string);
        }
        Logger logger = zzg.zzq;
        String strValueOf = String.valueOf(zzbrVarZzh);
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 31);
        sb.append("isUserRecoverableError status: ");
        sb.append(strValueOf);
        logger.w("GoogleAuthUtil", sb.toString());
        throw new UserRecoverableAuthException(string, intent);
    }
}
