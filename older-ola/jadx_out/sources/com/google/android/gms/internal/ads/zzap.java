package com.google.android.gms.internal.ads;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

/* JADX INFO: loaded from: classes.dex */
public final class zzap {
    public static zzc zzb(zzp zzpVar) {
        long j;
        boolean z;
        long j2;
        boolean z2;
        long j3;
        long j4;
        long jCurrentTimeMillis = System.currentTimeMillis();
        Map<String, String> map = zzpVar.zzab;
        String str = map.get("Date");
        long jZzf = str != null ? zzf(str) : 0L;
        String str2 = map.get("Cache-Control");
        if (str2 != null) {
            j = 0;
            z = false;
            j2 = 0;
            for (String str3 : str2.split(",")) {
                String strTrim = str3.trim();
                if (strTrim.equals("no-cache") || strTrim.equals("no-store")) {
                    return null;
                }
                if (strTrim.startsWith("max-age=")) {
                    try {
                        j = Long.parseLong(strTrim.substring(8));
                    } catch (Exception unused) {
                    }
                } else if (strTrim.startsWith("stale-while-revalidate=")) {
                    j2 = Long.parseLong(strTrim.substring(23));
                } else if (strTrim.equals("must-revalidate") || strTrim.equals("proxy-revalidate")) {
                    z = true;
                }
            }
            z2 = true;
        } else {
            j = 0;
            z = false;
            j2 = 0;
            z2 = false;
        }
        String str4 = map.get("Expires");
        long jZzf2 = str4 != null ? zzf(str4) : 0L;
        String str5 = map.get("Last-Modified");
        long jZzf3 = str5 != null ? zzf(str5) : 0L;
        String str6 = map.get("ETag");
        if (z2) {
            long j5 = jCurrentTimeMillis + (j * 1000);
            j3 = z ? j5 : j5 + (j2 * 1000);
            j4 = j5;
        } else if (jZzf <= 0 || jZzf2 < jZzf) {
            j3 = 0;
            j4 = 0;
        } else {
            j4 = jCurrentTimeMillis + (jZzf2 - jZzf);
            j3 = j4;
        }
        zzc zzcVar = new zzc();
        zzcVar.data = zzpVar.data;
        zzcVar.zza = str6;
        zzcVar.zze = j4;
        zzcVar.zzd = j3;
        zzcVar.zzb = jZzf;
        zzcVar.zzc = jZzf3;
        zzcVar.zzf = map;
        zzcVar.zzg = zzpVar.allHeaders;
        return zzcVar;
    }

    static String zzb(long j) {
        return zzp().format(new Date(j));
    }

    private static long zzf(String str) {
        try {
            return zzp().parse(str).getTime();
        } catch (ParseException e) {
            zzaf.zza(e, "Unable to parse dateStr: %s, falling back to 0", str);
            return 0L;
        }
    }

    private static SimpleDateFormat zzp() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz", Locale.US);
        simpleDateFormat.setTimeZone(TimeZone.getTimeZone("GMT"));
        return simpleDateFormat;
    }
}
