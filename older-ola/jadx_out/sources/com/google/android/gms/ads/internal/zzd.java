package com.google.android.gms.ads.internal;

import android.app.Activity;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.RemoteException;
import android.support.annotation.Nullable;
import android.util.DisplayMetrics;
import com.facebook.accountkit.internal.InternalLogger;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.common.wrappers.Wrappers;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzadk;
import com.google.android.gms.internal.ads.zzaeg;
import com.google.android.gms.internal.ads.zzafa;
import com.google.android.gms.internal.ads.zzajh;
import com.google.android.gms.internal.ads.zzajj;
import com.google.android.gms.internal.ads.zzajl;
import com.google.android.gms.internal.ads.zzajx;
import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzaki;
import com.google.android.gms.internal.ads.zzakk;
import com.google.android.gms.internal.ads.zzakq;
import com.google.android.gms.internal.ads.zzang;
import com.google.android.gms.internal.ads.zzano;
import com.google.android.gms.internal.ads.zzanz;
import com.google.android.gms.internal.ads.zzaoe;
import com.google.android.gms.internal.ads.zzaqw;
import com.google.android.gms.internal.ads.zzgk;
import com.google.android.gms.internal.ads.zzhu;
import com.google.android.gms.internal.ads.zzhx;
import com.google.android.gms.internal.ads.zzjj;
import com.google.android.gms.internal.ads.zzjn;
import com.google.android.gms.internal.ads.zzkb;
import com.google.android.gms.internal.ads.zzlu;
import com.google.android.gms.internal.ads.zznk;
import com.google.android.gms.internal.ads.zznx;
import com.google.android.gms.internal.ads.zzpl;
import com.google.android.gms.internal.ads.zzqs;
import com.google.android.gms.internal.ads.zzrc;
import com.google.android.gms.internal.ads.zzua;
import com.google.android.gms.internal.ads.zzwz;
import com.google.android.gms.internal.ads.zzxg;
import com.google.android.gms.internal.ads.zzxn;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.Executor;
import java.util.concurrent.TimeUnit;
import javax.annotation.ParametersAreNonnullByDefault;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
public abstract class zzd extends zza implements com.google.android.gms.ads.internal.overlay.zzn, zzbo, zzwz {
    protected final zzxn zzwh;
    private transient boolean zzwi;

    public zzd(Context context, zzjn zzjnVar, String str, zzxn zzxnVar, zzang zzangVar, zzw zzwVar) {
        this(new zzbw(context, zzjnVar, str, zzangVar), zzxnVar, null, zzwVar);
    }

    @VisibleForTesting
    private zzd(zzbw zzbwVar, zzxn zzxnVar, @Nullable zzbl zzblVar, zzw zzwVar) {
        super(zzbwVar, null, zzwVar);
        this.zzwh = zzxnVar;
        this.zzwi = false;
    }

