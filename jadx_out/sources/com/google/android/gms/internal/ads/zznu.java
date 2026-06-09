package com.google.android.gms.internal.ads;

import android.support.annotation.Nullable;
import android.text.TextUtils;

/* JADX INFO: loaded from: classes.dex */
final class zznu extends zznr {
    zznu() {
    }

    @Nullable
    private static String zzam(@Nullable String str) {
        if (TextUtils.isEmpty(str)) {
            return str;
        }
        int i = 0;
        int length = str.length();
        while (i < str.length() && str.charAt(i) == ',') {
            i++;
        }
        while (length > 0 && str.charAt(length - 1) == ',') {
            length--;
        }
        if (length < i) {
            return null;
        }
        return (i == 0 && length == str.length()) ? str : str.substring(i, length);
    }

    @Override // com.google.android.gms.internal.ads.zznr
    public final String zzd(@Nullable String str, String str2) {
        String strZzam = zzam(str);
        String strZzam2 = zzam(str2);
        if (TextUtils.isEmpty(strZzam)) {
            return strZzam2;
        }
        if (TextUtils.isEmpty(strZzam2)) {
            return strZzam;
        }
        StringBuilder sb = new StringBuilder(String.valueOf(strZzam).length() + 1 + String.valueOf(strZzam2).length());
        sb.append(strZzam);
        sb.append(",");
        sb.append(strZzam2);
        return sb.toString();
    }
}
