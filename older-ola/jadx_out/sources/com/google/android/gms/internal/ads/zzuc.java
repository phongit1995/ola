package com.google.android.gms.internal.ads;

import android.os.Parcel;
import android.util.Base64;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.common.util.VisibleForTesting;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

/* JADX INFO: loaded from: classes.dex */
@zzadh
final class zzuc {
    final zzjj zzaao;
    final int zzbop;
    final String zzye;

    @VisibleForTesting
    private zzuc(zzjj zzjjVar, String str, int i) {
        this.zzaao = zzjjVar;
        this.zzye = str;
        this.zzbop = i;
    }

    zzuc(zzty zztyVar) {
        this(zztyVar.zzlf(), zztyVar.getAdUnitId(), zztyVar.getNetworkType());
    }

    static zzuc zzba(String str) {
        String[] strArrSplit = str.split("\u0000");
        if (strArrSplit.length != 3) {
            throw new IOException("Incorrect field count for QueueSeed.");
        }
        Parcel parcelObtain = Parcel.obtain();
        try {
            try {
                String str2 = new String(Base64.decode(strArrSplit[0], 0), "UTF-8");
                int i = Integer.parseInt(strArrSplit[1]);
                byte[] bArrDecode = Base64.decode(strArrSplit[2], 0);
                parcelObtain.unmarshall(bArrDecode, 0, bArrDecode.length);
                parcelObtain.setDataPosition(0);
                return new zzuc(zzjj.CREATOR.createFromParcel(parcelObtain), str2, i);
            } catch (SafeParcelReader.ParseException | IllegalArgumentException | IllegalStateException e) {
                com.google.android.gms.ads.internal.zzbv.zzeo().zza(e, "QueueSeed.decode");
                throw new IOException("Malformed QueueSeed encoding.", e);
            }
        } finally {
            parcelObtain.recycle();
        }
    }

    final String zzlu() {
        Parcel parcelObtain = Parcel.obtain();
        try {
            try {
                String strEncodeToString = Base64.encodeToString(this.zzye.getBytes("UTF-8"), 0);
                String string = Integer.toString(this.zzbop);
                this.zzaao.writeToParcel(parcelObtain, 0);
                String strEncodeToString2 = Base64.encodeToString(parcelObtain.marshall(), 0);
                StringBuilder sb = new StringBuilder(String.valueOf(strEncodeToString).length() + 2 + String.valueOf(string).length() + String.valueOf(strEncodeToString2).length());
                sb.append(strEncodeToString);
                sb.append("\u0000");
                sb.append(string);
                sb.append("\u0000");
                sb.append(strEncodeToString2);
                return sb.toString();
            } catch (UnsupportedEncodingException unused) {
                zzakb.e("QueueSeed encode failed because UTF-8 is not available.");
                parcelObtain.recycle();
                return "";
            }
        } finally {
            parcelObtain.recycle();
        }
    }
}