    private final zzaeg zza(zzjj zzjjVar, Bundle bundle, zzajl zzajlVar, int i) {
        PackageInfo packageInfo;
        Bundle bundle2;
        long value;
        String string;
        JSONArray jSONArrayOptJSONArray;
        ApplicationInfo applicationInfo = this.zzvw.zzrt.getApplicationInfo();
        try {
            packageInfo = Wrappers.packageManager(this.zzvw.zzrt).getPackageInfo(applicationInfo.packageName, 0);
        } catch (PackageManager.NameNotFoundException unused) {
            packageInfo = null;
        }
        DisplayMetrics displayMetrics = this.zzvw.zzrt.getResources().getDisplayMetrics();
        if (this.zzvw.zzacs == null || this.zzvw.zzacs.getParent() == null) {
            bundle2 = null;
        } else {
            int[] iArr = new int[2];
            this.zzvw.zzacs.getLocationOnScreen(iArr);
            int i2 = iArr[0];
            int i3 = iArr[1];
            int width = this.zzvw.zzacs.getWidth();
            int height = this.zzvw.zzacs.getHeight();
            int i4 = (!this.zzvw.zzacs.isShown() || i2 + width <= 0 || i3 + height <= 0 || i2 > displayMetrics.widthPixels || i3 > displayMetrics.heightPixels) ? 0 : 1;
            bundle2 = new Bundle(5);
            bundle2.putInt("x", i2);
            bundle2.putInt("y", i3);
            bundle2.putInt("width", width);
            bundle2.putInt("height", height);
            bundle2.putInt(InternalLogger.EVENT_PARAM_VIEW_STATE_VISIBLE, i4);
        }
        String strZzql = zzbv.zzeo().zzpx().zzql();
        this.zzvw.zzacy = new zzajj(strZzql, this.zzvw.zzacp);
        this.zzvw.zzacy.zzn(zzjjVar);
        zzbv.zzek();
        String strZza = zzakk.zza(this.zzvw.zzrt, this.zzvw.zzacs, this.zzvw.zzacv);
        if (this.zzvw.zzadd != null) {
            try {
                value = this.zzvw.zzadd.getValue();
            } catch (RemoteException unused2) {
                zzakb.zzdk("Cannot get correlation id, default to 0.");
                value = 0;
            }
        } else {
            value = 0;
        }
        String string2 = UUID.randomUUID().toString();
        Bundle bundleZza = zzbv.zzep().zza(this.zzvw.zzrt, this, strZzql);
        ArrayList arrayList = new ArrayList();
        ArrayList arrayList2 = new ArrayList();
        for (int i5 = 0; i5 < this.zzvw.zzadi.size(); i5++) {
            String strKeyAt = this.zzvw.zzadi.keyAt(i5);
            arrayList.add(strKeyAt);
            if (this.zzvw.zzadh.containsKey(strKeyAt) && this.zzvw.zzadh.get(strKeyAt) != null) {
                arrayList2.add(strKeyAt);
            }
        }
        zzanz zzanzVarZza = zzaki.zza(new zzg(this));
        zzanz zzanzVarZza2 = zzaki.zza(new zzh(this));
        String strZzpu = zzajlVar != null ? zzajlVar.zzpu() : null;
        if (this.zzvw.zzads == null || this.zzvw.zzads.size() <= 0) {
            string = null;
        } else {
            int i6 = packageInfo != null ? packageInfo.versionCode : 0;
            if (i6 > zzbv.zzeo().zzqh().zzqz()) {
                zzbv.zzeo().zzqh().zzrf();
                zzbv.zzeo().zzqh().zzae(i6);
            } else {
                JSONObject jSONObjectZzre = zzbv.zzeo().zzqh().zzre();
                if (jSONObjectZzre != null && (jSONArrayOptJSONArray = jSONObjectZzre.optJSONArray(this.zzvw.zzacp)) != null) {
                    string = jSONArrayOptJSONArray.toString();
                }
            }
            string = null;
        }
        zzjn zzjnVar = this.zzvw.zzacv;
        String str = this.zzvw.zzacp;
        String strZzih = zzkb.zzih();
        zzang zzangVar = this.zzvw.zzacr;
        List<String> list = this.zzvw.zzads;
        boolean zZzqt = zzbv.zzeo().zzqh().zzqt();
        int i7 = displayMetrics.widthPixels;
        int i8 = displayMetrics.heightPixels;
        float f = displayMetrics.density;
        List<String> listZzjb = zznk.zzjb();
        String str2 = this.zzvw.zzaco;
        zzpl zzplVar = this.zzvw.zzadj;
        String strZzfq = this.zzvw.zzfq();
        float fZzdo = zzbv.zzfj().zzdo();
        boolean zZzdp = zzbv.zzfj().zzdp();
        zzbv.zzek();
        int iZzas = zzakk.zzas(this.zzvw.zzrt);
        zzbv.zzek();
        int iZzx = zzakk.zzx(this.zzvw.zzacs);
        boolean z = this.zzvw.zzrt instanceof Activity;
        boolean zZzqy = zzbv.zzeo().zzqh().zzqy();
        boolean zZzqa = zzbv.zzeo().zzqa();
        int iZztx = zzbv.zzff().zztx();
        zzbv.zzek();
        Bundle bundleZzrk = zzakk.zzrk();
        String strZzrw = zzbv.zzeu().zzrw();
        zzlu zzluVar = this.zzvw.zzadl;
        boolean zZzrx = zzbv.zzeu().zzrx();
        Bundle bundleZzlt = zzua.zzlk().zzlt();
        boolean zZzcr = zzbv.zzeo().zzqh().zzcr(this.zzvw.zzacp);
        List<Integer> list2 = this.zzvw.zzadn;
        boolean zIsCallerInstantApp = Wrappers.packageManager(this.zzvw.zzrt).isCallerInstantApp();
        boolean zZzqb = zzbv.zzeo().zzqb();
        zzbv.zzem();
        return new zzaeg(bundle2, zzjjVar, zzjnVar, str, applicationInfo, packageInfo, strZzql, strZzih, zzangVar, bundleZza, list, arrayList, bundle, zZzqt, i7, i8, f, strZza, value, string2, listZzjb, str2, zzplVar, strZzfq, fZzdo, zZzdp, iZzas, iZzx, z, zZzqy, zzanzVarZza, strZzpu, zZzqa, iZztx, bundleZzrk, strZzrw, zzluVar, zZzrx, bundleZzlt, zZzcr, zzanzVarZza2, list2, string, arrayList2, i, zIsCallerInstantApp, zZzqb, zzakq.zzrp(), (ArrayList) zzano.zza(zzbv.zzeo().zzqi(), (Object) null, 1000L, TimeUnit.MILLISECONDS));
    }

