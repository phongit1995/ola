package com.google.android.gms.ads.internal;

import android.content.Context;
import android.os.RemoteException;
import android.support.annotation.Nullable;
import android.support.v4.util.SimpleArrayMap;
import android.util.Log;
import android.view.View;
import com.google.ads.AdRequest;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.dynamic.ObjectWrapper;
import com.google.android.gms.internal.ads.zzaaw;
import com.google.android.gms.internal.ads.zzabl;
import com.google.android.gms.internal.ads.zzacm;
import com.google.android.gms.internal.ads.zzacq;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzajh;
import com.google.android.gms.internal.ads.zzaji;
import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzaki;
import com.google.android.gms.internal.ads.zzakk;
import com.google.android.gms.internal.ads.zzane;
import com.google.android.gms.internal.ads.zzang;
import com.google.android.gms.internal.ads.zzanz;
import com.google.android.gms.internal.ads.zzaoj;
import com.google.android.gms.internal.ads.zzaqw;
import com.google.android.gms.internal.ads.zzev;
import com.google.android.gms.internal.ads.zzjj;
import com.google.android.gms.internal.ads.zzjn;
import com.google.android.gms.internal.ads.zzkb;
import com.google.android.gms.internal.ads.zzlo;
import com.google.android.gms.internal.ads.zzlr;
import com.google.android.gms.internal.ads.zznk;
import com.google.android.gms.internal.ads.zznx;
import com.google.android.gms.internal.ads.zzod;
import com.google.android.gms.internal.ads.zzoo;
import com.google.android.gms.internal.ads.zzoq;
import com.google.android.gms.internal.ads.zzov;
import com.google.android.gms.internal.ads.zzox;
import com.google.android.gms.internal.ads.zzoz;
import com.google.android.gms.internal.ads.zzpa;
import com.google.android.gms.internal.ads.zzpb;
import com.google.android.gms.internal.ads.zzpd;
import com.google.android.gms.internal.ads.zzqs;
import com.google.android.gms.internal.ads.zzrc;
import com.google.android.gms.internal.ads.zzrf;
import com.google.android.gms.internal.ads.zzwy;
import com.google.android.gms.internal.ads.zzxn;
import com.google.android.gms.internal.ads.zzxq;
import com.google.android.gms.internal.ads.zzxz;
import com.google.android.gms.internal.ads.zzyc;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.CancellationException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import javax.annotation.ParametersAreNonnullByDefault;
import javax.annotation.concurrent.GuardedBy;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
public final class zzbc extends zzd implements zzpa {
    private final Object mLock;
    private zzaqw zzaaa;

    @Nullable
    private zzaqw zzaab;
    private int zzaac;

    @GuardedBy("mLock")
    private zzacm zzaad;
    private final String zzaae;
    private boolean zzwl;

    @VisibleForTesting
    private boolean zzzy;
    private zzaoj<zzpb> zzzz;

    public zzbc(Context context, zzw zzwVar, zzjn zzjnVar, String str, zzxn zzxnVar, zzang zzangVar) {
        this(context, zzwVar, zzjnVar, str, zzxnVar, zzangVar, false);
    }

