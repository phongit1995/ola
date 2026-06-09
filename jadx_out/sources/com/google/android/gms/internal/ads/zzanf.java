package com.google.android.gms.internal.ads;

import android.support.annotation.Nullable;
import android.support.annotation.WorkerThread;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzanf implements zzamx {

    @Nullable
    private final String zzcpq;

    public zzanf() {
        this(null);
    }

    public zzanf(@Nullable String str) {
        this.zzcpq = str;
    }

    @Override // com.google.android.gms.internal.ads.zzamx
    @WorkerThread
    public final void zzcz(String str) {
        String message;
        StringBuilder sb;
        String str2;
        try {
            String strValueOf = String.valueOf(str);
            zzane.zzck(strValueOf.length() != 0 ? "Pinging URL: ".concat(strValueOf) : new String("Pinging URL: "));
            HttpURLConnection httpURLConnection = (HttpURLConnection) new URL(str).openConnection();
            try {
                zzkb.zzif();
                zzamu.zza(true, httpURLConnection, this.zzcpq);
                zzamy zzamyVar = new zzamy();
                zzamyVar.zza(httpURLConnection, (byte[]) null);
                int responseCode = httpURLConnection.getResponseCode();
                zzamyVar.zza(httpURLConnection, responseCode);
                if (responseCode < 200 || responseCode >= 300) {
                    StringBuilder sb2 = new StringBuilder(String.valueOf(str).length() + 65);
                    sb2.append("Received non-success response code ");
                    sb2.append(responseCode);
                    sb2.append(" from pinging URL: ");
                    sb2.append(str);
                    zzane.zzdk(sb2.toString());
                }
            } finally {
                httpURLConnection.disconnect();
            }
        } catch (IOException e) {
            message = e.getMessage();
            sb = new StringBuilder(String.valueOf(str).length() + 27 + String.valueOf(message).length());
            str2 = "Error while pinging URL: ";
            sb.append(str2);
            sb.append(str);
            sb.append(". ");
            sb.append(message);
            zzane.zzdk(sb.toString());
        } catch (IndexOutOfBoundsException e2) {
            message = e2.getMessage();
            sb = new StringBuilder(String.valueOf(str).length() + 32 + String.valueOf(message).length());
            str2 = "Error while parsing ping URL: ";
            sb.append(str2);
            sb.append(str);
            sb.append(". ");
            sb.append(message);
            zzane.zzdk(sb.toString());
        } catch (RuntimeException e3) {
            message = e3.getMessage();
            sb = new StringBuilder(String.valueOf(str).length() + 27 + String.valueOf(message).length());
            str2 = "Error while pinging URL: ";
            sb.append(str2);
            sb.append(str);
            sb.append(". ");
            sb.append(message);
            zzane.zzdk(sb.toString());
        }
    }
}