    @Nullable
    static String zzc(zzajh zzajhVar) {
        if (zzajhVar == null) {
            return null;
        }
        String str = zzajhVar.zzbty;
        if (("com.google.android.gms.ads.mediation.customevent.CustomEventAdapter".equals(str) || "com.google.ads.mediation.customevent.CustomEventAdapter".equals(str)) && zzajhVar.zzbtw != null) {
            try {
                return new JSONObject(zzajhVar.zzbtw.zzbsb).getString("class_name");
            } catch (NullPointerException | JSONException unused) {
            }
        }
        return str;
    }

    @Override // com.google.android.gms.internal.ads.zzks
    @Nullable
    public final String getMediationAdapterClassName() {
        if (this.zzvw.zzacw == null) {
            return null;
        }
        return this.zzvw.zzacw.zzbty;
    }

    @Override // com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzjd
    public void onAdClicked() {
        if (this.zzvw.zzacw == null) {
            zzakb.zzdk("Ad state was null when trying to ping click URLs.");
            return;
        }
        if (this.zzvw.zzacw.zzcod != null && this.zzvw.zzacw.zzcod.zzbsn != null) {
            zzbv.zzfd();
            zzxg.zza(this.zzvw.zzrt, this.zzvw.zzacr.zzcw, this.zzvw.zzacw, this.zzvw.zzacp, false, zzc(this.zzvw.zzacw.zzcod.zzbsn));
        }
        if (this.zzvw.zzacw.zzbtw != null && this.zzvw.zzacw.zzbtw.zzbrw != null) {
            zzbv.zzfd();
            zzxg.zza(this.zzvw.zzrt, this.zzvw.zzacr.zzcw, this.zzvw.zzacw, this.zzvw.zzacp, false, this.zzvw.zzacw.zzbtw.zzbrw);
        }
        super.onAdClicked();
    }

    @Override // com.google.android.gms.ads.internal.overlay.zzn
    public final void onPause() {
        this.zzvy.zzj(this.zzvw.zzacw);
    }

    @Override // com.google.android.gms.ads.internal.overlay.zzn
    public final void onResume() {
        this.zzvy.zzk(this.zzvw.zzacw);
    }

    @Override // com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzks
    public void pause() {
        Preconditions.checkMainThread("pause must be called on the main UI thread.");
        if (this.zzvw.zzacw != null && this.zzvw.zzacw.zzbyo != null && this.zzvw.zzfo()) {
            zzbv.zzem();
            zzakq.zzi(this.zzvw.zzacw.zzbyo);
        }
        if (this.zzvw.zzacw != null && this.zzvw.zzacw.zzbtx != null) {
            try {
                this.zzvw.zzacw.zzbtx.pause();
            } catch (RemoteException unused) {
                zzakb.zzdk("Could not pause mediation adapter.");
            }
        }
        this.zzvy.zzj(this.zzvw.zzacw);
        this.zzvv.pause();
    }

    public final void recordImpression() {
        zza(this.zzvw.zzacw, false);
    }

