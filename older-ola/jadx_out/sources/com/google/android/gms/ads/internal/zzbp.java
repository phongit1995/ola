package com.google.android.gms.ads.internal;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import android.view.ViewGroup;
import android.webkit.WebView;
import com.google.android.gms.actions.SearchIntents;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.dynamic.ObjectWrapper;
import com.google.android.gms.internal.ads.zzaaw;
import com.google.android.gms.internal.ads.zzabc;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzahe;
import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzaki;
import com.google.android.gms.internal.ads.zzamu;
import com.google.android.gms.internal.ads.zzang;
import com.google.android.gms.internal.ads.zzci;
import com.google.android.gms.internal.ads.zzcj;
import com.google.android.gms.internal.ads.zzjj;
import com.google.android.gms.internal.ads.zzjn;
import com.google.android.gms.internal.ads.zzkb;
import com.google.android.gms.internal.ads.zzke;
import com.google.android.gms.internal.ads.zzkh;
import com.google.android.gms.internal.ads.zzkt;
import com.google.android.gms.internal.ads.zzkx;
import com.google.android.gms.internal.ads.zzla;
import com.google.android.gms.internal.ads.zzlg;
import com.google.android.gms.internal.ads.zzlo;
import com.google.android.gms.internal.ads.zzlu;
import com.google.android.gms.internal.ads.zzmu;
import com.google.android.gms.internal.ads.zznk;
import com.google.android.gms.internal.ads.zzod;
import java.util.Map;
import java.util.concurrent.Future;
import javax.annotation.ParametersAreNonnullByDefault;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
public final class zzbp extends zzkt {
    private final Context mContext;
    private final zzjn zzaau;
    private final Future<zzci> zzaav = zzaki.zza(new zzbs(this));
    private final zzbu zzaaw;

    @Nullable
    private WebView zzaax;

    @Nullable
    private zzci zzaay;
    private AsyncTask<Void, Void, String> zzaaz;

    @Nullable
    private zzkh zzxs;
    private final zzang zzyf;

