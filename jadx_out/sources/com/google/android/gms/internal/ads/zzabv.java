package com.google.android.gms.internal.ads;

import android.content.Context;
import android.graphics.Color;
import android.net.Uri;
import android.os.RemoteException;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.facebook.share.internal.MessengerShareContentUtility;
import com.google.android.gms.common.util.VisibleForTesting;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.CancellationException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicInteger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzabv implements Callable<zzajh> {

    @VisibleForTesting
    private static long zzbzx = 10;
    private final Context mContext;
    private final zzacm zzaad;
    private final zzci zzbjc;
    private final zzaji zzbze;
    private final zzalt zzbzy;
    private final com.google.android.gms.ads.internal.zzbc zzbzz;
    private JSONObject zzcac;
    private final zznx zzvr;
    private final Object mLock = new Object();
    private boolean zzcaa = false;
    private int mErrorCode = -2;
    private List<String> zzcab = null;
    private String zzcad = null;

    @Nullable
    private String zzcae = null;

    public zzabv(Context context, com.google.android.gms.ads.internal.zzbc zzbcVar, zzalt zzaltVar, zzci zzciVar, zzaji zzajiVar, zznx zznxVar) {
        this.mContext = context;
        this.zzbzz = zzbcVar;
        this.zzbzy = zzaltVar;
        this.zzbze = zzajiVar;
        this.zzbjc = zzciVar;
        this.zzvr = zznxVar;
        this.zzaad = zzbcVar.zzdr();
    }

    private final zzajh zza(zzpb zzpbVar, boolean z) {
        int i;
        synchronized (this.mLock) {
            i = (zzpbVar == null && this.mErrorCode == -2) ? 0 : this.mErrorCode;
        }
        return new zzajh(this.zzbze.zzcgs.zzccv, null, this.zzbze.zzcos.zzbsn, i, this.zzbze.zzcos.zzbso, this.zzcab, this.zzbze.zzcos.orientation, this.zzbze.zzcos.zzbsu, this.zzbze.zzcgs.zzccy, false, null, null, null, null, null, 0L, this.zzbze.zzacv, this.zzbze.zzcos.zzcep, this.zzbze.zzcoh, this.zzbze.zzcoi, this.zzbze.zzcos.zzcev, this.zzcac, i != -2 ? null : zzpbVar, null, null, null, this.zzbze.zzcos.zzcfh, this.zzbze.zzcos.zzcfi, null, this.zzbze.zzcos.zzbsr, this.zzcad, this.zzbze.zzcoq, this.zzbze.zzcos.zzzl, this.zzbze.zzcor, z, this.zzbze.zzcos.zzbsp, this.zzbze.zzcos.zzzm, this.zzcae);
    }

    private final zzanz<zzon> zza(JSONObject jSONObject, boolean z, boolean z2) {
        String string = z ? jSONObject.getString("url") : jSONObject.optString("url");
        double dOptDouble = jSONObject.optDouble("scale", 1.0d);
        boolean zOptBoolean = jSONObject.optBoolean("is_transparent", true);
        if (!TextUtils.isEmpty(string)) {
            return z2 ? zzano.zzi(new zzon(null, Uri.parse(string), dOptDouble)) : this.zzbzy.zza(string, new zzacb(this, z, dOptDouble, zOptBoolean, string));
        }
        zzd(0, z);
        return zzano.zzi(null);
    }

    private final void zzab(int i) {
        synchronized (this.mLock) {
            this.zzcaa = true;
            this.mErrorCode = i;
        }
    }

    private static zzaqw zzb(zzanz<zzaqw> zzanzVar) {
        try {
            return zzanzVar.get(((Integer) zzkb.zzik().zzd(zznk.zzbby)).intValue(), TimeUnit.MILLISECONDS);
        } catch (InterruptedException e) {
            zzane.zzc("", e);
            Thread.currentThread().interrupt();
            return null;
        } catch (CancellationException | ExecutionException | TimeoutException e2) {
            zzane.zzc("", e2);
            return null;
        }
    }

    private static Integer zzb(JSONObject jSONObject, String str) {
        try {
            JSONObject jSONObject2 = jSONObject.getJSONObject(str);
            return Integer.valueOf(Color.rgb(jSONObject2.getInt("r"), jSONObject2.getInt("g"), jSONObject2.getInt("b")));
        } catch (JSONException unused) {
            return null;
        }
    }

    static zzaqw zzc(zzanz<zzaqw> zzanzVar) {
        try {
            return zzanzVar.get(((Integer) zzkb.zzik().zzd(zznk.zzbbx)).intValue(), TimeUnit.SECONDS);
        } catch (InterruptedException e) {
            zzakb.zzc("InterruptedException occurred while waiting for video to load", e);
            Thread.currentThread().interrupt();
            return null;
        } catch (CancellationException | ExecutionException | TimeoutException e2) {
            zzakb.zzc("Exception occurred while waiting for video to load", e2);
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzc(zzqs zzqsVar, String str) {
        try {
            zzrc zzrcVarZzr = this.zzbzz.zzr(zzqsVar.getCustomTemplateId());
            if (zzrcVarZzr != null) {
                zzrcVarZzr.zzb(zzqsVar, str);
            }
        } catch (RemoteException e) {
            StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 40);
            sb.append("Failed to call onCustomClick for asset ");
            sb.append(str);
            sb.append(".");
            zzakb.zzc(sb.toString(), e);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static <V> List<V> zzk(List<zzanz<V>> list) {
        ArrayList arrayList = new ArrayList();
        Iterator<zzanz<V>> it2 = list.iterator();
        while (it2.hasNext()) {
            V v = it2.next().get();
            if (v != null) {
                arrayList.add(v);
            }
        }
        return arrayList;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:14:0x0040 A[Catch: Exception -> 0x01df, TimeoutException -> 0x01e3, InterruptedException | CancellationException | ExecutionException | JSONException -> 0x01e7, TryCatch #2 {InterruptedException | CancellationException | ExecutionException | JSONException -> 0x01e7, TimeoutException -> 0x01e3, Exception -> 0x01df, blocks: (B:3:0x0002, B:5:0x000e, B:7:0x002a, B:9:0x0032, B:12:0x003a, B:15:0x0044, B:17:0x005c, B:19:0x006f, B:21:0x0077, B:29:0x00a3, B:33:0x00ad, B:35:0x00bb, B:37:0x00c5, B:39:0x00cd, B:41:0x00d7, B:43:0x00df, B:59:0x014d, B:64:0x0158, B:74:0x0186, B:76:0x01be, B:78:0x01c2, B:79:0x01d1, B:73:0x0182, B:67:0x0168, B:68:0x016f, B:70:0x0175, B:44:0x00e9, B:46:0x00f1, B:47:0x00fb, B:49:0x0103, B:51:0x0122, B:52:0x0128, B:54:0x013a, B:56:0x0145, B:55:0x013f, B:57:0x0149, B:22:0x007d, B:25:0x0086, B:28:0x0093, B:14:0x0040), top: B:92:0x0002 }] */
    /* JADX WARN: Removed duplicated region for block: B:17:0x005c A[Catch: Exception -> 0x01df, TimeoutException -> 0x01e3, InterruptedException | CancellationException | ExecutionException | JSONException -> 0x01e7, TryCatch #2 {InterruptedException | CancellationException | ExecutionException | JSONException -> 0x01e7, TimeoutException -> 0x01e3, Exception -> 0x01df, blocks: (B:3:0x0002, B:5:0x000e, B:7:0x002a, B:9:0x0032, B:12:0x003a, B:15:0x0044, B:17:0x005c, B:19:0x006f, B:21:0x0077, B:29:0x00a3, B:33:0x00ad, B:35:0x00bb, B:37:0x00c5, B:39:0x00cd, B:41:0x00d7, B:43:0x00df, B:59:0x014d, B:64:0x0158, B:74:0x0186, B:76:0x01be, B:78:0x01c2, B:79:0x01d1, B:73:0x0182, B:67:0x0168, B:68:0x016f, B:70:0x0175, B:44:0x00e9, B:46:0x00f1, B:47:0x00fb, B:49:0x0103, B:51:0x0122, B:52:0x0128, B:54:0x013a, B:56:0x0145, B:55:0x013f, B:57:0x0149, B:22:0x007d, B:25:0x0086, B:28:0x0093, B:14:0x0040), top: B:92:0x0002 }] */
    /* JADX WARN: Removed duplicated region for block: B:18:0x006e  */
    /* JADX WARN: Removed duplicated region for block: B:89:0x01f1  */
    @Override // java.util.concurrent.Callable
    /* JADX INFO: renamed from: zznw, reason: merged with bridge method [inline-methods] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final com.google.android.gms.internal.ads.zzajh call() {
        /*
            Method dump skipped, instruction units count: 505
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzabv.call():com.google.android.gms.internal.ads.zzajh");
    }

    private final boolean zznx() {
        boolean z;
        synchronized (this.mLock) {
            z = this.zzcaa;
        }
        return z;
    }

    public final zzanz<zzon> zza(JSONObject jSONObject, String str, boolean z, boolean z2) {
        JSONObject jSONObject2 = z ? jSONObject.getJSONObject(str) : jSONObject.optJSONObject(str);
        if (jSONObject2 == null) {
            jSONObject2 = new JSONObject();
        }
        return zza(jSONObject2, z, z2);
    }

    public final List<zzanz<zzon>> zza(JSONObject jSONObject, String str, boolean z, boolean z2, boolean z3) throws JSONException {
        JSONArray jSONArrayOptJSONArray = jSONObject.optJSONArray(str);
        ArrayList arrayList = new ArrayList();
        if (jSONArrayOptJSONArray == null || jSONArrayOptJSONArray.length() == 0) {
            zzd(0, false);
            return arrayList;
        }
        int length = z3 ? jSONArrayOptJSONArray.length() : 1;
        for (int i = 0; i < length; i++) {
            JSONObject jSONObject2 = jSONArrayOptJSONArray.getJSONObject(i);
            if (jSONObject2 == null) {
                jSONObject2 = new JSONObject();
            }
            arrayList.add(zza(jSONObject2, false, z2));
        }
        return arrayList;
    }

    public final Future<zzon> zza(JSONObject jSONObject, String str, boolean z) throws JSONException {
        JSONObject jSONObject2 = jSONObject.getJSONObject(str);
        boolean zOptBoolean = jSONObject2.optBoolean("require", true);
        if (jSONObject2 == null) {
            jSONObject2 = new JSONObject();
        }
        return zza(jSONObject2, zOptBoolean, z);
    }

    final /* synthetic */ void zza(final zzaoj zzaojVar, String str) {
        try {
            com.google.android.gms.ads.internal.zzbv.zzel();
            final zzaqw zzaqwVarZza = zzarc.zza(this.mContext, zzasi.zzvq(), "native-omid", false, false, this.zzbjc, this.zzbze.zzcgs.zzacr, this.zzvr, null, this.zzbzz.zzbi(), this.zzbze.zzcoq);
            zzaqwVarZza.zzuf().zza(new zzasd(zzaojVar, zzaqwVarZza) { // from class: com.google.android.gms.internal.ads.zzabx
                private final zzaoj zzbnu;
                private final zzaqw zzcai;

                {
                    this.zzbnu = zzaojVar;
                    this.zzcai = zzaqwVarZza;
                }

                @Override // com.google.android.gms.internal.ads.zzasd
                public final void zze(boolean z) {
                    this.zzbnu.set(this.zzcai);
                }
            });
            zzaqwVarZza.loadData(str, "text/html", "UTF-8");
        } catch (Exception e) {
            zzaojVar.set(null);
            zzane.zzc("", e);
        }
    }

    public final zzanz<zzaqw> zzc(JSONObject jSONObject, String str) {
        final JSONObject jSONObjectOptJSONObject = jSONObject.optJSONObject(str);
        if (jSONObjectOptJSONObject == null) {
            return zzano.zzi(null);
        }
        if (TextUtils.isEmpty(jSONObjectOptJSONObject.optString("vast_xml"))) {
            zzakb.zzdk("Required field 'vast_xml' is missing");
            return zzano.zzi(null);
        }
        final zzace zzaceVar = new zzace(this.mContext, this.zzbjc, this.zzbze, this.zzvr, this.zzbzz);
        final zzaoj zzaojVar = new zzaoj();
        zzaoe.zzcvy.execute(new Runnable(zzaceVar, jSONObjectOptJSONObject, zzaojVar) { // from class: com.google.android.gms.internal.ads.zzacf
            private final zzaoj zzbns;
            private final zzace zzcbf;
            private final JSONObject zzcbg;

            {
                this.zzcbf = zzaceVar;
                this.zzcbg = jSONObjectOptJSONObject;
                this.zzbns = zzaojVar;
            }

            @Override // java.lang.Runnable
            public final void run() {
                this.zzcbf.zza(this.zzcbg, this.zzbns);
            }
        });
        return zzaojVar;
    }

    public final void zzd(int i, boolean z) {
        if (z) {
            zzab(i);
        }
    }

    public final zzanz<zzoj> zzg(JSONObject jSONObject) throws JSONException {
        JSONObject jSONObjectOptJSONObject = jSONObject.optJSONObject("attribution");
        if (jSONObjectOptJSONObject == null) {
            return zzano.zzi(null);
        }
        String strOptString = jSONObjectOptJSONObject.optString("text");
        int iOptInt = jSONObjectOptJSONObject.optInt("text_size", -1);
        Integer numZzb = zzb(jSONObjectOptJSONObject, "text_color");
        Integer numZzb2 = zzb(jSONObjectOptJSONObject, "bg_color");
        int iOptInt2 = jSONObjectOptJSONObject.optInt("animation_ms", 1000);
        int iOptInt3 = jSONObjectOptJSONObject.optInt("presentation_ms", 4000);
        int i = (this.zzbze.zzcgs.zzadj == null || this.zzbze.zzcgs.zzadj.versionCode < 2) ? 1 : this.zzbze.zzcgs.zzadj.zzbjq;
        boolean zOptBoolean = jSONObjectOptJSONObject.optBoolean("allow_pub_rendering");
        List<zzanz<zzon>> arrayList = new ArrayList<>();
        if (jSONObjectOptJSONObject.optJSONArray("images") != null) {
            arrayList = zza(jSONObjectOptJSONObject, "images", false, false, true);
        } else {
            arrayList.add(zza(jSONObjectOptJSONObject, MessengerShareContentUtility.MEDIA_IMAGE, false, false));
        }
        zzaoj zzaojVar = new zzaoj();
        int size = arrayList.size();
        AtomicInteger atomicInteger = new AtomicInteger(0);
        Iterator<zzanz<zzon>> it2 = arrayList.iterator();
        while (it2.hasNext()) {
            it2.next().zza(new zzacc(atomicInteger, size, zzaojVar, arrayList), zzaki.zzcrj);
            arrayList = arrayList;
        }
        return zzano.zza(zzaojVar, new zzaca(this, strOptString, numZzb2, numZzb, iOptInt, iOptInt3, iOptInt2, i, zOptBoolean), zzaki.zzcrj);
    }
}