    @Override // com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzks
    public void resume() {
        Preconditions.checkMainThread("resume must be called on the main UI thread.");
        zzaqw zzaqwVar = (this.zzvw.zzacw == null || this.zzvw.zzacw.zzbyo == null) ? null : this.zzvw.zzacw.zzbyo;
        if (zzaqwVar != null && this.zzvw.zzfo()) {
            zzbv.zzem();
            zzakq.zzj(this.zzvw.zzacw.zzbyo);
        }
        if (this.zzvw.zzacw != null && this.zzvw.zzacw.zzbtx != null) {
            try {
                this.zzvw.zzacw.zzbtx.resume();
            } catch (RemoteException unused) {
                zzakb.zzdk("Could not resume mediation adapter.");
            }
        }
        if (zzaqwVar == null || !zzaqwVar.zzum()) {
            this.zzvv.resume();
        }
        this.zzvy.zzk(this.zzvw.zzacw);
    }

    public void showInterstitial() {
        zzakb.zzdk("showInterstitial is not supported for current ad type");
    }

    protected void zza(@Nullable zzajh zzajhVar, boolean z) {
        if (zzajhVar == null) {
            zzakb.zzdk("Ad state was null when trying to ping impression URLs.");
            return;
        }
        if (zzajhVar == null) {
            zzakb.zzdk("Ad state was null when trying to ping impression URLs.");
        } else {
            zzakb.zzck("Pinging Impression URLs.");
            if (this.zzvw.zzacy != null) {
                this.zzvw.zzacy.zzpm();
            }
            zzajhVar.zzcoq.zza(zzhu.zza.zzb.AD_IMPRESSION);
            if (zzajhVar.zzbso != null && !zzajhVar.zzcok) {
                zzbv.zzek();
                zzakk.zza(this.zzvw.zzrt, this.zzvw.zzacr.zzcw, zzc(zzajhVar.zzbso));
                zzajhVar.zzcok = true;
            }
        }
        if (!zzajhVar.zzcom || z) {
            if (zzajhVar.zzcod != null && zzajhVar.zzcod.zzbso != null) {
                zzbv.zzfd();
                zzxg.zza(this.zzvw.zzrt, this.zzvw.zzacr.zzcw, zzajhVar, this.zzvw.zzacp, z, zzc(zzajhVar.zzcod.zzbso));
            }
            if (zzajhVar.zzbtw != null && zzajhVar.zzbtw.zzbrx != null) {
                zzbv.zzfd();
                zzxg.zza(this.zzvw.zzrt, this.zzvw.zzacr.zzcw, zzajhVar, this.zzvw.zzacp, z, zzajhVar.zzbtw.zzbrx);
            }
            zzajhVar.zzcom = true;
        }
    }

    @Override // com.google.android.gms.internal.ads.zzwz
    public final void zza(zzqs zzqsVar, String str) {
        String customTemplateId;
        zzrc zzrcVar = null;
        if (zzqsVar != null) {
            try {
                customTemplateId = zzqsVar.getCustomTemplateId();
            } catch (RemoteException e) {
                zzakb.zzc("Unable to call onCustomClick.", e);
                return;
            }
        } else {
            customTemplateId = null;
        }
        if (this.zzvw.zzadh != null && customTemplateId != null) {
            zzrcVar = this.zzvw.zzadh.get(customTemplateId);
        }
        if (zzrcVar == null) {
            zzakb.zzdk("Mediation adapter invoked onCustomClick but no listeners were set.");
        } else {
            zzrcVar.zzb(zzqsVar, str);
        }
    }

    public final boolean zza(zzaeg zzaegVar, zznx zznxVar) {
        this.zzvr = zznxVar;
        zznxVar.zze("seq_num", zzaegVar.zzccy);
        zznxVar.zze("request_id", zzaegVar.zzcdi);
        zznxVar.zze("session_id", zzaegVar.zzccz);
        if (zzaegVar.zzccw != null) {
            zznxVar.zze("app_version", String.valueOf(zzaegVar.zzccw.versionCode));
        }
        zzbw zzbwVar = this.zzvw;
        zzbv.zzeg();
        Context context = this.zzvw.zzrt;
        zzhx zzhxVar = this.zzwc.zzxb;
        zzajx zzafaVar = zzaegVar.zzccv.extras.getBundle("sdk_less_server_data") != null ? new zzafa(context, zzaegVar, this, zzhxVar) : new zzadk(context, zzaegVar, this, zzhxVar);
        zzafaVar.zzqo();
        zzbwVar.zzact = zzafaVar;
        return true;
    }