    public zzbc(Context context, zzw zzwVar, zzjn zzjnVar, String str, zzxn zzxnVar, zzang zzangVar, boolean z) {
        super(context, zzjnVar, str, zzxnVar, zzangVar, zzwVar);
        this.mLock = new Object();
        this.zzzz = new zzaoj<>();
        this.zzaac = 1;
        this.zzaae = UUID.randomUUID().toString();
        this.zzzy = z;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static zzov zza(zzpb zzpbVar) {
        zzov zzovVar;
        IObjectWrapper iObjectWrapperZzka;
        Object objUnwrap = null;
        if (zzpbVar instanceof zzoq) {
            zzoq zzoqVar = (zzoq) zzpbVar;
            zzovVar = new zzov(zzoqVar.getHeadline(), zzoqVar.getImages(), zzoqVar.getBody(), zzoqVar.zzkg(), zzoqVar.getCallToAction(), zzoqVar.getAdvertiser(), -1.0d, null, null, zzoqVar.zzkc(), zzoqVar.getVideoController(), zzoqVar.zzkd(), zzoqVar.zzke(), zzoqVar.getMediationAdapterClassName(), zzoqVar.getExtras());
            if (zzoqVar.zzka() != null) {
                iObjectWrapperZzka = zzoqVar.zzka();
                objUnwrap = ObjectWrapper.unwrap(iObjectWrapperZzka);
            }
        } else if (zzpbVar instanceof zzoo) {
            zzoo zzooVar = (zzoo) zzpbVar;
            zzovVar = new zzov(zzooVar.getHeadline(), zzooVar.getImages(), zzooVar.getBody(), zzooVar.zzjz(), zzooVar.getCallToAction(), null, zzooVar.getStarRating(), zzooVar.getStore(), zzooVar.getPrice(), zzooVar.zzkc(), zzooVar.getVideoController(), zzooVar.zzkd(), zzooVar.zzke(), zzooVar.getMediationAdapterClassName(), zzooVar.getExtras());
            if (zzooVar.zzka() != null) {
                iObjectWrapperZzka = zzooVar.zzka();
                objUnwrap = ObjectWrapper.unwrap(iObjectWrapperZzka);
            }
        } else {
            zzovVar = null;
        }
        if (objUnwrap instanceof zzpd) {
            zzovVar.zzb((zzpd) objUnwrap);
        }
        return zzovVar;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void zza(zzbw zzbwVar, zzbw zzbwVar2) {
        if (zzbwVar2.zzade == null) {
            zzbwVar2.zzade = zzbwVar.zzade;
        }
        if (zzbwVar2.zzadf == null) {
            zzbwVar2.zzadf = zzbwVar.zzadf;
        }
        if (zzbwVar2.zzadh == null) {
            zzbwVar2.zzadh = zzbwVar.zzadh;
        }
        if (zzbwVar2.zzadi == null) {
            zzbwVar2.zzadi = zzbwVar.zzadi;
        }
        if (zzbwVar2.zzadk == null) {
            zzbwVar2.zzadk = zzbwVar.zzadk;
        }
        if (zzbwVar2.zzadj == null) {
            zzbwVar2.zzadj = zzbwVar.zzadj;
        }
        if (zzbwVar2.zzads == null) {
            zzbwVar2.zzads = zzbwVar.zzads;
        }
        if (zzbwVar2.zzacy == null) {
            zzbwVar2.zzacy = zzbwVar.zzacy;
        }
        if (zzbwVar2.zzadt == null) {
            zzbwVar2.zzadt = zzbwVar.zzadt;
        }
        if (zzbwVar2.zzacz == null) {
            zzbwVar2.zzacz = zzbwVar.zzacz;
        }
        if (zzbwVar2.zzada == null) {
            zzbwVar2.zzada = zzbwVar.zzada;
        }
        if (zzbwVar2.zzacv == null) {
            zzbwVar2.zzacv = zzbwVar.zzacv;
        }
        if (zzbwVar2.zzacw == null) {
            zzbwVar2.zzacw = zzbwVar.zzacw;
        }
        if (zzbwVar2.zzacx == null) {
            zzbwVar2.zzacx = zzbwVar.zzacx;
        }
    }

    private final void zza(zzoo zzooVar) {
        zzakk.zzcrm.post(new zzbg(this, zzooVar));
    }

    private final void zza(zzoq zzoqVar) {
        zzakk.zzcrm.post(new zzbi(this, zzoqVar));
    }

    private final void zza(zzov zzovVar) {
        zzakk.zzcrm.post(new zzbh(this, zzovVar));
    }

    private final boolean zzcp() {
        return this.zzvw.zzacw != null && this.zzvw.zzacw.zzcfp;
    }

    @Nullable
    private final zzwy zzcw() {
        if (this.zzvw.zzacw == null || !this.zzvw.zzacw.zzceq) {
            return null;
        }
        return this.zzvw.zzacw.zzcod;
    }

    private final void zzdx() {
        zzacm zzacmVarZzdr = zzdr();
        if (zzacmVarZzdr != null) {
            zzacmVarZzdr.zzmc();
        }
    }

    @Override // com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzks
    public final String getAdUnitId() {
        return this.zzvw.zzacp;
    }

    public final String getUuid() {
        return this.zzaae;
    }

    @Override // com.google.android.gms.ads.internal.zzd, com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzks
    public final void pause() {
        throw new IllegalStateException("Native Ad DOES NOT support pause().");
    }

    @Override // com.google.android.gms.ads.internal.zzd, com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzks
    public final void resume() {
        throw new IllegalStateException("Native Ad DOES NOT support resume().");
    }

    @Override // com.google.android.gms.ads.internal.zzd, com.google.android.gms.internal.ads.zzks
    public final void showInterstitial() {
        throw new IllegalStateException("Interstitial is NOT supported by NativeAdManager.");
    }

    @Override // com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzks
    public final void zza(zzaaw zzaawVar) {
        throw new IllegalStateException("In App Purchase is NOT supported by NativeAdManager.");
    }

    @Override // com.google.android.gms.ads.internal.zza
    public final void zza(zzaji zzajiVar, zznx zznxVar) {
        if (zzajiVar.zzacv != null) {
            this.zzvw.zzacv = zzajiVar.zzacv;
        }
        if (zzajiVar.errorCode != -2) {
            zzakk.zzcrm.post(new zzbd(this, zzajiVar));
            return;
        }
        int i = zzajiVar.zzcgs.zzceg;
        if (i == 1) {
            this.zzvw.zzadv = 0;
            zzbw zzbwVar = this.zzvw;
            zzbv.zzej();
            zzbwVar.zzacu = zzabl.zza(this.zzvw.zzrt, this, zzajiVar, this.zzvw.zzacq, null, this.zzwh, this, zznxVar);
            String strValueOf = String.valueOf(this.zzvw.zzacu.getClass().getName());
            zzakb.zzck(strValueOf.length() != 0 ? "AdRenderer: ".concat(strValueOf) : new String("AdRenderer: "));
            return;
        }
        JSONArray jSONArray = new JSONArray();
        try {
            JSONArray jSONArray2 = new JSONObject(zzajiVar.zzcos.zzceo).getJSONArray("slots");
            for (int i2 = 0; i2 < jSONArray2.length(); i2++) {
                JSONArray jSONArray3 = jSONArray2.getJSONObject(i2).getJSONArray("ads");
                for (int i3 = 0; i3 < jSONArray3.length(); i3++) {
                    jSONArray.put(jSONArray3.get(i3));
                }
            }
            zzdx();
            ArrayList arrayList = new ArrayList();
            for (int i4 = 0; i4 < i; i4++) {
                arrayList.add(zzaki.zza(new zzbe(this, i4, jSONArray, i, zzajiVar)));
            }
            for (int i5 = 0; i5 < arrayList.size(); i5++) {
                try {
                    zzakk.zzcrm.post(new zzbf(this, (zzpb) ((zzanz) arrayList.get(i5)).get(((Long) zzkb.zzik().zzd(zznk.zzbao)).longValue(), TimeUnit.MILLISECONDS), i5, arrayList));
                } catch (InterruptedException e) {
                    zzane.zzc("", e);
                    Thread.currentThread().interrupt();
                } catch (CancellationException | ExecutionException | TimeoutException e2) {
                    zzane.zzc("", e2);
                }
            }
        } catch (JSONException e3) {
            zzakb.zzc("Malformed native ad response", e3);
            zzi(0);
        }
    }

    @Override // com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzks
    public final void zza(zzod zzodVar) {
        throw new IllegalStateException("CustomRendering is NOT supported by NativeAdManager.");
    }

    @Override // com.google.android.gms.internal.ads.zzpa
    public final void zza(zzox zzoxVar) {
        if (this.zzaaa != null) {
            this.zzaaa.zzb(zzoxVar);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpa
    public final void zza(zzoz zzozVar) {
        if (this.zzvw.zzacw.zzcob != null) {
            zzbv.zzeo().zzqd().zza(this.zzvw.zzacv, this.zzvw.zzacw, new zzev(zzozVar), (zzaqw) null);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:99:0x02cf  */
    @Override // com.google.android.gms.ads.internal.zzd, com.google.android.gms.ads.internal.zza
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected final boolean zza(com.google.android.gms.internal.ads.zzajh r28, com.google.android.gms.internal.ads.zzajh r29) {
        /*
            Method dump skipped, instruction units count: 826
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.ads.internal.zzbc.zza(com.google.android.gms.internal.ads.zzajh, com.google.android.gms.internal.ads.zzajh):boolean");
    }

    @Override // com.google.android.gms.ads.internal.zzd
    protected final boolean zza(zzjj zzjjVar, zzajh zzajhVar, boolean z) {
        return this.zzvv.zzdz();
    }

    @Override // com.google.android.gms.ads.internal.zzd, com.google.android.gms.ads.internal.zza
    public final boolean zza(zzjj zzjjVar, zznx zznxVar) {
        try {
            zzdq();
            return super.zza(zzjjVar, zznxVar, this.zzaac);
        } catch (Exception e) {
            if (!zzane.isLoggable(4)) {
                return false;
            }
            Log.i(AdRequest.LOGTAG, "Error initializing webview.", e);
            return false;
        }
    }

    protected final void zzb(@Nullable IObjectWrapper iObjectWrapper) {
        Object objUnwrap = iObjectWrapper != null ? ObjectWrapper.unwrap(iObjectWrapper) : null;
        if (objUnwrap instanceof zzoz) {
            ((zzoz) objUnwrap).zzkl();
        }
        super.zzb(this.zzvw.zzacw, false);
    }

    @Override // com.google.android.gms.ads.internal.zza
    protected final void zzb(boolean z) {
        String str;
        super.zzb(z);
        if (this.zzwl) {
            if (((Boolean) zzkb.zzik().zzd(zznk.zzbcb)).booleanValue()) {
                zzdt();
            }
        }
        if (zzcp()) {
            if (this.zzaab == null && this.zzaaa == null) {
                return;
            }
            zzaqw zzaqwVar = null;
            if (this.zzaab != null) {
                str = null;
                zzaqwVar = this.zzaab;
            } else if (this.zzaaa != null) {
                zzaqwVar = this.zzaaa;
                str = "javascript";
            } else {
                str = null;
            }
            if (zzaqwVar.getWebView() == null || !zzbv.zzfa().zzi(this.zzvw.zzrt)) {
                return;
            }
            int i = this.zzvw.zzacr.zzcve;
            int i2 = this.zzvw.zzacr.zzcvf;
            StringBuilder sb = new StringBuilder(23);
            sb.append(i);
            sb.append(".");
            sb.append(i2);
            this.zzwb = zzbv.zzfa().zza(sb.toString(), zzaqwVar.getWebView(), "", "javascript", str);
            if (this.zzwb != null) {
                zzbv.zzfa().zzm(this.zzwb);
            }
        }
    }

    @Override // com.google.android.gms.ads.internal.zza
    protected final void zzbq() {
        zzb(false);
    }

    @Override // com.google.android.gms.ads.internal.zza
    protected final void zzc(int i, boolean z) {
        zzdx();
        super.zzc(i, z);
    }

    @Override // com.google.android.gms.ads.internal.zzd, com.google.android.gms.internal.ads.zzwz
    public final void zzcd() {
        zzlr zzlrVarZzio;
        zzajh zzajhVar = this.zzvw.zzacw;
        if (zzajhVar.zzbtx == null) {
            super.zzcd();
            return;
        }
        try {
            zzxq zzxqVar = zzajhVar.zzbtx;
            zzlo videoController = null;
            zzxz zzxzVarZzmo = zzxqVar.zzmo();
            if (zzxzVarZzmo != null) {
                videoController = zzxzVarZzmo.getVideoController();
            } else {
                zzyc zzycVarZzmp = zzxqVar.zzmp();
                if (zzycVarZzmp != null) {
                    videoController = zzycVarZzmp.getVideoController();
                } else {
                    zzqs zzqsVarZzmt = zzxqVar.zzmt();
                    if (zzqsVarZzmt != null) {
                        videoController = zzqsVarZzmt.getVideoController();
                    }
                }
            }
            if (videoController == null || (zzlrVarZzio = videoController.zzio()) == null) {
                return;
            }
            zzlrVarZzio.onVideoEnd();
        } catch (RemoteException e) {
            zzakb.zzd("#007 Could not call remote method.", e);
        }
    }

    @Override // com.google.android.gms.ads.internal.zzd, com.google.android.gms.internal.ads.zzwz
    public final void zzce() {
        if (this.zzvw.zzacw == null || !"com.google.ads.mediation.admob.AdMobAdapter".equals(this.zzvw.zzacw.zzbty)) {
            super.zzce();
        } else {
            zzbs();
        }
    }

    @Override // com.google.android.gms.ads.internal.zzd, com.google.android.gms.internal.ads.zzwz
    public final void zzcj() {
        if (this.zzvw.zzacw == null || !"com.google.ads.mediation.admob.AdMobAdapter".equals(this.zzvw.zzacw.zzbty)) {
            super.zzcj();
        } else {
            zzbr();
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpa
    public final void zzcr() {
        if (zzcp() && this.zzwb != null) {
            zzaqw zzaqwVar = null;
            if (this.zzaab != null) {
                zzaqwVar = this.zzaab;
            } else if (this.zzaaa != null) {
                zzaqwVar = this.zzaaa;
            }
            if (zzaqwVar != null) {
                zzaqwVar.zza("onSdkImpression", new HashMap());
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpa
    public final void zzcs() {
        super.zzby();
        if (this.zzaab != null) {
            this.zzaab.destroy();
            this.zzaab = null;
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpa
    public final void zzct() {
        if (this.zzaaa != null) {
            this.zzaaa.destroy();
            this.zzaaa = null;
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpa
    public final boolean zzcu() {
        if (zzcw() != null) {
            return zzcw().zzbta;
        }
        return false;
    }

    @Override // com.google.android.gms.internal.ads.zzpa
    public final boolean zzcv() {
        if (zzcw() != null) {
            return zzcw().zzbtb;
        }
        return false;
    }

    public final void zzd(@Nullable List<String> list) {
        Preconditions.checkMainThread("setNativeTemplates must be called on the main UI thread.");
        this.zzvw.zzads = list;
    }

    final void zzdq() {
        synchronized (this.mLock) {
            zzakb.v("Initializing webview native ads utills");
            this.zzaad = new zzacq(this.zzvw.zzrt, this, this.zzaae, this.zzvw.zzacq, this.zzvw.zzacr);
        }
    }

    @Nullable
    public final zzacm zzdr() {
        zzacm zzacmVar;
        synchronized (this.mLock) {
            zzacmVar = this.zzaad;
        }
        return zzacmVar;
    }

    protected final Future<zzpb> zzds() {
        return this.zzzz;
    }

    public final void zzdt() {
        if (this.zzvw.zzacw == null || this.zzaaa == null) {
            this.zzwl = true;
            zzakb.zzdk("Request to enable ActiveView before adState is available.");
        } else {
            zzbv.zzeo().zzqd().zza(this.zzvw.zzacv, this.zzvw.zzacw, this.zzaaa.getView(), this.zzaaa);
            this.zzwl = false;
        }
    }

    public final void zzdu() {
        this.zzwl = false;
        if (this.zzvw.zzacw == null || this.zzaaa == null) {
            zzakb.zzdk("Request to enable ActiveView before adState is available.");
        } else {
            zzbv.zzeo().zzqd().zzh(this.zzvw.zzacw);
        }
    }

    public final SimpleArrayMap<String, zzrf> zzdv() {
        Preconditions.checkMainThread("getOnCustomTemplateAdLoadedListeners must be called on the main UI thread.");
        return this.zzvw.zzadi;
    }

    public final void zzdw() {
        if (this.zzaaa == null || this.zzaaa.zztm() == null || this.zzvw.zzadj == null || this.zzvw.zzadj.zzbjr == null) {
            return;
        }
        this.zzaaa.zztm().zzb(this.zzvw.zzadj.zzbjr);
    }

    public final void zzf(zzaqw zzaqwVar) {
        this.zzaaa = zzaqwVar;
    }

    public final void zzg(@Nullable zzaqw zzaqwVar) {
        this.zzaab = zzaqwVar;
    }

    @Override // com.google.android.gms.ads.internal.zza
    protected final void zzi(int i) {
        zzc(i, false);
    }

    @Override // com.google.android.gms.internal.ads.zzpa
    public final void zzi(View view) {
        if (this.zzwb != null) {
            zzbv.zzfa().zza(this.zzwb, view);
        }
    }

    public final void zzj(int i) {
        Preconditions.checkMainThread("setMaxNumberOfAds must be called on the main UI thread.");
        this.zzaac = i;
    }

    @Override // com.google.android.gms.internal.ads.zzpa
    @Nullable
    public final zzrc zzr(String str) {
        Preconditions.checkMainThread("getOnCustomClickListener must be called on the main UI thread.");
        if (this.zzvw.zzadh == null) {
            return null;
        }
        return this.zzvw.zzadh.get(str);
    }
}
