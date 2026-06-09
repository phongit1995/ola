package com.google.android.gms.internal.ads;

import android.content.Context;
import android.location.Location;
import android.net.ConnectivityManager;
import android.os.Bundle;
import android.text.TextUtils;
import com.google.android.gms.ads.identifier.AdvertisingIdClient;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.annotation.concurrent.GuardedBy;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzafn extends zzaeo {
    private static final Object sLock = new Object();

    @GuardedBy("sLock")
    private static zzafn zzchh;
    private final Context mContext;
    private final zzafm zzchi;
    private final ScheduledExecutorService zzchj = Executors.newSingleThreadScheduledExecutor();

    private zzafn(Context context, zzafm zzafmVar) {
        this.mContext = context;
        this.zzchi = zzafmVar;
    }

    private static zzaej zza(Context context, zzafm zzafmVar, zzaef zzaefVar, ScheduledExecutorService scheduledExecutorService) {
        char c;
        String string;
        zzakb.zzck("Starting ad request from service using: google.afma.request.getAdDictionary");
        zznx zznxVar = new zznx(((Boolean) zzkb.zzik().zzd(zznk.zzawh)).booleanValue(), "load_ad", zzaefVar.zzacv.zzarb);
        if (zzaefVar.versionCode > 10 && zzaefVar.zzcdl != -1) {
            zznxVar.zza(zznxVar.zzd(zzaefVar.zzcdl), "cts");
        }
        zznv zznvVarZzjj = zznxVar.zzjj();
        zzanz zzanzVarZza = zzano.zza(zzafmVar.zzche.zzk(context), ((Long) zzkb.zzik().zzd(zznk.zzbdf)).longValue(), TimeUnit.MILLISECONDS, scheduledExecutorService);
        zzanz zzanzVarZza2 = zzano.zza(zzafmVar.zzchd.zzr(context), ((Long) zzkb.zzik().zzd(zznk.zzbah)).longValue(), TimeUnit.MILLISECONDS, scheduledExecutorService);
        zzanz<String> zzanzVarZzcl = zzafmVar.zzcgy.zzcl(zzaefVar.zzccw.packageName);
        zzanz<String> zzanzVarZzcm = zzafmVar.zzcgy.zzcm(zzaefVar.zzccw.packageName);
        zzanz<String> zzanzVarZza3 = zzafmVar.zzchf.zza(zzaefVar.zzccx, zzaefVar.zzccw);
        Future<zzaga> futureZzq = com.google.android.gms.ads.internal.zzbv.zzev().zzq(context);
        zzanz<Location> zzanzVarZzi = zzano.zzi(null);
        Bundle bundle = zzaefVar.zzccv.extras;
        boolean z = (bundle == null || bundle.getString("_ad") == null) ? false : true;
        if (zzaefVar.zzcdr && !z) {
            zzanzVarZzi = zzafmVar.zzchb.zza(zzaefVar.applicationInfo);
        }
        zzanz zzanzVarZza4 = zzano.zza(zzanzVarZzi, ((Long) zzkb.zzik().zzd(zznk.zzbco)).longValue(), TimeUnit.MILLISECONDS, scheduledExecutorService);
        Future futureZzi = zzano.zzi(null);
        if (((Boolean) zzkb.zzik().zzd(zznk.zzayj)).booleanValue()) {
            futureZzi = zzano.zza(zzafmVar.zzchf.zzae(context), ((Long) zzkb.zzik().zzd(zznk.zzayk)).longValue(), TimeUnit.MILLISECONDS, scheduledExecutorService);
        }
        Bundle bundle2 = (zzaefVar.versionCode < 4 || zzaefVar.zzcdc == null) ? null : zzaefVar.zzcdc;
        ((Boolean) zzkb.zzik().zzd(zznk.zzawx)).booleanValue();
        com.google.android.gms.ads.internal.zzbv.zzek();
        if (zzakk.zzl(context, "android.permission.ACCESS_NETWORK_STATE") && ((ConnectivityManager) context.getSystemService("connectivity")).getActiveNetworkInfo() == null) {
            zzakb.zzck("Device is offline.");
        }
        String string2 = zzaefVar.versionCode >= 7 ? zzaefVar.zzcdi : UUID.randomUUID().toString();
        new zzaft(context, string2, zzaefVar.applicationInfo.packageName);
        if (zzaefVar.zzccv.extras != null && (string = zzaefVar.zzccv.extras.getString("_ad")) != null) {
            return zzafs.zza(context, zzaefVar, string);
        }
        List<String> listZzf = zzafmVar.zzcgz.zzf(zzaefVar.zzcdj);
        String str = string2;
        Bundle bundle3 = (Bundle) zzano.zza(zzanzVarZza, (Object) null, ((Long) zzkb.zzik().zzd(zznk.zzbdf)).longValue(), TimeUnit.MILLISECONDS);
        zzagk zzagkVar = (zzagk) zzano.zza(zzanzVarZza2, (Object) null);
        Location location = (Location) zzano.zza(zzanzVarZza4, (Object) null);
        AdvertisingIdClient.Info info = (AdvertisingIdClient.Info) zzano.zza((Future<Object>) futureZzi, (Object) null);
        String str2 = (String) zzano.zza(zzanzVarZza3, (Object) null);
        String str3 = (String) zzano.zza(zzanzVarZzcl, (Object) null);
        String str4 = (String) zzano.zza(zzanzVarZzcm, (Object) null);
        zzaga zzagaVar = (zzaga) zzano.zza(futureZzq, (Object) null);
        if (zzagaVar == null) {
            zzakb.zzdk("Error fetching device info. This is not recoverable.");
            return new zzaej(0);
        }
        zzafl zzaflVar = new zzafl();
        zzaflVar.zzcgs = zzaefVar;
        zzaflVar.zzcgt = zzagaVar;
        zzaflVar.zzcgo = zzagkVar;
        zzaflVar.zzaqe = location;
        zzaflVar.zzcgn = bundle3;
        zzaflVar.zzccx = str2;
        zzaflVar.zzcgr = info;
        if (listZzf == null) {
            zzaflVar.zzcdj.clear();
        }
        zzaflVar.zzcdj = listZzf;
        zzaflVar.zzcdc = bundle2;
        zzaflVar.zzcgp = str3;
        zzaflVar.zzcgq = str4;
        zzaflVar.zzcgu = zzafmVar.zzcgx.zze(context);
        zzaflVar.zzcgv = zzafmVar.zzcgv;
        JSONObject jSONObjectZza = zzafs.zza(context, zzaflVar);
        if (jSONObjectZza == null) {
            return new zzaej(0);
        }
        if (zzaefVar.versionCode < 7) {
            try {
                jSONObjectZza.put("request_id", str);
            } catch (JSONException unused) {
            }
        }
        zznxVar.zza(zznvVarZzjj, "arc");
        zznxVar.zzjj();
        zzanz zzanzVarZza5 = zzano.zza(zzano.zza(zzafmVar.zzchg.zzof().zzf(jSONObjectZza), zzafo.zzxn, scheduledExecutorService), 10L, TimeUnit.SECONDS, scheduledExecutorService);
        zzanz<Void> zzanzVarZzop = zzafmVar.zzcha.zzop();
        if (zzanzVarZzop != null) {
            zzanm.zza(zzanzVarZzop, "AdRequestServiceImpl.loadAd.flags");
        }
        zzafz zzafzVar = (zzafz) zzano.zza(zzanzVarZza5, (Object) null);
        if (zzafzVar == null) {
            return new zzaej(0);
        }
        if (zzafzVar.getErrorCode() != -2) {
            return new zzaej(zzafzVar.getErrorCode());
        }
        zznxVar.zzjm();
        zzaej zzaejVarZza = !TextUtils.isEmpty(zzafzVar.zzom()) ? zzafs.zza(context, zzaefVar, zzafzVar.zzom()) : null;
        if (zzaejVarZza == null && !TextUtils.isEmpty(zzafzVar.getUrl())) {
            zzaejVarZza = zza(zzaefVar, context, zzaefVar.zzacr.zzcw, zzafzVar.getUrl(), str3, str4, zzafzVar, zznxVar, zzafmVar);
        }
        if (zzaejVarZza == null) {
            c = 0;
            zzaejVarZza = new zzaej(0);
        } else {
            c = 0;
        }
        String[] strArr = new String[1];
        strArr[c] = "tts";
        zznxVar.zza(zznvVarZzjj, strArr);
        zzaejVarZza.zzcfd = zznxVar.zzjk();
        return zzaejVarZza;
    }

    /* JADX WARN: Removed duplicated region for block: B:27:0x008a A[Catch: all -> 0x01cb, TryCatch #5 {all -> 0x01cb, blocks: (B:14:0x004f, B:16:0x0060, B:18:0x0066, B:20:0x0070, B:22:0x0076, B:25:0x0082, B:27:0x008a, B:29:0x0096, B:31:0x00a0, B:34:0x00bc, B:42:0x00cb, B:45:0x00e8, B:48:0x00fc, B:50:0x010a, B:51:0x0115, B:60:0x012e, B:61:0x0131, B:62:0x0132, B:66:0x0140, B:68:0x014c, B:73:0x0162, B:75:0x017b, B:80:0x0191, B:86:0x01a6, B:39:0x00c6, B:40:0x00c9), top: B:112:0x004f, outer: #2 }] */
    /* JADX WARN: Removed duplicated region for block: B:41:0x00ca  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static com.google.android.gms.internal.ads.zzaej zza(com.google.android.gms.internal.ads.zzaef r18, android.content.Context r19, java.lang.String r20, java.lang.String r21, java.lang.String r22, java.lang.String r23, com.google.android.gms.internal.ads.zzafz r24, com.google.android.gms.internal.ads.zznx r25, com.google.android.gms.internal.ads.zzafm r26) {
        /*
            Method dump skipped, instruction units count: 510
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzafn.zza(com.google.android.gms.internal.ads.zzaef, android.content.Context, java.lang.String, java.lang.String, java.lang.String, java.lang.String, com.google.android.gms.internal.ads.zzafz, com.google.android.gms.internal.ads.zznx, com.google.android.gms.internal.ads.zzafm):com.google.android.gms.internal.ads.zzaej");
    }

    public static zzafn zza(Context context, zzafm zzafmVar) {
        zzafn zzafnVar;
        synchronized (sLock) {
            if (zzchh == null) {
                if (context.getApplicationContext() != null) {
                    context = context.getApplicationContext();
                }
                zznk.initialize(context);
                zzchh = new zzafn(context, zzafmVar);
                if (context.getApplicationContext() != null) {
                    com.google.android.gms.ads.internal.zzbv.zzek().zzal(context);
                }
                zzajz.zzai(context);
            }
            zzafnVar = zzchh;
        }
        return zzafnVar;
    }

    private static void zza(String str, Map<String, List<String>> map, String str2, int i) {
        if (zzakb.isLoggable(2)) {
            StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 39);
            sb.append("Http Response: {\n  URL:\n    ");
            sb.append(str);
            sb.append("\n  Headers:");
            zzakb.v(sb.toString());
            if (map != null) {
                for (String str3 : map.keySet()) {
                    StringBuilder sb2 = new StringBuilder(String.valueOf(str3).length() + 5);
                    sb2.append("    ");
                    sb2.append(str3);
                    sb2.append(":");
                    zzakb.v(sb2.toString());
                    Iterator<String> it2 = map.get(str3).iterator();
                    while (it2.hasNext()) {
                        String strValueOf = String.valueOf(it2.next());
                        zzakb.v(strValueOf.length() != 0 ? "      ".concat(strValueOf) : new String("      "));
                    }
                }
            }
            zzakb.v("  Body:");
            if (str2 != null) {
                int i2 = 0;
                while (i2 < Math.min(str2.length(), 100000)) {
                    int i3 = i2 + 1000;
                    zzakb.v(str2.substring(i2, Math.min(str2.length(), i3)));
                    i2 = i3;
                }
            } else {
                zzakb.v("    null");
            }
            StringBuilder sb3 = new StringBuilder(34);
            sb3.append("  Response Code:\n    ");
            sb3.append(i);
            sb3.append("\n}");
            zzakb.v(sb3.toString());
        }
    }

    @Override // com.google.android.gms.internal.ads.zzaen
    public final void zza(zzaef zzaefVar, zzaeq zzaeqVar) {
        com.google.android.gms.ads.internal.zzbv.zzeo().zzd(this.mContext, zzaefVar.zzacr);
        zzanz<?> zzanzVarZzb = zzaki.zzb(new zzafp(this, zzaefVar, zzaeqVar));
        com.google.android.gms.ads.internal.zzbv.zzez().zzsa();
        com.google.android.gms.ads.internal.zzbv.zzez().getHandler().postDelayed(new zzafq(this, zzanzVarZzb), 60000L);
    }

    @Override // com.google.android.gms.internal.ads.zzaen
    public final void zza(zzaey zzaeyVar, zzaet zzaetVar) {
        zzakb.v("Nonagon code path entered in octagon");
        throw new IllegalArgumentException();
    }

    @Override // com.google.android.gms.internal.ads.zzaen
    public final zzaej zzb(zzaef zzaefVar) {
        return zza(this.mContext, this.zzchi, zzaefVar, this.zzchj);
    }

    @Override // com.google.android.gms.internal.ads.zzaen
    public final void zzb(zzaey zzaeyVar, zzaet zzaetVar) {
        zzakb.v("Nonagon code path entered in octagon");
        throw new IllegalArgumentException();
    }
}