    @Override // com.google.android.gms.ads.internal.zza
    final boolean zza(zzajh zzajhVar) {
        zzjj zzjjVar;
        boolean z = false;
        if (this.zzvx != null) {
            zzjjVar = this.zzvx;
            this.zzvx = null;
        } else {
            zzjjVar = zzajhVar.zzccv;
            if (zzjjVar.extras != null) {
                z = zzjjVar.extras.getBoolean("_noRefresh", false);
            }
        }
        return zza(zzjjVar, zzajhVar, z);
    }

    @Override // com.google.android.gms.ads.internal.zza
    protected boolean zza(@Nullable zzajh zzajhVar, zzajh zzajhVar2) {
        int i;
        if (zzajhVar != null && zzajhVar.zzbtz != null) {
            zzajhVar.zzbtz.zza((zzwz) null);
        }
        if (zzajhVar2.zzbtz != null) {
            zzajhVar2.zzbtz.zza(this);
        }
        int i2 = 0;
        if (zzajhVar2.zzcod != null) {
            i2 = zzajhVar2.zzcod.zzbtc;
            i = zzajhVar2.zzcod.zzbtd;
        } else {
            i = 0;
        }
        this.zzvw.zzadt.zze(i2, i);
        return true;
    }

    protected boolean zza(zzjj zzjjVar, zzajh zzajhVar, boolean z) {
        zzbl zzblVar;
        long j;
        if (!z && this.zzvw.zzfo()) {
            if (zzajhVar.zzbsu > 0) {
                zzblVar = this.zzvv;
                j = zzajhVar.zzbsu;
            } else if (zzajhVar.zzcod != null && zzajhVar.zzcod.zzbsu > 0) {
                zzblVar = this.zzvv;
                j = zzajhVar.zzcod.zzbsu;
            } else if (!zzajhVar.zzceq && zzajhVar.errorCode == 2) {
                this.zzvv.zzg(zzjjVar);
            }
            zzblVar.zza(zzjjVar, j);
        }
        return this.zzvv.zzdz();
    }

    @Override // com.google.android.gms.ads.internal.zza
    public boolean zza(zzjj zzjjVar, zznx zznxVar) {
        return zza(zzjjVar, zznxVar, 1);
    }