    public zzbp(Context context, zzjn zzjnVar, String str, zzang zzangVar) {
        this.mContext = context;
        this.zzyf = zzangVar;
        this.zzaau = zzjnVar;
        this.zzaax = new WebView(this.mContext);
        this.zzaaw = new zzbu(str);
        zzk(0);
        this.zzaax.setVerticalScrollBarEnabled(false);
        this.zzaax.getSettings().setJavaScriptEnabled(true);
        this.zzaax.setWebViewClient(new zzbq(this));
        this.zzaax.setOnTouchListener(new zzbr(this));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final String zzv(String str) throws zzcj {
        if (this.zzaay == null) {
            return str;
        }
        Uri uriZza = Uri.parse(str);
        try {
            uriZza = this.zzaay.zza(uriZza, this.mContext, null, null);
        } catch (zzcj e) {
            zzakb.zzc("Unable to process ad data", e);
        }
        return uriZza.toString();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzw(String str) {
        Intent intent = new Intent("android.intent.action.VIEW");
        intent.setData(Uri.parse(str));
        this.mContext.startActivity(intent);
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void destroy() {
        Preconditions.checkMainThread("destroy must be called on the main UI thread.");
        this.zzaaz.cancel(true);
        this.zzaav.cancel(true);
        this.zzaax.destroy();
        this.zzaax = null;
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final String getAdUnitId() {
        throw new IllegalStateException("getAdUnitId not implemented");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    @Nullable
    public final String getMediationAdapterClassName() {
        return null;
    }

    @Override // com.google.android.gms.internal.ads.zzks
    @Nullable
    public final zzlo getVideoController() {
        return null;
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final boolean isLoading() {
        return false;
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final boolean isReady() {
        return false;
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void pause() {
        Preconditions.checkMainThread("pause must be called on the main UI thread.");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void resume() {
        Preconditions.checkMainThread("resume must be called on the main UI thread.");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void setImmersiveMode(boolean z) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void setManualImpressionsEnabled(boolean z) {
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void setUserId(String str) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void showInterstitial() {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void stopLoading() {
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzaaw zzaawVar) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzabc zzabcVar, String str) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzahe zzaheVar) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzjn zzjnVar) {
        throw new IllegalStateException("AdSize must be set before initialization");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzke zzkeVar) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzkh zzkhVar) {
        this.zzxs = zzkhVar;
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzkx zzkxVar) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzla zzlaVar) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzlg zzlgVar) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzlu zzluVar) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzmu zzmuVar) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zza(zzod zzodVar) {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final boolean zzb(zzjj zzjjVar) {
        Preconditions.checkNotNull(this.zzaax, "This Search Ad has already been torn down");
        this.zzaaw.zza(zzjjVar, this.zzyf);
        this.zzaaz = new zzbt(this, null).execute(new Void[0]);
        return true;
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final Bundle zzba() {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final IObjectWrapper zzbj() {
        Preconditions.checkMainThread("getAdFrame must be called on the main UI thread.");
        return ObjectWrapper.wrap(this.zzaax);
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final zzjn zzbk() {
        return this.zzaau;
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final void zzbm() {
        throw new IllegalStateException("Unused method");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final zzla zzbw() {
        throw new IllegalStateException("getIAppEventListener not implemented");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    public final zzkh zzbx() {
        throw new IllegalStateException("getIAdListener not implemented");
    }

    @Override // com.google.android.gms.internal.ads.zzks
    @Nullable
    public final String zzck() {
        return null;
    }

    @VisibleForTesting
    final String zzea() {
        Uri.Builder builder = new Uri.Builder();
        builder.scheme("https://").appendEncodedPath((String) zzkb.zzik().zzd(zznk.zzbcz));
        builder.appendQueryParameter(SearchIntents.EXTRA_QUERY, this.zzaaw.getQuery());
        builder.appendQueryParameter("pubId", this.zzaaw.zzed());
        Map<String, String> mapZzee = this.zzaaw.zzee();
        for (String str : mapZzee.keySet()) {
            builder.appendQueryParameter(str, mapZzee.get(str));
        }
        Uri uriBuild = builder.build();
        if (this.zzaay != null) {
            try {
                uriBuild = this.zzaay.zza(uriBuild, this.mContext);
            } catch (zzcj e) {
                zzakb.zzc("Unable to process ad data", e);
            }
        }
        String strZzeb = zzeb();
        String encodedQuery = uriBuild.getEncodedQuery();
        StringBuilder sb = new StringBuilder(String.valueOf(strZzeb).length() + 1 + String.valueOf(encodedQuery).length());
        sb.append(strZzeb);
        sb.append("#");
        sb.append(encodedQuery);
        return sb.toString();
    }

    @VisibleForTesting
    final String zzeb() {
        String strZzec = this.zzaaw.zzec();
        if (TextUtils.isEmpty(strZzec)) {
            strZzec = "www.google.com";
        }
        String str = (String) zzkb.zzik().zzd(zznk.zzbcz);
        StringBuilder sb = new StringBuilder(String.valueOf(strZzec).length() + 8 + String.valueOf(str).length());
        sb.append("https://");
        sb.append(strZzec);
        sb.append(str);
        return sb.toString();
    }

    @VisibleForTesting
    final void zzk(int i) {
        if (this.zzaax == null) {
            return;
        }
        this.zzaax.setLayoutParams(new ViewGroup.LayoutParams(-1, i));
    }

    @VisibleForTesting
    final int zzu(String str) {
        String queryParameter = Uri.parse(str).getQueryParameter("height");
        if (TextUtils.isEmpty(queryParameter)) {
            return 0;
        }
        try {
            zzkb.zzif();
            return zzamu.zza(this.mContext, Integer.parseInt(queryParameter));
        } catch (NumberFormatException unused) {
            return 0;
        }
    }
}