    public final boolean zza(zzjj zzjjVar, zznx zznxVar, int i) {
        zzajl zzajlVarZzra;
        if (!zzca()) {
            return false;
        }
        zzbv.zzek();
        zzgk zzgkVarZzaf = zzbv.zzeo().zzaf(this.zzvw.zzrt);
        Bundle bundleZza = zzgkVarZzaf == null ? null : zzakk.zza(zzgkVarZzaf);
        this.zzvv.cancel();
        this.zzvw.zzadv = 0;
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbcs)).booleanValue()) {
            zzajlVarZzra = zzbv.zzeo().zzqh().zzra();
            zzbv.zzes().zza(this.zzvw.zzrt, this.zzvw.zzacr, false, zzajlVarZzra, zzajlVarZzra != null ? zzajlVarZzra.zzpv() : null, this.zzvw.zzacp, null);
        } else {
            zzajlVarZzra = null;
        }
        return zza(zza(zzjjVar, bundleZza, zzajlVarZzra, i), zznxVar);
    }

    @Override // com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzabm
    public final void zzb(zzajh zzajhVar) {
        super.zzb(zzajhVar);
        if (zzajhVar.zzbtw != null) {
            zzakb.zzck("Disable the debug gesture detector on the mediation ad frame.");
            if (this.zzvw.zzacs != null) {
                this.zzvw.zzacs.zzfu();
            }
            zzakb.zzck("Pinging network fill URLs.");
            zzbv.zzfd();
            zzxg.zza(this.zzvw.zzrt, this.zzvw.zzacr.zzcw, zzajhVar, this.zzvw.zzacp, false, zzajhVar.zzbtw.zzbsa);
            if (zzajhVar.zzcod != null && zzajhVar.zzcod.zzbsr != null && zzajhVar.zzcod.zzbsr.size() > 0) {
                zzakb.zzck("Pinging urls remotely");
                zzbv.zzek().zza(this.zzvw.zzrt, zzajhVar.zzcod.zzbsr);
            }
        } else {
            zzakb.zzck("Enable the debug gesture detector on the admob ad frame.");
            if (this.zzvw.zzacs != null) {
                this.zzvw.zzacs.zzft();
            }
        }
        if (zzajhVar.errorCode != 3 || zzajhVar.zzcod == null || zzajhVar.zzcod.zzbsq == null) {
            return;
        }
        zzakb.zzck("Pinging no fill URLs.");
        zzbv.zzfd();
        zzxg.zza(this.zzvw.zzrt, this.zzvw.zzacr.zzcw, zzajhVar, this.zzvw.zzacp, false, zzajhVar.zzcod.zzbsq);
    }

    protected final void zzb(@Nullable zzajh zzajhVar, boolean z) {
        if (zzajhVar == null) {
            return;
        }
        if (zzajhVar != null && zzajhVar.zzbsp != null && !zzajhVar.zzcol) {
            zzbv.zzek();
            zzakk.zza(this.zzvw.zzrt, this.zzvw.zzacr.zzcw, zzb(zzajhVar.zzbsp));
            zzajhVar.zzcol = true;
        }
        if (!zzajhVar.zzcon || z) {
            if (zzajhVar.zzcod != null && zzajhVar.zzcod.zzbsp != null) {
                zzbv.zzfd();
                zzxg.zza(this.zzvw.zzrt, this.zzvw.zzacr.zzcw, zzajhVar, this.zzvw.zzacp, z, zzb(zzajhVar.zzcod.zzbsp));
            }
            if (zzajhVar.zzbtw != null && zzajhVar.zzbtw.zzbry != null) {
                zzbv.zzfd();
                zzxg.zza(this.zzvw.zzrt, this.zzvw.zzacr.zzcw, zzajhVar, this.zzvw.zzacp, z, zzajhVar.zzbtw.zzbry);
            }
            zzajhVar.zzcon = true;
        }
    }

    @Override // com.google.android.gms.internal.ads.zzwz
    public final void zzb(String str, String str2) {
        onAppEvent(str, str2);
    }

    @Override // com.google.android.gms.ads.internal.zza
    protected final boolean zzc(zzjj zzjjVar) {
        return super.zzc(zzjjVar) && !this.zzwi;
    }

    protected boolean zzca() {
        zzbv.zzek();
        if (!zzakk.zzl(this.zzvw.zzrt, "android.permission.INTERNET")) {
            return false;
        }
        zzbv.zzek();
        return zzakk.zzaj(this.zzvw.zzrt);
    }

    public void zzcb() {
        this.zzwi = false;
        zzbn();
        this.zzvw.zzacy.zzpo();
    }

    public void zzcc() {
        this.zzwi = true;
        zzbp();
    }

    public void zzcd() {
        zzakb.zzdk("Mediated ad does not support onVideoEnd callback");
    }

    public void zzce() {
        onAdClicked();
    }

    @Override // com.google.android.gms.internal.ads.zzwz
    public final void zzcf() {
        zzcb();
    }

    @Override // com.google.android.gms.internal.ads.zzwz
    public final void zzcg() {
        zzbo();
    }

    @Override // com.google.android.gms.internal.ads.zzwz
    public final void zzch() {
        zzcc();
    }

    @Override // com.google.android.gms.internal.ads.zzwz
    public final void zzci() {
        if (this.zzvw.zzacw != null) {
            String str = this.zzvw.zzacw.zzbty;
            StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 74);
            sb.append("Mediation adapter ");
            sb.append(str);
            sb.append(" refreshed, but mediation adapters should never refresh.");
            zzakb.zzdk(sb.toString());
        }
        zza(this.zzvw.zzacw, true);
        zzb(this.zzvw.zzacw, true);
        zzbq();
    }

    public void zzcj() {
        recordImpression();
    }

    @Override // com.google.android.gms.internal.ads.zzks
    @Nullable
    public final String zzck() {
        if (this.zzvw.zzacw == null) {
            return null;
        }
        return zzc(this.zzvw.zzacw);
    }

    @Override // com.google.android.gms.ads.internal.zzbo
    public final void zzcl() {
        Executor executor = zzaoe.zzcvy;
        zzbl zzblVar = this.zzvv;
        zzblVar.getClass();
        executor.execute(zze.zza(zzblVar));
    }

    @Override // com.google.android.gms.ads.internal.zzbo
    public final void zzcm() {
        Executor executor = zzaoe.zzcvy;
        zzbl zzblVar = this.zzvv;
        zzblVar.getClass();
        executor.execute(zzf.zza(zzblVar));
    }
}
